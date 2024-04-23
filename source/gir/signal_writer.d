module gir.signal_writer;

import code_writer;
import defs;
import import_symbols;
import gir.func;
import gir.param;
import gir.structure;
import gir.type_node;
import std_includes;
import utils;

/// Signal writer class
class SignalWriter
{
  this(Func signal)
  {
    this.imports = new ImportSymbols(signal.repo.namespace);
    imports.add("Types");
    imports.add("GObject.Types");
    this.signal = signal;

    owningClass = cast(Structure)signal.parent;
    assert(owningClass && owningClass != signal.repo.globalStruct,
      "Signal '" ~ signal.fullName.to!string ~ "' does not have a valid class");

    process();
  }

  // Process the signal
  private void process()
  {
    decl ~= "ulong connect" ~ signal.dName(true) ~ "(";

    preCall ~= "extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals,"
      ~ " void* _invocHint, void* _marshalData)\n{\n";
    preCall ~= "assert(_nParams == " ~ (signal.params.length + 1).to!dstring
      ~ ", \"Unexpected number of signal parameters\");\n";
    preCall ~= "auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;\n";

    processReturn();

    auto instanceParamName = owningClass.dType[0].toLower ~ owningClass.dType[1 .. $];
    preCall ~= "auto " ~ instanceParamName ~ " = getVal!" ~ owningClass.dType ~ "(_paramVals);\n"; // Instance parameter is the first value
    decl ~= "delegate(";
    call ~= "_dgClosure.dlg(";

    foreach (i, param; signal.params)
    { // The parameter index is +1 because the first one is the object instance
      preCall ~= "auto " ~ param.dName ~ " = getVal!" ~ param.dType ~ "(&_paramVals[" ~ (i + 1).to!dstring ~ "]);\n";
      processParam(param);
    }

    // Add the instance parameter (last)
    addDeclParam(owningClass.dType ~ " " ~ instanceParamName);
    addCallParam(instanceParamName);

    decl ~= ") dlg, ConnectFlags flags = ConnectFlags.Default)";
    call ~= ");";
  }

  // Helper to add parameter to call string with comma separator
  private void addCallParam(dstring paramStr)
  {
    if (!call.endsWith('('))
      call ~= ", ";

    call ~= paramStr;
  }

  // Helper to add parameter to decl string with comma separator
  private void addDeclParam(dstring paramStr)
  {
    if (!decl.endsWith('('))
      decl ~= ", ";

    decl ~= paramStr;
  }

  /// Process return value
  private void processReturn()
  {
    if (signal.origDType == "none")
    {
      decl ~= "void ";
      return;
    }

    signal.addImports(imports, signal.repo); // Add imports required for return value type

    assert(signal.containerType == ContainerType.None, "No support for signal container return type '"
      ~ signal.containerType.to!string ~ "'");

    final switch (signal.kind) with (TypeKind)
    {
      case Basic, BasicAlias:
        decl ~= signal.dType ~ " ";
        preCall ~= signal.dType ~ " _retval;\n";
        call ~= "_retval = ";
        break;
      case String:
        decl ~= "string ";
        preCall ~= signal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= "string _retval = _cretval.fromCString("d ~ signal.fullOwnerStr ~ ");\n";
        break;
      case Enum, Flags:
        decl ~= signal.dType ~ " ";
        preCall ~= signal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= signal.dType ~ " _retval = cast(" ~ signal.dType ~ ")_cretval;\n";
        break;
      case Boxed:
        decl ~= signal.dType ~ " ";
        preCall ~= signal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= signal.dType ~ " _retval = new "d ~ signal.dType ~ "(cast(" ~ signal.cType.stripConst ~ ")_cretval, "
          ~ signal.fullOwnerStr ~ ");\n";
        break;
      case Wrap, Reffed, Object, Interface:
        decl ~= signal.dType ~ " ";
        preCall ~= signal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";

        postCall ~= signal.dType ~ " _retval = " ~ ((signal.kind == Object || signal.kind == Interface)
          ? "ObjectG.getDObject!"d : "new "d);
        postCall ~= signal.dType ~ "(cast(" ~ signal.cType.stripConst ~ ")_cretval"
          ~ (signal.kind != TypeKind.Wrap ? ", " ~ signal.fullOwnerStr : "") ~ ");\n";

        if (signal.kind == TypeKind.Object || signal.kind == TypeKind.Interface)
          imports.add("GObject.ObjectG");
        break;
      case Simple, Pointer, Callback, Opaque, Unknown, Container, Namespace:
        assert(0, "Unsupported signal return value type '" ~ signal.dType.to!string ~ "' (" ~ signal.kind.to!string ~ ") for "
            ~ signal.fullName.to!string);
    }

    postCall ~= "setVal!" ~ signal.dType ~ "(_returnValue, _retval);\n";
  }

  /// Process parameter
  private void processParam(Param param)
  {
    param.addImports(imports, signal.repo);

    assert(param.containerType == ContainerType.None, "No support for signal container parameter type '"
      ~ param.containerType.to!string ~ "'");

    assert(param.direction == ParamDirection.In, "No support for signal parameter direction '"
      ~ param.direction.to!string ~ "'");

    addCallParam(param.dName);

    final switch (param.kind) with (TypeKind)
    {
      case Basic, BasicAlias:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
        break;
      case Enum, Flags:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
        break;
      case String:
        addDeclParam(param.directionStr ~ "string " ~ param.dName);

        preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ param.dName ~ ".toCString("
          ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
        break;
      case Wrap, Boxed, Reffed, Object, Interface:
        addDeclParam(param.dType ~ " " ~ param.dName);
        break;
      case Simple, Pointer, Opaque, Callback, Unknown, Container, Namespace:
        assert(0, "Unsupported signal parameter type '" ~ param.dType.to!string ~ "' (" ~ param.kind.to!string ~ ") for "
            ~ signal.fullName.to!string);
    }
  }

  /**
   * Write signal binding to a CodeWriter.
   * Params:
   *   writer = Code writer to write to.
   *   ifaceModule = Set to true when writing interface module (defaults to false which writes function for mixin template module)
   */
  void write(CodeWriter writer, bool ifaceModule = false)
  {
    signal.writeDocs(writer);

    if (ifaceModule)
    {
      writer ~= decl ~ ";";
      return;
    }

    writer ~= decl;
    writer ~= "{";

    if (preCall.length > 0)
      writer ~= preCall;

    writer ~= call;

    if (postCall.length > 0)
      writer ~= postCall;

    writer ~= ["}", "", "auto closure = new DClosure(dlg, &_cmarshal);"];
    writer ~= ["return connectSignalClosure(\"" ~ signal.name ~ "\", closure, (flags & ConnectFlags.After) != 0);", "}"];
  }

  Func signal; /// The signal object being written
  Structure owningClass; /// The class which owns the signal (parent)
  ImportSymbols imports; /// Import symbols needed to support the signal
  dstring decl; /// Signal declaration
  dstring preCall; /// Pre-call code for call return variable, call output parameter variables, and input variable processing
  dstring call; /// The D delegate call
  dstring postCall; /// Post-call code for return value processing, output parameter processing, and input variable cleanup
}

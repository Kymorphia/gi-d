module gir.signal_writer;

import code_writer;
import defs;
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
    this.signal = signal;

    owningClass = cast(Structure)signal.parent;
    assert(owningClass && owningClass != signal.repo.globalStruct,
      "Signal '" ~ signal.fullName.to!string ~ "' does not have a valid class");

    signal.repo.defs.resolveSymbol("GObject.DClosure");

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

    auto instanceParamName = signal.repo.defs.symbolName(owningClass.dType[0].toLower ~ owningClass.dType[1 .. $]);
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

    signal.repo.defs.importManager.add("GObject.Types"); // For ConnectFlags
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
    auto retVal = signal.returnVal;

    if (!retVal || retVal.origDType == "none")
    {
      decl ~= "void ";
      return;
    }

    assert(retVal.containerType == ContainerType.None, "No support for signal container return type '"
      ~ retVal.containerType.to!string ~ "'");

    final switch (retVal.kind) with (TypeKind)
    {
      case Basic, BasicAlias:
        decl ~= retVal.dType ~ " ";
        preCall ~= retVal.dType ~ " _retval;\n";
        call ~= "_retval = ";
        break;
      case String:
        decl ~= "string ";
        call ~= "auto _retval = ";
        break;
      case Enum, Flags:
        decl ~= retVal.dType ~ " ";
        call ~= "auto _dretval = ";
        postCall ~= retVal.cType ~ " _retval = cast(" ~ retVal.cType ~ ")_dretval;\n";
        break;
      case Boxed:
        decl ~= retVal.dType ~ " ";
        call ~= "auto _retval = ";
        break;
      case Wrap, Reffed, Object, Interface:
        decl ~= retVal.dType ~ " ";
        call ~= "auto _retval = ";
        break;
      case Simple, Pointer, Callback, Opaque, Unknown, Container, Namespace:
        assert(0, "Unsupported signal return value type '" ~ retVal.dType.to!string ~ "' (" ~ retVal.kind.to!string ~ ") for "
            ~ signal.fullName.to!string);
    }

    postCall ~= "setVal!" ~ retVal.dType ~ "(_returnValue, _retval);\n";
  }

  /// Process parameter
  private void processParam(Param param)
  {
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
  dstring decl; /// Signal declaration
  dstring preCall; /// Pre-call code for call return variable, call output parameter variables, and input variable processing
  dstring call; /// The D delegate call
  dstring postCall; /// Post-call code for return value processing, output parameter processing, and input variable cleanup
}

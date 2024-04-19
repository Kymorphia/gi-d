module gir.deleg_writer;

import code_writer;
import defs;
import import_symbols;
import gir.func;
import gir.param;
import gir.type_node;
import std_includes;
import utils;

/// Delegate C callback marshal writer class
class DelegWriter
{
  this(Param delegParam)
  {
    this.delegParam = delegParam;
    imports = new ImportSymbols(delegParam.repo.namespace);
    callback = cast(Func)delegParam.typeObject;

    assert(this.callback, "DelegWriter parameter " ~ delegParam.fullName.to!string ~ " has "
      ~ delegParam.typeObject.to!string ~ " typeObject");

    process();
  }

  // Process the delegate parameter
  private void process()
  {
    decl ~= "extern(C) ";

    if (delegParam.scope_ == ParamScope.Async)
      preCall ~= "ptrThawGC(" ~ callback.closureParam.dName ~ ");\n"; // If it is an asynchronous callback, delegate can be thawed immediately (will continue to exist so long as it is in use)

    processReturn();

    decl ~= "_" ~ delegParam.dName ~ "Callback(";

    if (delegParam.scope_ == ParamScope.Call)
      call ~= "_static_" ~ delegParam.dName ~ "("; // Call the static per thread delegate pointer which is used to pass it from the outer function to the C callback
    else
      call ~= "(*(cast(" ~ delegParam.dType ~ "*)" ~ callback.closureParam.dName ~ "))(";

    foreach (param; callback.params)
      processParam(param);

    decl ~= ")";
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
    if (callback.origDType == "none")
    {
      decl ~= "void ";
      return;
    }

    callback.addImports(imports, callback.repo); // Add imports required for return value type

    if (callback.containerType == ContainerType.Array)
    {
      processReturnArray();
      return;
    }
    else if (callback.containerType != ContainerType.None)
    {
      processReturnContainer();
      return;
    }

    decl ~= callback.cType ~ " ";

    final switch (callback.kind) with (TypeKind)
    {
      case Basic, BasicAlias, Pointer:
        call ~= callback.cType ~ " _retval = ";
        break;
      case String:
        preCall ~= callback.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= callback.cType ~ " _retval = _dretval.toCString("d ~ callback.fullOwnerStr ~ ");\n";
        break;
      case Enum, Flags:
        preCall ~= callback.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= callback.cType ~ " _retval = cast(" ~ callback.cType ~ ")_dretval;\n";
        break;
      case Simple:
        preCall ~= callback.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= callback.cType ~ " _retval;\nif (_dretval)\n_retval = *_dretval;\n";
        break;
      case Opaque, Wrap, Boxed, Reffed, Object, Interface:
        preCall ~= callback.dType ~ " _dretval;\n";
        call ~= "_dretval = ";

        postCall ~= callback.cType ~ " _retval = _dretval.cPtr!" ~ callback.cTypeRemPtr
          ~ "(" ~ callback.fullOwnerStr ~ ");\n";
        break;
      case Callback, Unknown, Container, Namespace:
        assert(0, "Unsupported delegate return value type '" ~ callback.dType.to!string
          ~ "' (" ~ callback.kind.to!string ~ ") for " ~ callback.fullName.to!string);
    }
  }

  /// Process array return value
  private void processReturnArray()
  {
    assert(callback.ownership == Ownership.Full, "Unsupported delegate return array ownership '"
      ~ callback.ownership.to!string ~ "' for " ~ callback.fullName.to!string);

    auto elemType = callback.elemTypes[0];

    decl ~= callback.cType ~ " ";
    preCall ~= elemType.dType ~ "[] _dretval;\n";
    call ~= "_dretval = ";
    postCall ~= callback.cType ~ " _retval;\n\nif (_dretval.length > 0)\n{\n";

    if (callback.fixedSize != ArrayNotFixed) // Array is a fixed size? Add an array size assertion.
      postCall ~= "assert(!_dretval || _dretval.length == " ~ callback.fixedSize.to!dstring
        ~ `, "Delegate '` ~ callback.dType ~ `' should return array of size ` ~ callback.fixedSize.to!dstring
        ~ ` not " ~ _dretval.length.to!string);\n`;

    if (callback.zeroTerminated)
    {
      postCall ~= "_retval = cast(" ~ callback.cType ~ ")g_malloc_n(_dretval.length + 1, (*_retval).sizeof);\n";
      postCall ~= "zero(cast(void*)&_retval[_dretval.length], (*_retval).sizeof);";
    }
    else
      postCall ~= "_retval = cast(" ~ callback.cType ~ ")g_malloc_n(_dretval.length, (*_retval).sizeof);\n";

    if (elemType.kind.among(TypeKind.Basic, TypeKind.BasicAlias, TypeKind.Enum))
      postCall ~= "_retval[0 .. _dretval.length] = _dretval[0 .. _dretval.length];\n";
    else
    {
      postCall ~= "\nforeach (i; 0 .. _dretval.length)\n";

      final switch (elemType.kind) with (TypeKind)
      {
        case String:
          postCall ~= "_retval[i] = _dretval[i].toCString(true);\n";
          break;
        case Enum, Flags:
          postCall ~= "_retval[i] = cast(" ~ elemType.cType ~ ")_dretval[i];\n";
          break;
        case Simple:
        case Pointer:
          postCall ~= "_retval[i] = _dretval[i];\n";
          break;
        case Opaque, Wrap, Boxed, Reffed, Object, Interface:
          postCall ~= "_retval[i] = _dretval[i].cPtr!" ~ elemType.cTypeRemPtr ~ "(" ~ callback.fullOwnerStr ~ ");\n";
          break;
        case Basic, BasicAlias, Callback, Unknown, Container, Namespace:
          assert(0, "Unsupported delegate return value array type '" ~ elemType.dType.to!string
            ~ "' (" ~ elemType.kind.to!string ~ ") for " ~ callback.fullName.to!string);
      }
    }

    postCall ~= "}\n\n";

    if (callback.lengthParamIndex >= 0) // Array has length parameter?
    {
      auto lengthParam = callback.params[callback.lengthParamIndex];
      postCall ~= lengthParam.dName ~ " = cast(" ~ lengthParam.dName ~ ".typeof)_dretval.length;\n";
    }
  }

  /// Process a return container (not Array)
  private void processReturnContainer()
  {
    assert(callback.ownership == Ownership.Full, "Unsupported delegate return array ownership '"
      ~ callback.ownership.to!string ~ "' for " ~ callback.fullName.to!string);

    if (callback.containerType == ContainerType.ByteArray)
    {
      decl ~= "GByteArray ";
      call ~= "ByteArray* _dretval = ";
      postCall ~= "GByteArray* _retval = _dretval ? _dretval.cPtr(true) : null;\n";
      imports.add("GLib.ByteArray");
      return;
    }
    else if (callback.containerType == ContainerType.HashTable)
      assert(0, "Unsupported delegate return type GHashTable for " ~ callback.fullName.to!string);

    decl ~= callback.cType ~ " ";
    call ~= callback.dType ~ "_dretval = ";
    postCall ~= callback.cType ~ " _retval = _dretval ? _dretval.cPtr(true) : null;\n";
  }

  /// Process parameter
  private void processParam(Param param)
  {
    if (param.isInstanceParam) // Instance parameter or closure data? Skip
      return;

    param.addImports(imports, param.repo);

    if (param.isArrayLength) // Array length parameter?
    {
      addDeclParam(param.cType ~ " " ~ param.dName);
      return;
    }

    if (param.containerType == ContainerType.Array) // Array container?
    {
      processArrayParam(param);
      return;
    }
    else if (param.containerType != ContainerType.None) // Other type of container?
    {
      processContainerParam(param);
      return;
    }

    addDeclParam(param.cType ~ " " ~ param.dName);

    if (param is callback.closureParam) // Closure parameter?
      return;

    final switch (param.kind) with (TypeKind)
    {
      case Basic, BasicAlias, Enum, Flags, Simple, Pointer:
        addCallParam(param.direction == ParamDirection.In ? param.dName : "*" ~ param.dName);
        break;
      case String:
        if (param.direction == ParamDirection.In)
        {
          preCall ~= "string _" ~ param.dName ~ " = " ~ param.dName ~ ".fromCString(" ~ param.fullOwnerStr ~ ");\n";
          addCallParam("_" ~ param.dName);
        }
        else if (param.direction == ParamDirection.Out)
        {
          preCall ~= "string _" ~ param.dName ~ ";\n";
          addCallParam("_" ~ param.dName);
          postCall ~= "*" ~ param.dName ~ " = _" ~ param.dName ~ ".toCString(" ~ param.fullOwnerStr ~ ");\n";
        }
        else // InOut
          assert(0, "InOut string arguments not supported"); // FIXME - Does this even exist?
        break;
      case Opaque, Wrap, Boxed, Reffed, Object, Interface:
        if (param.direction == ParamDirection.In)
        {
          addCallParam(param.dName ~ " ? " ~ ((param.kind == Object || param.kind == Interface)
            ? "ObjectG.getDObject!"d : "new "d) ~ param.dType ~ "(" ~ param.dName ~ ", " ~ param.fullOwnerStr
            ~ ") : null");

          if (param.kind == TypeKind.Object || param.kind == TypeKind.Interface)
            imports.add("GObject.ObjectG");
        }
        else if (param.direction == ParamDirection.Out)
        {
          preCall ~= param.dType ~ " _" ~ param.dName ~ ";\n";
          addCallParam("_" ~ param.dName);
          postCall ~= "*" ~ param.dName ~ " = _" ~ param.dName ~ ".cPtr!(" ~ param.cTypeRemPtr ~ ", true);\n";
        }
        else // InOut
          assert(0, "InOut arguments of type '" ~ param.kind.to!string ~ "' not supported"); // FIXME - Does this even exist?
        break;
      case Callback, Unknown, Container, Namespace:
        assert(0, "Unsupported parameter type '" ~ param.dType.to!string ~ "' (" ~ param.kind.to!string ~ ") for "
            ~ callback.fullName.to!string);
    }
  }

  // Process an array parameter
  private void processArrayParam(Param param)
  {
    if ((param.direction != ParamDirection.Out && param.ownership != Ownership.None)
        || (param.direction == ParamDirection.Out && param.ownership != Ownership.Full))
      assert(0, "Unsupported delegate array parameter direction '" ~ param.direction.to!string
        ~ "' and ownership '" ~ param.ownership.to!string ~ "'");

    auto elemType = param.elemTypes[0];

    addDeclParam(param.cType ~ " " ~ param.dName);
    preCall ~= elemType.dType ~ "[] _" ~ param.dName ~ ";\n";
    addCallParam("_" ~ param.dName);

    // Pre C function call processing
    if (param.direction == ParamDirection.In || param.direction == ParamDirection.InOut)
    {
      dstring lengthStr;

      if (param.lengthParamIndex >= 0) // Array has length parameter?
        lengthStr = callback.params[param.lengthParamIndex].dName;
      else if (param.fixedSize != ArrayNotFixed) // Array is a fixed size?
        lengthStr = param.fixedSize.to!dstring;
      else if (param.zeroTerminated) // Array is zero terminated?
      {
        postCall ~= "uint _len" ~ param.dName ~ ";\nif (" ~ param.dName ~ ")\nfor (; " ~ param.dName
          ~ "[_len" ~ param.dName ~ "] != " ~ (elemType.cType.endsWith("*") ? "null"d : "0") ~ "; _len" ~ param.dName
          ~ "++)\nbreak;\n";
        lengthStr = "_len" ~ param.dName;
      }
      else
        assert(0); // This should be prevented by defs.fixupRepos()

      final switch (elemType.kind) with (TypeKind)
      {
        case Basic, BasicAlias, Enum, Flags, Simple, Pointer:
          preCall ~= "_" ~ param.dName ~ " = cast(" ~ elemType.dType ~ "[])" ~ param.dName ~ "[0 .. " ~ lengthStr ~ "];\n";
          break;
        case String:
          preCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n_" ~ param.dName ~ " ~= " ~ param.dName ~ "[i].fromCString("
            ~ param.fullOwnerStr ~ ");\n";
          break;
        case Opaque, Boxed, Wrap, Reffed:
          preCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n_" ~ param.dName ~ " ~= new " ~ elemType.dType ~ "(cast("
            ~ elemType.cType.stripConst ~ "*)&" ~ param.dName ~ "[i]"
            ~ (param.kind != Wrap ? ", " ~ param.fullOwnerStr : "") ~ ");\n";
          break;
        case Object, Interface:
          preCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n_" ~ param.dName ~ " ~= ObjectG.getDObject(" ~ param.dName
            ~ "[i], " ~ param.fullOwnerStr ~ ");\n";
          imports.add("GObject.ObjectG");
          break;
        case Unknown, Callback, Container, Namespace:
          assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
              ~ ") for " ~ callback.fullName.to!string);
      }
    }

    if (param.direction == ParamDirection.Out || param.direction == ParamDirection.InOut)
    {
      if (param.lengthParamIndex >= 0) // Array has length parameter?
      {
        auto lengthParam = callback.params[param.lengthParamIndex];
        postCall ~= lengthParam.dName ~ " = cast(" ~ lengthParam.cType  ~ ")_" ~ param.dName ~ ".length"
          ~ (param.zeroTerminated ? " - 1;\n"d : ";\n"d);
      }

      final switch (elemType.kind) with (TypeKind)
      {
        case Basic, String, BasicAlias, Enum, Flags, Simple, Pointer, Opaque, Wrap, Boxed, Reffed, Object, Interface:
          postCall ~= param.dName ~ " = arrayDtoC!(" ~ elemType.dType ~ ", Yes.Malloc, "
            ~ (param.zeroTerminated ? "Yes"d : "No"d) ~ ".ZeroTerm)(_" ~ param.dName ~ ");\n";
          break;
        case Unknown, Callback, Container, Namespace:
          assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
            ~ ") for " ~ callback.fullName.to!string);
      }
    }
  }

  // Process a container parameter (except array)
  private void processContainerParam(Param param)
  {
    if (param.containerType == ContainerType.HashTable) // Hash tables are converted into dlang associative arrays
    {
      assert(param.direction == ParamDirection.Out, "Function container HashTable parameter '" ~ param
          .fullName.to!string ~ "' direction not supported '" ~ param.direction.to!string ~ "'");

      addDeclParam("GHashTable* " ~ param.dName);
      addCallParam("_" ~ param.dName);

      auto mapType = param.elemTypes[1].dType ~ "[" ~ param.elemTypes[0].dType ~ "]";
      preCall ~= mapType ~ " _" ~ param.dName;

      postCall ~= "*" ~ param.dName ~ " = mapToHashTable!(" ~ param.elemTypes[0].dType ~ ", " ~ param.elemTypes[1].dType
        ~ ")(_" ~ param.dName ~ ");\n";

      imports.add("GLib.Global");
      return;
    }

    addDeclParam(param.cType ~ " " ~ param.dName);

    auto elemType = param.elemTypes[0];

    final switch(param.direction) with(ParamDirection)
    {
      case In, InOut:
        postCall ~= "_" ~ param.dName ~ " = new " ~ param.dType ~ "!(" ~ elemType.dType ~ ", " ~ elemType.cType
          ~ ")(_" ~ param.dName ~ ", GidOwnership." ~ param.ownership.to!dstring ~ ");\n";
        addCallParam("_" ~ param.dName);
        break;
      case Out:
        preCall ~= param.cType ~ " _" ~ param.dName ~ ";\n";
        addCallParam("&_" ~ param.dName);
        postCall ~= param.dName ~ " = new " ~ param.dType ~ "!(" ~ elemType.dType ~ ", " ~ elemType.cType
          ~ ")(_" ~ param.dName ~ ", GidOwnership." ~ param.ownership.to!dstring ~ ");\n";
        break;
    }
  }

  /**
   * Generate the delegate C callback function code.
   * Returns: The generated D code for the C callback delegate function marshaller
   */
  dstring generate()
  {
    dstring output = decl ~ "\n{\n";

    if (preCall.length > 0)
      output ~= preCall ~ "\n";

    output ~= call ~ "\n";

    if (postCall.length > 0)
      output ~= postCall ~ "\n";

    if (callback.origDType != "none")
      output ~= "return _retval;\n";

    return output ~ "}\n";
  }

  Param delegParam; /// The parameter of the callback delegate
  Func callback; /// The resolved callback delegate type of parameter
  ImportSymbols imports; /// Import symbols needed to support the function
  dstring decl; /// Function declaration
  dstring preCall; /// Pre-call code for call return variable, call output parameter variables, and input variable processing
  dstring call; /// The C function call
  dstring postCall; /// Post-call code for return value processing, output parameter processing, and input variable cleanup
}

module gir.deleg_writer;

import code_writer;
import defs;
import gir.func;
import gir.param;
import gir.structure;
import gir.type_node;
import std_includes;
import utils;

/// Delegate C callback marshal writer class
class DelegWriter
{
  this(Param delegParam)
  {
    this.delegParam = delegParam;
    callback = cast(Func)delegParam.typeObjectRoot;

    assert(this.callback, "DelegWriter parameter " ~ delegParam.fullName.to!string ~ " has "
      ~ delegParam.typeObjectRoot.to!string ~ " typeObjectRoot");

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
    auto retVal = callback.returnVal;

    if (!retVal || retVal.origDType == "none")
    {
      decl ~= "void ";
      return;
    }

    if (retVal.containerType == ContainerType.Array)
    {
      processReturnArray();
      return;
    }
    else if (retVal.containerType != ContainerType.None)
    {
      processReturnContainer();
      return;
    }

    decl ~= retVal.cType ~ " ";

    final switch (retVal.kind) with (TypeKind)
    {
      case Basic, BasicAlias, Pointer:
        call ~= retVal.cType ~ " _retval = ";
        break;
      case String:
        preCall ~= retVal.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= retVal.cType ~ " _retval = _dretval.toCString("d ~ retVal.fullOwnerStr ~ ");\n";
        break;
      case Enum, Flags:
        preCall ~= retVal.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= "auto _retval = cast(" ~ retVal.cType ~ ")_dretval;\n";
        break;
      case Simple:
        preCall ~= retVal.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= retVal.cType ~ " _retval;\nif (_dretval)\n_retval = *_dretval;\n";
        break;
      case Opaque, Wrap, Boxed, Reffed, Object:
        preCall ~= retVal.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= retVal.cType ~ " _retval = cast(" ~ retVal.cTypeRemPtr ~ "*)_dretval.cPtr("
          ~ retVal.fullOwnerStr ~ ");\n";
        break;
      case Interface:
        auto objectGSym = retVal.repo.defs.resolveSymbol("GObject.ObjectG");
        preCall ~= retVal.dType ~ " _dretval;\n";
        call ~= "_dretval = ";
        postCall ~= retVal.cType ~ " _retval = cast(" ~ retVal.cTypeRemPtr ~ "*)(cast(" ~ objectGSym ~ ")_dretval).cPtr("
          ~ retVal.fullOwnerStr ~ ");\n";
        break;
      case Callback, Unknown, Container, Namespace:
        assert(0, "Unsupported delegate return value type '" ~ retVal.dType.to!string
          ~ "' (" ~ retVal.kind.to!string ~ ") for " ~ callback.fullName.to!string);
    }
  }

  /// Process array return value
  private void processReturnArray()
  {
    auto retVal = callback.returnVal;

    assert(retVal.ownership == Ownership.Full, "Unsupported delegate return array ownership '"
      ~ retVal.ownership.to!string ~ "' for " ~ callback.fullName.to!string);

    auto elemType = retVal.elemTypes[0];

    decl ~= retVal.cType ~ " ";
    preCall ~= elemType.dType ~ "[] _dretval;\n";
    call ~= "_dretval = ";
    postCall ~= retVal.cType ~ " _retval;\n\nif (_dretval.length > 0)\n{\n";

    if (retVal.fixedSize != ArrayNotFixed) // Array is a fixed size? Add an array size assertion.
      postCall ~= "assert(!_dretval || _dretval.length == " ~ retVal.fixedSize.to!dstring
        ~ `, "Delegate '` ~ retVal.dType ~ `' should return array of size ` ~ retVal.fixedSize.to!dstring
        ~ ` not " ~ _dretval.length.to!string);\n`;

    if (retVal.zeroTerminated)
    {
      postCall ~= "_retval = cast(" ~ retVal.cType ~ ")g_malloc_n(_dretval.length + 1, (*_retval).sizeof);\n";
      postCall ~= "zero(cast(void*)&_retval[_dretval.length], (*_retval).sizeof);";
    }
    else
      postCall ~= "_retval = cast(" ~ retVal.cType ~ ")g_malloc_n(_dretval.length, (*_retval).sizeof);\n";

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
          postCall ~= "_retval[i] = _dretval[i].cPtr(" ~ retVal.fullOwnerStr ~ ");\n";
          break;
        case Basic, BasicAlias, Callback, Unknown, Container, Namespace:
          assert(0, "Unsupported delegate return value array type '" ~ elemType.dType.to!string
            ~ "' (" ~ elemType.kind.to!string ~ ") for " ~ callback.fullName.to!string);
      }
    }

    postCall ~= "}\n\n";

    if (retVal.lengthParam) // Array has length parameter?
      postCall ~= retVal.lengthParam.dName ~ " = cast(" ~ retVal.lengthParam.dName ~ ".typeof)_dretval.length;\n";
  }

  /// Process a return container (not Array)
  private void processReturnContainer()
  {
    auto retVal = callback.returnVal;

    assert(retVal.ownership == Ownership.Full, "Unsupported delegate return array ownership '"
      ~ retVal.ownership.to!string ~ "' for " ~ retVal.fullName.to!string);

    if (retVal.containerType == ContainerType.ByteArray)
    {
      auto byteArraySym = retVal.repo.defs.resolveSymbol("GLib.ByteArray");
      decl ~= "GByteArray ";
      call ~= byteArraySym ~ "* _dretval = ";
      postCall ~= "GByteArray* _retval = _dretval ? _dretval.cPtr(true) : null;\n";
      return;
    }
    else if (retVal.containerType == ContainerType.HashTable)
      assert(0, "Unsupported delegate return type GHashTable for " ~ callback.fullName.to!string);

    decl ~= retVal.cType ~ " ";
    call ~= retVal.dType ~ "_dretval = ";
    postCall ~= retVal.cType ~ " _retval = _dretval ? _dretval.cPtr(true) : null;\n";
  }

  /// Process parameter
  private void processParam(Param param)
  {
    if (param.isInstanceParam) // Instance parameter or closure data? Skip
      return;

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
      case Basic, BasicAlias, Enum, Flags, Pointer:
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
      case Simple:
        addCallParam("*"d ~ param.dName);
        break;
      case Opaque, Wrap, Boxed, Reffed, Object, Interface:
        if (param.direction == ParamDirection.In)
        {
          if (param.kind == TypeKind.Object || param.kind == TypeKind.Interface)
          {
            auto objectGSym = param.repo.defs.resolveSymbol("GObject.ObjectG");
            addCallParam(param.dName ~ " ? " ~ objectGSym ~ ".getDObject!" ~ param.dType ~ "(cast(void*)"
              ~ param.dName ~ ", " ~ param.fullOwnerStr ~ ") : null");
          }
          else
            addCallParam(param.dName ~ " ? new " ~ param.dType ~ "(cast(void*)" ~ param.dName ~ ", "
              ~ param.fullOwnerStr ~ ") : null");
        }
        else if (param.direction == ParamDirection.Out)
        { // FIXME - Not sure if this will work for all cases, also could optimize by allowing C structure to be directly used in D object
          preCall ~= "auto _" ~ param.dName ~ " = new " ~ param.dType ~ "(" ~ param.dName ~ ", false);\n";
          addCallParam("_" ~ param.dName);
          postCall ~= "*" ~ param.dName ~ " = *cast(" ~ param.cType ~ ")_" ~ param.dName ~ ".cPtr;\n";
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

      if (param.lengthParam) // Array has length parameter?
        lengthStr = param.lengthParam.dName;
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
          auto objectGSym = param.repo.defs.resolveSymbol("GObject.ObjectG");
          preCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n_" ~ param.dName ~ " ~= " ~ objectGSym ~ ".getDObject("
            ~ param.dName ~ "[i], " ~ param.fullOwnerStr ~ ");\n";
          break;
        case Unknown, Callback, Container, Namespace:
          assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
              ~ ") for " ~ callback.fullName.to!string);
      }
    }

    if (param.direction == ParamDirection.Out || param.direction == ParamDirection.InOut)
    {
      if (param.lengthParam) // Array has length parameter?
        postCall ~= param.lengthParam.dName ~ " = cast(" ~ param.lengthParam.cType  ~ ")_" ~ param.dName ~ ".length"
          ~ (param.zeroTerminated ? " - 1;\n"d : ";\n"d);

      final switch (elemType.kind) with (TypeKind)
      {
        case Basic, String, BasicAlias, Enum, Flags, Simple, Pointer, Opaque, Wrap, Boxed, Reffed, Object, Interface:
          postCall ~= param.dName ~ " = arrayDtoC!(" ~ elemType.dType ~ ", Yes.UseMalloc, "
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

      auto mapToHashTableSym = param.repo.defs.resolveSymbol("Gid.mapToHashTable");
      postCall ~= "*" ~ param.dName ~ " = " ~ mapToHashTableSym ~ "!(" ~ param.elemTypes[0].dType ~ ", "
        ~ param.elemTypes[1].dType ~ ")(_" ~ param.dName ~ ");\n";

      return;
    }

    addDeclParam(param.cType ~ " " ~ param.dName);
    auto gidOwnershipSym = param.repo.defs.resolveSymbol("Gid.GidOwnership");

    auto elemType = param.elemTypes[0];

    final switch(param.direction) with(ParamDirection)
    {
      case In, InOut:
        postCall ~= "_" ~ param.dName ~ " = new " ~ param.dType ~ "!(" ~ elemType.dType ~ ", " ~ elemType.cType
          ~ ")(_" ~ param.dName ~ ", " ~ gidOwnershipSym ~ "." ~ param.ownership.to!dstring ~ ");\n";
        addCallParam("_" ~ param.dName);
        break;
      case Out:
        preCall ~= param.cType ~ " _" ~ param.dName ~ ";\n";
        addCallParam("&_" ~ param.dName);
        postCall ~= param.dName ~ " = new " ~ param.dType ~ "!(" ~ elemType.dType ~ ", " ~ elemType.cType
          ~ ")(_" ~ param.dName ~ ", " ~ gidOwnershipSym ~ "." ~ param.ownership.to!dstring ~ ");\n";
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

    if (callback.returnVal && callback.returnVal.origDType != "none")
      output ~= "return _retval;\n";

    return output ~ "}\n";
  }

  Param delegParam; /// The parameter of the callback delegate
  Func callback; /// The resolved callback delegate type of parameter
  dstring decl; /// Function declaration
  dstring preCall; /// Pre-call code for call return variable, call output parameter variables, and input variable processing
  dstring call; /// The C function call
  dstring postCall; /// Post-call code for return value processing, output parameter processing, and input variable cleanup
}

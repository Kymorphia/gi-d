module gir.func_writer;

import code_writer;
import defs;
import gir.deleg_writer;
import gir.func;
import gir.param;
import gir.structure;
import gir.type_node;
import std_includes;
import utils;

/// Function writer class
class FuncWriter
{
  this(Func func)
  {
    this.func = func;
    process();
  }

  // Process the function
  private void process()
  {
    codeTrap("func.write", func.fullDName);

    if (func.funcType != FuncType.Method && !func.isCtor && func.parent !is func.repo.globalStruct)
      decl ~= "static "; // Function is "static" if it is not a method, constructor, or global function

    if (func.throws)
    { // postCall for exceptions is order sensitive and must be handled before output and return processing
      postCall ~= "if (_err)\nthrow new " ~ func.errorDomain ~ "(_err);\n";
      func.repo.defs.resolveSymbol("GLib.ErrorG");
    }

    // Write out any C callback embedded functions
    foreach (param; func.params)
    {
      if (param.kind == TypeKind.Callback && !param.isDestroy)
      { // Use a static delegate pointer if there is no closure data argument
        auto staticDelegatePtr = !param.typeObjectRoot || !(cast(Func)param.typeObjectRoot).closureParam;

        if (staticDelegatePtr)
          preCall ~= "static " ~ param.dType ~ " _static_" ~ param.dName ~ ";\n\n";

        auto delegWriter = new DelegWriter(param, staticDelegatePtr);
        preCall ~= delegWriter.generate() ~ "\n";

        if (staticDelegatePtr)
        {
          preCall ~= "_static_" ~ param.dName ~ " = " ~ param.dName ~ ";\n";
          postCall ~= "_static_" ~ param.dName ~ " = null;\n"; // Clear the delegate pointer to allow it to be collected
        }
     }
    }

    processReturn();

    if (func.isCtor)
      decl ~= "this(";
    else if (func.shadowsFunc)
      decl ~= func.shadowsFunc.dName ~ "(";
    else
      decl ~= func.dName ~ "(";

    call ~= func.cName ~ "(";

    foreach (param; func.params)
      processParam(param);

    if (func.throws)
    {
      preCall ~= "GError *_err;\n";
      addCallParam("&_err");
    }

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
    auto retVal = func.returnVal;

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

    final switch (retVal.kind) with (TypeKind)
    {
      case Basic, BasicAlias:
        decl ~= retVal.dType ~ " ";
        preCall ~= retVal.dType ~ " _retval;\n";
        call ~= "_retval = ";
        // postCall ~= retVal.dType ~ " _retval = cast(" ~ retVal.dType ~ ")_cretval;\n";
        break;
      case String:
        decl ~= "string ";
        preCall ~= retVal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= "string _retval = _cretval.fromCString("d ~ retVal.fullOwnerFlag ~ ".Free);\n";
        break;
      case Enum, Flags:
        decl ~= retVal.dType ~ " ";
        preCall ~= retVal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= retVal.dType ~ " _retval = cast(" ~ retVal.dType ~ ")_cretval;\n";
        break;
      case Simple:
        decl ~= retVal.dType ~ " ";
        preCall ~= retVal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= retVal.dType ~ " _retval;\nif (_cretval)\n_retval = *_cretval;\n";
        break;
      case Callback:
        decl ~= retVal.dType ~ "* ";
        call ~= retVal.dType ~ "* _retval = ";
        break;
      case Pointer:
        if (!func.isCtor)
          decl ~= retVal.dType ~ " ";

        call ~= "auto _retval = ";
        break;
      case Boxed:
        if (!func.isCtor)
          decl ~= retVal.dType ~ " ";

        preCall ~= retVal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";

        if (!func.isCtor)
          postCall ~= "auto _retval = _cretval ? new "d ~ retVal.dType ~ "(cast(void*)_cretval, " ~ retVal.fullOwnerFlag
            ~ ".Take) : null;\n";
        else // Constructor method
          postCall ~= "this(_cretval, " ~ retVal.fullOwnerFlag ~ ".Take);\n";
        break;
      case Opaque, Wrap, Reffed, Object, Interface:
        if (!func.isCtor)
          decl ~= retVal.dType ~ " ";

        preCall ~= retVal.cType ~ " _cretval;\n";
        call ~= "_cretval = ";

        if (!func.isCtor)
        {
          if (retVal.kind == TypeKind.Object || retVal.kind == TypeKind.Interface)
          {
            auto objectGSym = retVal.repo.defs.resolveSymbol("GObject.ObjectG");
            postCall ~= "auto _retval = " ~ objectGSym ~ ".getDObject!"
              ~ retVal.dType ~ "(cast(" ~ retVal.cType.stripConst ~ ")_cretval"
              ~ (retVal.kind != TypeKind.Wrap ? (", " ~ retVal.fullOwnerFlag ~ ".Take") : "") ~ ");\n";
          }
          else
            postCall ~= "auto _retval = _cretval ? new "
              ~ retVal.dType ~ "(cast(" ~ retVal.cType.stripConst ~ ")_cretval"
              ~ (retVal.kind != TypeKind.Wrap ? (", " ~ retVal.fullOwnerFlag ~ ".Take") : "") ~ ") : null;\n";
        }
        else // Constructor method
          postCall ~= "this(_cretval" ~ (retVal.kind != TypeKind.Wrap ? (", " ~ retVal.fullOwnerFlag ~ ".Take") : "")
            ~ ");\n";
        break;
      case Unknown, Container, Namespace:
        assert(0, "Unsupported return value type '" ~ retVal.dType.to!string ~ "' (" ~ retVal.kind.to!string ~ ") for "
            ~ func.fullName.to!string);
    }
  }

  /// Process array return value
  private void processReturnArray()
  {
    auto retVal = func.returnVal;
    auto elemType = retVal.elemTypes[0];
    auto retType = elemType.dType == "char" ? "string " : (elemType.dType ~ "[] "); // Use string for char[] with length

    decl ~= retType;
    preCall ~= retVal.cType ~ " _cretval;\n";
    call ~= "_cretval = ";
    postCall ~= (elemType.dType == "char" ? "string" : (elemType.dType ~ "[]")) ~ " _retval;\n";

    dstring lengthStr;

    postCall ~= "\nif (_cretval)\n{\n";

    if (retVal.lengthParam) // Array has length parameter?
    {
      preCall ~= retVal.lengthParam.dType ~ " _cretlength;\n";
      lengthStr = "_cretlength";
    }
    else if (retVal.fixedSize != ArrayNotFixed) // Array is a fixed size?
      lengthStr = retVal.fixedSize.to!dstring;
    else if (retVal.zeroTerminated) // Array is zero terminated?
    {
      postCall ~= "uint _cretlength;\nfor (; _cretval[_cretlength] "d ~ (elemType.cType.endsWith("*")
        ? "!is null"d : "!= 0") ~ "; _cretlength++)\nbreak;\n";
      lengthStr = "_cretlength";
    }
    else
      assert(0, "Function '" ~ func.fullName.to!string ~ "' return array has indeterminate length"); // This should be prevented by defs.fixupRepos()

    if (elemType.kind.among(TypeKind.Basic, TypeKind.BasicAlias, TypeKind.Enum))
      postCall ~= "_retval = cast(" ~ retType ~ ")_cretval[0 .. " ~ lengthStr ~ "];\n";
    else
    {
      postCall ~= "_retval = new " ~ elemType.dType ~ "[" ~ lengthStr ~ "];\nforeach (i; 0 .. "
        ~ lengthStr ~ ")\n";

      final switch (elemType.kind) with (TypeKind)
      {
        case String:
          postCall ~= "_retval[i] = _cretval[i].fromCString(" ~ retVal.fullOwnerFlag ~ ".Free);\n";
          break;
        case Enum, Flags:
          postCall ~= "_retval[i] = cast(" ~ elemType.dType ~ ")(_cretval[i]);\n";
          break;
        case Simple, Pointer:
          postCall ~= "_retval[i] = _cretval[i];\n";
          break;
        case Opaque, Wrap, Boxed, Reffed:
          postCall ~= "_retval[i] = new " ~ elemType.dType ~ "(cast(void*)" ~ (retVal.cType.countStars == 1 ? "&"d : "")
            ~ "_cretval[i], " ~ retVal.fullOwnerFlag ~ ".Take);\n";
          break;
        case Object, Interface:
          auto objectGSym = retVal.repo.defs.resolveSymbol("GObject.ObjectG");
          postCall ~= "_retval[i] = " ~ objectGSym ~ ".getDObject!" ~ elemType.dType ~ "(_cretval[i], "
            ~ retVal.fullOwnerFlag ~ ".Take);\n";
          break;
        case Basic, BasicAlias, Callback, Unknown, Container, Namespace:
          assert(0, "Unsupported return value array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType
              .kind.to!string ~ ") for " ~ func.fullName.to!string);
      }
    }

    postCall ~= "}\n";
  }

  /// Process a return container (not Array)
  private void processReturnContainer()
  {
    auto retVal = func.returnVal;
    dstring templateArgs;

    if (retVal.containerType == ContainerType.HashTable)
      templateArgs = "!(" ~ retVal.elemTypes[0].dType ~ ", " ~ retVal.elemTypes[1].dType ~ ", "
        ~ "GidOwnership." ~ retVal.ownership.to!dstring ~ ")";
    else
      templateArgs = retVal.containerType != ContainerType.ByteArray ? ("!(" ~ retVal.elemTypes[0].dType
        ~ ", " ~ "GidOwnership." ~ retVal.ownership.to!dstring ~ ")") : "";

    decl ~= retVal.dType ~ " ";
    preCall ~= retVal.cType ~ " _cretval;\n";
    call ~= "_cretval = ";
    postCall ~= "auto _retval = g" ~ retVal.containerType.to!dstring ~ "ToD" ~ templateArgs ~ "(cast("
      ~ retVal.cType.stripConst ~ ")_cretval);\n";
  }

  /// Process parameter
  private void processParam(Param param)
  {
    if (param.isInstanceParam) // Instance parameter?
    {
      call ~= "cast(" ~ param.cTypeRemPtr.stripConst ~ "*)cPtr";
      return;
    }

    if (param.isLengthReturnArray) // Return array length parameter is handled in processReturnArray()
    {
      addCallParam("&_cretlength");
      return;
    }

    if (param.lengthArrayParams.length > 0)
    {
      addCallParam((param.direction == ParamDirection.In ? "_"d : "&_"d) ~ param.dName);
      return;
    }

    if (param.containerType == ContainerType.Array) // Array container?
    { // Declare length variable before the array in case it is used by the array
      if (param.lengthParam)
      {
        // Only declare length parameter for first array
        if (param == param.lengthParam.lengthArrayParams[0])
          preCall ~= param.lengthParam.dType ~ " _" ~ param.lengthParam.dName ~ ";\n";

        if (param.direction != ParamDirection.Out) // Set length if parameter is non-null, handles multiple optional array arguments
          preCall ~= "if (" ~ param.dName ~ ")\n_" ~ param.lengthParam.dName ~ " = cast(" ~ param.lengthParam.dType
            ~ ")" ~ param.dName ~ ".length;\n\n";
      }

      if (param.direction == ParamDirection.In)
        processArrayInParam(param);
      else if (param.direction == ParamDirection.Out)
        processArrayOutParam(param);
      else
        assert(0); // Should be prevented by verify()
      return;
    }
    else if (param.containerType != ContainerType.None) // Other type of container?
    {
      if (param.direction == ParamDirection.In)
        processContainerInParam(param);
      else if (param.direction == ParamDirection.Out)
        processContainerOutParam(param);
      else
        assert(0, "InOut container parameter not supported for " ~ param.fullName.to!string);

      return;
    }
    else if (param.isClosure) // Closure data?
    {
      if (param.callbackIndex != NoCallback)
      {
        auto callbackParam = func.params[param.callbackIndex];
        auto freezeDeleg = callbackParam.scope_ != ParamScope.Call;

        // Duplicate delegate to malloc heap memory and pin the context if not Call scope
        preCall ~= "auto _" ~ callbackParam.dName ~ " = " ~ (freezeDeleg ? "freezeDelegate("d : ""d)
          ~ "cast(void*)&" ~ callbackParam.dName ~ (freezeDeleg ? ");\n"d : ";\n"d);
        addCallParam("_" ~ callbackParam.dName); // Pass the duplicate pinned delegate as closure data
      }
      else
        addCallParam("null"); // Pass null if there is no callback associated with this closure data

      return;
    }
    else if (param.isDestroy) // Destroy callback?
    {
      if (param.callbackIndex != NoCallback)
        addCallParam("&thawDelegate"); // Free the duplicate delegate and unpin the context
      else
        addCallParam("null"); // Pass null if there is no callback associated with this destroy notify

      return;
    }

    final switch (param.kind) with (TypeKind)
    {
      case Basic, BasicAlias:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);

        if (param.direction == ParamDirection.In)
          addCallParam(param.dName);
        else
          addCallParam("cast(" ~ param.cType ~ ")&" ~ param.dName);
        break;
      case Enum, Flags:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
        addCallParam((param.direction != ParamDirection.In ? "&"d : "") ~ param.dName);
        break;
      case String:
        addDeclParam(param.directionStr ~ "string " ~ param.dName);

        if (param.direction == ParamDirection.In)
        {
          preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ param.dName ~ ".toCString(" ~ param.fullOwnerFlag
            ~ ".Alloc);\n";
          addCallParam("_" ~ param.dName);
        }
        else if (param.direction == ParamDirection.Out)
        {
          preCall ~= "char* _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = _" ~ param.dName ~ ".fromCString(" ~ param.fullOwnerFlag ~ ".Free);\n";
        }
        else // InOut
          assert(0, "InOut string arguments not supported"); // FIXME - Does this even exist?

        break;
      case Simple:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
        addCallParam("&" ~ param.dName);
        break;
      case Pointer:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
        addCallParam((param.direction == ParamDirection.Out ? "&"d : ""d) ~ param.dName);
        break;
      case Callback:
        if (cast(Func)param.typeObjectRoot)
        {
          addDeclParam(param.dType ~ " " ~ param.dName);
          addCallParam("&_" ~ param.dName ~ "Callback");
        }
        else
        {
          addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
          addCallParam(param.dName);
        }
        break;
      case Opaque, Wrap, Boxed, Reffed, Object:
        if (param.direction == ParamDirection.In)
        {
          addDeclParam(param.dType ~ " " ~ param.dName);
          addCallParam(param.dName ~ " ? cast(" ~ param.cTypeRemPtr.stripConst ~ "*)" ~ param.dName ~ ".cPtr"
            ~ (!param.kind.among(TypeKind.Opaque, TypeKind.Wrap) ? ("(" ~ param.fullOwnerFlag ~ ".Dup)") : "") ~ " : null");
        }
        else if (param.direction == ParamDirection.Out)
        {
          addDeclParam("out " ~ param.dType ~ " " ~ param.dName);
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = " ~ "new " ~ param.dType;
          postCall ~= "(cast(void*)" ~ (param.cTypeRemPtr.endsWith('*') ? "_"d : "&_"d) ~ param.dName;
          postCall ~= (param.kind != TypeKind.Wrap ? (", " ~ param.fullOwnerFlag ~ ".Take") : "") ~ ");\n";
        }
        else // InOut
          assert(0, "InOut arguments of type '" ~ param.kind.to!string ~ "' not supported"); // FIXME - Does this even exist?
        break;
      case Interface:
        auto objectGSym = param.repo.defs.resolveSymbol("GObject.ObjectG");

        if (param.direction == ParamDirection.In)
        {
          addDeclParam(param.dType ~ " " ~ param.dName);
          addCallParam(param.dName ~ " ? cast(" ~ param.cTypeRemPtr.stripConst ~ "*)(cast(" ~ objectGSym ~ ")"
            ~ param.dName ~ ").cPtr(" ~ param.fullOwnerFlag ~ ".Dup) : null");
        }
        else if (param.direction == ParamDirection.Out)
        {
          addDeclParam("out " ~ param.dType ~ " " ~ param.dName);
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = " ~ objectGSym ~ ".getDObject!" ~ param.dType ~ "(_"
            ~ param.dName ~ ", " ~ param.fullOwnerFlag ~ ".Take);\n";
        }
        else // InOut
          assert(0, "InOut arguments of type '" ~ param.kind.to!string ~ "' not supported"); // FIXME - Does this even exist?
        break;
      case Unknown, Container, Namespace:
        assert(0, "Unsupported parameter type '" ~ param.dType.to!string ~ "' (" ~ param.kind.to!string ~ ") for "
            ~ param.fullName.to!string);
    }
  }

  // Process an array input parameter
  private void processArrayInParam(Param param)
  {
    auto elemType = param.elemTypes[0];

    if (elemType.dType == "char") // char[] arrays are sometimes used for strings with a length parameter
      addDeclParam("string " ~ param.dName);
    else
      addDeclParam(elemType.dType ~ "[] " ~ param.dName);

    addCallParam("_" ~ param.dName);

    assert(param.ownership == Ownership.None, "Function array parameter " ~ param.fullName.to!string
        ~ " ownership not supported"); // FIXME - Support for ownership Full/Container

    if (param.fixedSize != ArrayNotFixed) // Add an array size assertion if fixed size does not match
      preCall ~= "assert(!" ~ param.dName ~ " || " ~ param.dName ~ ".length == "
        ~ param.fixedSize.to!dstring ~ ");\n";

    final switch (elemType.kind) with (TypeKind)
    {
      case Basic, BasicAlias, Enum, Flags, Simple, Pointer:
        preCall ~= "auto _" ~ param.dName ~ " = cast(" ~ param.cType ~ ")";

        if (param.zeroTerminated) // If zero terminated, append a null or 0 value to the array and use the pointer to pass to the C function call
          preCall ~= "(" ~ param.dName ~ " ~ " ~ (elemType.cType.endsWith("*") ? "null" : elemType.cType ~ ".init")
            ~ ").ptr";
        else
          preCall ~= param.dName ~ ".ptr";

        preCall ~= ";\n";
        break;
      case String:
        preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";
        preCall ~= "foreach (s; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= s.toCString(No.Alloc);\n";

        if (param.zeroTerminated)
          preCall ~= "_tmp" ~ param.dName ~ " ~= null;\n";

        preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ "_tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
        break;
      case Wrap:
        preCall ~= elemType.cTypeRemPtr ~ "[] _tmp" ~ param.dName ~ ";\n";
        preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= obj.cInstance;\n";

        if (param.zeroTerminated)
          preCall ~= "_tmp" ~ param.dName ~ " ~= " ~ elemType.cTypeRemPtr ~ "();\n";

        preCall ~= param.cType ~ " _" ~ param.dName ~ " = _tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
        break;
      case Boxed:
        preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";

        preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= "
          ~ (elemType.cType.endsWith('*') ? ""d : "*"d) ~ "cast(" ~ elemType.cTypeRemPtr ~ "*)obj.cPtr;\n";

        if (param.zeroTerminated)
          preCall ~= "_tmp" ~ param.dName ~ ".length++;\n";

        preCall ~= param.cType ~ " _" ~ param.dName ~ " = _tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
        break;
      case Opaque, Reffed, Object:
        preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";

        preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= obj ? cast("
          ~ elemType.cTypeRemPtr.stripConst ~ "*)obj.cPtr : null;\n";

        if (param.zeroTerminated)
          preCall ~= "_tmp" ~ param.dName ~ " ~= null;\n";

        preCall ~= param.cType ~ " _" ~ param.dName ~ " = cast(" ~ param.cType ~ ")_tmp"
          ~ param.dName ~ ".ptr" ~ ";\n\n";
        break;
      case Interface:
        auto objectGSym = func.repo.defs.resolveSymbol("GObject.ObjectG");
        preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";

        preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName
          ~ " ~= obj ? cast(" ~ elemType.cTypeRemPtr.stripConst ~ "*)(cast(" ~ objectGSym ~ ")obj).cPtr : null;\n";

        if (param.zeroTerminated)
          preCall ~= "_tmp" ~ param.dName ~ " ~= null;\n";

        preCall ~= param.cType ~ " _" ~ param.dName ~ " = _tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
        break;
      case Unknown, Callback, Container, Namespace:
        assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
            ~ ") for " ~ param.fullName.to!string);
    }
  }

  // Process an array output parameter
  private void processArrayOutParam(Param param)
  {
    auto elemType = param.elemTypes[0];

    addDeclParam(param.directionStr ~ elemType.dType ~ "[] " ~ param.dName);

    dstring lengthStr;

    if (param.lengthParam) // Array has length parameter?
      lengthStr = "_" ~ param.lengthParam.dName;
    else if (param.fixedSize != ArrayNotFixed) // Array is a fixed size?
      lengthStr = param.fixedSize.to!dstring;
    else if (param.zeroTerminated) // Array is zero terminated?
    {
      postCall ~= "uint _len" ~ param.dName ~ ";\nif (_" ~ param.dName ~ ")\n{\nfor (; _" ~ param.dName
        ~ "[_len" ~ param.dName ~ "] " ~ (elemType.cTypeRemPtr.endsWith("*") ? "!is null"d : "!= 0") ~ "; _len" ~ param.dName
        ~ "++)\n{\n}\n}\n";
      lengthStr = "_len" ~ param.dName;
    }
    else
      assert(0); // This should be prevented by verify()

    final switch (elemType.kind) with (TypeKind)
    {
      case Basic, BasicAlias, Enum, Flags, Simple, Pointer:
        if (!param.callerAllocates)
        {
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          postCall ~= param.dName ~ "[0 .. $] = _" ~ param.dName ~ "[0 .. " ~ lengthStr ~ "];\n";

          if (param.ownership != Ownership.None)
            postCall ~= "safeFree(cast(void*)_" ~ param.dName ~ ");\n";
        }
        else
          addCallParam(param.dName ~ ".ptr");
        break;
      case String:
        if (!param.callerAllocates)
        {
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ "[i] = _" ~ param.dName ~ "[i].fromCString("
            ~ param.fullOwnerFlag ~ ".Free);\n";

          if (param.ownership != Ownership.None)
            postCall ~= "safeFree(cast(void*)_" ~ param.dName ~ ");\n";
        }
        else
        {
          preCall ~= elemType.cType ~ "[] _" ~ param.dName ~ ";\n";
          preCall ~= "_" ~ param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          addCallParam("_" ~ param.dName ~ ".ptr");
          postCall ~= param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ "[i] = _" ~ param.dName
            ~ "[i].fromCString(" ~ param.fullOwnerFlag ~ ".Free);\n";
        }
        break;
      case Opaque, Wrap, Boxed, Reffed:
        if (!param.callerAllocates)
        {
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ "[i] = new " ~ elemType.dType ~ "(cast(void*)_"
            ~ param.dName ~ "[i]" ~ (param.kind != Wrap ? (", " ~ param.fullOwnerFlag ~ ".Take") : "") ~ ");\n";

          if (param.ownership != Ownership.None)
            postCall ~= "safeFree(cast(void*)_" ~ param.dName ~ ");\n";
        }
        else
        {
          preCall ~= elemType.cType ~ "[] _" ~ param.dName ~ ";\n";
          preCall ~= "_" ~ param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          addCallParam("_" ~ param.dName ~ ".ptr");
          postCall ~= param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ "[i] = new " ~ elemType.dType
            ~ "(cast(void*)&_" ~ param.dName ~ "[i]" ~ (param.kind != Wrap ? (", " ~ param.fullOwnerFlag ~ ".Take")
            : "") ~ ");\n";

          if (param.ownership != Ownership.None)
            postCall ~= "safeFree(cast(void*)_" ~ param.dName ~ ");\n";
        }
        break;
      case Object, Interface:
        if (!param.callerAllocates)
        {
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ ".length = " ~ lengthStr ~ ";\n";

          auto objectGSym = func.repo.defs.resolveSymbol("GObject.ObjectG");
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ "[i] = " ~ objectGSym ~ ".getDObject!"
            ~ elemType.dType ~ "(_" ~ param.dName ~ "[i], " ~ param.fullOwnerFlag ~ ".Take);\n";

          if (!param.callerAllocates && param.ownership != Ownership.None)
            postCall ~= "safeFree(cast(void*)_" ~ param.dName ~ ");\n";
        }
        else
        {
          preCall ~= elemType.cType ~ "[] _" ~ param.dName ~ ";\n";
          preCall ~= "_" ~ param.dName ~ ".length = " ~ lengthStr ~ ";\n";
          addCallParam("_" ~ param.dName ~ ".ptr");
          postCall ~= param.dName ~ ".length = " ~ lengthStr ~ ";\n";

          auto objectGSym = func.repo.defs.resolveSymbol("GObject.ObjectG");
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ "[i] = " ~ objectGSym ~ ".getDObject!"
            ~ elemType.dType ~ "(cast(void*)&_" ~ param.dName ~ "[i], " ~ param.fullOwnerFlag ~ ".Take);\n";
        }
        break;
      case Unknown, Callback, Container, Namespace:
        assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
            ~ ") for " ~ param.fullName.to!string);
    }
  }

  // Process a container "in" parameter (except array)
  private void processContainerInParam(Param param)
  {
    dstring templateParams;

    switch (param.containerType) with(ContainerType)
    {
      case ByteArray:
        break;
      case Array, PtrArray:
        templateParams = "!(" ~ param.elemTypes[0].dType  ~ ", " ~ param.zeroTerminated.to!dstring ~ ")";
        break;
      case List, SList:
        templateParams = "!(" ~ param.elemTypes[0].dType ~ ")";
        break;
      case HashTable:
        templateParams = "!(" ~ param.elemTypes[0].dType ~ ", " ~ param.elemTypes[1].dType ~ ")";
        break;
      default:
        assert(0, "Unsupported 'in' container type '" ~ param.containerType.to!string ~ "' for "
          ~ param.fullName.to!string);
    }

    addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);

    preCall ~= "auto _" ~ param.dName ~ " = g" ~ param.containerType.to!dstring ~ "FromD" ~ templateParams ~ "("
      ~ param.dName ~ ");\n";

    if (param.ownership != Ownership.Full)
      preCall ~= "scope(exit) containerFree!(" ~ param.cType ~ ", " ~ param.elemTypes[0].dType ~ ", " ~ "GidOwnership."
        ~ param.ownership.to!dstring ~ ")(_" ~ param.dName ~ ");\n";

    addCallParam("_" ~ param.dName);
  }

  // Process a container "out" parameter (except array)
  private void processContainerOutParam(Param param)
  {
    dstring templateParams;

    switch (param.containerType) with(ContainerType)
    {
      case ByteArray:
        templateParams = "GidOwnership." ~ param.ownership.to!dstring;
        break;
      case Array, PtrArray, List, SList:
        templateParams = param.elemTypes[0].dType  ~ ", " ~ "GidOwnership." ~ param.ownership.to!dstring;
        break;
      case HashTable:
        templateParams = "!(" ~ param.elemTypes[0].dType ~ ", " ~ param.elemTypes[1].dType ~ ", "
          ~ "GidOwnership." ~ param.ownership.to!dstring;
        break;
      default:
        assert(0, "Unsupported 'out' container type '" ~ param.containerType.to!string ~ "' for "
          ~ param.fullName.to!string);
    }

    addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
    preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
    addCallParam("&_" ~ param.dName);
    postCall ~= param.dName ~ " = g" ~ param.containerType.to!dstring ~ "ToD!(" ~ templateParams ~ ")(_"
      ~ param.dName ~ ");\n";
  }

  /**
   * Write function binding to a CodeWriter.
   * Params:
   *   writer = Code writer to write to.
   *   moduleType = Module file type being written (defaults to ModuleType.Normal)
   */
  void write(CodeWriter writer, ModuleType moduleType = ModuleType.Normal)
  {
    auto isStatic = decl.startsWith("static");

    if (moduleType == ModuleType.IfaceTemplate && isStatic) // Skip static methods in interface template files (implemented in the interface definition file)
      return;

    func.writeDocs(writer);

    if (moduleType == ModuleType.Iface && !isStatic) // Interface module and not a static method? (Static methods are implemented in the interface below)
    {
      writer ~= decl ~ ";";
      return;
    }

    auto parentNode = cast(TypeNode)func.parent;

    // Add "override" for methods of an interface mixin template or if an ancestor/iface has a method with the same name
    if (parentNode && (parentNode.kind == TypeKind.Interface || func.needOverride) && !isStatic)
      writer ~= "override " ~ decl;
    else
      writer ~= decl;

    writer ~= "{";

    if (preCall.length > 0)
      writer ~= preCall;

    writer ~= call;

    if (postCall.length > 0)
      writer ~= postCall;

    if (func.returnVal.origDType != "none" && !func.isCtor)
      writer ~= "return _retval;";

    writer ~= "}";
  }

  Func func; /// The function object being written
  dstring decl; /// Function declaration
  dstring preCall; /// Pre-call code for call return variable, call output parameter variables, and input variable processing
  dstring call; /// The C function call
  dstring postCall; /// Post-call code for return value processing, output parameter processing, and input variable cleanup
}

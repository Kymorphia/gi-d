module gir.func_writer;

import code_writer;
import defs;
import import_symbols;
import gir.deleg_writer;
import gir.func;
import gir.param;
import gir.type_node;
import std_includes;
import utils;

/// Function writer class
class FuncWriter
{
  this(Func func)
  {
    this.imports = new ImportSymbols(func.repo.namespace);
    imports.add("gid");
    imports.add("global");
    imports.add(func.repo.namespace ~ ".c.functions");
    imports.add(func.repo.namespace ~ ".c.types");
    this.func = func;
    process();
  }

  // Process the function
  private void process()
  {
    if (func.funcType != FuncType.Method && !func.isCtor && func.parent !is func.repo.globalStruct)
      decl ~= "static "; // Function is "static" if it is not a method, constructor, or global function

    if (func.throws)
    { // postCall for exceptions is order sensitive and must be handled before output and return processing
      postCall ~= "if (_err)\nthrow new " ~ func.errorDomain ~ "(_err);\n";
      imports.add("GLib.ErrorG");
    }

    // Write out any C callback embedded functions
    foreach (param; func.params)
    {
      if (param.kind == TypeKind.Callback && cast(Func)param.typeObject && !param.isDestroy)
      {
        if (param.scope_ == ParamScope.Call)
          preCall ~= "static " ~ param.dType ~ " _static_" ~ param.dName ~ ";\n\n";

        auto delegWriter = new DelegWriter(param);
        preCall ~= delegWriter.generate() ~ "\n";

        if (param.scope_ == ParamScope.Call)
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
    if (func.origDType == "none")
    {
      decl ~= "void ";
      return;
    }

    func.addImports(imports, func.repo); // Add imports required for return value type

    if (func.containerType == ContainerType.Array)
    {
      processReturnArray();
      return;
    }
    else if (func.containerType != ContainerType.None)
    {
      processReturnContainer();
      return;
    }

    final switch (func.kind) with (TypeKind)
    {
      case Basic, BasicAlias:
        decl ~= func.dType ~ " ";
        preCall ~= func.dType ~ " _retval;\n";
        call ~= "_retval = ";
        // postCall ~= func.dType ~ " _retval = cast(" ~ func.dType ~ ")_cretval;\n";
        break;
      case String:
        decl ~= "string ";
        preCall ~= func.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= "string _retval = _cretval.fromCString("d ~ func.fullOwnerStr ~ ");\n";
        break;
      case Enum, Flags:
        decl ~= func.dType ~ " ";
        preCall ~= func.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= func.dType ~ " _retval = cast(" ~ func.dType ~ ")_cretval;\n";
        break;
      case Simple:
        decl ~= func.dType ~ " ";
        preCall ~= func.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= func.dType ~ " _retval;\nif (_cretval)\n_retval = *_cretval;\n";
        break;
      case Callback:
        decl ~= func.dType ~ "* ";
        call ~= func.dType ~ "* _retval = ";
        break;
      case Opaque:
        decl ~= func.dType ~ " ";
        call ~= func.dType ~ " _retval = ";
        break;
      case Boxed:
        if (!func.isCtor)
          decl ~= func.dType ~ " ";

        preCall ~= func.cType ~ " _cretval;\n";
        call ~= "_cretval = ";

        if (!func.isCtor)
          postCall ~= func.dType ~ " _retval = new "d ~ func.dType ~ "(cast(" ~ func.cType.stripConst ~ ")_cretval, "
            ~ func.fullOwnerStr ~ ");\n";
        else // Constructor method
          postCall ~= "this(_cretval, " ~ func.fullOwnerStr ~ ");\n";
        break;
      case Wrap, Reffed, Object, Interface:
        if (!func.isCtor)
          decl ~= func.dType ~ " ";

        preCall ~= func.cType ~ " _cretval;\n";
        call ~= "_cretval = ";

        if (!func.isCtor)
        {
          postCall ~= func.dType ~ " _retval = " ~ ((func.kind == Object || func.kind == Interface)
            ? "ObjectG.getDObject!"d : "new "d);
          postCall ~= func.dType ~ "(cast(" ~ func.cType.stripConst ~ ")_cretval"
            ~ (func.kind != TypeKind.Wrap ? ", " ~ func.fullOwnerStr : "") ~ ");\n";
        }
        else // Constructor method
          postCall ~= "this(_cretval" ~ (func.kind != TypeKind.Wrap ? ", " ~ func.fullOwnerStr : "") ~ ");\n";

        if (func.kind == TypeKind.Object || func.kind == TypeKind.Interface)
          imports.add("GObject.ObjectG");
        break;
      case Unknown, Namespace:
        assert(0, "Unsupported return value type '" ~ func.dType.to!string ~ "' (" ~ func.kind.to!string ~ ") for "
            ~ func.fullName.to!string);
    }
  }

  /// Process array return value
  private void processReturnArray()
  {
    auto elemType = func.elemTypes[0];

    decl ~= elemType.dType ~ "[] ";
    preCall ~= func.cType ~ " _cretval;\n";
    call ~= "_cretval = ";
    postCall ~= elemType.dType ~ "[] _retval;\n";

    dstring lengthStr;

    postCall ~= "\nif (_cretval)\n{\n";

    if (func.lengthParamIndex >= 0) // Array has length parameter?
    {
      auto lengthParam = func.params[func.lengthParamIndex];
      preCall ~= lengthParam.dType ~ " _cretlength;\n";
      lengthStr = "_cretlength";
    }
    else if (func.fixedSize != ArrayNotFixed) // Array is a fixed size?
      lengthStr = func.fixedSize.to!dstring;
    else if (func.zeroTerminated) // Array is zero terminated?
    {
      postCall ~= "uint _cretlength;\nfor (; _cretval[_cretlength] != "d ~ (elemType.cType.endsWith("*") ? "null"d : "0")
        ~ "; _cretlength++)\nbreak;\n";
      lengthStr = "_cretlength";
    }
    else
      assert(0, "Function '" ~ func.fullName.to!string ~ "' return array has indeterminate length"); // This should be prevented by defs.fixupRepos()

    if (elemType.kind.among(TypeKind.Basic, TypeKind.BasicAlias, TypeKind.Enum))
      postCall ~= "_retval = cast(" ~ elemType.dType ~ "[])_cretval[0 .. " ~ lengthStr ~ "];\n";
    else
    {
      postCall ~= "_retval = new " ~ elemType.dType ~ "[" ~ lengthStr ~ "];\nforeach (i; 0 .. "
        ~ lengthStr ~ ")\n";

      final switch (elemType.kind) with (TypeKind)
      {
        case String:
          postCall ~= "_retval[i] = _cretval[i].fromCString(" ~ func.fullOwnerStr ~ ");\n";
          break;
        case Enum, Flags:
          postCall ~= "_retval[i] = cast(" ~ elemType.dType ~ ")(_cretval[i]);\n";
          break;
        case Simple:
          postCall ~= "_retval[i] = *cretval[i];\n";
          break;
        case Opaque:
          postCall ~= "_retval[i] = cretval[i];\n";
          break;
        case Wrap, Boxed, Reffed:
          postCall ~= "_retval[i] = new " ~ elemType.dType ~ "(_cretval[i], " ~ func.fullOwnerStr ~ ");\n";
          break;
        case Object, Interface:
          postCall ~= "_retval[i] = ObjectG.getDObject!" ~ elemType.dType ~ "(_cretval[i], "
            ~ func.fullOwnerStr ~ ");\n";
          imports.add("GObject.ObjectG");
          break;
        case Basic, BasicAlias, Callback, Unknown, Namespace:
          assert(0, "Unsupported return value array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType
              .kind.to!string
              ~ ") for " ~ func.fullName.to!string);
      }
    }

    postCall ~= "}\n";
  }

  /// Process a return container (not Array)
  private void processReturnContainer()
  {
    if (func.containerType == ContainerType.ByteArray)
    {
      decl ~= "ByteArray ";
      preCall ~= "GByteArray* _cretval;\n";
      call ~= "_cretval = ";
      postCall ~= "ByteArray _retval = _cretval ? new ByteArray(_cretval) : null;\n";
      imports.add("GLib.ByteArray");
      return;
    }
    else if (func.containerType == ContainerType.HashTable)
    {
      auto mapType = func.elemTypes[1].dType ~ "[" ~ func.elemTypes[0].dType ~ "]";
      decl ~= mapType ~ " ";
      preCall ~= "GHashTable* _cretval;\n";
      call ~= "_cretval = ";
      postCall ~= mapType ~ " _retval = _cretval ? hashTableToMap!(" ~ func.elemTypes[0].dType ~ ", "
        ~ func.elemTypes[1].dType ~ ", " ~ func.fullOwnerStr ~ ")(_cretval) : null;\n";
      imports.add("GLib.global");
      return;
    }

    auto dContainer = func.dType ~ "!(";

    foreach (i, elemType; func.elemTypes)
    {
      if (i != 0)
        dContainer ~= ", ";

      dContainer ~= elemType.dType ~ ", " ~ elemType.cType;
    }

    dContainer ~= ")";

    decl ~= dContainer ~ " ";
    preCall ~= func.cType ~ "* _cretval;\n";
    call ~= "_cretval = ";
    postCall ~= dContainer ~ " _retval = _cretval ? new " ~ dContainer ~ "(_cretval) : null;\n";
  }

  /// Process parameter
  private void processParam(Param param)
  {
    if (param.isInstanceParam) // Instance parameter?
    {
      call ~= "cPtr" ~ "!" ~ param.cTypeRemPtr.stripConst;
      return;
    }

    param.addImports(imports, func.repo);

    if (param.isArrayLength) // Array length parameter?
    {
      if (param.arrayParamIndex == ParamIndexReturnVal) // Return array length parameter is handled in processReturnArray()
      {
        addCallParam("&_cretlength");
        return;
      }

      auto arrayParam = func.params[param.arrayParamIndex];

      if (param.direction == ParamDirection.Out)
      {
        preCall ~= param.dType ~ " _" ~ param.dName ~ ";\n";
        addCallParam("&_" ~ param.dName);
      }
      else if (param.direction == ParamDirection.InOut)
      {
        preCall ~= param.dType ~ " _" ~ param.dName ~ (
            " = " ~ arrayParam.dName ~ " ? " ~ arrayParam.dName
            ~ ".length : 0;\n");
        addCallParam("&_" ~ param.dName);
      }
      else // Input
        addCallParam(arrayParam.dName ~ " ? cast(" ~ param.cType ~ ")" ~ arrayParam.dName ~ ".length : 0");

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
    else if (param.isClosure) // Closure data?
    {
      if (param.callbackIndex != NoCallback)
      {
        auto callbackParam = func.params[param.callbackIndex];

        if (param.scope_ != ParamScope.Call)
          preCall ~= "ptrFreezeGC(cast(void*)&" ~ callbackParam.dName ~ ");\n"; // Add delegate as a GC root so it doesn't get collected when there are no D pointers to it

        addCallParam("cast(void*)&" ~ callbackParam.dName); // Pass the delegate as closure data
      }
      else
        addCallParam("null"); // Pass null if there is no callback associated with this closure data

      return;
    }
    else if (param.isDestroy) // Destroy callback?
    {
      if (param.callbackIndex != NoCallback)
        addCallParam("&ptrThawDestroyNotify"); // Remove delegate from the GC root when the closure is no longer used by the C code
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
        preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ (param.direction != ParamDirection.Out ? "cast("
            ~ param.cType ~ ")" ~ param.dName : "") ~ ";\n";
        addCallParam((param.direction != ParamDirection.In ? "&_"d : "_") ~ param.dName);

        if (param.direction != ParamDirection.In)
          postCall ~= param.dName ~ " = cast(" ~ param.dType ~ ")_" ~ param.dName ~ ";\n";
        break;
      case String:
        addDeclParam(param.directionStr ~ "string " ~ param.dName);

        if (param.direction == ParamDirection.In)
        {
          preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ param.dName ~ ".toCString("
            ~ (
                param.ownership == Ownership.Full).to!dstring ~ ");\n";
          addCallParam("_" ~ param.dName);
        }
        else if (param.direction == ParamDirection.Out)
        {
          preCall ~= "char* _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = _" ~ param.dName ~ ".fromCString("
            ~ (param.ownership == Ownership.Full)
              .to!dstring ~ ");\n";
        }
        else // InOut
          assert(0, "InOut string arguments not supported"); // FIXME - Does this even exist?

        break;
      case Simple:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
        addCallParam("&" ~ param.dName);
        break;
      case Opaque:
        addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
        addCallParam(param.dName);
        break;
      case Callback:
        if (cast(Func)param.typeObject)
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
      case Wrap, Boxed, Reffed, Object, Interface:
        if (param.direction == ParamDirection.In)
        {
          addDeclParam(param.dType ~ " " ~ param.dName);
          addCallParam(param.dName ~ " ? " ~ param.dName ~ ".cPtr!" ~ param.cTypeRemPtr.stripConst ~ " : null");
        }
        else if (param.direction == ParamDirection.Out)
        {
          addDeclParam("out " ~ param.dType ~ " " ~ param.dName);
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = " ~ "new " ~ param.dType;
          postCall ~= (param.cTypeRemPtr.endsWith('*') ? "(_"d : "(&_"d) ~ param.dName;
          postCall ~= (param.kind != TypeKind.Wrap ? (", " ~ param.fullOwnerStr) : "") ~ ");\n";
        }
        else // InOut
          assert(0, "InOut arguments of type '" ~ param.kind.to!string ~ "' not supported"); // FIXME - Does this even exist?
        break;
      case Unknown, Namespace:
        assert(0, "Unsupported parameter type '" ~ param.dType.to!string ~ "' (" ~ param.kind.to!string ~ ") for "
            ~ func.fullName.to!string);
    }
  }

  // Process an array parameter
  private void processArrayParam(Param param)
  {
    auto elemType = param.elemTypes[0];

    if (param.direction == ParamDirection.In && elemType.dType == "char") // char[] arrays are sometimes used for strings with a length parameter
      addDeclParam("string " ~ param.dName);
    else
      addDeclParam(param.directionStr ~ elemType.dType ~ "[] " ~ param.dName);

    if (param.direction != ParamDirection.In && param.callerAllocates)
    {
      addCallParam(param.dName ~ ".ptr");
      return;
    }

    addCallParam((param.direction == ParamDirection.In ? "_" :"&_"d) ~ param.dName);

    // Pre C function call processing
    if (param.direction == ParamDirection.In || param.direction == ParamDirection.InOut)
    {
      assert(param.ownership == Ownership.None, "Function array parameter " ~ param.fullName.to!string
          ~ " ownership not supported"); // FIXME - Support for ownership Full/Container

      if (param.fixedSize != ArrayNotFixed) // Add an array size assertion if fixed size does not match
        preCall ~= "assert(!" ~ param.dName ~ " || " ~ param.dName ~ ".length == "
          ~ param.fixedSize.to!dstring ~ ");\n";

      final switch (elemType.kind) with (TypeKind)
      {
        case Basic, BasicAlias, Enum, Flags, Simple, Opaque:
          dstring ptrStr;

          if (param.zeroTerminated) // If zero terminated, append a null or 0 value to the array and use the pointer to pass to the C function call
            ptrStr = "(" ~ param.dName ~ " ~ " ~ (elemType.cType.endsWith("*") ? "null"d : "0"d) ~ ").ptr";
          else
            ptrStr = param.dName ~ ".ptr";

          preCall ~= "auto _" ~ param.dName ~ " = cast(" ~ param.cType ~ ")" ~ ptrStr ~ ";\n";
          break;
        case String:
          preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";
          preCall ~= "foreach (s; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= s.toCString(false);\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= null;\n";

          preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ "_tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
          break;
        case Wrap:
          preCall ~= elemType.cTypeRemPtr ~ "[] _tmp" ~ param.dName ~ ";\n";
          preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= obj.cInstance;\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= " ~ elemType.cType ~ "();\n";

          preCall ~= param.cType ~ " _" ~ param.dName ~ " = _tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
          break;
        case Boxed:
          preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";

          preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= "
            ~ (elemType.cType.endsWith('*') ? ""d : "*"d) ~ "obj.cPtr!"
            ~ elemType.cTypeRemPtr.stripConst ~ ";\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ ".length++;\n";

          preCall ~= param.cType ~ " _" ~ param.dName ~ " = _tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
          break;
        case Reffed, Object, Interface:
          preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";

          preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= obj ? obj.cPtr!"
            ~ elemType.cTypeRemPtr.stripConst ~ " : null;\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= null;\n";

          preCall ~= param.cType ~ " _" ~ param.dName ~ " = _tmp" ~ param.dName ~ ".ptr" ~ ";\n\n";
          break;
        case Unknown, Callback, Namespace:
          assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
              ~ ") for " ~ func.fullName.to!string);
      }
    }

    // Post C function call processing
    if (param.direction == ParamDirection.Out || param.direction == ParamDirection.InOut)
    {
      dstring lengthStr;

      if (param.lengthParamIndex >= 0) // Array has length parameter?
        lengthStr = "_" ~ func.params[param.lengthParamIndex].dName;
      else if (param.fixedSize != ArrayNotFixed) // Array is a fixed size?
        lengthStr = param.fixedSize.to!dstring;
      else if (param.zeroTerminated) // Array is zero terminated?
      {
        postCall ~= "uint _len" ~ param.dName ~ ";\nif (_" ~ param.dName ~ ")\nfor (; _" ~ param.dName
          ~ "[_len" ~ param.dName ~ "] != " ~ (elemType.cType.endsWith("*") ? "null"d : "0") ~ "; _len" ~ param.dName
          ~ "++)\nbreak;\n";
        lengthStr = "_len" ~ param.dName;
      }
      else
        assert(0); // This should be prevented by defs.fixupRepos()

      preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";

      final switch (elemType.kind) with (TypeKind)
      {
        case Basic, BasicAlias, Enum, Flags, Simple, Opaque:
          postCall ~= param.dName ~ " = _" ~ param.dName ~ "[0 .. " ~ lengthStr ~ "];\n";

          if (param.ownership != Ownership.None)
          {
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
            imports.add("GLib.c.functions");
          }
          break;
        case String:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= _" ~ param.dName ~ "[i].fromCString("
            ~ (
                param.ownership == Ownership.Full).to!dstring ~ ");\n";

          if (param.ownership != Ownership.None)
          {
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
            imports.add("GLib.c.functions");
          }
          break;
        case Wrap, Boxed, Reffed:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= new " ~ elemType.dType ~ "("
            ~ param.dName ~ "[i]" ~ (param.kind != Wrap ? ", " ~ param.fullOwnerStr : "") ~ ");\n";

          if (param.direction == ParamDirection.Out && param.ownership != Ownership.None)
          { // Free the output array container (FIXME - Not positive on this and what about inout?)
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
            imports.add("GLib.c.functions");
          }
          break;
        case Object, Interface:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= ObjectG.getDObject(_" ~ param.dName
            ~ "[i], " ~ param.fullOwnerStr ~ ");\n";
          imports.add("GObject.ObjectG");

          if (param.ownership != Ownership.None)
          {
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
            imports.add("GLib.c.functions");
          }
          break;
        case Unknown, Callback, Namespace:
          assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
              ~ ") for " ~ func.fullName.to!string);
      }
    }
  }

  // Process a container parameter (except array)
  private void processContainerParam(Param param)
  {
    if (param.containerType == ContainerType.HashTable) // Hash tables are converted into dlang associative arrays
    {
      assert(param.direction == ParamDirection.Out, "Function container HashTable parameter '" ~ param
          .fullName.to!string
          ~ "' direction not supported '" ~ param.direction.to!string ~ "'");

      auto mapType = param.elemTypes[1].dType ~ "[" ~ param.elemTypes[0].dType ~ "]";
      addDeclParam(mapType ~ " " ~ param.dName);

      preCall ~= "GHashTable* _cretval;\n";
      call ~= "_cretval = ";
      postCall ~= mapType ~ " _retval = _cretval ? hashTableToMap!(" ~ func.elemTypes[0].dType ~ ", "
        ~ func.elemTypes[1].dType ~ ", " ~ param.fullOwnerStr ~ ")(_cretval) : null;\n";
      imports.add("GLib.global");
      return;
    }

    addDeclParam(param.directionStr ~ param.dType ~ " " ~ param.dName);
    auto elemType = param.elemTypes[0];

    final switch(param.direction) with(ParamDirection)
    {
      case In:
        final switch(param.ownership) with(Ownership)
        {
          case None:
            addCallParam(param.dName ~ ".cPtr");
            break;
          case Container, Full, Unset:
            assert(0, "Unsupported parameter container " ~ param.dType.to!string ~ " direction "
              ~ param.direction.to!string);
        }
        break;
      case Out:
        preCall ~= param.cType ~ " _" ~ param.dName ~ ";\n";
        addCallParam("&_" ~ param.dName);
        postCall ~= param.dName ~ " = new " ~ param.dType ~ "!(" ~ elemType.dType ~ ", " ~ elemType.cType
          ~ ")(_" ~ param.dName ~ ", GidOwnership." ~ param.ownership.to!dstring ~ ");\n";
        break;
      case InOut:
        final switch(param.ownership) with(Ownership)
        {
          case None, Container, Full, Unset:
            assert(0, "Unsupported parameter container " ~ param.dType.to!string ~ " direction "
              ~ param.direction.to!string);
        }
    }
  }

  /**
   * Write function binding to a CodeWriter.
   * Params:
   *   writer = Code writer to write to.
   *   ifaceModule = Set to true when writing interface module (defaults to false which writes function for mixin template module)
   */
  void write(CodeWriter writer, bool ifaceModule = false)
  {
    func.writeDocs(writer);

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

    if (func.origDType != "none" && !func.isCtor)
      writer ~= "return _retval;";

    writer ~= "}";
  }

  Func func; /// The function object being written
  ImportSymbols imports; /// Import symbols needed to support the function
  dstring decl; /// Function declaration
  dstring preCall; /// Pre-call code for call return variable, call output parameter variables, and input variable processing
  dstring call; /// The C function call
  dstring postCall; /// Post-call code for return value processing, output parameter processing, and input variable cleanup
}

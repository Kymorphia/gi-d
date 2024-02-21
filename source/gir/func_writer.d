module gir.func_writer;

import code_writer;
import defs;
import import_symbols;
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
    auto isCtor = func.funcType == FuncType.Constructor && func.name == "new";

    if (func.funcType != FuncType.Method && !isCtor && func.parent !is func.repo.globalStruct)
      decl ~= "static "; // Function is "static" if it is not a method, constructor, or global function

    processReturn();

    decl ~= isCtor ? "this(" : func.dName ~ "(";
    call ~= func.cName ~ "(";

    foreach (param; func.params)
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

  /**
   * Ternary helper function
   * Params:
   *   expr = Expression to check
   *   ptr = Pointer value to use if val is not null (if this argument is null, expr is used)
   * Returns: A ternary operator string
   */
  private dstring valOrNull(dstring expr, dstring ptr = null)
  {
    return expr ~ " ? " ~ ptr ? ptr : expr ~ " : null";
  }

  /// Process return value
  private void processReturn()
  {
    if (func.origDType == "none")
    {
      decl ~= "void ";
      return;
    }

    func.addImports(imports, func.repo);

    if (func.containerType == ContainerType.Array)
    {
      processReturnArray();
      return;
    }
    else if (func.containerType == ContainerType.ByteArray)
    {
      decl ~= "ByteArray ";
      preCall ~= "GByteArray* _cretval;\n";
      call ~= "_cretval = ";
      postCall ~= "ByteArray _retval = _cretval ? new ByteArray(_cretval) : null;\n";
      return;
    }
    else if (func.containerType != ContainerType.None)
    {
      processReturnContainer();
      return;
    }

    auto kind = func.kind;
    auto isCtor = func.funcType == FuncType.Constructor && func.name == "new";

    final switch(kind) with(TypeKind)
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
        postCall ~= "string _retval = _cretval.fromCString("d ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
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
      case Opaque:
      case Callback:
        decl ~= func.dType ~ "* ";
        call ~= func.dType ~ "* _retval = ";
        break;
      case Wrap:
        decl ~= func.dType ~ " ";
        preCall ~= func.cType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= func.dType ~ " _retval;\n_retval = new " ~ func.dType ~ "(_cretval);\n";
        break;
      case Boxed, Reffed, Object:
        if (!isCtor)
          decl ~= func.dType ~ " ";

        preCall ~= func.cType ~ " _cretval;\n";
        call ~= "_cretval = ";

        if (!isCtor)
        {
          postCall ~= func.dType ~ " _retval = "d ~ (kind == Object ? "ObjectG.getDObject!"d : "new ")
            ~ func.dType ~ "(cast(" ~ func.cType.stripConst ~ ")_cretval, "
            ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
        }
        else // Constructor method
          postCall ~= "this(_cretval, " ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
        break;
      case Unknown, Interface, Namespace:
        assert(0, "Unsupported return value type '" ~ func.dType.to!string ~ "' (" ~ kind.to!string ~ ") for "
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

    if (elemType.kind.among (TypeKind.Basic, TypeKind.BasicAlias, TypeKind.Enum))
      postCall ~= "_retval = cast(" ~ elemType.dType  ~ "[])_cretval[0 .. " ~ lengthStr ~ "];\n";
    else
    {
      postCall ~= "_retval = new "~ elemType.dType ~ "[" ~ lengthStr ~ "];\nforeach (i; 0 .. "
        ~ lengthStr ~ ")\n";

      final switch (elemType.kind) with(TypeKind)
      {
        case String:
          postCall ~= "_retval[i] = _cretval[i].fromCString(" ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
          break;
        case Flags:
          postCall ~= "_retval[i] = cast(" ~ elemType.dType ~ ")(_cretval[i]);\n";
          break;
        case Simple:
          postCall ~= "_retval[i] = *cretval[i];\n";
          break;
        case Opaque:
          postCall ~= "_retval[i] = cretval[i];\n";
          break;
        case Wrap, Boxed, Reffed:
          postCall ~= "_retval[i] = new " ~ elemType.dType ~ "(_cretval[i], "
            ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
          break;
        case Object:
          postCall ~= "_retval[i] = ObjectG.getDObject!" ~ elemType.dType ~ "(_cretval[i], "
            ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
          break;
        case Basic, BasicAlias, Callback, Enum, Unknown, Interface, Namespace:
          assert(0, "Unsupported return value array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
            ~ ") for " ~ func.fullName.to!string);
      }
    }

    postCall ~= "}\n";
  }

  /// Process a return container (not Array or ByteArray)
  private void processReturnContainer()
  {
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
      call ~= (call.endsWith('(') ? ""d : ", ") ~ "cPtr";

      if (param.kind == TypeKind.Object)
        call ~= "!" ~ param.cTypeRemPtr;

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
        preCall ~= param.dType ~ " _" ~ param.dName ~ (" = " ~ arrayParam.dName ~ " ? " ~ arrayParam.dName
          ~ ".length : 0;\n");
        addCallParam("&_" ~ param.dName);
      }
      else // Input
        addCallParam(arrayParam.dName ~ " ? cast(" ~ param.cType ~ ")" ~ arrayParam.dName ~ ".length : 0");

      return;
    }

    if (param.containerType == ContainerType.Array)
    {
      processArrayParam(param);
      return;
    }
    else if (param.containerType != ContainerType.None)
    {
      assert(param.ownership != Ownership.None, "Function container parameter '" ~ param.fullName.to!string
        ~ "' ownership not supported '" ~ param.ownership.to!string ~ "'");
      addDeclParam(param.dType ~ " " ~ param.dName);
      addCallParam(param.dName ~ ".cPtr");
      return;
    }

    auto isInput = param.direction == ParamDirection.In;

    final switch(param.kind) with(TypeKind)
    {
      case Basic, BasicAlias:
        addDeclParam((!isInput ? ParamDirectionValues[param.direction] ~ " " : "") ~ param.dType
          ~ " " ~ param.dName);

        if (isInput)
          addCallParam(param.dName);
        else
          addCallParam("cast(" ~ param.cType ~ ")&" ~ param.dName);
        break;
      case Enum:
        addDeclParam((!isInput ? ParamDirectionValues[param.direction] ~ " " : "") ~ param.dType
          ~ " " ~ param.dName);
        preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ (param.direction != ParamDirection.Out ? "cast("
          ~ param.cType ~ ")" ~ param.dName : "") ~ ";\n";
        addCallParam((!isInput ? "&_"d : "_") ~ param.dName);

        if (!isInput)
          postCall ~= param.dName ~ " = cast(" ~ param.dType ~ ")_" ~ param.dName ~ ";\n";
        break;
      case Flags:
        if (param.direction == ParamDirection.In)
        {
          addDeclParam(param.dType ~ " " ~ param.dName);
          preCall ~= param.cType ~ " _" ~ param.dName ~ " = cast(" ~ param.cType ~ ")cast(uint)" ~ param.dName ~ ";\n";
          addCallParam("_" ~ param.dName);
        }
        else if (param.direction == ParamDirection.Out)
        {
          addDeclParam("out " ~ param.dType ~ " " ~ param.dName);
          preCall ~= param.cType ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = cast(" ~ param.dType ~ ")_" ~ param.dName ~ ";\n";
        }
        else // InOut
        {
          addDeclParam("inout " ~ param.dType ~ " " ~ param.dName);
          preCall ~= param.cType ~ " _" ~ param.dName ~ " = cast(" ~ param.cType ~ ")cast(uint)" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = cast(" ~ param.dType ~ ")_" ~ param.dName ~ ";\n";
        }
        break;
      case String:
        addDeclParam((!isInput ? ParamDirectionValues[param.direction] ~ " " : "") ~ "string " ~ param.dName);

        if (param.direction == ParamDirection.In)
        {
          preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ param.dName ~ ".toCString("
            ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
          addCallParam("_" ~ param.dName);
        }
        else if (param.direction == ParamDirection.Out)
        {
          preCall ~= "char* _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = _" ~ param.dName ~ ".fromCString("
            ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
        }
        else // InOut
          assert(0, "InOut string arguments not supported"); // FIXME - Does this even exist?

        break;
      case Simple:
        addDeclParam((!isInput ? ParamDirectionValues[param.direction] ~ " " : "") ~ param.dType
          ~ " " ~ param.dName);
        addCallParam("&" ~ param.dName);
        break;
      case Opaque:
      case Callback:
        addDeclParam((!isInput ? ParamDirectionValues[param.direction] ~ " " : "") ~ param.dType
          ~ " " ~ param.dName);
        addCallParam(param.dName);
        break;
      case Wrap, Boxed, Reffed, Object:
        if (param.direction == ParamDirection.In)
        {
          addDeclParam(param.dType ~ " " ~ param.dName);

          if (param.kind == TypeKind.Object)
            addCallParam(param.dName ~ " ? " ~ param.dName ~ ".cPtr!" ~ param.cTypeRemPtr ~ " : null");
          else
            addCallParam(param.dName ~ " ? " ~ param.dName ~ ".cPtr : null");
        }
        else if (param.direction == ParamDirection.Out)
        {
          addDeclParam("out " ~ param.dType ~ " " ~ param.dName);
          preCall ~= param.cTypeRemPtr ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);

          if (param.kind == TypeKind.Wrap)
            postCall ~= param.dName ~ " = " ~ "new " ~ param.dType ~ "(&_"d ~ param.dName ~ ");\n";
          else
            postCall ~= param.dName ~ " = " ~ "new " ~ param.dType ~ "(_" ~ param.dName ~ ", "
              ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
        }
        else // InOut
          assert(0, "InOut arguments of type '" ~ param.kind.to!string ~ "' not supported"); // FIXME - Does this even exist?
        break;
      case Unknown, Interface, Namespace:
        assert(0, "Unsupported parameter type '" ~ param.dType.to!string ~ "' (" ~ param.kind.to!string ~ ") for "
          ~ func.fullName.to!string);
    }
  }

  // Process an array parameter
  private void processArrayParam(Param param)
  {
    auto elemType = param.elemTypes[0];

    if (param.direction != ParamDirection.In)
    {
      addDeclParam(ParamDirectionValues[param.direction] ~ " " ~ elemType.dType ~ "[] " ~ param.dName);
      addCallParam("&_"d ~ param.dName);
    }
    else
    {
      if (elemType.dType == "char") // char[] arrays are sometimes used for strings with a length parameter
        addDeclParam("string " ~ param.dName);
      else
        addDeclParam(elemType.dType ~ "[] " ~ param.dName);

      addCallParam("_" ~ param.dName);
    }

    if (param.direction == ParamDirection.In || param.direction == ParamDirection.InOut)
    {
      assert(param.ownership == Ownership.None, "Function array parameter " ~ param.fullName.to!string
        ~ " ownership not supported"); // FIXME - Support for ownership Full/Container

      if (param.fixedSize != ArrayNotFixed) // Add an array size assertion if fixed size does not match
        preCall ~= "assert(!" ~ param.dName ~ " || " ~ param.dName ~ ".length == "
          ~ param.fixedSize.to!dstring ~ ");\n";

      final switch (elemType.kind) with(TypeKind)
      {
        case Basic, BasicAlias, Enum, Flags, Simple, Opaque:
          dstring ptrStr;

          if (param.zeroTerminated) // If zero terminated, append a null or 0 value to the array and use the pointer to pass to the C function call
            ptrStr = "(" ~ param.dName ~ " ~ " ~ elemType.cType.endsWith("*") ? "null" : "0" ~ ").ptr";
          else
            ptrStr = param.dName ~ ".ptr";

          preCall ~= "auto _" ~ param.dName ~ " = cast(" ~ param.cType ~ ")" ~ valOrNull (param.dName, ptrStr) ~ ";\n";
          break;
        case String:
          preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";
          preCall ~= "foreach (s; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= s.toCString(false);\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= null;\n";

          preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ valOrNull (param.dName, "_tmp" ~ param.dName
            ~ ".ptr") ~ ";\n\n";
          break;
        case Wrap:
          preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";
          preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= *obj.cPtr;\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= " ~ elemType.cType ~ "();\n";

          preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ valOrNull (param.dName, "_tmp" ~ param.dName ~ ".ptr")
            ~ ";\n\n";
          break;
        case Boxed, Reffed, Object:
          preCall ~= elemType.cType ~ "[] _tmp" ~ param.dName ~ ";\n";

          if (elemType.kind == TypeKind.Object)
            preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= obj ? obj.cPtr!"
              ~ elemType.cTypeRemPtr ~ " : null;\n";
          else
            preCall ~= "foreach (obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= obj ? obj.cPtr : null;\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= null;\n";

          preCall ~= param.cType ~ " _" ~ param.dName ~ " = " ~ valOrNull (param.dName, "_tmp" ~ param.dName ~ ".ptr")
            ~ ";\n\n";
          break;
        case Unknown, Callback, Interface, Namespace:
          assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
            ~ ") for " ~ func.fullName.to!string);
      }
    }

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

      final switch (elemType.kind) with(TypeKind)
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
            ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";

          if (param.ownership != Ownership.None)
          {
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
            imports.add("GLib.c.functions");
          }
          break;
        case Wrap, Boxed, Reffed:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= new " ~ elemType.dType ~ "("
            ~ param.dName ~ "[i], " ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";

          if (param.ownership != Ownership.None)
          {
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
            imports.add("GLib.c.functions");
          }
          break;
        case Object:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach (i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= ObjectG.getDObject(_" ~ param.dName
            ~ "[i], " ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";

          if (param.ownership != Ownership.None)
          {
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
            imports.add("GLib.c.functions");
          }
          break;
        case Unknown, Callback, Interface, Namespace:
          assert(0, "Unsupported parameter array type '" ~ elemType.dType.to!string ~ "' (" ~ elemType.kind.to!string
            ~ ") for " ~ func.fullName.to!string);
      }
    }
  }

  /**
   * Write function binding to a CodeWriter.
   * Params:
   *   writer = Code writer to write to.
   */
  void write(CodeWriter writer)
  {
    func.writeDocs(writer);

    writer ~= decl;
    writer ~= "{";

    if (preCall.length > 0)
      writer ~= preCall;

    writer ~= call;

    if (postCall.length > 0)
      writer ~= postCall;

    auto isCtor = func.funcType == FuncType.Constructor && func.name == "new";

    if (func.origDType != "none" && !isCtor)
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

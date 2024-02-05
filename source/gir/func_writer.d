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
    if (func.dType == "none")
    {
      decl ~= "void ";
      return;
    }

    if (func.isArray)
    {
      processReturnArray();
      return;
    }

    auto kind = func.kind;
    auto isCtor = func.funcType == FuncType.Constructor && func.name == "new";

    final switch(kind) with(TypeKind)
    {
      case Basic:
        decl ~= func.subDType ~ " ";
        preCall ~= func.subDType ~ " _retval;\n";
        call ~= "_retval = ";
        // postCall ~= func.subDType ~ " _retval = cast(" ~ func.subDType ~ ")_cretval;\n";
        break;
      case String:
        decl ~= "string ";
        preCall ~= func.subCType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= "string _retval = _cretval.fromCString("d ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
        break;
      case Enum, Flags:
        decl ~= func.subDType ~ " ";
        preCall ~= func.subCType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= func.subDType ~ " _retval = cast(" ~ func.subDType ~ ")_cretval;\n";
        break;
      case Simple:
        decl ~= func.subDType ~ " ";
        preCall ~= func.subCType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= func.subDType ~ " _retval;\nif (_cretval)\n_retval = *_cretval;\n";
        break;
      case Opaque:
        decl ~= func.subDType ~ "* ";
        call ~= func.subDType ~ "* _cretval = ";
        break;
      case Wrap:
        decl ~= func.subDType ~ " ";
        preCall ~= func.subCType ~ " _cretval;\n";
        call ~= "_cretval = ";
        postCall ~= func.subDType ~ " _retval;\n_retval = new " ~ func.subDType ~ "(_cretval);\n";
        imports.add(func.subDType.canFind(".") ? func.subDType : func.repo.namespace ~ "." ~ func.subDType);
        break;
      case Boxed, Reffed, Object:
        if (!isCtor)
          decl ~= func.subDType ~ " ";

        preCall ~= func.subCType ~ " _cretval;\n";
        call ~= "_cretval = ";

        if (!isCtor)
        {
          postCall ~= func.subDType ~ " _retval = "d ~ (kind == Object ? "ObjectG.getDObject!"d : "new ")
            ~ func.subDType ~ "(_cretval, " ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
          imports.add(func.subDType);

          if (kind == Object)
            imports.add("GObject.ObjectG");
        }
        else // Constructor method
          postCall ~= "this(_cretval, " ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
        break;
      case Unknown, Interface, Namespace:
        assert(0, "Unsupported return value type '" ~ func.subDType.to!string ~ "' (" ~ kind.to!string ~ ") for "
          ~ func.repo.namespace.to!string ~ "." ~ func.name.to!string);
    }
  }

  /// Process array return value
  private void processReturnArray()
  {
    decl ~= func.subDType ~ "[] ";
    preCall ~= func.subCType ~ " _cretval;\n";
    call ~= "_cretval = ";
    postCall ~= func.subDType ~ "[] _retval;\n";

    auto kind = func.kind;
    dstring lengthStr;

    postCall ~= "if (_cretval)\n{\n";

    if (func.lengthParamIndex >= 0) // Array has length parameter?
    {
      auto lengthParam = func.params[func.lengthParamIndex];
      preCall ~= lengthParam.subCType ~ " _cretlength;\n";
      lengthStr = "_cretlength";
    }
    else if (func.fixedSize != ArrayNotFixed) // Array is a fixed size?
      lengthStr = func.fixedSize.to!dstring;
    else if (func.zeroTerminated) // Array is zero terminated?
    {
      postCall ~= "uint _cretlength;\nfor (; _cretval[i] != "d ~ (func.subCType.endsWith("*") ? "null"d : "0")
        ~ "; _cretlength++)\nbreak;\n";
      lengthStr = "_cretlength";
    }
    else
      assert(0); // This should be prevented by defs.fixupRepos()

    if (kind.among (TypeKind.Basic, TypeKind.Enum))
      postCall ~= "\n" ~ func.subDType ~ "[] _retval = _cretval[0 .. " ~ lengthStr ~ "];\n";
    else
    {
      postCall ~= "\nauto _retval = new "~ func.subDType ~ "[" ~ lengthStr ~ "];\nforeach (i; 0 .. " ~ lengthStr ~ ")\n";

      final switch (kind) with(TypeKind)
      {
        case String:
          postCall ~= "_retval[i] = _cretval[i].fromCString(" ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
          break;
        case Flags:
          postCall ~= "_retval[i] = cast(" ~ func.subDType ~ ")(_cretval[i]);\n";
          break;
        case Simple:
          postCall ~= "_retval[i] = *cretval[i];\n";
          break;
        case Opaque:
          postCall ~= "_retval[i] = cretval[i];\n";
          break;
        case Wrap, Boxed, Reffed:
          postCall ~= "_retval[i] = new " ~ func.subDType ~ "(_cretval[i]);\n";
          break;
        case Object:
          postCall ~= "_retval[i] = ObjectG.getDObject!" ~ func.subDType ~ "(_cretval[i], "
            ~ (func.ownership == Ownership.Full).to!dstring ~ ");\n";
          imports.add("GObject.ObjectG");
          break;
        case Basic, Enum, Unknown, Interface, Namespace:
          assert(0, "Unsupported return value array type '" ~ func.subDType.to!string ~ "' (" ~ kind.to!string
            ~ ") for " ~ func.repo.namespace.to!string ~ "." ~ func.name.to!string);
      }
    }

    postCall ~= "}\n";
  }

  /// Process parameter
  private void processParam(Param param)
  {
    if (param.isInstanceParam) // Instance parameter?
    {
      call ~= (call.endsWith('(') ? ""d : ", ") ~ "cPtr";
      return;
    }

    if (param.isArrayLength) // Array length parameter?
    {
      auto arrayParam = param.arrayParamIndex != ParamIndexReturnVal ? func.params[param.arrayParamIndex] : null;

      // Output or InOut?
      if (param.direction == ParamDirection.Out)
      {
        preCall ~= param.subCType ~ " _" ~ param.dName ~ ";\n";
        addCallParam("&_" ~ param.dName);
      }
      else if (param.direction == ParamDirection.InOut)
      {
        preCall ~= param.subCType ~ " _" ~ param.dName ~ (" = " ~ arrayParam.dName ~ " ? " ~ arrayParam.dName
          ~ ".length : 0;\n");
        addCallParam("&_" ~ param.dName);
      }
      else // Input
        addCallParam(arrayParam.dName ~ " ? " ~ arrayParam.dName ~ ".length : 0");

      return;
    }

    if (param.isArray)
    {
      processArrayParam(param);
      return;
    }

    auto isInput = param.direction == ParamDirection.In;

    final switch(param.kind) with(TypeKind)
    {
      case Basic:
        addDeclParam((!isInput ? param.direction ~ " " : "") ~ param.subDType ~ " " ~ param.dName);
        addCallParam((!isInput ? "&"d : "") ~ param.dName);
        break;
      case Enum, Flags:
        addDeclParam((!isInput ? param.direction ~ " " : "") ~ param.subDType ~ " " ~ param.dName);
        preCall ~= param.subCType ~ " _" ~ param.dName ~ " = " ~ (param.direction != ParamDirection.Out ? "cast("
          ~ param.subCType ~ ")" ~ param.dName : "") ~ ";\n";
        addCallParam((!isInput ? "&_"d : "_") ~ param.dName);

        if (!isInput)
          postCall ~= param.dName ~ " = cast(" ~ param.subDType ~ ")_" ~ param.dName ~ ";\n";
        break;
      case String:
        addDeclParam((!isInput ? param.direction ~ " " : "") ~ "string " ~ param.dName);

        if (param.direction == ParamDirection.In)
        {
          preCall ~= param.subCType ~ " _" ~ param.dName ~ " = " ~ param.dName ~ ".toCString("
            ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
          addCallParam("_" ~ param.dName);
        }
        else if (param.direction == ParamDirection.Out)
        {
          preCall ~= param.subCType ~ " _" ~ param.dName ~ ";\n";
          addCallParam("&_" ~ param.dName);
          postCall ~= param.dName ~ " = _" ~ param.dName ~ ".fromCString("
            ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
        }
        else // InOut
          assert(0, "InOut string arguments not supported"); // FIXME - Does this even exist?

        break;
      case Simple:
        addDeclParam((!isInput ? param.direction ~ " " : "") ~ param.subDType ~ " " ~ param.dName);
        addCallParam((!isInput ? "&"d : "") ~ param.dName);
        break;
      case Opaque:
        addDeclParam((!isInput ? param.direction ~ " " : "") ~ param.subDType ~ " " ~ param.dName);
        addCallParam(param.dName);
        break;
      case Wrap, Boxed, Reffed, Object:
        addDeclParam(param.subDType ~ " " ~ param.dName);
        addCallParam(param.dName ~ " ? " ~ param.dName ~ ".cPtr : null");
        imports.add(param.subDType);
        break;
      case Unknown, Interface, Namespace:
        assert(0, "Unsupported parameter type '" ~ param.subDType.to!string ~ "' (" ~ param.kind.to!string ~ ") for "
          ~ func.repo.namespace.to!string ~ "." ~ func.name.to!string);
    }
  }

  // Process an array parameter
  private void processArrayParam(Param param)
  {
    if (param.direction != ParamDirection.In)
    {
      addDeclParam(param.direction ~ " " ~ param.subDType ~ "[] " ~ param.dName);
      addCallParam("&_"d ~ param.dName);
    }
    else
    {
      addDeclParam(param.subDType ~ "[] " ~ param.dName);
      addCallParam("_" ~ param.dName);
    }

    auto kind = param.kind;

    if (param.direction == ParamDirection.In || param.direction == ParamDirection.InOut)
    {
      assert(param.ownership == Ownership.None); // FIXME - Support for ownership Full/Container

      if (param.fixedSize != ArrayNotFixed) // Add an array size assertion if fixed size does not match
        preCall ~= "assert(!" ~ param.dName ~ " || " ~ param.dName ~ ".length == "
          ~ param.fixedSize.to!dstring ~ ");\n";

      final switch (kind) with(TypeKind)
      {
        case Basic, Enum, Flags, Simple, Opaque:
          dstring ptrStr;

          if (param.zeroTerminated) // If zero terminated, append a null or 0 value to the array and use the pointer to pass to the C function call
            ptrStr = "(" ~ param.dName ~ " ~ " ~ param.subCType.endsWith("*") ? "null" : "0" ~ ").ptr";
          else
            ptrStr = param.dName ~ ".ptr";

          preCall ~= param.subArrayCType ~ " _" ~ param.dName ~ " = " ~ valOrNull (param.dName, ptrStr)
            ~ ";\n";
          break;
        case String:
          preCall ~= param.subCType ~ "[] _tmp" ~ param.dName ~ ";\n";
          preCall ~= "foreach(s; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= s.toCString(false);\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= null;";

          preCall ~= param.subArrayCType ~ " _" ~ param.dName ~ " = " ~ valOrNull (param.dName,
            "_tmp" ~ param.dName ~ ".ptr") ~ ";\n";
          break;
        case Wrap, Boxed, Reffed, Object:
          preCall ~= param.subCType ~ "[] _tmp" ~ param.dName ~ ";\n";
          preCall ~= "foreach(obj; " ~ param.dName ~ ")\n" ~ "_tmp" ~ param.dName ~ " ~= obj ? obj.cPtr : null;\n";

          if (param.zeroTerminated)
            preCall ~= "_tmp" ~ param.dName ~ " ~= null;";

          preCall ~= param.subArrayCType ~ " _" ~ param.dName ~ " = " ~ valOrNull (param.dName,
            "_tmp" ~ param.dName ~ ".ptr") ~ ";\n";
          imports.add(param.subDType);
          break;
        case Unknown, Interface, Namespace:
          assert(0, "Unsupported parameter array type '" ~ param.subDType.to!string ~ "' (" ~ kind.to!string ~ ") for "
            ~ func.repo.namespace.to!string ~ "." ~ func.name.to!string);
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
        postCall ~= "uint _len" ~ param.dName ~ ";\nif (_" ~ param.dName ~ ")\nfor (; _" ~ param.dName ~ "[i] != "
          ~ (param.subCType.endsWith("*") ? "null"d : "0") ~ "; _len" ~ param.dName ~ "++)\nbreak;\n";
        lengthStr = "_len" ~ param.dName;
      }
      else
        assert(0); // This should be prevented by defs.fixupRepos()

      preCall ~= param.subArrayCType ~ " _" ~ param.dName ~ ";\n";

      final switch (kind) with(TypeKind)
      {
        case Basic, Enum, Flags, Simple, Opaque:
          postCall ~= param.dName ~ " = _" ~ param.dName ~ "[0 .. " ~ lengthStr ~ "];\n";

          if (param.ownership != Ownership.None)
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
          break;
        case String:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach(i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= _" ~ param.dName ~ "[i].fromCString("
            ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";

          if (param.ownership != Ownership.None)
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
          break;
        case Wrap, Boxed, Reffed:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach(i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= new " ~ param.subDType ~ "("
            ~ param.dName ~ "[i], " ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
          imports.add(param.subDType);

          if (param.ownership != Ownership.None)
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
          break;
        case Object:
          postCall ~= param.dName ~ ".length = 0;\n"; // Set the output array parameter to 0 length
          postCall ~= "foreach(i; 0 .. " ~ lengthStr ~ ")\n" ~ param.dName ~ " ~= ObjectG.getDObject(_" ~ param.dName
            ~ "[i], " ~ (param.ownership == Ownership.Full).to!dstring ~ ");\n";
          imports.add("GObject.ObjectG");
          imports.add(param.subDType);

          if (param.ownership != Ownership.None)
            postCall ~= "g_free(_" ~ param.dName ~ ");\n";
          break;
        case Unknown, Interface, Namespace:
          assert(0, "Unsupported parameter array type '" ~ param.subDType.to!string ~ "' (" ~ kind.to!string ~ ") for "
            ~ func.repo.namespace.to!string ~ "." ~ func.name.to!string);
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

    if (func.dType != "none" && !isCtor)
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

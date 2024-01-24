module defs;

import std.utf : toUTF32;

import gir.func;
import gir.param;
import gir.repo;
import gir.structure;
import gir.type_node;
import std_includes;
import utils;
import xml_patch;
import xml_tree;

class Defs
{
  this()
  {
  }

  /**
   * Load definition control files from a directory.
   * Params:
   *   path = Path of definition files
   */
  void loadDefFiles(string path = "defs")
  {
    foreach (string filename; dirEntries(path, "*.def", SpanMode.shallow))
      loadDefs(readText(filename).to!dstring, filename);
  }

  /**
   * Load a definition file.
   * Params:
   *   filename = The name of the .def file to load
   */
  void loadDefs(dstring defs, string filename = null)
  { // Curly brace block argument processing state machine
    enum BlockState
    {
      None, // Not processing a block
      Start, // Expecting opening brace '{'
      Content, // Processing content until '}'
    }

    dstring[] cmdTokens;
    uint lineCount, startLine;
    BlockState block;
    Repo curRepo;
    StructDefs curStructDefs;

    string posInfo()
    {
      return "(file '" ~ filename ~ "' line " ~ lineCount.to!string ~ ")";
    }

    foreach (line; defs.splitLines)
    {
      lineCount++;

      bool warnRepoUnspecified()
      {
        if (!curRepo)
          stderr.writeln("'", cmdTokens[0], "' command requires 'repo' file to be specified");
        return curRepo !is null;
      }

      bool warnStructUnspecified()
      {
        if (!curStructDefs)
          stderr.writeln("'", cmdTokens[0], "' command requires 'struct' to be specified");
        return curStructDefs !is null;
      }

      if (block == BlockState.Start) // Expecting block start?
      {
        if (line.startsWith('{'))
        {
          block = BlockState.Content;
          continue;
        }

        stderr.writeln("'", cmdTokens[0], "' command requires ", cmdTokens.length, " arguments ", posInfo);
        block = BlockState.None; // Just ignore previous command and continue to process the line
      }

      if (block == BlockState.None)
      {
        line = line.strip;

        if (line.startsWith("#") || line.empty) // Skip comments and empty lines
          continue;

        cmdTokens = line.splitQuoted.array; // Parse command tokens
      }
      else if (block == BlockState.Content) // Processing multi-line brace block content
      {
        if (!line.startsWith('}'))
        { // Append content to last command argument and advance to next line
          cmdTokens[$ - 1] ~= line ~ "\n";
          continue;
        }

        block = BlockState.None; // Closing brace of multi-line block argument, fall through to process the command
      }

      switch (cmdTokens[0])
      {
        case "add":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 3)
          {
            try
            {
              auto patch = new XmlPatch();
              patch.parseAddCmd(cmdTokens[1], cmdTokens[2]);
              curRepo.patches ~= patch;
            }
            catch (XmlPatchError e)
              stderr.writeln("XML patch error: ", e.msg, " ", posInfo);
          }
          else if (cmdTokens.length == 2)
          {
            block = BlockState.Start;
            cmdTokens ~= "";
          }
          break;
        case "code":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 2)
          {
            auto code = "// code start at line " ~ startLine.to!dstring ~ "\n\n" ~ cmdTokens[1] ~ "\n// code end at line "
              ~ lineCount.to!dstring;

            if (curStructDefs)
              curStructDefs.code ~= code;
            else
              curRepo.code ~= code;
          }
          else if (cmdTokens.length == 1)
          {
            block = BlockState.Start;
            cmdTokens ~= "";
            startLine = lineCount;
          }
          else
            stderr.writeln("'code' command requires 1 argument ", posInfo);
          break;
        case "del":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 2)
          {
            try
            {
              auto patch = new XmlPatch();
              patch.parseDeleteCmd(cmdTokens[1]);
              curRepo.patches ~= patch;
            }
            catch (XmlPatchError e)
              stderr.writeln("XML patch error: ", e.msg, " ", posInfo);
          }
          else
            stderr.writeln("'del' command requires 1 argument ", posInfo);
          break;
        case "import":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 2)
          {
            if (curStructDefs)
              curStructDefs.imports ~= cmdTokens[1];
            else
              curRepo.imports ~= cmdTokens[1];
          }
          else
            stderr.writeln("'code' command requires 1 argument ", posInfo);
          break;
        case "rename":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 3)
          {
            try
            {
              auto patch = new XmlPatch();
              patch.parseRenameCmd(cmdTokens[1], cmdTokens[2]);
              curRepo.patches ~= patch;
            }
            catch (XmlPatchError e)
              stderr.writeln("XML patch error: ", e.msg, " ", posInfo);
          }
          else if (cmdTokens.length == 2)
          {
            block = BlockState.Start;
            cmdTokens ~= "";
          }
          break;
        case "repo":
          if (cmdTokens.length == 2)
          {
            curRepo = new Repo(this, cmdTokens[1].to!string);
            repos ~= curRepo;
          }
          else
            stderr.writeln("'gir' command requires 1 argument ", posInfo);
          break;
        case "reserved":
          if (cmdTokens.length == 2)
            reservedWords[cmdTokens[1]] = true;
          else
            stderr.writeln("'reserved' command requires 1 argument ", posInfo);

          break;
        case "set":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 3)
          {
            try
            {
              auto patch = new XmlPatch();
              patch.parseSetCmd(cmdTokens[1], cmdTokens[2]);
              curRepo.patches ~= patch;
            }
            catch (XmlPatchError e)
              stderr.writeln("XML patch error: ", e.msg, " ", posInfo);
          }
          else if (cmdTokens.length == 2)
          {
            block = BlockState.Start;
            cmdTokens ~= "";
          }
          break;
        case "struct":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 2)
          {
            curStructDefs = new StructDefs();
            structDefs[cmdTokens[1]] = curStructDefs;
          }
          else
            stderr.writeln("'struct' command requires 1 argument ", posInfo);
          break;
        case "subtype":
          if (cmdTokens.length == 3)
          {
            typeof(typeSubs)* subs = curRepo ? &curRepo.typeSubs : &typeSubs;

            if (cmdTokens[1] !in *subs)
              (*subs)[cmdTokens[1]] = cmdTokens[2];
            else
              stderr.writeln("subtype '", cmdTokens[1], "' already exists ", posInfo);
          }
          else
            stderr.writeln("'subtype' command requires 2 arguments ", posInfo);

          break;
        default:
          stderr.writeln("Unknown command '", cmdTokens[0], "'");
      }
    }
  }

  /**
   * Load gir files specified in the loaded definition files to Repo objects.
   * Params:
   *   girPaths = Array of paths to search for Gir files
   */
  void loadRepos(string[] girPaths = ["/usr/share/gir-1.0"])
  {
    foreach (repo; repos)
    { // Search for Gir file in search paths
      foreach (search; girPaths)
      {
        auto filePath = buildPath(search, repo.filename ~ ".gir");
        if (isFile(filePath))
        {
          repo.filename = filePath;
          goto found;
        }
      }

      throw new Exception("Repository Gir file '" ~ repo.filename ~ "' not found (search paths = "
        ~ girPaths.join(":") ~ ")");

      found:
      auto tree = new XmlTree();
      tree.parse(readText(repo.filename).toUTF32, repo.filename); // Load the Gir XML file

      XmlNode namespaceNode;

      if (tree.root)
      {
        foreach (n; tree.root.children)
          if (n.id == "namespace")
            namespaceNode = n;
      }

      if (!namespaceNode)
        throw new Exception("No 'namespace' XML node found in Gir file");

      foreach (patch; repo.patches) // Apply XML patches from defs file
        patch.apply(tree, namespaceNode);

      repo.fromXmlTree(tree); // Convert XML tree to Gir object tree
    }

    fixupRepos();
  }

  /// Ensure consistent state of repo data and fixup additional data (array parameter indexes, etc)
  private void fixupRepos()
  {
    foreach (repo; repos)
    {
      foreach (fn; repo.functions)
        fixupFunc(fn, [FuncType.Function]);

      foreach (st; repo.structs)
        foreach (fn; st.functions)
          fixupFunc(fn, [FuncType.Function, FuncType.Constructor, FuncType.Signal, FuncType.Method]);
    }
  }

  void fixupFunc(Func fn, FuncType[] allowedTypes)
  {
    void disableFunc(string msg)
    {
      fn.disable = true;
      stderr.writeln("Disabling '" ~ (fn.parent ? (cast(Structure)fn.parent).name.to!string : fn.repo.namespace.to!string) ~ "."
        ~ fn.name.to!string ~ "': " ~ msg);
    }

    if (!fn.introspectable || !fn.movedTo.empty || fn.funcType == FuncType.VirtualMethod
        || fn.funcType == FuncType.FuncMacro)
      fn.disable = true;

    if (fn.disable)
      return;

    if (!allowedTypes.canFind(fn.funcType))
    {
      disableFunc("type '" ~ fn.funcType.to!string ~ "' not supported where found");
      return;
    }

    if (fn.isArray && fn.lengthParamIndex == ArrayNoLengthParam && fn.fixedSize == ArrayNotFixed
      && !fn.zeroTerminated)
    {
      disableFunc("array return value has indeterminate length");
      return;
    }

    if (fn.lengthParamIndex != ArrayNoLengthParam) // Returns array with a length argument?
    { // Array length parameter indexes don't count instance parameters
      if (fn.hasInstanceParam)
        fn.lengthParamIndex++;

      if (fn.lengthParamIndex >= fn.params.length)
      {
        disableFunc("invalid return array length parameter index");
        return;
      }

      auto lengthParam = fn.params[fn.lengthParamIndex];

      if (lengthParam.direction != ParamDirection.Out)
      {
        disableFunc("return array length parameter direction must be 'out'");
        return;
      }

      lengthParam.isArrayLength = true;
      lengthParam.arrayParamIndex = ParamIndexReturnVal;
    }

    foreach (pi, pa; fn.params)
    {
      if (pa.isInstanceParam && pi != 0)
      {
        disableFunc("invalid additional instance param '" ~ pa.name.to!string ~ "'");
        return;
      }

      if (pa.isArray && pa.lengthParamIndex == ArrayNoLengthParam && pa.fixedSize == ArrayNotFixed
        && !pa.zeroTerminated)
      {
        disableFunc("array param '" ~ pa.name.to!string ~ "' has indeterminate length");
        return;
      }

      if (pa.lengthParamIndex != ArrayNoLengthParam) // Parameter array with a length argument?
      { // Array length parameter indexes don't count instance parameters
        if (fn.hasInstanceParam)
          pa.lengthParamIndex++;

        if (pa.lengthParamIndex >= fn.params.length)
        {
          disableFunc("array param '" ~ pa.name.to!string ~ "' has invalid length parameter index");
          return;
        }

        auto lengthParam = fn.params[pa.lengthParamIndex];

        if (pa.direction != lengthParam.direction)
        {
          disableFunc("array param '" ~ pa.name.to!string ~ "' direction mismatch with length param '"
            ~ lengthParam.name.to!string ~ "'");
          return;
        }

        lengthParam.isArrayLength = true;
        lengthParam.arrayParamIndex = cast(int)pi;
      }

      if (pa.direction != ParamDirection.Out && pa.ownership != Ownership.None)
      { // FIXME
        disableFunc("param '" ~ pa.name.to!string ~ "' ownership transfer not yet supported");
        return;
      }
    }
  }

  /**
   * Write the packages for the loaded Repo objects defined in the definitions files.
   * Params:
   *   basePath = The path to the toplevel packages directory (defaults to "packages")
   *   packagePrefix = Prefix to add to package name (defaults to "gid-")
   */
  void writePackages(string basePath = "packages", string packagePrefix = "gid-")
  {
    foreach (repo; repos)
    {
      repo.writePackage(basePath, packagePrefix);
    }
  }

  /**
   * Get the kind classification of a type string
   * Params:
   *   type = The type string (a C or D type)
   *   repo = The repo the type was found in
   * Returns: The type classification, falls back to TypeKind.Basic if no other type applies
   */
  TypeKind typeKind(dstring type, Repo repo)
  {
    if (auto kind = type in typeCache)
      return *kind;

    if (type.among("char*"d, "const char*"d, "string"d, "utf8"d))
      return TypeKind.String;

    auto ndx = type.countUntil('.');

    if (ndx != -1)
    {
      if (auto pRepo = type in repoHash)
        repo = *pRepo;

      type = type[ndx + 1 .. $];
    }

    if (auto en = type in repo.enumHash)
      return en.bitfield ? TypeKind.Flags : TypeKind.Enum;

    if (auto st = type in repo.structHash)
    {
      if (st.isGObject)
        return TypeKind.Object;
      else if (st.isBoxed)
        return TypeKind.Boxed;
      else
        return TypeKind.Struct;
    }

    return TypeKind.Basic;
  }

  /**
   * Fix symbol name if it is a reserved word, by appending an underscore to it.
   * Params:
   *   name = The symbol name
   * Returns: The symbol name possibly with underscore appended if it is a reserved Dlang word
   */
  dstring symbolName(dstring name)
  {
    if (name in reservedWords) // Add underscore to reserved words
      return name ~ "_";
    else if (!name.empty && name[0] >= '0' && name[0] <= '9') // Starts with a digit? Can happen with some shortened enum members.
      return "_" ~ name;

    return name;
  }

  /**
   * Substitute type.
   * Params:
   *   type = Type string
   * Returns: Type string with any relevant substitutions
   */
  dstring subTypeStr(dstring type)
  {
    auto tok = tokenizeType(type).filter!(x => x != "volatile").array;

    if (tok.empty)
      return type;

    // Substitute types not including end '*' pointers
    dstring sub(dstring s)
    {
      for (auto i = cast(int)(s.length) - 1; i >= 0; i--)
      {
        if (s[i] != '*' && s[i] != ' ')
        {
          auto t = s[0 .. i + 1];
          return typeSubs.get(t, t) ~ s[i + 1 .. $];
        }
      }

      return s;
    }

    // Remove multiple "const", format as const(TYPE)*, and substitute type names
    if (tok[0] == "const" && tok[$ - 1] == "*")
      return "const(" ~ sub(tok[0 .. $ - 1].filter!(x => x != "const").join("")) ~ ")*";

    return sub(tok.filter!(x => x != "const")
      .map!(x => x == "*" ? x : " " ~ x)
      .join("").strip);
  }

  bool[dstring] reservedWords; /// Reserved words (_ appended)
  dstring[dstring] typeSubs; /// Global type substitutions
  Repo[] repos; /// Gir repositories
  StructDefs[dstring] structDefs; /// Structure definitions by name
  TypeKind[dstring] typeCache; /// Type kind cache

  Repo[dstring] repoHash; /// Hash of repositories by namespace
}

/// Structure definitions
class StructDefs
{
  dstring[] imports; /// Import commands
  dstring code; /// Combined content of code commands
}

/// Kind of a type
enum TypeKind
{
  Basic, /// A basic data type
  Enum, /// Enumeration type
  Flags, /// Bitfield flags type
  Struct, /// Simple struct type
  String, /// A string
  Object, /// A GObject derived type
  Boxed, /// A GLib boxed type
}

module defs;

import std.utf : toUTF32;

import import_symbols;
import gir.alias_;
import gir.constant;
import gir.enumeration;
import gir.func;
import gir.param;
import gir.repo;
import gir.structure;
import gir.type_node;
import std_includes;
import utils;
import xml_patch;
import xml_tree;

enum DefsCmdPrefix = "//!"d; /// Prefix used for definition commands
enum DefsCommentPrefix = "//#"d; /// Prefix used for definition comments (not included in content)

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
    string[] classFiles;

    foreach (string filename; dirEntries(path, "*.d", SpanMode.shallow))
    { // Process class files, which contain a dash in the filename, after the main repo files
      if (filename.baseName.canFind('-'))
        classFiles ~= filename;
      else
        loadDefs(filename);
    }

    foreach (filename; classFiles)
      loadDefs(filename);
  }

  /**
   * Load a definition file. Filenames are of the form "Namespace.d" and "Namespace-Class.d",
   * such as "GLib.d" and "GLib-Boxed.d".
   *
   * Params:
   *   filename = The name of the definition file to load
   */
  void loadDefs(string filename)
  { // Curly brace block argument processing state machine
    enum BlockState
    {
      None, // Not processing a block
      Start, // Expecting opening brace '{'
      Content, // Processing content until '}'
    }

    // Definition code class state
    enum ClassState
    {
      Pre, // Pre class
      Start, // Start of class (expecting '{')
      In, // In class
      Post, // Post class
    }

    auto fileData = readText(filename).to!dstring; // The definition file data converted to a unicode dstring
    dstring[] cmdTokens; // Parsed definition command tokens (space separated and quoted strings)
    uint lineCount; // Current line count
    BlockState block; // Multi-line block processing state
    Repo curRepo; // Current repo or null
    dstring curStructName; // Current structure name or null
    ClassState classState; // Current definition code class state

    string posInfo()
    {
      return "(file '" ~ filename ~ "' line " ~ lineCount.to!string ~ ")";
    }

    // Process raw code lines in definition files (not definition commands)
    void processDefCode(dstring line, dstring lineRaw)
    {
      auto defCode = curRepo.structDefCode[curStructName];

      if (line.startsWith("import ")) // Import statement?
      {
        try
          defCode.imports.parseImport(line);
        catch(Exception e)
          warning(e.msg, " ", posInfo);

        return;
      }

      if (classState == ClassState.Pre) // Not inside class?
      { // Is this a class declaration?
        if (line.startsWith("class") || line.startsWith("abstract class"))
        {
          defCode.classDecl = line;
          classState = ClassState.Start;
        }
        else
          defCode.preClass ~= line; // Append to pre class content
      }
      else if (classState == ClassState.Start)
      {
        if (lineRaw == "{")
          classState = ClassState.In;
      }
      else if (classState == ClassState.In)
      {
        if (lineRaw == "}")
          classState = ClassState.Post;
        else
          defCode.inClass ~= line; // Append to inside class content
      }
      else
        defCode.postClass ~= line; // Append to inside class content
    }

    auto classSplitName = filename.baseName.stripExtension.split('-');
    auto repoName = classSplitName[0];

    if (classSplitName.length > 1) // Is this a repo class file? Will have a dash separator between the namespace and class names.
    {
      auto findRepo = repos.find!(x => x.namespace.to!string == repoName);

      if (findRepo.length > 0) // Is there a repo with the matching namespace from the filename?
      { // Set current repo and struct name from filename
        curRepo = findRepo[0];
        curStructName = classSplitName[1].to!dstring;

        if (curStructName !in curRepo.structDefCode) // If structure definition code wasn't already created, create it and disable generation of init/funcs by default
        {
          curRepo.structDefCode[curStructName] = new DefCode();
          curRepo.structDefCode[curStructName].genInit = false;
          curRepo.structDefCode[curStructName].genFuncs = false;
        }
      }
      else
      {
        warning("Ignoring class definition file '", filename, "' with no matching repository '",
          classSplitName[0], "'");
        return;
      }
    }

    foreach (line; fileData.splitLines) // Loop on definition file lines
    {
      lineCount++;
      auto lineStrip = line.strip;

      if (lineStrip.startsWith(DefsCommentPrefix)) // Skip definition comments
        continue;

      dstring cmdLine;

      if (lineStrip.startsWith(DefsCmdPrefix))
        cmdLine = lineStrip[DefsCmdPrefix.length .. $];

      if (!cmdLine)
      { // All lines which aren't definition commands get processed as potential code
        if (!curStructName.empty)
          processDefCode(lineStrip, line);

        continue;
      }

      if (block == BlockState.Start) // Expecting block start?
      {
        if (cmdLine.startsWith('{'))
        {
          block = BlockState.Content;
          continue;
        }

        warning("'", cmdTokens[0], "' command requires ", cmdTokens.length, " arguments ", posInfo);
        block = BlockState.None; // Just ignore previous command and continue to process the line
      }

      if (block == BlockState.None)
      {
        if (cmdLine.empty) // Skip empty command lines
          continue;

        cmdTokens = cmdLine.splitQuoted.array; // Parse command tokens
      }
      else if (block == BlockState.Content) // Processing multi-line brace block content
      {
        if (!cmdLine.startsWith('}'))
        { // Append content to last command argument and advance to next line
          cmdTokens[$ - 1] ~= cmdLine ~ "\n";
          continue;
        }

        block = BlockState.None; // Closing brace of multi-line block argument, fall through to process the command
      }

      auto cmd = cmdTokens[0];
      auto findCmdInfo = defCommandInfo.find!(x => x.name == cmd);
      if (findCmdInfo.empty)
      {
        warning("Unknown command '", cmd, "'");
        continue;
      }

      auto cmdInfo = findCmdInfo[0];

      if ((cmdInfo.flags & DefCmdFlags.AllowBlock) && cmdTokens.length == cmdInfo.argCount) // Allow multi-line block arguments for some commands
      {
        block = BlockState.Start;
        cmdTokens ~= "";
        continue;
      }

      if (cmdTokens.length != cmdInfo.argCount + 1)
      {
        warning("'", cmd, "' command requires ", cmdInfo.argCount, " ", cmdInfo.argCount == 1
          ? "argument " : "arguments ", posInfo);
        break;
      }

      if (cmdInfo.flags & DefCmdFlags.ReqRepo && !curRepo)
      {
        warning("'", cmd, "' command requires 'repo' to be specified ", posInfo);
        continue;
      }

      if (cmdInfo.flags & DefCmdFlags.ReqClass && !curStructName)
      {
        warning("'", cmd, "' command requires 'struct' to be specified ", posInfo);
        continue;
      }

      switch (cmd)
      {
        case "add", "del", "rename", "set":
          auto patch = new XmlPatch();

          try
          {
            final switch (cmd)
            {
              case "add":
                patch.parseAddCmd(cmdTokens[1], cmdTokens[2]);
                break;
              case "del":
                patch.parseDeleteCmd(cmdTokens[1]);
                break;
              case "rename":
                patch.parseRenameCmd(cmdTokens[1], cmdTokens[2]);
                break;
              case "set":
                patch.parseSetCmd(cmdTokens[1], cmdTokens[2]);
                break;
            }
          }
          catch (XmlPatchError e)
          {
            warning("XML patch error: ", e.msg, " ", posInfo);
            break;
          }

          if (curRepo)
            curRepo.patches ~= patch;
          else
            patches ~= patch;
          break;
        case "class":
          curStructName = cmdTokens[1];

          if (curStructName !in curRepo.structDefCode)
            curRepo.structDefCode[curStructName] = new DefCode();
          else
            warning("Duplicate class command found for '", curStructName, "' ", posInfo);
          break;
        case "generate":
          auto genItem = cmdTokens[1];

          switch(genItem)
          {
            case "init":
              curRepo.structDefCode[curStructName].genInit = true;
              break;
            case "funcs":
              curRepo.structDefCode[curStructName].genFuncs = true;
              break;
            default:
              warning("Unknown generate parameter '" ~ genItem ~ "' ", posInfo);
              break;
          }

          break;
        case "import":
          curRepo.structDefCode[curStructName].imports.add(cmdTokens[1]);
          break;
        case "kind":
          TypeKind kind;

          try
            kind = cmdTokens[2].to!TypeKind;
          catch (Exception e)
          {
            warning("Unknown type kind '" ~ cmdTokens[2].to!string ~ "' should be one of: " ~
              [EnumMembers!TypeKind].map!(x => x.to!string).join(", "), " ", posInfo);
            break;
          }

          curRepo.kindSubs[cmdTokens[1]] = kind;
          break;
        case "repo":
          curRepo = new Repo(this, cmdTokens[1].to!string);
          curRepo.namespace = repoName.to!dstring;
          repos ~= curRepo;
          curStructName = null;
          break;
        case "reserved":
          reservedWords[cmdTokens[1]] = true;
          break;
        case "subtype":
          typeof(typeSubs)* subs = curRepo ? &curRepo.typeSubs : &typeSubs;

          if (cmdTokens[1] !in *subs)
            (*subs)[cmdTokens[1]] = cmdTokens[2];
          else
            warning("subtype '", cmdTokens[1], "' already exists ", posInfo);
          break;
        default:
          assert(0);
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
    {
      string filePath;
      foreach (search; girPaths) // Search for Gir file in search paths
      {
        auto p = buildPath(search, repo.filename ~ ".gir");
        if (isFile(p))
        {
          filePath = p;
          break;
        }
      }

      if (filePath.empty)
        throw new Exception("Repository Gir file '" ~ repo.filename ~ "' not found (search paths = "
          ~ girPaths.join(":") ~ ")");

      repo.filename = filePath;
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

      foreach (patch; patches) // Apply global XML patches from defs file
      {
        try
          patch.apply(tree, namespaceNode);
        catch (XmlPatchError e)
        {}
      }

      foreach (patch; repo.patches) // Apply XML patches from defs file
        patch.apply(tree, namespaceNode);

      repo.fromXmlTree(tree); // Convert XML tree to Gir object tree
    }

    fixupVerifyRepos();
  }

  /// Ensure consistent state of repo data and fixup additional data (array parameter indexes, etc)
  private void fixupVerifyRepos()
  {
    repoHash = repos.map!(x => tuple(x.namespace, x)).assocArray;

    foreach (repo; repos)
      repo.fixupTypes;

    foreach (repo; repos)
      repo.fixupDeps;

    foreach (repo; repos)
      repo.verify;
  }

  /**
   * Write the packages for the loaded Repo objects defined in the definitions files.
   * Params:
   *   basePath = The path to the toplevel packages directory (defaults to "packages")
   *   packagePrefix = Prefix to add to package name (defaults to "gid-")
   */
  void writePackages(string basePath = "packages")
  {
    foreach (repo; repos)
      repo.writePackage(basePath);
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
    foreach (i; 0 .. 2) // Resolve up to 1 alias dereference
    {
      if (type.among("char*"d, "const char*"d, "string"d, "utf8"d))
        return TypeKind.String;

      if (auto obj = repo.typeObjectHash.get(type, null))
      {
        if (auto al = cast(Alias)obj)
        {
          type = al.dType;
          continue;
        }

        if (cast(Func)obj)
          return TypeKind.Callback;
        else if (auto node = cast(TypeNode)obj)
          return node.kind;
        else if (cast(Constant)obj)
          return TypeKind.Basic;
        else if (auto en = cast(Enumeration)obj)
          return en.bitfield ? TypeKind.Flags : TypeKind.Enum;
        else
          return TypeKind.Unknown;
      }

      return i > 0 ? TypeKind.BasicAlias : TypeKind.Basic;
    }

    return TypeKind.Unknown; // Multiple alias dereferences
  }

  /**
   * Find type object by D type name which may include the namespace separated by a period.
   * Params:
   *   typeName = Type name string
   *   namespace = Default namespace or null
   * Returns: The matching type object or null if not found (possible basic type), throws an exception if typeName has a namespace that wasn't resolved
   */
  Base findTypeObject(dstring typeName, Repo repo)
  {
    auto t = typeName.split('.');
    if (t.length > 1)
    {
      repo = repoHash.get(t[0], null);

      if (!repo)
        throw new Exception("Failed to resolve namespace '" ~ t[0].to!string ~ "' for type '"
          ~ typeName.to!string ~ "'");

      typeName = t[1];
    }

    return repo.typeObjectHash.get(subTypeStr(typeName, repo.typeSubs), null);
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
   *   localSubs = Local substitution map or null (default)
   * Returns: Type string with any relevant substitutions
   */
  dstring subTypeStr(dstring type, dstring[dstring] localSubs = null)
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

          if (t in localSubs)
            t = localSubs[t];
          else
            t = typeSubs.get(t, t);

          return t ~ s[i + 1 .. $];
        }
      }

      return s;
    }

    // Remove multiple "const", format as const(TYPE)*, and substitute type names
    if (tok[0] == "const" && tok[$ - 1] == "*")
      return "const(" ~ sub(tok[0 .. $ - 1].filter!(x => !x.among("const"d, "("d, ")"d)).join("")) ~ ")*";

    return sub(tok.filter!(x => x != "const")
      .map!(x => x == "*" ? x : " " ~ x)
      .join("").strip);
  }

  bool[dstring] reservedWords; /// Reserved words (_ appended)
  dstring[dstring] typeSubs; /// Global type substitutions
  XmlPatch[] patches; /// Global XML patches specified in definitions file
  Repo[] repos; /// Gir repositories

  Repo[dstring] repoHash; /// Hash of repositories by namespace
}

/// Kind of a type
enum TypeKind
{
  Unknown, /// Unknown type
  Basic, /// A basic data type
  String, /// A string
  BasicAlias, /// An alias to a basic type
  Enum, /// Enumeration type
  Flags, /// Bitfield flags type
  Simple, /// Simple Record or Union with basic fields (Basic, Enum, Flags) and no methods (alias to C type)
  Opaque, /// Opaque Record pointer type with no accessible fields or methods (alias to C type)
  Callback, /// Callback function type
  Wrap, /// Record or Union with accessible fields and/or methods (wrap with a class)
  Boxed, /// A GLib boxed Record type
  Reffed, /// Referenced Class type with inheritence (not GObject derived)
  Object, /// A GObject Class
  Interface, /// Interface type
  Namespace, /// Namespace structure (no C type, global module for example)
}

/**
 * Check if a type kind has a module file.
 * Params:
 *   kind = The type kind
 * Returns: true if the given type kind is implemented with its own module
 */
bool typeKindHasModule(TypeKind kind)
{
  return kind >= TypeKind.Wrap;
}

/**
 * Check if a type kind is defined in a global module.
 * Params:
 *   kind = The type kind
 * Returns: true if the given type kind is defined in a global module
 */
bool typeKindIsGlobal(TypeKind kind)
{
  return kind >= TypeKind.BasicAlias && kind <= TypeKind.Callback;
}

/// Manual code from a definitions file
class DefCode
{
  this()
  {
    imports = new ImportSymbols();
  }

  bool genInit = true; /// Generate class constructor/destructor init code
  bool genFuncs = true; /// Generate functions and methods
  ImportSymbols imports; /// Imports
  dstring[] preClass; /// Pre class declaration code, line separated
  dstring classDecl; /// Class declaration
  dstring[] inClass; /// Code inside of the class, line separated
  dstring[] postClass; /// Post class code
}

/// Definition command flags
enum DefCmdFlags
{
  AllowBlock = 1 << 0, /// Allow a multi-line block argument (last arg)
  ReqRepo = 1 << 1, /// Require repo to have been specified
  ReqClass = 1 << 2, /// Require struct to have been specified
  None = 0,
}

/// Definition command info
struct DefCmd
{
  dstring name;
  int argCount;
  BitFlags!DefCmdFlags flags;
  string help;
}

// Command information
immutable DefCmd[] defCommandInfo = [
  {"add", 2, DefCmdFlags.AllowBlock, "add <XmlSelect> <AttributeValue | Xml> - Add an XML attribute or node"},
  {"class", 1, DefCmdFlags.ReqRepo, "class <Class> - Select the current structure/class"},
  {"del", 1, DefCmdFlags.None, "del <XmlSelect> - Delete an XML attribute or node"},
  {"generate", 1, DefCmdFlags.ReqClass, "generate <'Init' | 'Funcs'> - Force generation of Init or Function code"},
  {"import", 1, DefCmdFlags.ReqClass, "import <Import> - Add a D import"},
  {"kind", 2, DefCmdFlags.ReqRepo, "kind <TypeName> <TypeKind> - Override a type kind"},
  {"rename", 2, DefCmdFlags.None, "rename <XmlSelect> <AttributeName | XmlNodeId> - Rename an XML attribute or node ID"},
  {"repo", 1, DefCmdFlags.None, "repo <RepoName> - Specify the Gir repository name to load"},
  {"reserved", 1, DefCmdFlags.None, "reserved <Word> - Identify a reserved word, an underscore will be appended to it"},
  {"set", 2, DefCmdFlags.AllowBlock, "set <XmlSelect> <AttributeValue | Xml> - Set an XML attribute or node"},
  {"subtype", 2, DefCmdFlags.None, "subtype <FromTypeName> <ToTypeName> - Substitute a type name"},
];

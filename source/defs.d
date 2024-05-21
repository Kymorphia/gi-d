module defs;

import std.utf : toUTF32;

import import_manager;
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

    foreach (string filename; dirEntries(path, "*.d", SpanMode.shallow).array.sort)
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
          classState = ClassState.In; // FIXME - How to specify other sections of modules?

          if (curStructName !in curRepo.structDefCode)
            curRepo.structDefCode[curStructName] = new DefCode();
          else
            warning("Duplicate class command found for '", curStructName, "' ", posInfo);
          break;
        case "generate":
          auto genItem = cmdTokens[1];

          switch (genItem)
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
        case "info":
          if (curRepo)
            curRepo.dubInfo[cmdTokens[1].to!string] ~= cmdTokens[2].to!string;
          else
            dubInfo[cmdTokens[1].to!string] ~= cmdTokens[2].to!string;
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
        case "merge":
          curRepo.merge = cmdTokens[1];
          break;
        case "namespace":
          curRepo = new Repo(this, null);
          curRepo.defsFilename = filename;
          curRepo.namespace = cmdTokens[1];
          repos ~= curRepo;
          curStructName = null;
          break;
        case "repo":
          curRepo = new Repo(this, cmdTokens[1].to!string);
          curRepo.defsFilename = filename;
          curRepo.namespace = repoName.to!dstring;
          repos ~= curRepo;
          curStructName = null;
          break;
        case "reserved":
          reservedWords[cmdTokens[1]] = true;
          break;
        case "subctype", "subdtype", "subtype":
          dstring[dstring]*[] subs;

          if (cmd == "subctype" || cmd == "subtype")
            subs ~= curRepo ? &curRepo.cTypeSubs : &cTypeSubs;

          if (cmd == "subdtype" || cmd == "subtype")
            subs ~= curRepo ? &curRepo.dTypeSubs : &dTypeSubs;

          foreach (subMap; subs)
          {
            if (cmdTokens[1] !in (*subMap))
              (*subMap)[cmdTokens[1]] = cmdTokens[2];
            else
              warning(cmd, " '", cmdTokens[1], "' already exists ", posInfo);
          }
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
    repos = repos.sort!((x, y) => x.namespace < y.namespace).array;

    foreach (repo; repos)
    {
      if (repo.filename.empty)
        continue;

      auto repoPaths = girPaths.map!(path => buildPath(path, repo.filename ~ ".gir")).filter!(x => x.exists);

      if (repoPaths.empty)
        throw new Exception("Repository Gir file '" ~ repo.filename ~ "' not found (search paths = "
          ~ girPaths.join(":") ~ ")");

      repo.filename = repoPaths.front;

      if (repoPaths.count > 1)
        warning("Multiple matches found for repository in path, using " ~ repo.filename);

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
        {
        }
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
      repo.fixup;

    // Keep trying to resolve types until there are no more or no progress is made
    while (true)
    {
      auto count = unresolvedTypes.length;

      foreach (typeNode; unresolvedTypes.keys)
        typeNode.resolve;

      if (count == unresolvedTypes.length)
        break;
    }

//    if (!unresolvedTypes.empty)
//      unresolvedTypes.keys.map!(x => x.fullName ~ ", " ~ x.dType ~ ", " ~ x.to!dstring ~ ", " ~ unresolvedTypes[x].to!uint.to!dstring).array.sort.join("\n").writeln;

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

    writeDubJsonFile(basePath);
  }

  /**
   * Write master packages dub JSON file.
   * Params:
   *   path = The path to the packages directory
   */
  private void writeDubJsonFile(string path)
  {
    string output = "{\n";

    foreach (key; ["name", "description", "copyright", "authors", "license"])
    {
      if (auto val = dubInfo.get(key, null))
      {
        if (key == "authors")
          output ~= `  "authors": [` ~ val.map!(x => `"` ~ x ~ `"`).join(", ") ~ "],\n";
        else
          output ~= `  "` ~ key ~ `": "` ~ val[0] ~ "\",\n";
      }
    }

    output ~= `  "targetType": "none",` ~ "\n";
	  output ~= `  "dependencies": {` ~ "\n";

    auto sortedRepos = repos.filter!(x => x.merge.empty).map!(x => x.name.to!string.toLower).array.sort;

    output ~= sortedRepos.map!(x => `    ":` ~ x ~ `": "*"`).join(",\n");
    output ~= "\n  },\n";

    output ~= `  "subPackages": [` ~ "\n";
    output ~= sortedRepos.map!(x => `    "./` ~ x ~ `/"`).join(",\n");
    output ~= "\n  ]\n}\n";

    write(buildPath(path, "dub.json"), output);
  }

  /**
   * Get the kind classification of a type string
   * Params:
   *   type = The D type string
   *   repo = The repo the type was found in
   * Returns: The type classification, falls back to TypeKind.Basic if no other type applies
   */
  TypeKind typeKind(dstring type, Repo repo)
  {
    foreach (i; 0 .. 4) // Resolve up to 4 alias dereferences
    {
      if (type.among("char*"d, "const char*"d, "string"d, "utf8"d))
        return TypeKind.String;

      if (type.isBasicType)
        return i > 0 ? TypeKind.BasicAlias : TypeKind.Basic;

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
    }

    return TypeKind.Unknown; // Too many alias dereferences
  }

  /**
   * Find type object by D type name which may include the namespace separated by a period.
   * Params:
   *   typeName = Type name string
   *   repo = Repo to use if typeName does not contain a namespace (optional if typeName has a namespace)
   * Returns: The matching type object or null if not found (possible basic type), throws an exception if typeName has a namespace that wasn't resolved
   */
  TypeNode findTypeObject(dstring typeName, Repo repo = null)
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

    assert(repo);

    return repo.typeObjectHash.get(subTypeStr(typeName, dTypeSubs, repo.dTypeSubs), null);
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
   *   subs = Primary substitution map (usually dTypeSubs or cTypeSubs)
   *   localSubs = Local substitution map or null (default)
   * Returns: Type string with any relevant substitutions
   */
  dstring subTypeStr(dstring type, dstring[dstring] subs, dstring[dstring] localSubs = null)
  {
    if (auto s = subs.get(type, null)) // See if the type exactly matches a substitution (handles multi word substitions too)
      return s;

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
            t = subs.get(t, t);

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

  /**
   * Designate the start of output processing for module imports. Enables tracking of symbol names and
   * creation of aliases for conflicts for used symbols.
   */
  void beginImports(Structure klassModule)
  {
    importManager = new ImportManager(klassModule);
    importManager.add("Gid.gid");
    importManager.add("Types");
    importManager.add(klassModule.repo.namespace ~ ".c.functions");
    importManager.add(klassModule.repo.namespace ~ ".c.types");
  }

  /**
   * Indicates the end of processing for the current output module imports which was activated with beginImports().
   */
  void endImports()
  {
    importManager = null;
  }

  /**
   * Resolve a D type symbol name. Uses the D type name or an alias if it conflicts with
   * another symbol imported into the current module which was defined by a call to beginImports().
   * Params:
   *   typeNode = The type node object to get the D type name of
   * Returns: The D type name or an alias
   */
  dstring resolveSymbol(dstring typeName)
  {
    if (importManager)
      importManager.add(typeName);

    auto t = typeName.split('.');
    assert(t.length == 2);

    return t[1];
  }

  bool[dstring] reservedWords; /// Reserved words (_ appended)
  dstring[dstring] cTypeSubs; /// Global C type substitutions
  dstring[dstring] dTypeSubs; /// Global D type substitutions
  string[][string] dubInfo; /// Dub JSON file info ("name", "description", "copyright", "authors", "license"), only "authors" uses multiple values
  XmlPatch[] patches; /// Global XML patches specified in definitions file
  Repo[] repos; /// Gir repositories
  Repo[dstring] repoHash; /// Hash of repositories by namespace
  ImportManager importManager; /// Current import manager used with beginImports()/endImports()
  UnresolvedFlags[TypeNode] unresolvedTypes; /// TypeNode objects which have an unresolved type (for recursive type resolution)
}

/// Manual code from a definitions file
class DefCode
{
  this()
  {
    imports = new ImportManager();
  }

  bool genInit = true; /// Generate class constructor/destructor init code
  bool genFuncs = true; /// Generate functions and methods
  ImportManager imports; /// Imports
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
  {
    "add", 2, DefCmdFlags.AllowBlock, "add <XmlSelect> <AttributeValue | Xml> - Add an XML attribute or node"
  },
  {"class", 1, DefCmdFlags.ReqRepo, "class <Class> - Select the current structure/class"},
  {"del", 1, DefCmdFlags.None, "del <XmlSelect> - Delete an XML attribute or node"},
  {
    "generate", 1, DefCmdFlags.ReqClass, "generate <'init' | 'funcs'> - Force generation of Init or Function code"
  },
  {"import", 1, DefCmdFlags.ReqClass, "import <Import> - Add a D import"},
  {"info", 2, DefCmdFlags.None, "info <name> <value> - Set JSON dub info for repo or master package"
    ~ " (name, description, copyright, authors, license), multiple authors values can be given"},
  {"kind", 2, DefCmdFlags.ReqRepo, "kind <TypeName> <TypeKind> - Override a type kind"},
  {"merge", 1, DefCmdFlags.ReqRepo, "merge <Namespace> - Merge current repo into the package identified by Namespace"},
  {"namespace", 1, DefCmdFlags.None, "namespace <Namespace> - Create a repository from a namespace instead of a Gir file"},
  {
    "rename", 2, DefCmdFlags.None, "rename <XmlSelect> <AttributeName | XmlNodeId> - Rename an XML attribute or node ID"
  },
  {"repo", 1, DefCmdFlags.None, "repo <RepoName> - Specify the Gir repository name to load"},
  {
    "reserved", 1, DefCmdFlags.None, "reserved <Word> - Identify a reserved word, an underscore will be appended to it"
  },
  {
    "set", 2, DefCmdFlags.AllowBlock, "set <XmlSelect> <AttributeValue | Xml> - Set an XML attribute or node"
  },
  {"subtype", 2, DefCmdFlags.None, "subtype <FromTypeName> <ToTypeName> - Substitute a type name (D and C types)"},
  {"subctype", 2, DefCmdFlags.None, "subctype <FromTypeName> <ToTypeName> - Substitute a C type name"},
  {"subdtype", 2, DefCmdFlags.None, "subdtype <FromTypeName> <ToTypeName> - Substitute a D type name"},
];

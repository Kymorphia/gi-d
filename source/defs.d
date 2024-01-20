module defs;

import std.utf : toUTF32;

import gir.repo;
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

    uint lineCount;
    BlockState block;
    bool repoSpecified;

    string posInfo()
    {
      return "(file '" ~ filename ~ "' line " ~ lineCount.to!string ~ ")";
    }

    foreach (line; defs.splitLines.map!(x => x.strip))
    {
      lineCount++;
      dstring[] cmdTokens;

      bool warnRepoUnspecified()
      {
        if (!repoSpecified)
          stderr.writeln("'", cmdTokens[0], "' command requires 'repo' file to be specified");

        return repoSpecified;
      }

      if (block == BlockState.Start) // Expecting block start?
      {
        if (line == "{")
        {
          block = BlockState.Content;
          continue;
        }

        stderr.writeln("'", cmdTokens[0], "' command requires ", cmdTokens.length, " arguments ", posInfo);
        block = BlockState.None; // Just ignore previous command and continue to process the line
      }

      if (block == BlockState.None)
      {
        if (line.startsWith("#") || line.empty) // Skip comments and empty lines
          continue;

        cmdTokens = line.split; // Parse command tokens
      }
      else if (block == BlockState.Content) // Processing multi-line brace block content
      {
        if (line != "}")
        { // Append content to last command argument and advance to next line
          cmdTokens[$ - 1] ~= line;
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
            auto patch = new XmlPatch(filename, lineCount);
            patch.parseAddCmd(cmdTokens[1], cmdTokens[2]);
            repos[$ - 1].patches ~= patch;
          }
          else if (cmdTokens.length == 2)
          {
            block = BlockState.Start;
            cmdTokens ~= "";
          }
          break;
        case "del":
          if (!warnRepoUnspecified)
            break;

          if (cmdTokens.length == 2)
          {
            auto patch = new XmlPatch(filename, lineCount);
            patch.parseDeleteCmd(cmdTokens[1]);
            repos[$ - 1].patches ~= patch;
          }
          else
            stderr.writeln("'del' command requires 1 argument ", posInfo);
          break;
        case "repo":
          if (cmdTokens.length == 2)
          {
            repoSpecified = true;
            repos ~= new Repo(this, cmdTokens[1].to!string);
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
            auto patch = new XmlPatch(filename, lineCount);
            patch.parseSetCmd(cmdTokens[1], cmdTokens[2]);
            repos[$ - 1].patches ~= patch;
          }
          else if (cmdTokens.length == 2)
          {
            block = BlockState.Start;
            cmdTokens ~= "";
          }
          break;
        case "subtype":
          if (cmdTokens.length == 3)
          {
            typeof(typeSubs)* subs = repoSpecified ? &repos[$ - 1].typeSubs : &typeSubs;

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
        tree.patch(patch, namespaceNode);

      repo.fromXmlTree(tree); // Convert XML tree to Gir object tree
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
    auto tok = tokenizeType(type);

    if (tok.empty)
      return type;

    // Remove multiple "const", format as const(TYPE)*, and substitute type names
    if (tok[0] == "const" && tok[$ - 1] == "*")
      return "const(" ~ tok[0 .. $ - 1].filter!(x => x != "const" && x != "volatile")
        .map!(x => typeSubs.get(x, x))
        .join("") ~ ")*";

    return tok.filter!(x => x != "const" && x != "volatile")
      .map!(x => typeSubs.get(x, x))
      .map!(x => x == "*" ? x : " " ~ x)
      .join("").strip;
  }

  bool[dstring] reservedWords; /// Reserved words (_ appended)
  dstring[dstring] typeSubs; /// Global type substitutions
  Repo[] repos; /// Gir repositories
}

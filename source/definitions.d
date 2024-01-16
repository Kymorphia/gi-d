module definitions;

import std_includes;
import utils;

class Definitions
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
  {
    uint lineCount;

    string posInfo()
    {
      return "(file '" ~ filename ~ "' line " ~ lineCount.to!string ~ ")";
    }

    foreach (line; defs.splitLines.map!(x => x.strip))
    {
      lineCount++;

      if (line.startsWith("#") || line.empty)
        continue;

      auto tokens = line.split;

      switch (tokens[0])
      {
        case "girfile":
          break;
        case "reserved":
          if (tokens.length == 2)
            reservedWords[tokens[1]] = true;
          else
            stderr.writeln("reserved requires 1 argument ", posInfo);

          break;
        case "subtype":
          if (tokens.length == 3)
          {
            if (tokens[1]!in typeSubs)
              typeSubs[tokens[1]] = tokens[2];
            else
              stderr.writeln("subtype '", tokens[1], "' already exists ", posInfo);
          }
          else
            stderr.writeln("subtype requires 2 arguments ", posInfo);

          break;
        default:
          stderr.writeln("Unknown command '", tokens[0], "'");
      }
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
    if (name in reservedWords)
      return name ~ "_";

    return name;
  }

  /**
   * Substitute C type.
   * Params:
   *   type = C type string
   * Returns: C type string with any relevant substitutions
   */
  dstring subCTypeStr(dstring type)
  {
    auto tok = tokenizeType(type);

    if (tok.empty)
      return type;

    // Remove multiple "const", format as const(TYPE)*, and substitute type names
    if (tok[0] == "const" && tok[$ - 1] == "*")
      return "const(" ~ tok[0 .. $ - 1].filter!(x => x != "const")
        .map!(x => typeSubs.get(x, x))
        .join("") ~ ")*";

    return tok.filter!(x => x != "const")
      .map!(x => typeSubs.get(x, x))
      .join("");
  }

  dstring[dstring] typeSubs; /// Def file type substitutions
  bool[dstring] reservedWords; /// Def file reserved words (_ appended)
}

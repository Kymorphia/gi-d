module import_symbols;

import code_writer;
import std_includes;
import utils;

final class ImportSymbols
{
  this(dstring defaultNamespace = null)
  {
    this.defaultNamespace = defaultNamespace;
  }

  this(ImportSymbols imSyms, dstring defaultNamespace = null)
  {
    this(defaultNamespace);

    foreach (m; imSyms.modSyms.byKeyValue)
      add(m.key, m.value.keys);
  }

  /**
   * Add an import symbol.
   * Params:
   *   mod = The import module name (default namespace is used if not present)
   *   symbol = Optional symbol in the module to import
   */
  void add(dstring mod, dstring symbol = null)
  {
    if (symbol)
      add(mod, [symbol]);
    else
      add(mod, cast(dstring[])[]);
  }

  /**
   * Add import symbols to an import array.
   * Params:
   *   mod = The import module name 
   *   symbols = Array of symbols to add (empty to indicate all symbols wildcard)
   */
  void add(dstring mod, dstring[] symbols)
  {
    if (!mod.canFind('.') && defaultNamespace)
      mod = defaultNamespace ~ "." ~ mod;

    codeTrap("import.add", mod);

    if (mod in modSyms) // Module name already exists?
    {
      if (!modSyms[mod].empty) // Module symbol array not empty?
      {
        if (!symbols.empty)
        {
          foreach (sym; symbols)
            modSyms[mod][sym] = true; // Add symbol to symbol map
        }
        else
          modSyms[mod].clear; // All symbols requested, empty the symbol array
      } // Module import is all symbols
    }
    else if (!symbols.empty)
      modSyms[mod] = symbols.map!(x => tuple(x, true)).assocArray; // Add module and symbols
    else
      modSyms[mod] = cast(bool[dstring])null; // Add module for all symbols (empty array)
  }

  /**
   * Remove an import module or import module symbol from an import array.
   * Params:
   *   mod = Module name
   *   symbol = The symbol to remove or null (default) to remove all symbols
   * Returns: true if removed, false if no match was found
   */
  bool remove(dstring mod, dstring symbol = null)
  {
    if (!mod.canFind('.') && defaultNamespace)
      mod = defaultNamespace ~ "." ~ mod;

    if (mod !in modSyms)
      return false;

    if (!symbol.empty)
    {
      if (symbol !in modSyms[mod])
        return false;

      modSyms[mod].remove(symbol);
      return true;
    }

    modSyms.remove(mod);
    return true;
  }

  /**
   * Merge import symbols from another module symbol array.
   * Params:
   *   mergeSyms = Other module symbols to merge into this module symbol array
   */
  void merge(ImportSymbols mergeSyms)
  {
    foreach (m; mergeSyms.modSyms.byKeyValue)
      add(m.key, m.value.keys);
  }

  /**
   * Parse an import statement and add it to the import symbol array.
   * Params:
   *   statement = Import statement to parse
   */
  void parseImport(dstring statement)
  {
    auto tokens = statement.strip.stripRight(";").split;

    if (tokens.length >= 2 && tokens[0] == "import")
    {
      if (tokens.length > 3 && tokens[2] == ":")
        add(tokens[1], tokens[3 .. $].map!(x => x.strip(",")).array);
      else
        add(tokens[1]);
    }
    else
      throw new Exception("Invalid import statement '" ~ statement.to!string ~ "'");
  }

  /**
   * Generate the import commands for the import symbol object.
   * Params:
   *   prefix = A prefix to add to each import line (defaults to empty string)
   */
  dstring[] generate(dstring prefix = null)
  {
    dstring[] importLines;

    foreach (mod; modSyms.keys.array.sort)
    {
      auto syms = modSyms[mod];

      if (syms.empty)
        importLines ~= prefix ~ "import " ~ mod ~ ";";
      else
        importLines ~= prefix ~ "import " ~ mod ~ " : "d ~ syms.keys.join(", ") ~ ";";
    }

    return importLines;
  }

  /**
   * Write import statements to a code writer.
   * Params:
   *   writer = The code writer to write to
   *   prefix = A prefix to add to each import line (defaults to empty string)
   * Returns: true if any imports lines were written, false if empty
   */
  bool write(CodeWriter writer, dstring prefix = null)
  {
    auto importLines = generate(prefix);
    writer ~= importLines;
    return !importLines.empty;
  }

  /// moduleName => (Symbol => true)
  private bool[dstring][dstring] modSyms;
  private dstring defaultNamespace;
}

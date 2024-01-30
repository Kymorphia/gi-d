module import_symbols;

import code_writer;
import std_includes;

final class ImportSymbols
{
  this()
  {
  }

  this(ImportSymbols imSyms)
  {
    foreach (m; imSyms.modSyms.byKeyValue)
      add(m.key, m.value.keys);
  }

  /**
   * Add an import symbol.
   * Params:
   *   module = The import module name 
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
   *   module = The import module name 
   *   symbols = Array of symbols to add (empty to indicate all symbols wildcard)
   */
  void add(dstring mod, dstring[] symbols)
  {
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
   * Write import statements to a code writer.
   * Params:
   *   writer = The code writer to write to
   * Returns: true if any imports lines were written, false if empty
   */
  bool write(CodeWriter writer)
  {
    foreach (mod; modSyms.keys.array.sort)
    {
      auto syms = modSyms[mod];

      if (syms.empty)
        writer ~= "import " ~ mod ~ ";";
      else
        writer ~= "import " ~ mod ~ " : "d ~ syms.keys.join(", ") ~ ";";
    }

    return modSyms.length > 0;
  }

  /// moduleName => (Symbol => true)
  private bool[dstring][dstring] modSyms;
}

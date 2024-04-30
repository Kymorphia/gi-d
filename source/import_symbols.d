module import_symbols;

import code_writer;
import std_includes;
import utils;

import gir.structure;

final class ImportSymbols
{
  this(Structure klassModule)
  {
    this.klassModule = klassModule;
    this.defaultNamespace = klassModule.repo.namespace;
    this.classNames = [klassModule.name : klassModule];
  }

  this(ImportSymbols imSyms, Structure klassModule)
  {
    this(klassModule);
    merge(imSyms);
  }

  this(dstring defaultNamespace = null)
  {
    this.defaultNamespace = defaultNamespace;
  }

  this(ImportSymbols imSyms, dstring defaultNamespace = null)
  {
    this(defaultNamespace);
    merge(imSyms);
  }

  /**
   * Add class structure import to an import symbols object. Class names are aliased if there are conflicts.
   * Params:
   *   klass = The class structure to add a module import for
   */
  void add(Structure klass)
  {
    if (klass in classAliases || klass == klassModule)
      return;

    codeTrap("import.add", klass.fullName);

    dstring name;

    if (klass.name in classNames) // Check for class name conflicts
      name = "D" ~ klass.repo.namespace ~ klass.name; // Create an alias to use in local module
    else
      classNames[klass.name] = klass;

    classAliases[klass] = name;
  }

  /**
   * Add import module as a string with an optional symbol to an import symbols object. Should only be used if there is no associated Structure object for the import.
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
   * Add import module as a string with symbols to an import symbols object. Should only be used if there is no associated Structure object for the import.
   * Params:
   *   mod = The import module name in the form namespace.module (if namespace is not supplied the supplied default is used)
   *   symbols = Array of symbols to add (empty to indicate all symbols wildcard)
   */
  void add(dstring mod, dstring[] symbols)
  {
    codeTrap("import.add", mod);

    if (!mod.canFind('.') && defaultNamespace)
      mod = defaultNamespace ~ "." ~ mod;

    if (mod !in stringImports) // Module name doesn't already exist?
      stringImports[mod] = symbols.map!(x => tuple(x, true)).assocArray; // Add module and symbols (can be empty)
    else if (!stringImports[mod].empty) // Module symbol array not wildcard?
    {
      if (!symbols.empty)
      {
        foreach (sym; symbols)
          stringImports[mod][sym] = true; // Add symbol to symbol map
      }
      else
        stringImports[mod].clear; // All symbols requested, empty the symbol array
    } // Module import is all symbols, doesn't matter if symbols were specified or not, will still be wildcard
  }

  /**
   * Remove an import class from an import object.
   * Params:
   *   klass = Class structure to remove
   * Returns: true if removed, false if no match was found
   */
  bool remove(Structure klass)
  {
    if (klass !in classAliases)
      return false;

    classAliases.remove(klass);

    foreach (name, cmpKlass; classNames)
      if (cmpKlass == klass)
        classNames.remove(name);

    return true;
  }

  /**
   * Remove an import module by string or import module symbol from an import object.
   * Params:
   *   mod = The import module name in the form namespace.module (if namespace is not supplied the supplied default is used)
   *   symbol = The symbol to remove or null (default) to remove all symbols
   * Returns: true if removed, false if no match was found
   */
  bool remove(dstring mod, dstring symbol = null)
  {
    if (!mod.canFind('.') && defaultNamespace)
      mod = defaultNamespace ~ "." ~ mod;

    if (mod !in stringImports)
      return false;

    if (!symbol.empty)
    {
      if (symbol !in stringImports[mod])
        return false;

      stringImports[mod].remove(symbol);
      return true;
    }

    stringImports.remove(mod);
    return true;
  }

  /**
   * Merge import symbols from another module symbol array.
   * Params:
   *   mergeSyms = Other module symbols to merge into this module symbol array
   */
  void merge(ImportSymbols mergeSyms)
  {
    foreach (st, aliasName; mergeSyms.classAliases) // Add structure imports from other ImportSymbols object
      add(st);

    foreach (s, syms; mergeSyms.stringImports) // Add string imports from other ImportSymbols object
      add(s, syms.keys);
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
   * Resolve a class name for the given imports, using aliases created by createClassAliases() or the plain class name if not aliased.
   * Params:
   *   klass = The class structure to get the name of
   * Returns: The class name or an alias if there are conflicts in the current module imports.
   */
  dstring resolveClassName(Structure klass)
  {
    if (auto aliasName = classAliases.get(klass, null))
      return aliasName;

    return klass.dType;
  }

  /**
   * Generate the import commands for the import symbol object.
   * Params:
   *   prefix = A prefix to add to each import line (defaults to empty string)
   */
  dstring[] generate(dstring prefix = null)
  {
    dstring[] importLines;

    foreach (klass, aliasName; classAliases)
    {
      if (!aliasName.empty)
        importLines ~= prefix ~ "import " ~ klass.fullName ~ " : " ~ aliasName ~ " = " ~ klass.name ~ ";";
      else
        importLines ~= prefix ~ "import " ~ klass.fullName ~ ";";
    }

    foreach (mod, syms; stringImports)
    {
      if (syms.empty)
        importLines ~= prefix ~ "import " ~ mod ~ ";";
      else
        importLines ~= prefix ~ "import " ~ mod ~ " : "d ~ syms.keys.join(", ") ~ ";";
    }

    return importLines.sort.array;
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

private:
  immutable dstring[] notClassMods = [".Types", ".Global", ".c.types", ".c.functions"]; // Modules which aren't class modules (matches end of module name)

  Structure klassModule; /// The current class module or null if not a class module
  dstring[Structure] classAliases; /// Structure => Alias (or null if no alias)
  Structure[dstring] classNames; /// Hash of ClassName -> Structure to detect conflicts

  bool[dstring][dstring] stringImports; /// moduleName => (Symbol => true)
  dstring defaultNamespace; /// Default namespace to use if not provided when adding imports
}

module gir.repo;

import defs;
import import_symbols;
import gir.alias_;
import gir.base;
import gir.constant;
import gir.enumeration;
import gir.field;
import gir.func;
import gir.func_writer;
import gir.member;
import gir.param;
import gir.property;
import gir.structure;
import gir.type_node;
import code_writer;
import std_includes;
import utils;
import xml_patch;
import xml_tree;

/// Gir repository
final class Repo : Base
{
  this(Defs defs)
  {
    this.defs = defs;
  }

  this(Defs defs, string filename)
  {
    this.defs = defs;
    this.filename = filename;
  }

  override @property dstring name()
  {
    return namespace;
  }

  /// Convert an XML object tree to a Gir object tree
  void fromXmlTree(XmlTree tree)
  {
    void recurseXml(XmlNode node)
    {
      switch (node.id)
      {
        case "alias": // Alias info
          aliases ~= new Alias(this, node);
          break;
        case "array": // Array type info
          break; // Do nothing, TypeNode handles this
        case "attribute": // FIXME - Freeform attributes, but for which nodes?
          break;
        case "bitfield", "enumeration": // Flags and enumerations
          enums ~= new Enumeration(this, node);
          break;
        case "c:include": // C include header
          cIncludes ~= node["name"];
          break;
        case "callback": // Callback type
          if (node.parent && node.parent.id == "field")
          {
            if (auto field = baseParentFromXmlNodeWarn!Field(node))
            {
              if (!field.callback)
                field.callback = new Func(field, node);
              else
                node.warn("Field has multiple callbacks");
            }
          }
          else
            callbacks ~= new Func(this, node);
          break;
        case "class", "interface", "record", "union": // Class, interfaces, structures, and unions
          if (!node.parent || node.parent.id != "namespace")
          { // Only warn if embedded structure is not marked as opaque
            auto st = node.baseParentFromXmlNode!Structure;
            if (!st || !st.opaque)
              node.warn("Embedded structure types not supported");

            goto noRecurse;
          }

          structs ~= new Structure(this, node);
          break;
        case "constant": // Constants
          constants ~= new Constant(this, node);
          break;
        case "constructor": // Constructor method (class and record)
        case "function": // Function (class, enumeration, namespace, interface, record)
        case "method": // Method function (class, interface, record)
          if (auto cl = node.baseParentFromXmlNode!Structure)
            cl.functions ~= new Func(cl, node);
          else if (auto en = node.baseParentFromXmlNode!Enumeration)
            en.functions ~= new Func(en, node);
          else
            globalStruct.functions ~= new Func(globalStruct, node);
          break;
        case "disable": // Not an actual Gir attribute, used for disabling arbitrary nodes
          break;
        case "doc": // Documentation file position
          if (auto base = baseParentFromXmlNodeWarn!Base(node))
          {
            base.docContent = node.content;
            base.docFilename = node.get("filename");
            base.docLine = node.get("line").to!uint;
          }
          break;
        case "doc-deprecated": // Deprecated note
          if (auto base = node.baseParentFromXmlNodeWarn!Base)
            base.docDeprecated = node.content;
          break;
        case "doc-version": // FIXME - Not sure what this is for
          if (auto base = baseParentFromXmlNodeWarn!Base(node))
            base.docVersion = node.content;
          break;
        case "docsection": // Documentation section
          docSections ~= new DocSection(this, node);
          break;
        case "field": // Field
          if (auto st = node.baseParentFromXmlNodeWarn!Structure)
            st.fields ~= new Field(st, node);
          break;
        case "function-macro": // Function macro (namespace)
          goto noRecurse; // Ignore function macros
        case "glib:boxed":
          break; // Silently ignore this seldom used node (only TreeRowData seen so far)
        case "glib:signal": // Signals (class and interface)
          if (auto cl = node.baseParentFromXmlNode!Structure)
            cl.signals ~= new Func(cl, node);
          else
            node.warn("Signal found in an unexpected location");
          break;
        case "implements": // Implemented interface
          if (auto cl = node.baseParentFromXmlNodeWarn!Structure)
            if (auto name = node.get("name"))
              cl.implements ~= name;
          break;
        case "include": // Package include
          includes ~= Include(node["name"], node["version"]);
          break;
        case "member": // Enumeration or bitfield member
          if (auto en = node.baseParentFromXmlNodeWarn!Enumeration)
            en.members ~= new Member(en, node);
          break;
        case "namespace": // Namespace
          namespace = node["name"];
          sharedLibrary = node.get("shared-library");
          nsVersion = node.get("version");
          identifierPrefixes = node.get("c:identifier-prefixes");
          symbolPrefixes = node.get("c:symbol-prefixes");

          // Add global namespace structure
          globalStruct = new Structure(this);
          globalStruct.origDType = namespace;
          globalStruct.structType = StructType.Class;
          structs ~= globalStruct;
          break;
        case "package": // Package name
          packageName = node.get("name");
          break;
        case "parameter", "instance-parameter": // Parameter
          if (node.parent)
          {
            if (auto fn = node.parent.baseParentFromXmlNodeWarn!Func)
              fn.params ~= new Param(fn, node);
          }
          else
            node.warn("Expected node to have a parent");
          break;
        case "parameters": // Node which contains parameters
          break; // Do nothing, parameters are individually processed
        case "prerequisite": // Interface object prerequisite
          if (auto cl = node.baseParentFromXmlNodeWarn!Structure)
            if (auto name = node.get("name"))
              cl.prerequisites ~= name;
          break;
        case "property": // Class or interface property
          if (auto cl = node.baseParentFromXmlNodeWarn!Structure)
            cl.properties ~= new Property(cl, node);
          break;
        case "repository": // Toplevel repository
          repoVersion = node.get("version");
          xmlns = node.get("xmlns");
          xmlnsC = node.get("xmlns:c");
          xmlnsGlib = node.get("xmlns:glib");
          break;
        case "return-value": // Function return value info
          break; // Do nothing, handled by function object
        case "source-position": // Source position information
          if (auto base = node.baseParentFromXmlNodeWarn!Base)
          {
            base.sourceFilename = node.get("filename");
            base.sourceLine = node.get("line").to!uint;
          }
          break;
        case "type": // Type information
          TypeNode parent;

          if (node.parent && node.parent.id == "type") // Is parent XML node also a <type>? Then it is a container type (GList, GHashTable, etc)
            parent = node.baseParentFromXmlNode!TypeNode;

          if (!parent && node.parent && node.parent.id == "array") // Is parent XML node an <array>?
            parent = node.parent.baseParentFromXmlNode!TypeNode;

          if (parent) // Add the element type to the container
            parent.elemTypes ~= new TypeNode(parent, node);

          if (dumpCTypes && "c:type" in node.attrs && !node["c:type"].canFind('.'))
            cTypeHash[node["c:type"]] = true;

          if (dumpDTypes && "name" in node.attrs && !node["name"].canFind('.'))
            dTypeHash[defs.subTypeStr(node["name"], typeSubs)] = true;

          break;
        case "varargs": // Varargs enable
          if (auto par = node.baseParentFromXmlNodeWarn!Param)
            par.varargs = true;
          break;
        case "virtual-method": // Virtual method (class, interface)
          goto noRecurse; // Ignore virtual methods for now (FIXME - do we want to support them?)
        default:
          static bool[dstring] unknownElements;

          if (node.id !in unknownElements)
          {
            unknownElements[node.id] = true;
            warning(cast(string)("Unknown XML element '" ~ node.id ~ "'"));
          }
          break;
      }

      foreach (child; node.children)
        recurseXml(child);

    noRecurse:
    }

    recurseXml(tree.root);
  }

  /// Fixup types
  void fixupTypes()
  {
    foreach (al; aliases) // Fixup aliases
    {
      al.fixup;
      typeObjectHash[al.name] = al;
    }

    foreach (con; constants) // Fixup constants
    {
      con.fixup;
      typeObjectHash[con.name] = con;
    }

    foreach (en; enums) // Hash enums
      typeObjectHash[en.name] = en;

    foreach (cb; callbacks) // Hash callbacks
      typeObjectHash[cb.name] = cb;

    foreach (st; structs) // Fixup structures (base type only, not dependencies which are fixed up below)
    {
      st.fixupType;
      typeObjectHash[st.name] = st;
    }

    foreach (dcArray; structDefCode.byKeyValue) // Loop on structure definitions and assign to structs
    {
      auto st = cast(Structure)typeObjectHash.get(dcArray.key, null);

      if (!st) // Create new class structures if non-existant, fixup base type, and hash
      {
        st = new Structure(this);
        st.dType = st.origDType = dcArray.key;
        st.structType = StructType.Class;
        structs ~= st;
        st.fixupType;
        typeObjectHash[st.name] = st;
      }

      st.defCode = dcArray.value;
    }

    structs.sort!((x, y) => x.name < y.name); // Sort structures by name

    foreach (sub; kindSubs.byKeyValue) // Substitute type kinds
    {
      if (auto obj = typeObjectHash.get(sub.key, null))
      {
        if (auto node = cast(TypeNode)obj)
          node.kind = sub.value;
        else
          warning("Type '" ~ repo.name ~ "." ~ sub.key ~ "' kind cannot be substituted");
      }
      else
        warning("Type kind substitution '" ~ repo.name ~ "." ~ sub.key ~ "' not found");
    }
  }

  // Fixup additional type dependencies (after fixupTypes() is called)
  void fixupDeps()
  {
    foreach (cb; callbacks) // Fixup callbacks
      cb.fixup;

    foreach (st; structs) // Do a full fixup of structure dependencies now that all type bases have been fixed up
      st.fixupDeps;
  }

  /// Ensure consistent state of repo data
  void verify()
  {
    foreach (al; aliases) // Verify aliases
    {
      try
        al.verify;
      catch (Exception e)
      {
        al.disable = true;
        warning("Disabling alias '" ~ al.fullName.to!string ~ "': " ~ e.msg);
      }
    }

    foreach (con; constants) // Verify constants
    {
      try
        con.verify;
      catch (Exception e)
      {
        con.disable = true;
        warning("Disabling constant '" ~ con.fullName.to!string ~ "': " ~ e.msg);
      }
    }

    foreach (cb; callbacks) // Verify callbacks
    {
      try
      {
        if (cb.funcType != FuncType.Callback)
          throw new Exception("Callback type '" ~ cb.funcType.to!string ~ "' not supported");

        cb.verify;
      }
      catch (Exception e)
      {
        cb.disable = true;
        warning("Disabling callback '" ~ cb.fullName.to!string ~ "': " ~ e.msg);
      }
    }

    foreach (st; structs) // Verify structures
    {
      try
        st.verify;
      catch (Exception e)
      {
        st.disable = true;
        warning("Disabling structure '" ~ st.fullName.to!string ~ "': " ~ e.msg);
      }
    }
  }

  /**
   * Write repository D binding package.
   * Params:
   *   basePath = The path to the toplevel packages directory (defaults to "packages")
   *   packagePrefix = Prefix to add to package name (defaults to "gid-")
   */
  void writePackage(string basePath = "packages")
  {
    assert(namespace.length > 0);
    auto packagePath = buildPath(basePath, namespace.toLower.to!string);
    auto sourcePath = buildPath(packagePath, namespace.to!string);
    auto cSourcePath = buildPath(sourcePath, "c");

    writeCTypes(buildPath(cSourcePath, "types.d"));
    writeCFuncs(buildPath(cSourcePath, "functions.d"));
    writeGlobalModule(buildPath(sourcePath, "global.d"));

    foreach (st; structs)
      if (!st.disable && ((st.defCode && st.defCode.inClass) || st.kind.typeKindHasModule) && st !is globalStruct)
        st.write(buildPath(sourcePath, st.dType.to!string ~ ".d"));

    writeDubJsonFile(buildPath(packagePath, "dub.json"));
  }

  /**
   * Write a dub JSON package file.
   * Params:
   *   path = Path of the file to write
   */
  private void writeDubJsonFile(string path)
  {
    auto content = `{
  "name": "%s",
  "description": "%s library gi-d binding",
  "copyright": "Copyright © 2024, Kymorphia, PBC",
	"authors": ["Element Green <element@kymorphia.com>"],
  "license": "MIT",
  "targetType": "library",
  "importPaths": [".", ".."],
  "sourcePaths": ["%s", ".."],
  "sourceFiles": ["../gid.d"]%s
}
`;
    string deps;
    if (!includes.empty)
      deps = ",\n  \"dependencies\": {\n" ~ includes.map!(x => `    "gid:` ~ x.name.to!string.toLower ~ `": "*"`).join(",\n")
        ~ "\n  }";

    write(path, content.format(namespace.toLower.to!string, namespace.to!string, namespace.to!string, deps));
  }

  /**
   * Write package D binding C types file.
   * Params:
   *   path = Path to D binding C types file to write
   */
  private void writeCTypes(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ namespace ~ ".c.types;", ""];

    writer ~= includes.map!(x => "import " ~ x.name ~ ".c.types;\n").array;

    if (!includes.empty)
      writer ~= "";

    foreach (a; aliases)
    {
      a.writeDocs(writer);
      writer ~= ["alias " ~ a.cName ~ " = " ~ a.cType ~ ";", ""];
    }

    foreach (e; enums)
    {
      e.writeDocs(writer);

      writer ~= ["enum " ~ e.cName ~ (e.bitfield ? " : uint"d : ""), "{"];

      Member[dstring] dupCheck; // Duplicate member check

      foreach (m; e.members)
      {
        auto memberName = m.name.camelCase(true);

        if (auto dup = memberName in dupCheck)
        {
          dup.xmlNode.warn("Ignoring duplicate enum member '" ~ memberName ~ "'");
          continue;
        }

        dupCheck[memberName] = m;

        if (writer.lines[$ - 1] != "{")
          writer ~= "";

        m.writeDocs(writer);
        writer ~= defs.symbolName(memberName) ~ " = " ~ m.value ~ ",";
      }

      writer ~= ["}", ""];
    }

    foreach (st; structs)
    {
      if (st.kind == TypeKind.Namespace)
        continue;

      if (st.fields.length > 0 && !st.opaque) // Regular structure?
      {
        if (st.kind == TypeKind.Simple)
          st.writeDocs(writer);

        writer ~= ["struct " ~ st.cType, "{"];

        foreach (fi, f; st.fields)
        {
          f.writeDocs(writer);

          if (f.containerType == ContainerType.Array)
          {
            if (f.fixedSize == ArrayNotFixed)
            { // Use array cType if array is not a fixed size
              if (!f.cType.empty)
                writer ~= f.cType ~ " " ~ f.dName ~ ";";
              else
                f.xmlNode.warn("Struct array field is not fixed size and array c:type not set");
            }
            else if (!f.elemTypes.empty && !f.elemTypes[0].cType.empty)
              writer ~= f.elemTypes[0].cType ~ "[" ~ f.fixedSize.to!dstring ~ "] " ~ f.dName ~ ";";
            else
              f.xmlNode.warn("Struct array field is missing c:type attribute");
          }
          else if (f.callback) // Callback field?
            writer ~= "extern(C) " ~ f.callback.getCPrototype ~ " " ~ f.callback.dName ~ ";";
          else // A regular field
          {
            if (!f.cType.empty)
              writer ~= f.cType ~ " " ~ f.dName ~ ";";
            else
              f.xmlNode.warn("Struct field is missing c:type attribute");
          }

          if (fi + 1 < st.fields.length)
            writer ~= "";
        }

        writer ~= ["}", ""];
      }
      else // Opaque structure
      {
        st.writeDocs(writer);
        writer ~= ["struct " ~ st.cType ~ ";", ""];
      }
    }

    foreach (cb; callbacks)
    {
      cb.writeDocs(writer);
      writer ~= ["alias extern(C) " ~ cb.getCPrototype ~ " " ~ cb.cName ~ ";", ""];
    }

    foreach (con; constants)
    {
      con.writeDocs(writer);

      if (con.kind == TypeKind.String)
        writer ~= ["enum " ~ con.cName ~ " = \"" ~ con.value ~ "\";", ""];
      else
        writer ~= ["enum " ~ con.cName ~ " = " ~ con.value ~ ";", ""];
    }

    writer.write();
  }

  /**
   * Write the functions.d for the package which contains the C function definitions and dynamic loading.
   * Params:
   *   path = Path to the functions.d file to write
   */
  private void writeCFuncs(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ namespace ~ ".c.functions;", ""];

    writer ~= ["import " ~ namespace ~ ".c.types;"];
    writer ~= includes.map!(x => "import " ~ x.name ~ ".c.types;\n").array;
    writer ~= "";

    writeSharedLibs(writer);

    writer ~= ["__gshared extern(C)", "{"];

    foreach (st; structs)
    {
      auto preamble = ["", "// " ~ st.dType];

      if (writer.lines[$ - 1] == "{")
        preamble = preamble[1 .. $];

      if (!st.glibGetType.empty)
      { // Write GType function if set
        writer ~= preamble ~ ["GType function() c_" ~ st.glibGetType ~ ";"];
        preamble = null;
      }

      foreach (f; st.functions)
      {
        if (f.movedTo || !f.funcType.among(FuncType.Function, FuncType.Constructor, FuncType.Method))
          continue;

        writer ~= preamble ~ [f.getCPrototype ~ " c_" ~ f.cName ~ ";"];
        preamble = null;
      }
    }

    writer ~= ["}"];

    foreach (st; structs)
    {
      auto preamble = ["", "// " ~ st.name];

      if (st && !st.glibGetType.empty)
      { // Write GType function if set
        writer ~= preamble ~ ["alias " ~ st.glibGetType ~ " = c_" ~ st.glibGetType ~ ";"];
        preamble = null;
      }

      foreach (f; st.functions)
      {
        if (f.movedTo || !f.funcType.among(FuncType.Function, FuncType.Constructor, FuncType.Method))
          continue;

        writer ~= preamble ~ ["alias " ~ f.cName ~ " = c_" ~ f.cName ~ ";"];
        preamble = null;
      }
    }

    writer ~= ["", "shared static this()", "{"];

    foreach (st; structs)
    {
      auto preamble = ["", "// " ~ st.name];

      if (writer.lines[$ - 1] == "{")
        preamble = preamble[1 .. $];

      if (st && !st.glibGetType.empty)
      { // Write GType function if set
        writer ~= preamble ~ ["link(" ~ st.glibGetType ~ ", \"" ~ st.glibGetType ~ "\");"];
        preamble = null;
      }

      foreach (f; st.functions)
      {
        if (f.movedTo || !f.funcType.among(FuncType.Function, FuncType.Constructor, FuncType.Method))
          continue;

        writer ~= preamble ~ ["link(" ~ f.cName ~ ", \"" ~ f.cName ~ "\");"];
        preamble = null;
      }
    }

    writer ~= ["}"];

    writer ~= linkerCode.to!dstring;

    writer.write();
  }

  private void writeSharedLibs(CodeWriter writer)
  {
    dstring[] winLibs, osxLibs, posixLibs;

    foreach (lib; sharedLibrary.split(',')) // Multiple libraries separated by commas
    { // Example "libatk-1.0.so.0"
      auto t = lib.split(".so."); // Split example into "libatk-1.0" and "0"
      auto t2 = t[0].split("."); // Split "libatk-1.0" into "libatk-1" and "0"

      // libatk-1.0-0.dll;atk-1.0-0.dll;atk-1.dll
      winLibs ~= "\"" ~ t[0] ~ "-" ~ t[1] ~ ".dll;" ~ t[0][3 .. $] ~ "-" ~ t[1] ~ ".dll;" ~ t2[0][3 .. $] ~ ".dll\"";
      osxLibs ~= "\"" ~ t[0] ~ "." ~ t[1] ~ ".dylib\""; // libatk-1.0.0.dylib
      posixLibs ~= "\"" ~ lib ~ "\""; // libatk-1.0.so.0
    }

    writer ~= [
      "version(Windows)",
      "private immutable LIBS = [" ~ winLibs.join(", ") ~ "];",
      "version(OSX)",
      "private immutable LIBS = [" ~ osxLibs.join(", ") ~ "];",
      "else",
      "private immutable LIBS = [" ~ posixLibs.join(", ") ~ "];",
      ""
    ];
  }

  /**
   * Write the global module for a package which has the same name as the namespace.
   * Params:
   *   path = Path to the file to write the global module to
   */
  private void writeGlobalModule(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ namespace ~ ".global;", ""];

    // Create the function writers first to construct the imports
    auto imports = new ImportSymbols(globalStruct.defCode.imports, namespace);
    FuncWriter[] funcWriters;

    foreach (fn; globalStruct.functions)
    {
      if (fn.disable)
        continue;

      funcWriters ~= new FuncWriter(fn);
      imports.merge(funcWriters[$ - 1].imports);
    }

    imports.remove("global");

    if (imports.write(writer))
      writer ~= "";

    if (globalStruct.defCode.preClass.length > 0)
      writer ~= globalStruct.defCode.preClass;

    bool preambleShown;
    foreach (al; aliases) // Write out aliases
    {
      if (!preambleShown)
      {
        writer ~= "// Aliases";
        preambleShown = true;
      }

      writer ~= "alias " ~ al.name ~ " = " ~ al.cName ~ ";";
    }

    preambleShown = false;
    foreach (en; enums) // Write out enum aliases
    {
      if (en.bitfield)
        continue;

      if (!preambleShown)
      {
        if (writer.lines[$ - 1] != "{")
          writer ~= "";

        writer ~= "// Enums";
        preambleShown = true;
      }

      writer ~= "alias " ~ en.name ~ " = " ~ en.cName ~ ";";
    }

    preambleShown = false;
    foreach (en; enums) // Write out bitfield aliases
    {
      if (!en.bitfield)
        continue;

      if (!preambleShown)
      {
        if (writer.lines[$ - 1] != "{")
          writer ~= "";

        writer ~= "// Flags";
        preambleShown = true;
      }

      writer ~= "alias " ~ en.name ~ " = BitFlags!(" ~ en.cName ~ ", Yes.unsafe);";
    }

    preambleShown = false;
    foreach (st; structs) // Write out simple struct aliases (not classes)
    {
      if (st.kind != TypeKind.Simple && st.kind != TypeKind.Opaque)
        continue;

      if (!preambleShown)
      {
        if (writer.lines[$ - 1] != "{")
          writer ~= "";

        writer ~= "// Structs";
        preambleShown = true;
      }

      writer ~= "alias " ~ st.name ~ " = " ~ st.cType ~ ";";
    }

    preambleShown = false;
    foreach (cb; callbacks) // Write out callback aliases
    {
      if (cb.disable)
        continue;

      if (!preambleShown)
      {
        if (writer.lines[$ - 1] != "{")
          writer ~= "";

        writer ~= "// Callbacks";
        preambleShown = true;
      }

      writer ~= "alias " ~ cb.dName ~ " = " ~ cb.cName ~ ";";
    }

    if (globalStruct.defCode.inClass.length > 0)
      writer ~= globalStruct.defCode.inClass;

    foreach (fnWriter; funcWriters)
    {
      writer ~= "";
      fnWriter.write(writer);
    }

    writer.write();
  }

  Defs defs; /// Defs loaded from def files
  string defsFilename; /// Defs filename responsible for loading this Repo object

  string filename; /// Gir filename
  dstring packageName; /// Package name
  dstring repoVersion; /// Version of the repo

  dstring namespace; /// Name space of symbols in gir file
  dstring nsVersion; /// Version of the namespace
  dstring sharedLibrary; /// Namespace shared library (multiple values separated by commas)
  dstring identifierPrefixes; /// Prefix to identifiers
  dstring symbolPrefixes; /// C symbol prefix

  Alias[] aliases; /// Aliases
  Constant[] constants; /// Constants
  Enumeration[] enums; /// Enumerations and bitfields
  Func[] callbacks; /// Callback function types
  Structure[] structs; /// Structures
  Structure globalStruct; /// Global namespace structure
  Include[] includes; /// Package includes
  dstring[] cIncludes; /// C header includes
  DocSection[] docSections; /// Documentation sections

  XmlPatch[] patches; /// XML patches specified in definitions file
  dstring[dstring] typeSubs; /// Type substitutions defined in the definitions file
  TypeKind[dstring] kindSubs; /// Type kind substitutions defined in the definitions file
  DefCode[dstring] structDefCode; /// Code defined in definition file for structures

  Base[dstring] typeObjectHash; /// Hash of type objects by name (Alias, Func (callback), Constant, Enumeration, or Structure)

  dstring xmlns;
  dstring xmlnsC;
  dstring xmlnsGlib;

  static bool dumpCTypes; /// Set to true to dump C types
  bool[dstring] cTypeHash; /// Hash of local C types

  static bool dumpDTypes; /// Set to true to dump D types
  bool[dstring] dTypeHash; /// Hash of local D types
}

/// Package include
struct Include
{
  dstring name;
  dstring version_;
}

/// Documentation section
final class DocSection : Base
{
  this(Base parent, XmlNode node)
  {
    super(parent);
    fromXml(node);
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);
    name = node.get("name");
  }

  dstring name; /// Name of doc section
}

/// Dynamic linker code included directly in each package
immutable string linkerCode =
  `
import core.sys.posix.dlfcn : dlerror, dlopen, dlsym, RTLD_GLOBAL, RTLD_NOW;
import std.string : fromStringz, toStringz;

private void link(T)(ref T funcPtr, string symbol)
{
  foreach (lib; LIBS)
  {
    if (auto handle = dlopen(cast(char*)toStringz(lib), RTLD_GLOBAL | RTLD_NOW))
    {
      if (auto symPtr = dlsym(handle, cast(char*)toStringz(symbol)))
      {
        funcPtr = cast(T)symPtr;
        return;
      }
    }
    else
      throw new Error("Failed to load library '" ~ lib ~ "': " ~ dlerror().fromStringz.idup);
  }

  funcPtr = cast(T)&symbolNotFound;
}

private void symbolNotFound()
{
  throw new Error("Attempted to execute a dynamic library function which was not found");
}
`;

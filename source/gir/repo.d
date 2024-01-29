module gir.repo;

import defs;
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
final class Repo
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

  /**
   * Add a structure to a repository. A struct with the same name must not already exist.
   * Params:
   *   st = The structure to add to the repository
   */
  void addStruct(Structure st)
  {
    if (st.name in structHash)
      throw new Exception("Duplicate structure name '" ~ namespace.to!string ~ "." ~ st.name.to!string ~ "'");

    structs ~= st;
    structHash[st.name] = st;
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
          aliasHash[aliases[$ - 1].name] = aliases[$ - 1];
          break;
        case "array": // Array type info
          break; // Do nothing, TypeNode handles this
        case "attribute": // FIXME - Freeform attributes, but for which nodes?
          break;
        case "bitfield", "enumeration": // Flags and enumerations
          enums ~= new Enumeration(this, node);
          enumHash[enums[$ - 1].name] = enums[$ - 1];
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
              {
                field.callback = new Func(this, node);
                field.callback.parent = field;
              }
              else
                node.warn("Field has multiple callbacks");
            }
          }
          else
            callbacks ~= new Func(this, node);
          break;
        case "class", "interface", "record", "union": // Class, interfaces, structures, and unions
          if (!node.parent || node.parent.id != "namespace")
          { // Only warn if structure is not marked as opaque
            auto st = node.baseParentFromXmlNode!Structure;
            if (!st || !st.opaque)
              node.warn("Embedded structure types not supported");

            goto noRecurse;
          }

          addStruct(new Structure(this, node));
          break;
        case "constant": // Constants
          constants ~= new Constant(this, node);
          break;
        case "constructor": // Constructor method (class and record)
        case "function": // Function (class, enumeration, namespace, interface, record)
        case "function-macro": // Function macro (namespace)
        case "glib:signal": // Signals (class and interface)
        case "method": // Method function (class, interface, record)
        case "virtual-method": // Virtual method (class, interface)
          if (auto cl = node.baseParentFromXmlNode!Structure)
          {
            cl.functions ~= new Func(this, node);
            cl.functions[$ - 1].parent = cl;
          }
          else if (auto en = node.baseParentFromXmlNode!Enumeration)
          {
            en.functions ~= new Func(this, node);
            en.functions[$ - 1].parent = en;
          }
          else
            globalStruct.functions ~= new Func(this, node);
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
          {
            auto f = new Field(this, node);

            if (!f.introspectable && !st.opaque)
            {
              node.warn("Field is not introspectable, setting struct to opaque");
              st.opaque = true;
            }

            f.parent = st;
            st.fields ~= f;
          }
          break;
        case "glib:boxed":
          break; // Silently ignore this seldom used node (only TreeRowData seen so far)
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
          {
            en.members ~= new Member(this, node);
            en.members[$ - 1].parent = en;
          }
          break;
        case "namespace": // Namespace
          namespace = node["name"];
          sharedLibrary = node.get("shared-library");
          nsVersion = node.get("version");
          identifierPrefixes = node.get("c:identifier-prefixes");
          symbolPrefixes = node.get("c:symbol-prefixes");

          // Add global namespace structure
          globalStruct = new Structure(this);
          globalStruct.name = namespace;
          globalStruct.structType = StructType.Class;
          addStruct(globalStruct);
          break;
        case "package": // Package name
          packageName = node.get("name");
          break;
        case "parameter", "instance-parameter": // Parameter
          if (node.parent)
          {
            if (auto fn = node.parent.baseParentFromXmlNodeWarn!Func)
            {
              fn.params ~= new Param(this, node);
              fn.params[$ - 1].parent = fn;
            }
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
          {
            cl.properties ~= new Property(this, node);
            cl.properties[$ - 1].parent = cl;
          }
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
          if (dumpCTypes && "c:type" in node.attrs)
            cTypeHash[node["c:type"]] = true;

          if (dumpDTypes && "name" in node.attrs)
            dTypeHash[node["name"]] = true;

          break; // Do nothing, TypeNode handles this
        case "varargs": // Varargs enable
          if (auto par = node.baseParentFromXmlNodeWarn!Param)
            par.varargs = true;
          break;
        default:
          static bool[dstring] unknownElements;

          if (node.id !in unknownElements)
          {
            unknownElements[node.id] = true;
            stderr.writeln(cast(string)("Unknown XML element '" ~ node.id ~ "'"));
          }
          break;
      }

      foreach (child; node.children)
        recurseXml(child);

    noRecurse:
    }

    recurseXml(tree.root);
  }

  /**
   * Write repository D binding package.
   * Params:
   *   basePath = The path to the toplevel packages directory (defaults to "packages")
   *   packagePrefix = Prefix to add to package name (defaults to "gid-")
   */
  void writePackage(string basePath = "packages", string packagePrefix = "gid-")
  {
    assert(namespace.length > 0);
    auto packagePath = buildPath(basePath, packagePrefix ~ namespace.to!string);
    auto packageCPath = buildPath(packagePath, "c");

    writeCTypes(buildPath(packageCPath, "types.d"));
    writeCFuncs(buildPath(packageCPath, "functions.d"));
    writeGlobalModule(buildPath(packagePath, namespace.to!string ~ ".d"));

    foreach (st; structs)
    {
      if (st.disable)
        continue;

      if (st.isBoxed)
        st.writeBoxed(buildPath(packagePath, st.name.to!string ~ ".d"));
      else if (st.isGObject)
        st.writeObject(buildPath(packagePath, st.name.to!string ~ ".d"));
    }
  }

  /**
   * Write package D binding C types file.
   * Params:
   *   path = Path to D binding C types file to write
   */
  private void writeCTypes(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ namespace.toLower ~ ".c.types;", ""];

    foreach (a; aliases)
    {
      a.writeDocs(writer);
      writer ~= ["alias " ~ a.cName ~ " = " ~ a.subCType ~ ";", ""];
    }

    foreach (e; enums)
    {
      e.writeDocs(writer);

      writer ~= ["enum " ~ e.cName, "{"];

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
      if (st.fields.length > 0 && !st.opaque) // Regular structure?
      {
        if (!st.isDClass)
          st.writeDocs(writer);

        writer ~= ["struct " ~ st.subCType, "{"];

        foreach (fi, f; st.fields)
        {
          f.writeDocs(writer);

          if (f.isArray)
          {
            if (f.fixedSize == ArrayNotFixed)
            { // Use array cType if array is not a fixed size
              if (!f.arrayCType.empty)
                writer ~= f.arrayCType ~ " " ~ defs.symbolName(f.name.camelCase) ~ ";";
              else
                f.xmlNode.warn("Struct array field is not fixed size and array c:type not set");
            }
            else if (!f.cType.empty)
              writer ~= f.subCType ~ "[" ~ f.fixedSize.to!dstring ~ "] " ~ defs.symbolName(f.name.camelCase) ~ ";";
            else
              f.xmlNode.warn("Struct array field is missing c:type attribute");
          }
          else if (f.callback) // Callback field?
            writer ~= "extern(C) " ~ f.callback.getCPrototype ~ " " ~ defs.symbolName(f.callback.name.camelCase) ~ ";";
          else // A regular field
          {
            if (!f.cType.empty)
              writer ~= f.subCType ~ " " ~ defs.symbolName(f.name.camelCase) ~ ";";
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
        writer ~= ["struct " ~ st.subCType ~ ";", ""];
      }
    }

    foreach (cb; callbacks)
    {
      cb.writeDocs(writer);
      writer ~= ["extern(C) " ~ cb.getCPrototype ~ " " ~ defs.symbolName(cb.name.camelCase) ~ ";", ""];
    }

    foreach (con; constants)
    {
      con.writeDocs(writer);

      if (con.isString)
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

    writer ~= ["module " ~ namespace.toLower ~ ".c.funcs;", ""];

    writeSharedLibs(writer);

    writer ~= ["__gshared extern(C)", "{"];

    foreach (st; structs)
    {
      auto preamble = ["", "// " ~ namespace.toLower ~ "." ~ st.name];

      if (writer.lines[$ - 1] == "{")
        preamble = preamble[1 .. $];

      if (!st.glibGetType.empty)
      { // Write GType function if set
        writer ~= preamble ~ ["GType function() c_" ~ st.glibGetType ~ ";"];
        preamble = null;
      }

      foreach (f; st.functions)
      {
        if (!f.funcType.among(FuncType.Function, FuncType.Constructor, FuncType.Method))
          continue;

        writer ~= preamble ~ [f.getCPrototype ~ " c_" ~ f.cName ~ ";"];
        preamble = null;
      }
    }

    writer ~= ["}"];

    foreach (st; structs)
    {
      auto preamble = ["", "// " ~ namespace.toLower ~ "." ~ st.name];

      if (st && !st.glibGetType.empty)
      { // Write GType function if set
        writer ~= preamble ~ ["alias " ~ st.glibGetType ~ " = c_" ~ st.glibGetType ~ ";"];
        preamble = null;
      }

      foreach (f; st.functions)
      {
        if (!f.funcType.among(FuncType.Function, FuncType.Constructor, FuncType.Method))
          continue;

        writer ~= preamble ~ ["alias " ~ f.cName ~ " = c_" ~ f.cName ~ ";"];
        preamble = null;
      }
    }

    writer ~= ["", "static this()", "{"];

    foreach (st; structs)
    {
      auto preamble = ["", "// " ~ namespace.toLower ~ "." ~ st.name];

      if (writer.lines[$ - 1] == "{")
        preamble = preamble[1 .. $];

      if (st && !st.glibGetType.empty)
      { // Write GType function if set
        writer ~= preamble ~ [st.glibGetType ~ " = link(\"" ~ st.glibGetType ~ "\");"];
        preamble = null;
      }

      foreach (f; st.functions)
      {
        if (!f.funcType.among(FuncType.Function, FuncType.Constructor, FuncType.Method))
          continue;

        writer ~= preamble ~ [f.cName ~ " = link(\"" ~ f.cName ~ "\");"];
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

    writer ~= ["module " ~ namespace.toLower ~ "." ~ namespace ~ ";", ""];

    foreach (im; globalStruct.defCode.imports) // Write out imports
      writer ~= "import " ~ im ~ ";";

    if (globalStruct.defCode.imports.length > 0)
      writer ~= "";

    if (globalStruct.defCode.preClass.length > 0)
      writer ~= globalStruct.defCode.preClass;

    if (globalStruct.defCode.classDecl.length > 0)
      writer ~= globalStruct.defCode.classDecl;
    else
      writer ~= ["struct " ~ namespace, "{" ];

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

      writer ~= "alias " ~ en.name ~ " = BitFlags!" ~ en.cName ~ ";";
    }

    preambleShown = false;
    foreach (st; structs) // Write out simple struct aliases (not classes)
    {
      if (st.isDClass)
        continue;

      if (!preambleShown)
      {
        if (writer.lines[$ - 1] != "{")
          writer ~= "";

        writer ~= "// Structs";
        preambleShown = true;
      }

      writer ~= "alias " ~ st.name ~ " = " ~ st.subCType ~ ";";
    }

    if (globalStruct.defCode.inClass.length > 0)
      writer ~= globalStruct.defCode.inClass;

    foreach (fn; globalStruct.functions)
    {
      if (fn.disable)
        continue;

      writer ~= "";
      new FuncWriter(fn, writer).write();
    }

    writer ~= "}";

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

  Alias[dstring] aliasHash;
  Enumeration[dstring] enumHash;
  Structure[dstring] structHash;

  XmlPatch[] patches; /// XML patches specified in definitions file
  dstring[dstring] typeSubs; /// Type substitutions defined in the definitions file
  DefCode[dstring] structDefCode; /// Code defined in definition file for structures

  dstring xmlns;
  dstring xmlnsC;
  dstring xmlnsGlib;

  static bool dumpCTypes; /// Set to true to dump C types
  static bool[dstring] cTypeHash; /// Hash of all C types encountered

  static bool dumpDTypes; /// Set to true to dump D types
  static bool[dstring] dTypeHash; /// Hash of all D types encountered
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
  this(Repo repo, XmlNode node)
  {
    this.repo = repo;
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
import core.sys.posix.dlfcn : dlclose, dlerror, dlopen, dlsym, RTLD_GLOBAL, RTLD_NOW;
import std.string : fromStringz, toStringz;

private void* link(string symbol)
{
  foreach (lib; LIBS)
  {
    if (auto handle = dlopen(lib, RTLD_GLOBAL | RTLD_NOW))
    {
      if (auto fptr = dlsym(handle, cast(char*)toStringz(symbol)))
        return fptr;
    }
    else throw new Error("Failed to load library '" ~ lib ~ "': " ~ dlerror().fromStringz.idup);
  }

  return symbolNotFound;
}

private void symbolNotFound()
{
  throw new Error("Attempted to execute a dynamic library function which was not found");
}
`;

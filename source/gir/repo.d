module gir.repo;

import definitions;
import gir.alias_;
import gir.base;
import gir.constant;
import gir.enumeration;
import gir.field;
import gir.func;
import gir.member;
import gir.param;
import gir.property;
import gir.structure;
import gir.type_node;
import code_writer;
import std_includes;
import utils;
import xml_tree;

/// Gir repository
final class Repo
{
  this(Definitions defs)
  {
    this.defs = defs;
  }

  this(Definitions defs, XmlTree tree)
  {
    this(defs);
    fromXmlTree(tree);
  }

  /// Convert an XML object tree to a Gir object tree
  void fromXmlTree(XmlTree tree)
  {
    void recurseXml(XmlNode node)
    {
      switch (node.name)
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
          if (node.parent && node.parent.name == "field")
          {
            if (auto field = baseParentFromXmlNodeWarn!Field(node))
            {
              if (field.callback)
                node.warn("Field has multiple callbacks");
              else
                field.callback = new Func(this, node);
            }
          }
          else
            callbacks ~= new Func(this, node);
          break;
        case "class", "interface", "record": // Class, interfaces, and structures
          structs ~= new Structure(this, node);
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
            cl.functions ~= new Func(this, node);
          else if (auto en = node.baseParentFromXmlNode!Enumeration)
            en.functions ~= new Func(this, node);
          else
            functions ~= new Func(this, node);
          break;
        case "doc": // Documentation file position
          if (auto base = baseParentFromXmlNodeWarn!Base(node))
          {
            base.docContent = node.content;
            base.docFilename = node.get("filename");
            base.docLine = node.get("line").to!uint;
          }
          break; // Do nothing, handled by individual objects
        case "doc-deprecated": // Deprecated note
          if (auto base = node.baseParentFromXmlNodeWarn!Base)
            base.docDeprecated = node.content;
          break;
        case "docsection": // Documentation section
          docSections ~= new DocSection(this, node);
          break;
        case "field": // Field 
          if (auto st = node.baseParentFromXmlNodeWarn!Structure)
            st.fields ~= new Field(this, node);
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
            en.members ~= new Member(this, node);
          break;
        case "namespace": // Namespace
          namespace = node["name"];
          sharedLibrary = node.get("shared-library");
          nsVersion = node.get("version");
          identifierPrefixes = node.get("c:identifier-prefixes");
          symbolPrefixes = node.get("c:symbol-prefixes");
          break;
        case "package": // Package name
          packageName = node.get("name");
          break;
        case "parameter", "instance-parameter": // Parameter
          if (node.parent)
          {
            if (auto fn = node.parent.baseParentFromXmlNodeWarn!Func)
              fn.params ~= new Param(this, node);
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
            cl.properties ~= new Property(this, node);
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
          break; // Do nothing, TypeNode handles this
        case "varargs": // Varargs enable
          if (auto par = node.baseParentFromXmlNodeWarn!Param)
            par.varargs = true;
          break;
        default:
          static bool[dstring] unknownElements;

          if (node.name !in unknownElements)
          {
            unknownElements[node.name] = true;
            stderr.writeln(cast(string)("Unknown XML element '" ~ node.name ~ "'"));
          }
          break;
      }

      foreach (child; node.children)
        recurseXml(child);
    }

    recurseXml(tree.root);
  }

  /**
   * Write repository D binding package.
   * Params:
   *   basePath = The path to the toplevel packages directory (defaults to "packages")
   *   packagePrefix = Prefix to add to package name (defaults to "gid")
   */
  void writePackage(string basePath = "packages", string packagePrefix = "gid")
  {
    assert(namespace.length > 0);
    auto packagePath = buildPath(basePath, packagePrefix ~ namespace.to!string);
    auto packageCPath = buildPath(packagePath, "c");

    writeCTypes(buildPath(packageCPath, "types.d"));
    writeCFuncs(buildPath(packageCPath, "functions.d"));
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
        st.writeDocs(writer);

        writer ~= ["struct " ~ st.subCType, "{"];

        foreach (fi, f; st.fields)
        {
          f.writeDocs(writer);

          if (f.isArray)
          {
            if (f.fixedSize == NotFixedSize)
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
      else // Opaque structure (docs are not written for the C type)
        writer ~= ["struct " ~ st.subCType ~ ";", ""];
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

  private void writeCFuncs(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ namespace.toLower ~ ".c.funcs;", ""];

    writeSharedLibs(writer);

    writer ~= ["__gshared extern(C)", "{"];

    foreach (st; structs)
    {
      if (st.functions.length == 0)
        continue;

      bool preambleShown;

      foreach (f; st.functions)
      {
        with (FuncType)
          if (!f.funcType.among(Function, Constructor, Method))
            continue;

        if (!preambleShown)
        {
          if (writer.lines[$ - 1] != "{")
            writer ~= "";

          writer ~= ["// " ~ namespace.toLower ~ "." ~ st.name, ""];
          preambleShown = true;
        }

        writer ~= f.getCPrototype ~ " c_" ~ f.cName ~ ";";
      }
    }

    writer ~= ["}", ""];

    foreach (st; structs)
    {
      bool preambleShown;

      foreach (f; st.functions)
      {
        with (FuncType)
          if (!f.funcType.among(Function, Constructor, Method))
            continue;

        if (!preambleShown)
        {
          if (writer.lines[$ - 2] != "}")
            writer ~= "";

          writer ~= ["// " ~ namespace.toLower ~ "." ~ st.name, ""];
          preambleShown = true;
        }

        writer ~= "alias " ~ f.cName ~ " = c_" ~ f.cName ~ ";";
      }
    }

    writer ~= ["", "static this()", "{"];

    foreach (st; structs)
    {
      bool preambleShown;

      foreach (f; st.functions)
      {
        with (FuncType)
          if (!f.funcType.among(Function, Constructor, Method))
            continue;

        if (!preambleShown)
        {
          if (writer.lines[$ - 1] != "{")
            writer ~= "";

          writer ~= ["// " ~ namespace.toLower ~ "." ~ st.name, ""];
          preambleShown = true;
        }

        writer ~= f.cName ~ " = link(\"" ~ f.cName ~ "\");";
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

  Definitions defs; /// Definitions loaded from def files

  dstring fileName; /// Gir filename
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
  Func[] functions; /// Global package functions
  Structure[] structs; /// Structures
  Include[] includes; /// Package includes
  dstring[] cIncludes; /// C header includes
  DocSection[] docSections; /// Documentation sections

  dstring xmlns;
  dstring xmlnsC;
  dstring xmlnsGlib;
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

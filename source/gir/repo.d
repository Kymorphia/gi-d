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
        case "class", "interface": // Classes and interfaces
          structs ~= new Structure(this, node);
          break;
        case "record", "union": // Structures and unions
          if (auto st = baseParentFromXmlNode!Structure(node))
          { // Embedded union or structure field
            st.fields ~= new Field(st, node);
            st.fields[$-1].directStruct = new Structure(this, node);
          }
          else
            structs ~= new Structure(this, node);
          break;
        case "constant": // Constants
          constants ~= new Constant(this, node);
          break;
        case "constructor": // Constructor method (class and record)
        case "function": // Function (class, enumeration, namespace, interface, record)
        case "method": // Method function (class, interface, record)
          if (auto st = node.baseParentFromXmlNode!Structure)
            st.addFunc(new Func(st, node));
          else if (auto en = node.baseParentFromXmlNode!Enumeration)
            en.functions ~= new Func(en, node);
          else
            globalStruct.addFunc(new Func(globalStruct, node));
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
          globalStruct.kind = TypeKind.Namespace;
          globalStruct.origDType = "Global";
          globalStruct.structType = StructType.Class;
          structs ~= globalStruct;

          // Add global Types structure
          typesStruct = new Structure(this);
          typesStruct.kind = TypeKind.Namespace;
          typesStruct.origDType = "Types";
          typesStruct.structType = StructType.Class;
          structs ~= typesStruct;
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
          if (node.parent && node.parent.id.among("array"d, "type"d)) // Check for array or type (container) XML node parent
            if (auto parent = node.parent.baseParentFromXmlNode!TypeNode) // Get the parent of the array which contains the type information
              parent.elemTypes ~= new TypeNode(parent, node); // Add the element type to the container
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

  /// Fixup dependent data
  void fixup()
  {
    foreach (al; aliases) // Fixup aliases
    {
      al.fixup;
      typeObjectHash[al.name] = al;

      if (al.origName != al.name)
        typeObjectHash[al.origName] = al;
    }

    foreach (con; constants) // Hash constants (can reference other types, which are fixed up in fixupDeps())
    {
      con.fixup;
      typeObjectHash[con.name] = con;
    }

    foreach (en; enums) // Hash enums
    {
      typeObjectHash[en.name] = en;

      if (en.origName != en.name)
        typeObjectHash[en.origName] = en;
    }

    foreach (cb; callbacks) // Hash callbacks
    {
      cb.fixup;
      typeObjectHash[cb.name] = cb;

      if (cb.origName != cb.name)
        typeObjectHash[cb.origName] = cb;
    }

    foreach (st; structs) // Fixup structures (base type only, not dependencies which are fixed up below)
    {
      st.fixup;
      typeObjectHash[st.dType] = st;

      if (st.origDType != st.dType)
        typeObjectHash[st.origDType] = st;
    }

    foreach (stKey, stValue; structDefCode) // Loop on structure definitions and assign to structs
    {
      auto st = cast(Structure)typeObjectHash.get(stKey, null);

      if (!st) // Create new class structures if non-existant, fixup base type, and hash
      {
        st = new Structure(this);
        st.dType = st.origDType = stKey;
        st.structType = StructType.Class;
        structs ~= st;
        st.fixup;
        typeObjectHash[st.name] = st;
      }

      st.defCode = stValue;
    }

    structs.sort!((x, y) => x.name < y.name); // Sort structures by name

    foreach (sub; kindSubs.byKeyValue) // Substitute type kinds
    {
      if (auto obj = typeObjectHash.get(sub.key, null))
      {
        if (auto node = cast(TypeNode)obj)
          node.kind = sub.value;
        else
          warning("Type '" ~ name ~ "." ~ sub.key ~ "' kind cannot be substituted");
      }
      else
        warning("Type kind substitution '" ~ name ~ "." ~ sub.key ~ "' not found");
    }
  }

  /// Ensure consistent state of repo data
  void verify()
  {
    if (namespace.empty)
      throw new Exception("Repo '" ~ filename ~ "' has empty namespace");

    if (!merge.empty && merge !in defs.repoHash)
      throw new Exception("Repo '" ~ merge.to!string ~ "' not found to merge '" ~ namespace.to!string ~ "' into");

    foreach (al; aliases) // Verify aliases
    {
      try
        al.verify;
      catch (Exception e)
      {
        al.disable = true;
        warning(al.xmlLocation ~ "Disabling alias '" ~ al.fullName.to!string ~ "': " ~ e.msg);
      }
    }

    foreach (con; constants) // Verify constants
    {
      try
        con.verify;
      catch (Exception e)
      {
        con.disable = true;
        warning(con.xmlLocation ~ "Disabling constant '" ~ con.fullName.to!string ~ "': " ~ e.msg);
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
        warning(cb.xmlLocation ~ "Disabling callback '" ~ cb.fullName.to!string ~ "': " ~ e.msg);
      }
    }

    foreach (st; structs) // Verify structures
    {
      try
        st.verify;
      catch (Exception e)
      {
        st.disable = true;
        warning(st.xmlLocation ~ "Disabling structure '" ~ st.fullName.to!string ~ "': " ~ e.msg);
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
    auto packageName = (!merge.empty ? merge : namespace).toLower.to!string; // Use the package of the merge namespace if merge specified
    auto packagePath = buildPath(basePath, packageName);
    auto sourcePath = buildPath(packagePath, namespace.to!string);
    auto cSourcePath = buildPath(sourcePath, "c");

    writeCTypes(buildPath(cSourcePath, "types.d"));
    writeCFuncs(buildPath(cSourcePath, "functions.d"));

    if (typesStruct)
      writeTypesModule(buildPath(sourcePath, "Types.d"));

    if (globalStruct)
      writeGlobalModule(buildPath(sourcePath, "Global.d"));

    foreach (st; structs)
    {
      if (!st.disable && ((st.defCode && st.defCode.inClass) || st.inModule) && st !is globalStruct
        && st !is typesStruct)
      {
        st.write(sourcePath);

        if (st.kind == TypeKind.Interface)
          st.write(sourcePath, true);
      }
    }

    foreach (al; aliases) // Write modules for aliases to structure types in modules
    {
      auto st = cast(Structure)al.typeObject;

      if (!al.disable && st && st.inModule)
      {
        auto codeWriter = new CodeWriter(buildPath(sourcePath, al.name.to!string ~ ".d"), [
          "module " ~ al.fullName ~ ";",
          "",
          "import " ~ st.fullName ~ ";",
          "",
          "alias " ~ al.name ~ " = " ~ st.name ~ ";"
        ]);

        codeWriter.write;
      }
    }

    if (merge.empty)
      writeDubJsonFile(buildPath(packagePath, "dub.json"));
  }

  /**
   * Write a dub JSON package file.
   * Params:
   *   path = Path of the file to write
   */
  private void writeDubJsonFile(string path)
  {
    string output = "{\n";
    output ~= `  "name": "` ~ namespace.toLower.to!string ~ "\",\n";

    if ("description" !in dubInfo)
      dubInfo["description"] ~= namespace.to!string ~ " library gi-d binding";

    foreach (key; ["description", "copyright", "authors", "license"])
    {
      if (auto val = dubInfo.get(key, defs.dubInfo.get(key, null))) // Fall back to master dub info
      {
        if (key == "authors")
          output ~= `  "authors": [` ~ val.map!(x => `"` ~ x ~ `"`).join(", ") ~ "],\n";
        else
          output ~= `  "` ~ key ~ `": "` ~ val[0] ~ "\",\n";
      }
    }

    output ~= `  "targetType": "dynamicLibrary",` ~ "\n";
    output ~= `  "importPaths": [".", ".."],` ~ "\n";
    output ~= `  "sourcePaths": ["` ~ namespace.to!string ~ `", ".."]`;

    if (!includes.empty)
    { // Use merge repo names as needed
      string depFunc(Include inc)
      {
        string s = `    "gid:`;
        auto incRepo = defs.repoHash.get(inc.name, null);
        s ~= ((incRepo && incRepo.merge) ? incRepo.merge : inc.name).to!string.toLower;
        return s ~ `": "*"`;
      }

      output ~= ",\n  \"dependencies\": {\n" ~ includes.map!depFunc.join(",\n") ~ "\n  }";
    }

    output ~= "\n}\n";
    write(path, output);
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

    writer ~= includes.map!(x => "public import " ~ x.name ~ ".c.types;\n").array;

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
      codeTrap("ctypes.struct", st.fullName);

      if (st.kind == TypeKind.Namespace || st.cType.empty)
        continue;

      if (st.fields.length > 0 && !st.opaque && !st.pointer) // Regular structure?
        st.writeCStruct(writer);
      else if (st.pointer)
      {
        st.writeDocs(writer);
        writer ~= ["alias " ~ st.cType ~ " = " ~ st.cType ~ "_st*;", ""];
        writer ~= ["struct " ~ st.cType ~ "_st;", ""];
      }
      else // Opaque structure or pointer to opaque structure
      {
        st.writeDocs(writer);
        writer ~= ["struct " ~ st.cType ~ ";"d, ""];
      }
    }

    foreach (cb; callbacks)
    {
      cb.writeDocs(writer);
      writer ~= ["alias extern(C) " ~ cb.getCPrototype ~ " " ~ cb.cName ~ ";", ""];
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
    writer ~= includes.map!(x => "public import " ~ x.name ~ ".c.types;\n").array;
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
   * Write the global types module for a package.
   * Params:
   *   path = Path to the file to write the global module to
   */
  private void writeTypesModule(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ namespace ~ ".Types;", ""];

    auto imports = new ImportSymbols(typesStruct.defCode.imports, namespace);
    imports.add("Gid.gid");
    imports.add(namespace ~ ".c.types");

    foreach (cb; callbacks) // Add imports for callback types
      if (!cb.disable)
        cb.addImports(imports, this);

    imports.remove("Types");

    if (imports.write(writer))
      writer ~= "";

    foreach (i, al; aliases.filter!(x => !x.disable).enumerate) // Write out aliases
    {
      auto st = cast(Structure)al.typeObject;

      if ((al.typeObject && al.typeObject.disable) || (st && st.inModule)) // Skip if target type is disabled or an alias of a type in a module (alias is written as a module in writePackage())
        continue;

      if (i == 0)
        writer ~= [""d, "// Aliases"];

      auto fn = cast(Func)al.typeObject;

      if (fn && fn.funcType == FuncType.Callback) // Callback aliases should alias to D callback delegates, not C functions
        writer ~= ["alias " ~ al.name ~ " = " ~ fn.dName ~ ";"];
      else if (al.name == al.cName)
        writer ~= ["alias " ~ al.name ~ " = " ~ namespace ~ ".c.types." ~ al.cName ~ ";"];
      else
        writer ~= ["alias " ~ al.name ~ " = " ~ al.cName ~ ";"];
    }

    foreach (i, en; enums.filter!(x => !x.disable).enumerate) // Write out enums
      writer ~= (i == 0 ? [""d, "// Enums"] : []) ~ ["alias " ~ en.name ~ " = " ~ en.cName ~ ";"];

    auto simpleStructs = structs.filter!(x => !x.disable && !x.inModule).enumerate;

    foreach (i, st; simpleStructs) // Write out simple struct aliases (not classes)
      writer ~= (i == 0 ? [""d, "// Structs"] : []) ~ ["alias " ~ st.name ~ " = " ~ st.cType ~ ";"];

    foreach (i, cb; callbacks.filter!(x => !x.disable).enumerate) // Write out callback delegate types
      writer ~= (i == 0 ? [""d, "// Callbacks"] : []) ~ cb.getDelegPrototype;

    foreach (i, con; constants.filter!(x => !x.disable).enumerate) // Write out constants
    {
      writer ~= "";
      con.writeDocs(writer);
      writer ~= ["enum " ~ con.name ~ (con.kind == TypeKind.String ? (" = \"" ~ con.value ~ "\";")
        : (" = " ~ con.value ~ ";")), ""];
    }

    if (typesStruct.defCode.preClass.length > 0)
      writer ~= typesStruct.defCode.preClass;

    if (typesStruct.defCode.inClass.length > 0)
      writer ~= typesStruct.defCode.inClass;

    writer.write();
  }

  /**
   * Write the global module for a package containing global functions.
   * Params:
   *   path = Path to the file to write the global module to
   */
  private void writeGlobalModule(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ namespace ~ ".Global;", ""];

    // Create the function writers first to construct the imports
    auto imports = new ImportSymbols(globalStruct.defCode.imports, namespace);
    imports.add("Gid.gid");
    imports.add(namespace ~ ".c.functions");
    imports.add(namespace ~ ".c.types");

    FuncWriter[] funcWriters;

    foreach (fn; globalStruct.functions)
    {
      if (fn.disable)
        continue;

      funcWriters ~= new FuncWriter(fn);
      imports.merge(funcWriters[$ - 1].imports);
    }

    imports.remove("Global");

    if (imports.write(writer))
      writer ~= "";

    if (globalStruct.defCode.preClass.length > 0)
      writer ~= globalStruct.defCode.preClass;

    if (globalStruct.defCode.inClass.length > 0)
      writer ~= globalStruct.defCode.inClass;

    foreach (fnWriter; funcWriters) // Write out functions
    {
      writer ~= "";
      fnWriter.write(writer);
    }

    if (globalStruct.defCode.postClass.length > 0)
      writer ~= globalStruct.defCode.postClass;

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
  Structure typesStruct; /// Global Types module structure
  Include[] includes; /// Package includes
  dstring[] cIncludes; /// C header includes
  DocSection[] docSections; /// Documentation sections

  XmlPatch[] patches; /// XML patches specified in definitions file
  dstring[dstring] cTypeSubs; /// C type substitutions defined in the definitions file
  dstring[dstring] dTypeSubs; /// D type substitutions defined in the definitions file
  TypeKind[dstring] kindSubs; /// Type kind substitutions defined in the definitions file
  DefCode[dstring] structDefCode; /// Code defined in definition file for structures
  dstring merge; /// Package to merge this repo into identified by its namespace
  string[][string] dubInfo; /// Dub JSON file info ("name", "description", "copyright", "authors", "license"), only "authors" uses multiple values

  Base[dstring] typeObjectHash; /// Hash of type objects by name (Alias, Func (callback), Constant, Enumeration, or Structure)

  dstring xmlns;
  dstring xmlnsC;
  dstring xmlnsGlib;

  static bool dumpCTypes; /// Set to true to dump C types
  static bool dumpDTypes; /// Set to true to dump D types
  static bool suggestDefCmds; /// Output definition command suggestions
  string[][string] suggestions; /// Suggested definitions (if suggestDefCmds is enabled), keyed by type of suggestion
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

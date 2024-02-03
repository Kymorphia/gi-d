module gir.structure;

import code_writer;
import defs;
import import_symbols;
import gir.base;
import gir.field;
import gir.func;
import gir.func_writer;
import gir.property;
import gir.repo;
import gir.type_node;
import utils;

/// Type of structure
enum StructType : dstring
{
  Class = "class", /// A class
  Interface = "interface", /// An interface
  Record = "record", /// A structure record
  Union = "union", /// A union
}

/// Structure class which is used for class, interface, and records in Gir files
final class Structure : Base
{
  this(Repo repo)
  {
    this.repo = repo;
    defCode = new DefCode;
  }

  this(Repo repo, XmlNode node)
  {
    this(repo);
    fromXml(node);
  }

  @property dstring subName()
  {
    return repo.defs.subTypeStr(name, repo.typeSubs);
  }

  @property dstring subCType()
  {
    return repo.defs.subTypeStr(cType, repo.typeSubs);
  }

  @property TypeKind kind()
  {
    if (cType.empty)
      return TypeKind.Namespace;

    if (structType == StructType.Class && !parent.empty && !glibGetType.empty)
      return TypeKind.Object;

    if (structType == StructType.Record && !glibGetType.empty)
      return TypeKind.Boxed;

    if (structType == StructType.Record && opaque)
      return TypeKind.Opaque;

    if (structType == StructType.Record || structType == StructType.Union)
      return functions.empty ? TypeKind.Simple : TypeKind.Wrap;

    if (structType == StructType.Interface)
      return TypeKind.Interface;

    return TypeKind.Unknown;
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    name = node.get("name");
    structType = cast(StructType)node.id;
    cType = node.get("c:type");
    cSymbolPrefix = node.get("c:symbol-prefix");
    parent = node.get("parent");
    version_ = node.get("version");

    abstract_ = node.get("abstract") == "1";
    deprecated_ = node.get("deprecated") == "1";
    disguised = node.get("disguised") == "1";
    opaque = node.get("opaque") == "1";
    glibFundamental = node.get("glib:fundamental") == "1";

    deprecatedVersion = node.get("deprecated-version");
    glibGetType = node.get("glib:get-type");
    glibTypeName = node.get("glib:type-name");
    glibGetValueFunc = node.get("glib:get-value-func");
    glibSetValueFunc = node.get("glib:set-value-func");
    glibRefFunc = node.get("glib:glib-ref-func");
    glibUnrefFunc = node.get("glib:glib-unref-func");
    glibTypeStruct = node.get("glib:type-struct");
    glibIsGtypeStructFor = node.get("glib:is-gtype-struct-for");
  }

  /**
   * Write structure module.
   * Params:
   *   path = Path to the file to write to
   */
  void write(string path)
  {
    auto moduleName = repo.namespace ~ "." ~ name;
    auto writer = new CodeWriter(path);
    writer ~= ["module " ~ moduleName ~ ";", ""];

    // Create the function writers first to construct the imports
    auto imports = new ImportSymbols(defCode.imports, repo.namespace);

    imports.add("gid");
    imports.add(repo.namespace ~ ".c.functions");
    imports.add(repo.namespace ~ ".c.types");

    FuncWriter[] funcWriters;

    foreach (fn; functions)
    {
      if (!fn.disable)
      {
        funcWriters ~= new FuncWriter(fn);
        imports.merge(funcWriters[$ - 1].imports);
      }
    }

    dstring parentType;
    auto kindVal = kind;

    if (kindVal == TypeKind.Object)
    {
      if (parent.canFind('.'))
        parentType = parent;
      else
        parentType = repo.namespace ~ "." ~ parent;
    }
    else if (kindVal == TypeKind.Boxed)
      parentType = "GLib.Boxed";

    if (parentType)
      imports.add(parentType);

    dstring[] propMethods;
    if (kindVal == TypeKind.Wrap)
      propMethods = constructPropMethods(imports); // Construct wrapper property methods in order to collect imports

    imports.remove(moduleName);

    if (imports.write(writer))
      writer ~= "";

    if (defCode.preClass.length > 0)
      writer ~= defCode.preClass;

    writeDocs(writer);

    if (!defCode.classDecl.empty)
      writer ~= defCode.classDecl;
    else if (parentType)
      writer ~= "class " ~ subName ~ " : " ~ parentType.split('.')[1];
    else
      writer ~= "class " ~ subName;

    if (kindVal == TypeKind.Object)
    {
      writer ~= ["{", "this(" ~ subCType ~ "* wrapPtr, bool owned)", "{", "super(wrapPtr, owned);", "}", ""];
      writer ~= ["auto cPtr()", "{", "return cast(" ~ subCType ~ "*)ptr;", "}", ""];
      writer ~= ["override GType getType()", "{", "return " ~ glibGetType ~ "();", "}"];
    }
    else if (kindVal == TypeKind.Boxed)
    {
      writer ~= ["{", "this(" ~ subCType ~ "* wrapPtr)", "{", "super(wrapPtr);", "}", ""];
      writer ~= ["auto cPtr()", "{", "return cast(" ~ subCType ~ "*)ptr;", "}", ""];
      writer ~= ["override GType getType()", "{", "return " ~ glibGetType ~ "();", "}"];
    }
    else if (kindVal == TypeKind.Wrap) // Wrap a structure in a class with properties
    {
      writer ~= ["{", subCType ~ "* cPtr;", ""];
      writer ~= ["this(" ~ subCType ~ "* wrapPtr)", "{", "cPtr = wrapPtr;", "}"];
      writer ~= propMethods;
    }
    else if (defCode.inClass.length == 0)
      writer ~= "{";

    if (defCode.inClass.length > 0)
      writer ~= defCode.inClass;

    foreach (fnWriter; funcWriters)
    {
      writer ~= "";
      fnWriter.write(writer);
    }

    writer ~= "}";

    writer.write();
  }

  // Construct struct wrapper property methods
  private dstring[] constructPropMethods(ImportSymbols imports)
  {
    dstring[] lines;

    foreach(f; fields)
    {
      if (f.disable)
        continue;

      auto fieldKind = repo.defs.typeKind(f.subDType, repo);

      lines ~= ["", "@property " ~ f.subDType ~ " " ~ f.dName ~ "()", "{"];

      final switch(fieldKind) with(TypeKind)
      {
        case Basic:
          lines ~= "return cPtr." ~ f.dName ~ ";";
          break;
        case String:
          lines ~= "return cPtr." ~ f.dName ~ ".fromCString(false);";
          break;
        case Enum, Flags:
          lines ~= "return cast(" ~ f.subDType ~ ")cPtr." ~ f.dName ~ ";";
          imports.add("global");
          break;
        case Simple:
          lines ~= "return *cPtr." ~ f.dName ~ ";";
          imports.add(f.subDType);
          break;
        case Boxed:
        case Wrap:
          lines ~= "return new " ~ f.subDType ~ "(cPtr." ~ f.dName ~ ");";
          imports.add(f.subDType);
          break;
        case Object:
          lines ~= "return ObjectG.getDObject!" ~ f.subDType ~ "(cPtr." ~ f.dName ~ ", false);";
          imports.add(f.subDType);
          break;
        case Unknown, Opaque, Interface, Namespace:
          throw new Exception("Unhandled field property type '" ~ f.subDType.to!string ~ "' (" ~ fieldKind.to!string
            ~ ") for struct " ~ subName.to!string);
      }

      lines ~= "}";

      if (!f.writable)
        continue;

      lines ~= ["", "@property void " ~ f.dName ~ "(" ~ f.subDType ~ " propval)", "{"];

      final switch(fieldKind) with(TypeKind)
      {
        case Basic:
          lines ~= "cPtr." ~ f.dName ~ " = propval;";
          break;
        case String:
          lines ~= "cPtr." ~ f.dName ~ " = toCString(true);";
          break;
        case Enum, Flags:
          lines ~= "cPtr." ~ f.dName ~ " = cast(" ~ f.subCType ~ ")propval;";
          break;
        case Simple:
          lines ~= "cPtr." ~ f.dName ~ " = *propval;";
          break;
        case Boxed:
        case Wrap:
          lines ~= "cPtr." ~ f.dName ~ " = propval.cPtr;";
          break;
        case Object:
          lines ~= "cPtr." ~ f.dName ~ " = propval.get" ~ f.subDType ~ ";";
          break;
        case Unknown, Opaque, Interface, Namespace:
          throw new Exception("Unhandled field property type '" ~ f.subDType.to!string ~ "' (" ~ fieldKind.to!string
            ~ ") for struct " ~ subName.to!string);
      }

      lines ~= "}";
    }

    return lines;
  }

  dstring name; /// Name of structure
  StructType structType; /// Type of structure
  dstring cType; /// C type name
  dstring cSymbolPrefix; /// C symbol prefix
  dstring parent; /// Parent structure

  dstring[] implements; /// Interfaces implemented by structure
  dstring[] prerequisites; /// Interface prerequisite types
  Func[] functions; /// Constructors, functions, methods, virtual methods, and signals
  Field[] fields; /// Structure fields
  Property[] properties; /// Properties

  DefCode defCode; /// Code from definitions file

  bool abstract_; /// Is abstract type?
  bool deprecated_; /// Deprecated?
  bool disguised; /// Disguised (FIXME)
  bool opaque; /// Opaque structure type
  dstring version_; /// Version
  dstring deprecatedVersion; /// Deprecated version

  bool glibFundamental;
  dstring glibGetType; /// GLib get_type function
  dstring glibTypeName; /// GLib type name
  dstring glibGetValueFunc; /// GLib get value function
  dstring glibSetValueFunc; /// GLib set value function
  dstring glibRefFunc; /// GLib ref function
  dstring glibUnrefFunc; /// GLib unref function
  dstring glibTypeStruct; /// GLib class structure
  dstring glibIsGtypeStructFor; /// Indicates what type a class structure belongs to
}

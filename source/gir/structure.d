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

/// Structure class which is used for class, interface, and records in Gir files
final class Structure : Base
{
  this(Base parent)
  {
    super(parent);
    defCode = new DefCode;
  }

  this(Base parent, XmlNode node)
  {
    this(parent);
    fromXml(node);
  }

  override @property dstring name()
  {
    return _name;
  }

  override @property void name(dstring val)
  {
    _name = val;
  }

  @property dstring subName()
  {
    return repo.defs.subTypeStr(_name, repo.typeSubs);
  }

  @property dstring subCType()
  {
    return repo.defs.subTypeStr(cType, repo.typeSubs);
  }

  @property TypeKind kind()
  {
    if (cType.empty)
      return TypeKind.Namespace;

    if (structType == StructType.Record && !glibGetType.empty)
      return TypeKind.Boxed;

    if (structType == StructType.Record && opaque && functions.empty)
      return TypeKind.Opaque;

    if (structType == StructType.Record || structType == StructType.Union)
    {
      if (!functions.empty)
        return TypeKind.Wrap;

      foreach (field; fields)
        if (!field.kind.among(TypeKind.Basic, TypeKind.Enum, TypeKind.Flags))
          return TypeKind.Wrap;

      return TypeKind.Simple;
    }

    if (structType == StructType.Class && glibFundamental && !glibRefFunc.empty && !glibUnrefFunc.empty)
      return TypeKind.Reffed;

    if (structType == StructType.Class && !parent.empty && !glibGetType.empty)
      return TypeKind.Object;

    if (structType == StructType.Interface)
      return TypeKind.Interface;

    return TypeKind.Unknown;
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    _name = node.get("name");
    structType = cast(StructType)StructTypeValues.countUntil(node.id);
    cType = node.get("c:type");
    cSymbolPrefix = node.get("c:symbol-prefix");
    parent = node.get("parent");
    version_ = node.get("version");

    abstract_ = node.get("abstract") == "1";
    deprecated_ = node.get("deprecated") == "1";
    opaque = node.get("opaque") == "1";
    glibFundamental = node.get("glib:fundamental") == "1";

    deprecatedVersion = node.get("deprecated-version");
    glibGetType = node.get("glib:get-type");
    glibTypeName = node.get("glib:type-name");
    glibGetValueFunc = node.get("glib:get-value-func");
    glibSetValueFunc = node.get("glib:set-value-func");
    glibRefFunc = node.get("glib:ref-func");
    glibUnrefFunc = node.get("glib:unref-func");
    glibTypeStruct = node.get("glib:type-struct");
    glibIsGtypeStructFor = node.get("glib:is-gtype-struct-for");
    copyFunction = node.get("copy-function");
    freeFunction = node.get("free-function");
  }

  /**
   * Write structure module.
   * Params:
   *   path = Path to the file to write to
   */
  void write(string path)
  {
    auto moduleName = repo.namespace ~ "." ~ subName;
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

    if (kindVal == TypeKind.Boxed)
      parentType = "GLib.Boxed";
    else if (!parent.empty)
    {
      if (parent.canFind('.'))
        parentType = parent;
      else
        parentType = repo.namespace ~ "." ~ parent;
    }

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
    {
      auto p = parentType.split('.');
      writer ~= "class " ~ subName ~ " : " ~ (p[0] == repo.namespace ? p[1] : parentType);
    }
    else
      writer ~= "class " ~ subName;

    if (kindVal == TypeKind.Wrap) // Wrap a structure in a class with properties
    {
      writer ~= ["{", subCType ~ "* wrapPtr;", ""];
      writer ~= ["this(" ~ subCType ~ "* wrapPtr)", "{",
        "if (!wrapPtr)", "throw new GidConstructException(\"Null struct pointer for " ~ fullName ~ "\");", "",
        "this.wrapPtr = wrapPtr;", "}"];

      if (freeFunction)
        writer ~= ["", "~this()", "{", freeFunction ~ "(wrapPtr);", "}"];

      writer ~= propMethods;
    }
    else if (kindVal == TypeKind.Boxed)
    {
      writer ~= ["{", "this(" ~ subCType ~ "* wrapPtr, bool ownedRef = false)", "{",
        "super(cast(void*)wrapPtr, ownedRef);", "}", ""];
      writer ~= ["auto cPtr()", "{", "return cast(" ~ subCType ~ "*)boxPtr;", "}", ""];
      writer ~= ["override GType getType()", "{", "return " ~ glibGetType ~ "();", "}"];
    }
    else if (kindVal == TypeKind.Reffed)
    {
      writer ~= "{";

      if (!parentType) // Root fundamental reffed type?
        writer ~= ["void* wrapPtr;", ""];

      if (!abstract_)
      {
        writer ~= ["this(" ~ subCType ~ "* wrapPtr, bool ownedRef)", "{", "this.wrapPtr = cast(void*)wrapPtr;", "",
          "if (!ownedRef)", glibRefFunc ~ "(wrapPtr);", "}", ""];
        writer ~= ["~this()", "{", glibUnrefFunc ~ "(wrapPtr);", "}", ""];
      }
    }
    else if (kindVal == TypeKind.Object)
    {
      writer ~= ["{", "this(" ~ subCType ~ "* wrapPtr, bool owned)", "{", "super(wrapPtr, owned);", "}", ""];
      writer ~= ["auto cPtr()", "{", "return cast(" ~ subCType ~ "*)ptr;", "}", ""];
      writer ~= ["override GType getType()", "{", "return " ~ glibGetType ~ "();", "}"];
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

      auto fieldKind = f.kind;

      lines ~= ["", "@property " ~ f.subDType ~ " " ~ f.dName ~ "()", "{"];

      final switch(fieldKind) with(TypeKind)
      {
        case Basic:
          lines ~= "return wrapPtr." ~ f.dName ~ ";";
          break;
        case String:
          lines ~= "return wrapPtr." ~ f.dName ~ ".fromCString(false);";
          break;
        case Enum, Flags:
          lines ~= "return cast(" ~ f.subDType ~ ")wrapPtr." ~ f.dName ~ ";";
          imports.add("global");
          break;
        case Simple:
          lines ~= "return *wrapPtr." ~ f.dName ~ ";";
          imports.add(f.subDType);
          break;
        case Boxed:
        case Wrap:
        case Reffed:
          lines ~= "return new " ~ f.subDType ~ "(wrapPtr." ~ f.dName ~ ");";
          imports.add(f.subDType);
          break;
        case Object:
          lines ~= "return ObjectG.getDObject!" ~ f.subDType ~ "(wrapPtr." ~ f.dName ~ ", false);";
          imports.add(f.subDType);
          break;
        case Unknown, Opaque, Interface, Namespace:
          throw new Exception("Unhandled readable field property type '" ~ f.subDType.to!string ~ "' (" ~ fieldKind.to!string
            ~ ") for struct " ~ subName.to!string);
      }

      lines ~= "}";

      if (!f.writable)
        continue;

      lines ~= ["", "@property void " ~ f.dName ~ "(" ~ f.subDType ~ " propval)", "{"];

      final switch(fieldKind) with(TypeKind)
      {
        case Basic:
          lines ~= "wrapPtr." ~ f.dName ~ " = propval;";
          break;
        case String:
          lines ~= ["g_free(wrapPtr." ~ f.dName ~ ");", "wrapPtr." ~ f.dName ~ " = propval.toCString(true);"];
          break;
        case Enum, Flags:
          lines ~= "wrapPtr." ~ f.dName ~ " = cast(" ~ f.subCType ~ ")propval;";
          break;
        case Simple:
          lines ~= "wrapPtr." ~ f.dName ~ " = *propval;";
          break;
        case Object:
          lines ~= "wrapPtr." ~ f.dName ~ " = propval.get" ~ f.subDType ~ ";";
          break;
        case Boxed, Wrap, Reffed, Unknown, Opaque, Interface, Namespace:
          throw new Exception("Unhandled writable field property type '" ~ f.subDType.to!string ~ "' (" ~ fieldKind.to!string
            ~ ") for struct " ~ subName.to!string);
      }

      lines ~= "}";
    }

    return lines;
  }

  private dstring _name; /// Name of structure
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
  dstring copyFunction; /// Record/Union copy function (not seen in the wild, but defined in gir-1.2.rnc - we use it via XML patching)
  dstring freeFunction; /// Record/Union free function (not seen in the wild, but defined in gir-1.2.rnc - we use it via XML patching)
}

/// Type of structure
enum StructType
{
  Class, /// A class
  Interface, /// An interface
  Record, /// A structure record
  Union, /// A union
}

immutable dstring[] StructTypeValues = [ "class", "interface", "record", "union" ];

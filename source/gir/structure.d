module gir.structure;

import code_writer;
import gir.base;
import gir.field;
import gir.func;
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
  this(Repo repo, XmlNode node)
  {
    this.repo = repo;
    fromXml(node);
  }

  @property dstring subName()
  {
    return name; // FIXME - Need to substitute D symbol names
  }

  @property dstring subCType()
  {
    return repo.defs.subTypeStr(cType);
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
   * Returns true if this structure is implemented as a D class.
   * Returns: true if struct is a D class (GBoxed and GObject types)
   */
  bool isDClass()
  {
    return structType == StructType.Class || !glibGetType.empty;
  }

  /**
   * Check if structure is a boxed type.
   * Returns: true if structure is a boxed type
   */
  bool isBoxed()
  {
    return structType == StructType.Record && !glibGetType.empty;
  }

  /**
   * Check if structure is a GObject type.
   * Returns: true if structure is a boxed type
   */
  bool isGObject()
  {
    return structType == StructType.Class && !parent.empty && !glibGetType.empty;
  }

  /**
   * Write "class" to a file path. This includes GObject and Boxed types.
   * Params:
   *   path = Path to the file to write to
   */
  void writeBoxed(string path)
  {
    auto writer = new CodeWriter(path);

    writer ~= ["module " ~ repo.namespace ~ "." ~ name ~ ";", ""];
    writeDocs(writer);

    writer ~= `\
class ` ~ subName ~ ` : Boxed
{
  this(` ~ subCType ~ `* wrapPtr)
  {
    super(wrapPtr);
  }

  override GType getType()
  {
    return ` ~ glibGetType ~ `();
  }
`;

    foreach (f; functions)
      f.writeFunction(writer);
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

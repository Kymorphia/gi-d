module gir.structure;

import std.conv : to;

import gir.base;
import gir.field;
import gir.func;
import gir.property;
import gir.type_node;

/// Type of structure
enum StructType : dstring
{
  Class = "class", /// A class
  Interface = "interface", /// An interface
  Record = "record", /// A structure record
}

/// Structure class which is used for class, interface, and records in Gir files
final class Structure : Base
{
  this()
  {
  }

  this(XmlNode node)
  {
    fromXml(node);
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    name = node.get("name");
    structType = cast(StructType)node.name;
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

module gir.structure;

import gir.func;
import gir.type;

/// Type of structure
enum StructureType : dstring
{
  Class = "class", /// A class
  Interface = "interface", /// An interface
  Record = "record", /// A structure record
}

/// Structure class which is used for class, interface, and records in Gir files
class Structure
{
  dstring name; /// Name of structure
  StructureType structureType; /// Type of structure
  dstring cType; /// C type name
  dstring cSymbolPrefix; /// C symbol prefix
  dstring parent; /// Parent structure

  dstring implements; /// Interfaces implemented by structure
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

  dstring sourceFilename; /// Source filename
  uint sourceLine; /// Source line

  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line

  dstring xmlns;
  dstring xmlnsC;
  dstring xmlnsGlib;
}

/// Field in a structure
class Field
{
  dstring name; /// Field name
  Type type; /// Field type (array element type if array.isArray)
  ArrayInfo array; /// Array info for array field types
  bool private_; /// Private field?
  bool readable; /// Readable field?
}

/// Class property
class Property
{
  dstring name; /// Name of property
  Type type; /// Property type
  ArrayInfo array; /// Array info for array properties
  dstring defaultValue; /// Default value
  Ownership ownership; /// Ownership transfer
  bool readable; /// Property is readable
  bool writable; /// Property is writable
  bool construct; /// Construct property?
  bool constructOnly; /// Construct only property?
  bool deprecated_; /// Deprecated?
  bool introspectable; /// Introspectable?
  dstring version_; /// Version
  dstring deprecatedVersion; /// Deprecated version

  dstring cPropertyGet; /// C get property function
  dstring cPropertySet; /// C set property function
  dstring getter; /// Getter method
  dstring setter; /// Setter method

  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line
}

module gir.enum_;

import gir.func;

/// Enumeration or bitfield flags
class Enum
{
  bool bitfield; /// true if flags bitfield, false for enum
  dstring name; /// Name of enum/flags
  dstring cType; /// C type name
  dstring glibGetType; /// GLib get_type function name
  dstring glibTypeName; /// GLib type name
  dstring glibErrorDomain; /// GLib error domain
  dstring version_; /// Version

  EnumMember[] members; /// Enum/flags members
  Func[] functions; /// Functions

  dstring sourceFilename; /// Source filename
  uint sourceLine; /// Source line
  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line
}

/// Member value for enumeration or bitfield flags
class EnumMember
{
  dstring name;
  dstring cIdentifier;
  uint value;
  dstring glibName;
  dstring glibNick;

  dstring docFilename;
  uint docLine;
}

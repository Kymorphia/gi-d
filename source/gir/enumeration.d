module gir.enumeration;

import gir.base;
import gir.func;
import gir.member;

/// Enumeration or bitfield flags
final class Enumeration : Base
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

    bitfield = node.name == "bitfield";
    name = node.get("name");
    cName = node.get("c:type");

    glibGetType = node.get("glib:get-type");
    glibTypeName = node.get("glib:type-name");
    glibErrorDomain = node.get("glib:error-domain");
    version_ = node.get("version");
  }

  bool bitfield; /// true if flags bitfield, false for enum
  dstring name; /// Name of enum/flags
  dstring cName; /// C type name (Gir c:type)
  dstring glibGetType; /// GLib get_type function name
  dstring glibTypeName; /// GLib type name
  dstring glibErrorDomain; /// GLib error domain
  dstring version_; /// Version

  Member[] members; /// Enum/flags members
  Func[] functions; /// Functions
}

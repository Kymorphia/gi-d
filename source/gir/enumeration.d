module gir.enumeration;

import gir.base;
import gir.func;
import gir.member;
import gir.type_node;
import utils;

/// Enumeration or bitfield flags
final class Enumeration : TypeNode
{
  this(Base parent, XmlNode node)
  {
    super(parent);
    fromXml(node);
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    bitfield = node.id == "bitfield";

    glibGetType = node.get("glib:get-type");
    glibTypeName = node.get("glib:type-name");
    glibErrorDomain = node.get("glib:error-domain");
    version_ = node.get("version");
  }

  override void fixup()
  {
    kind = bitfield ? TypeKind.Flags : TypeKind.Enum;
    super.fixup;
  }

  bool bitfield; /// true if flags bitfield, false for enum
  dstring glibGetType; /// GLib get_type function name
  dstring glibTypeName; /// GLib type name
  dstring glibErrorDomain; /// GLib error domain
  dstring version_; /// Version

  Member[] members; /// Enum/flags members
  Func[] functions; /// Functions
}

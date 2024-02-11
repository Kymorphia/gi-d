module gir.enumeration;

import gir.base;
import gir.func;
import gir.member;

/// Enumeration or bitfield flags
final class Enumeration : Base
{
  this(Base parent, XmlNode node)
  {
    super(parent);
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

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    bitfield = node.id == "bitfield";
    _name = node.get("name");
    cName = node.get("c:type");

    glibGetType = node.get("glib:get-type");
    glibTypeName = node.get("glib:type-name");
    glibErrorDomain = node.get("glib:error-domain");
    version_ = node.get("version");
  }

  bool bitfield; /// true if flags bitfield, false for enum
  private dstring _name; /// Name of enum/flags
  dstring cName; /// C type name (Gir c:type)
  dstring glibGetType; /// GLib get_type function name
  dstring glibTypeName; /// GLib type name
  dstring glibErrorDomain; /// GLib error domain
  dstring version_; /// Version

  Member[] members; /// Enum/flags members
  Func[] functions; /// Functions
}

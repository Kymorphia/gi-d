module gir.enumeration;

import gir.base;
import gir.func;
import gir.member;
import gir.type_node;
import utils;

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
    origName = node.get("name");
    _name = repo.defs.subTypeStr(origName, repo.defs.dTypeSubs, repo.dTypeSubs);

    if (_name == origName)
      _name = _name.normalizeDTypeName();

    cName = node.get("c:type");
    glibGetType = node.get("glib:get-type");
    glibTypeName = node.get("glib:type-name");
    glibErrorDomain = node.get("glib:error-domain");
    version_ = node.get("version");
  }

  bool bitfield; /// true if flags bitfield, false for enum
  private dstring _name; /// Name of enum/flags
  dstring origName; /// Original alias name
  dstring cName; /// C type name (Gir c:type)
  dstring glibGetType; /// GLib get_type function name
  dstring glibTypeName; /// GLib type name
  dstring glibErrorDomain; /// GLib error domain
  dstring version_; /// Version

  Member[] members; /// Enum/flags members
  Func[] functions; /// Functions
}

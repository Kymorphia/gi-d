module gir.member;

import gir.type_node;

/// Member value for Enumeration
final class Member : TypeNode
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

    _name = node.get("name");
    cName = node.get("c:identifier");
    value = node.get("value");
    glibName = node.get("glib:name");
    glibNick = node.get("glib:nick");
  }

  private dstring _name; /// Name of the enumeration or bitfield member
  dstring cName; /// C name (Gir "c:identifier")
  dstring value; /// The value
  dstring glibName; /// GLib enum/flags name
  dstring glibNick; /// GLib enum/flags nick name
}

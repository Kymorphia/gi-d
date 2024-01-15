module gir.member;

import gir.type_node;

/// Member value for Enumeration
final class Member : TypeNode
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
    cName = node.get("c:identifier");
    value = node.get("value");
    glibName = node.get("glib:name");
    glibNick = node.get("glib:nick");
  }

  dstring name; /// Name of the enumeration or bitfield member
  dstring cName; /// C name (Gir "c:identifier")
  dstring value; /// The value
  dstring glibName; /// GLib enum/flags name
  dstring glibNick; /// GLib enum/flags nick name
}

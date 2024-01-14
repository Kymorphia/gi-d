module gir.field;

import gir.type_node;

/// Field in a structure
final class Field : TypeNode
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
    private_ = node.get("private") == "1";
    readable = node.get("readable") == "1";
  }

  dstring name; /// Field name
  bool private_; /// Private field?
  bool readable; /// Readable field?
}

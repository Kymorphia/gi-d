module gir.constant;

import gir.type_node;

final class Constant : TypeNode
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
    value = node.get("value");
  }

  dstring name; /// Name of constant
  dstring value; /// Value of constant
}

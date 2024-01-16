module gir.constant;

import gir.type_node;

final class Constant : TypeNode
{
  this(Repo repo, XmlNode node)
  {
    this.repo = repo;
    fromXml(node);
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);
    name = node.get("name");
    cName = node.get("c:type");
    value = node.get("value");
  }

  dstring name; /// Name of constant
  dstring cName; /// C name of constant
  dstring value; /// Value of constant
}

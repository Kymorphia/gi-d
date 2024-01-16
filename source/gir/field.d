module gir.field;

import gir.func;
import gir.type_node;

/// Field in a structure
final class Field : TypeNode
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
    private_ = node.get("private") == "1";
    readable = node.get("readable") == "1";
  }

  dstring name; /// Field name
  Func callback; /// For callback fields
  bool private_; /// Private field?
  bool readable; /// Readable field?
}

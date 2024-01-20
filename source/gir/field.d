module gir.field;

import gir.func;
import gir.structure;
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
    readable = node.get("readable", "1") == "1";
    writable = node.get("writable", "0") == "1";
    introspectable = node.get("introspectable", "1") == "1";
    private_ = node.get("private") == "1";
  }

  dstring name; /// Field name
  Func callback; /// For callback fields
  bool readable; /// Readable field?
  bool writable; /// Writable field?
  bool introspectable = true; /// Is field introspectable?
  bool private_; /// Private field?
}

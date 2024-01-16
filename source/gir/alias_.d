module gir.alias_;

import gir.type_node;

/**
 * Gir type alias object.
 * The TypeNode parent stores the aliased type.
 */
final class Alias : TypeNode
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
  }

  dstring name; /// D type name for the alias (Gir "name" attribute)
  dstring cName; /// C type name for the alias (Gir "c:type" attribute)
}

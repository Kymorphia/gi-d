module gir.alias_;

import gir.type_node;

/**
 * Gir type alias object.
 * The TypeNode parent stores the aliased type.
 */
final class Alias : TypeNode
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
    cName = node.get("c:type");
  }

  dstring name; /// D type name for the alias (Gir "name" attribute)
  dstring cName; /// C type name for the alias (Gir "c:type" attribute)
}

module gir.alias_;

import gir.type_node;

/**
 * Gir type alias object.
 * The TypeNode parent stores the aliased type.
 */
final class Alias : TypeNode
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
    cName = node.get("c:type");
  }

  private dstring _name; /// D type name for the alias (Gir "name" attribute)
  dstring cName; /// C type name for the alias (Gir "c:type" attribute)
}

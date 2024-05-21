module gir.return_value;

import gir.type_node;
import std_includes;

/// Function return value
final class ReturnValue : TypeNode
{
  this(Base parent, XmlNode node)
  {
    super(parent);
    fromXml(node);
  }

  override @property dstring name()
  {
    return "[RETURN]";
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    ownership = cast(Ownership)OwnershipValues.countUntil(node.get("transfer-ownership"));
    nullable = node.get("nullable") == "1";
  }

  bool nullable; /// Pointer can be null
}

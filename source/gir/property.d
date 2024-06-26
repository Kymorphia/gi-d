module gir.property;

import gir.param;
import gir.type_node;
import std_includes;

/// Class property
final class Property : TypeNode
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
    defaultValue = node.get("default-value");
    ownership = cast(Ownership)OwnershipValues.countUntil(node.get("ownership-transfer"));
    readable = node.get("readable") == "1";
    writable = node.get("writable") == "1";
    construct = node.get("construct") == "1";
    constructOnly = node.get("construct-only") == "1";
    deprecated_ = node.get("deprecated") == "1";
    introspectable = node.get("introspectable") == "1";

    version_ = node.get("version");
    deprecatedVersion = node.get("deprecated-version");

    cPropertyGet = node.get("c:property-get");
    cPropertySet = node.get("c:property-set");
    getter = node.get("getter");
    setter = node.get("setter");
  }

  private dstring _name; /// Name of property
  dstring defaultValue; /// Default value
  bool readable; /// Property is readable
  bool writable; /// Property is writable
  bool construct; /// Construct property?
  bool constructOnly; /// Construct only property?
  bool deprecated_; /// Deprecated?
  bool introspectable; /// Introspectable?
  dstring version_; /// Version
  dstring deprecatedVersion; /// Deprecated version

  dstring cPropertyGet; /// C get property function
  dstring cPropertySet; /// C set property function
  dstring getter; /// Getter method
  dstring setter; /// Setter method
}

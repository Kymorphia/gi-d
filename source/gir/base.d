module gir.base;

public import xml_tree;

private static Base[XmlNode] xmlNodeBaseHash;

abstract class Base
{
  @property XmlNode node()
  {
    return _node;
  }

  @property void node(XmlNode node)
  {
    _node = node;
    xmlNodeBaseHash[node] = this;
  }

  void fromXml(XmlNode node)
  {
    this.node = node;
  }

  private XmlNode _node; /// The XML node object was created from

  dstring[dstring] attributes; /// Gir key/value attributes
  dstring doc; /// Documentation content
  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line number
  dstring sourceFilename; /// Source code filename
  uint sourceLine; /// Source code line number
  dstring docDeprecated; /// Deprecated note documentation
}

/**
  * Template to get an XmlNode parent object of a given type and warn if not found.
  * Params:
  *   T = The expected type of object
  *   node = The XML node
  * Returns: The parent object of the given type or null
  */
T baseParentFromXmlNodeWarn(T)(XmlNode node)
{
  if (auto parent = node.parent)
  {
    if (auto obj = xmlNodeBaseHash.get(parent, null))
    {
      if (auto castObj = cast(T)obj)
        return castObj;

      node.warn(
          "Expected parent node object type '" ~ T.stringof
          ~ "' found '" ~ obj.stringof ~ "'");
    }
    else
      node.warn("No object found for node parent");
  }
  else
    node.warn("Expected node to have a parent");

  return null;
}

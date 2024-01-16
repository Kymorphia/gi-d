module gir.base;

import std.algorithm : map;
import std.string : splitLines, strip;

import code_writer;
public import gir.repo;
public import xml_tree;

private static Base[XmlNode] xmlNodeBaseHash;

abstract class Base
{
  this()
  {
  }

  this(Repo repo)
  {
    this.repo = repo;
  }

  @property XmlNode xmlNode()
  {
    return _node;
  }

  @property void xmlNode(XmlNode node)
  {
    _node = node;
    xmlNodeBaseHash[node] = this;
  }

  void fromXml(XmlNode node)
  {
    this.xmlNode = node;
  }

  void writeDocs(CodeWriter writer)
  {
    if (docContent.length == 0)
      return;

    writer ~= "/**";

    foreach (l; docContent.strip.splitLines.map!(x => x.strip))
      writer ~= "* " ~ l;

    writer ~= "*/";
  }

  private XmlNode _node; /// The XML node object was created from

  Repo repo; /// Parent repo
  dstring[dstring] attributes; /// Gir key/value attributes
  dstring docContent; /// Documentation content
  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line number
  dstring docVersion; /// FIXME - What is this for?
  dstring sourceFilename; /// Source code filename
  uint sourceLine; /// Source code line number
  dstring docDeprecated; /// Deprecated note documentation
}

/**
  * Template to get an XmlNode parent object of a given type.
  * Params:
  *   T = The expected type of object
  *   node = The XML node
  * Returns: The parent object of the given type or null
  */
T baseParentFromXmlNode(T)(XmlNode node)
{
  if (auto parent = node.parent)
    if (auto obj = xmlNodeBaseHash.get(parent, null))
      return cast(T)obj;

  return null;
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

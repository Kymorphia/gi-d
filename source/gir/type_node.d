module gir.type_node;

import std.conv : to;

public import gir.base;

/// Type information class
/// Combines multiple Gir information (type, array, ownership, etc)
abstract class TypeNode : Base
{
  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    if (auto typ = node.findChild("type"))
    {
      dType = typ.get("name");
      cType = typ.get("c:type");
    }

    if (auto arr = node.findChild("array"))
    {
      isArray = true;
      arrayCType = arr.get("c:type");
      zeroTerminated = arr.get("zero-terminated", "0") == "1";

      if (auto pFixedSize = "fixed-size" in arr.attrs)
        fixedSize = (*pFixedSize).to!int;
      else
        fixedSize = NotFixedSize;

      if (auto pLength = "length" in arr.attrs)
        lengthParamIndex = (*pLength).to!int;
      else
        lengthParamIndex = NoLengthParam;

      if (auto typ = arr.findChild("type")) // Use array element type for type info
      {
        dType = typ.get("name");
        cType = typ.get("c:type");
      }
    }
    else
      isArray = false;
  }

  dstring dType; /// D type (element type for arrays, Gir "name")
  dstring cType; /// C type (element type for arrays)

  bool isArray; /// true if this type is an array
  dstring arrayCType; /// Array C type (if isArray is true)
  bool zeroTerminated; /// true if array is zero terminated
  int fixedSize = NotFixedSize; /// Non-zero if array is a fixed size
  int lengthParamIndex = NoLengthParam; /// >= 0 if a length parameter index is set
}

enum NotFixedSize = 0; /// Value for TypeNode.fixedSize which indicates size is not fixed
enum NoLengthParam = -1; /// Value used for TypeNode.lengthParamIndex which indicates no length parameter

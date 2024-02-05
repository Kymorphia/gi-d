module gir.type_node;

import defs;
public import gir.base;
import std_includes;
import utils;

/// Type information class
/// Combines multiple Gir information (type, array, ownership, etc)
class TypeNode : Base
{
  this(Base parent)
  {
    super(parent);
  }

  @property dstring subCType()
  {
    return repo.defs.subTypeStr(cType, repo.typeSubs);
  }

  @property dstring subArrayCType()
  {
    return repo.defs.subTypeStr(arrayCType, repo.typeSubs);
  }

  @property dstring subDType()
  {
    return repo.defs.subTypeStr(dType, repo.typeSubs);
  }

  @property TypeKind kind()
  {
    return repo.defs.typeKind(subDType, repo);
  }

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
        fixedSize = ArrayNotFixed;

      if (auto pLength = "length" in arr.attrs)
        lengthParamIndex = (*pLength).to!int;
      else
        lengthParamIndex = ArrayNoLengthParam;

      if (auto typ = arr.findChild("type")) // Use array element type for type info
      {
        dType = typ.get("name");
        cType = typ.get("c:type");
      }
    }
    else
      isArray = false;
  }

  /// Check if type is a string type
  bool isString()
  {
    return dType == "utf8"; // FIXME - Other types
  }

  dstring dType; /// D type (element type for arrays, Gir "name")
  dstring cType; /// C type (element type for arrays)

  bool isArray; /// true if this type is an array
  dstring arrayCType; /// Array C type (if isArray is true)
  bool zeroTerminated; /// true if array is zero terminated
  int fixedSize = ArrayNotFixed; /// Non-zero if array is a fixed size
  int lengthParamIndex = ArrayNoLengthParam; /// >= 0 if a length parameter index is set
}

enum ArrayNotFixed = 0; /// Value for TypeNode.fixedSize which indicates size is not fixed
enum ArrayNoLengthParam = -1; /// Value used for TypeNode.lengthParamIndex which indicates no length parameter

module gir.type_node;

import defs;
public import gir.base;
import gir.field;
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

  dstring fullDType()
  {
    return typeRepo.namespace ~ "." ~ dType;
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

  void fixup()
  {
    auto t = dType.split('.');
    if (t.length > 1)
    {
      try
        typeRepo = repo.defs.repoHash[t[0]];
      catch (RangeError)
        throw new Exception("Repo '" ~ t[0].to!string ~ "' not found for type '" ~ dType.to!string ~ "'");
    }
    else
      typeRepo = repo;

    subDType = repo.defs.subTypeStr(dType, typeRepo.typeSubs);
    subCType = repo.defs.subTypeStr(cType, typeRepo.typeSubs);
    subArrayCType = repo.defs.subTypeStr(arrayCType, typeRepo.typeSubs);
    kind = repo.defs.typeKind(subDType, typeRepo);

    if (auto field = cast(Field)this)
      if (field.callback)
        return; // Skip further type checking if this is a callback field

    if (isArray && lengthParamIndex == ArrayNoLengthParam
        && fixedSize == ArrayNotFixed && !zeroTerminated)
      throw new Exception("array has indeterminate length");

    if (kind.among(TypeKind.Unknown, TypeKind.Interface, TypeKind.Namespace))
      throw new Exception("unhandled type kind '" ~ kind.to!string ~ "' for type '"
        ~ subDType.to!string ~ "'");

    if (subCType.empty) // No C type?
    {
      if (isArray)
      { // Attempt to derive member C type from array C type (strip last pointer)
        cType = repo.defs.getArrayMemberCType(subArrayCType);

        if (!cType)
          throw new Exception("could not determine member type for array type '" ~ subArrayCType.to!string ~ "'");

        subCType = repo.defs.subTypeStr(cType, typeRepo.typeSubs);

        stderr.writeln("Using member C type '" ~ subCType.to!string ~ "' for D type '"
          ~ subDType.to!string ~ "' for an array with C type '" ~ subArrayCType.to!string ~ "' in "
          ~ fullName.to!string);
      }
      else
        stderr.writeln("No c:type for D type '" ~ subDType.to!string ~ "' in '"
          ~ fullName.to!string ~ "'");
    }

    if (isArray && subArrayCType.empty)
      stderr.writeln("No array c:type for array of D type '" ~ subDType.to!string ~ "' in '"
        ~ fullName.to!string ~ "'");
  }

  dstring dType; /// D type (element type for arrays, Gir "name")
  dstring cType; /// C type (element type for arrays)

  Repo typeRepo; /// Repo containing the dType (can be this.repo)
  dstring subDType; /// Substituted D type
  dstring subCType; /// Substituted C type
  dstring subArrayCType; /// Substituted array C type
  TypeKind kind; /// Type kind

  bool isArray; /// true if this type is an array
  dstring arrayCType; /// Array C type (if isArray is true)
  bool zeroTerminated; /// true if array is zero terminated
  int fixedSize = ArrayNotFixed; /// Non-zero if array is a fixed size
  int lengthParamIndex = ArrayNoLengthParam; /// >= 0 if a length parameter index is set
}

enum ArrayNotFixed = 0; /// Value for TypeNode.fixedSize which indicates size is not fixed
enum ArrayNoLengthParam = -1; /// Value used for TypeNode.lengthParamIndex which indicates no length parameter

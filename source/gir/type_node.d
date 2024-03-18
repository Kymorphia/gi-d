module gir.type_node;

import defs;
import gir.alias_;
public import gir.base;
import gir.field;
import gir.structure;
import import_symbols;
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

  this(Base parent, XmlNode node)
  {
    super(parent);
    this.fromXml(node);
  }

  /// Full name of the D type with the namespace followed by a period and then the D type
  dstring fullDType()
  {
    if (typeRepo && !dType.empty)
      return typeRepo.namespace ~ "." ~ dType;

    return origDType.canFind('.') ? origDType : repo.namespace ~ "." ~ origDType;
  }

  /// cPtr with a single '*' removed (if it has any)
  dstring cTypeRemPtr()
  {
    if (!cType.endsWith("*"))
      return cType;

    if (cType.length > 3 && cType[$ - 3 .. $ - 1] == "*)") // Move * out of const(TYPE*) parenthesis if it is the last one
      return cType[0 .. $ - 3] ~ ")*";

    return cType[0 .. $ - 1];
  }

  /// Returns "true" if ownership is Full, "false" otherwise (help function)
  dstring fullOwnerStr()
  {
    return ownership == Ownership.Full ? "true"d : "false"d;
  }

  /// Get the full template container type. This type node must be a container type.
  dstring fullContainerType()
  {
    assert(!elemTypes.empty);

    if (dType == "ByteArray")
      return dType;

    if (dType == "HashTable")
      return elemTypes[1].dType ~ "[" ~ elemTypes[0].dType ~ "]";

    return dType ~ "!(" ~ elemTypes.map!(x => x.dType ~ ", " ~ x.cType).join(", ") ~ ")";
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    containerType = ContainerType.None;

    if (auto typ = node.findChild("type")) // Is there a child <type> node?
    {
      dType = origDType = typ.get("name");
      cType = origCType = typ.get("c:type");
    }
    else if (auto arr = node.findChild("array")) // Is there a child <array> node
    {
      dType = origDType = arr.get("name");
      cType = origCType = arr.get("c:type");

      if (dType.empty) // Regular memory type arrays don't have a D type, only array wrappers like GArray, GPtrArray, and GByteArray do, processed in fixup()
      {
        containerType = ContainerType.Array;
        zeroTerminated = arr.get("zero-terminated", "0") == "1";

        if (auto pFixedSize = "fixed-size" in arr.attrs)
          fixedSize = (*pFixedSize).to!int;
        else
          fixedSize = ArrayNotFixed;

        if (auto pLength = "length" in arr.attrs)
          lengthParamIndex = (*pLength).to!int;
        else
          lengthParamIndex = ArrayNoLengthParam;
      }
    }
    else // Is this a <type> node or other node with "name" and "c:type"? (Structure for example).
    {
      dType = origDType = node.get("name");
      cType = origCType = node.get("c:type");
    }
  }

  void fixup()
  {
    auto t = origDType.split('.');
    if (t.length > 1)
    {
      if (t[0]!in repo.defs.repoHash)
      {
        typeRepo = repo;
        warning("Repo '" ~ t[0].to!string ~ "' not found for type '" ~ origDType.to!string ~ "'");
      }
      else
        typeRepo = repo.defs.repoHash[t[0]];

      origDType = t[1];
    }
    else
      typeRepo = repo;

    dType = repo.defs.subTypeStr(origDType, typeRepo.typeSubs);
    cType = repo.defs.subTypeStr(origCType, typeRepo.typeSubs);
    kind = repo.defs.typeKind(dType, typeRepo);
    typeObject = typeRepo.typeObjectHash.get(dType, null);

    if (auto al = cast(Alias)typeObject)
      typeObject = typeRepo.typeObjectHash.get(al.dType, null);

    codeTrap("type.fixup", fullName);

    // HACK - gpointer is used in place of gconstpointer in Gir files, just use gconstpointer
    if (dType == "void*" && cType == "const(void)*")
      dType = "const(void)*";

    if (auto st = cast(Structure)typeObject) // Should only be set to a Structure for non-struct dependencies
    {
      if (cType == "void*" || cType == "const(void)*") // HACK? - Fix anonymous gpointer object parameters to have proper C types
      {
        cType = st.cType ~ "*";
        info(fullName ~ ": Using '" ~ cType ~ "' for anonymous pointer cType");
      }
      else if (cType.empty) // HACK? - Use structure cType if cType is missing
      {
        cType = st.cType ~ "*";
        info(fullName ~ ": Using '" ~ cType ~ "' for missing cType");
      }
    }

    if (cType.empty && kind == TypeKind.String)
    {
      cType = "char*";
      info(fullName ~ ": Using char* for missing cType");
    }

    foreach (typ; elemTypes)
      typ.fixup;

    if (containerType == ContainerType.Array)
    { // If there is a length parameter, dType is "ubyte", and array type uses char - treat it as a ubyte array
      if (lengthParamIndex != ArrayNoLengthParam && !elemTypes.empty && elemTypes[0].dType == "ubyte"
        && cType.stripConst.startsWith("char"))
      {
        info("Changing array cType from " ~ cType.to!string ~ " to ubyte for " ~ fullName.to!string);
        elemTypes[0].cType = "ubyte";
        cType = cType.replace("char", "ubyte");
      }
      else if (!elemTypes.empty && elemTypes[0].cType.empty) // Missing array element C type? Try and derive it from array C type
      {
        auto elemType = cType;
        auto isConst = cType.startsWith("const");

        if (isConst) // Strip const and () parenthesis from const(TYPE*)* expressions
          elemType = elemType[5 .. $].filter!(x => x != '(' && x != ')').array;

        auto count = elemType.countStars;

        if (count > 0)
        {
          elemType = elemType[0 .. $ - count]; // Strip the stars off

          if (isConst && count > 1)
            elemType = "const(" ~ elemType ~ "*"d.replicate(count - 2) ~ ")*";
          else
            elemType ~= "*"d.replicate(count - 1);

          if (elemType != "void")
            elemTypes[0].origCType = elemType;
        }

        if (elemTypes[0].origCType.empty && elemTypes[0].kind == TypeKind.Basic)
          elemTypes[0].origCType = elemTypes[0].dType; // Use D type if unable to derive C type from array C type, as long as D type is Basic

        if (elemTypes[0].origCType)
        {
          elemTypes[0].cType = repo.defs.subTypeStr(elemTypes[0].origCType, elemTypes[0].typeRepo.typeSubs);

          info("Using member C type '" ~ elemTypes[0].cType.to!string ~ "' for D type '"
            ~ elemTypes[0].dType.to!string ~ "' for an array with C type '" ~ cType.to!string ~ "' in "
            ~ fullName.to!string);
        }
      }
    }
    else if (ContainerTypeValues.canFind(fullDType) && !cast(Structure)this) // Not an array, check if it is another container type and not a structure (the type itself)
      containerType = cast(ContainerType)ContainerTypeValues.countUntil(fullDType);
  }

  void verify()
  {
    foreach (typ; elemTypes)
      if (typ.containerType != ContainerType.None)
        throw new Exception("Nested container types not yet supported");

    if (containerType == ContainerType.Array)
    {
      if (lengthParamIndex == ArrayNoLengthParam && fixedSize == ArrayNotFixed && !zeroTerminated)
        throw new Exception("Array has indeterminate length");

      if (elemTypes.empty)
        throw new Exception("Array type '" ~ cType.to!string ~ "' has no element type");

      if (elemTypes[0].cType.empty) // Missing array element C type?
        throw new Exception("Could not determine member type for array type '" ~ cType.to!string ~ "'");

      if (cType.empty && fixedSize == 0) // No array C type and not fixed size?
        warning("No array c:type for array of D type '" ~ dType.to!string ~ "' in '"
            ~ fullName.to!string ~ "'");

      if (elemTypes[0].dType == "string")
      {
        auto count = cType.countStars;
        if (count < 2)
          throw new Exception("Array type '" ~ cType.to!string ~ "' is probably a string, not an array of strings");
      }

      if (elemTypes[0].dType == "ubyte" && cType.canFind("char"))
        throw new Exception("Unsure if array is a null terminated string or not for array cType "
          ~ cType.to!string ~ " element cType " ~ elemTypes[0].cType.to!string ~ " dType "
          ~ elemTypes[0].dType.to!string);
    }
    else if (containerType != ContainerType.None) // Another container type?
    {
      auto reqElemTypes = containerTypeElemCount(containerType);

      if (elemTypes.length < reqElemTypes)
        throw new Exception(fullDType.to!string ~ " requires " ~ reqElemTypes.to!string ~ " container type(s), found "
            ~ elemTypes.length.to!string);

      if (elemTypes.length > reqElemTypes)
        warning(fullDType.to!string ~ " has excess container types");

      foreach (type; elemTypes)
        if (type.kind.among(TypeKind.Unknown, TypeKind.Namespace))
          throw new Exception(
              "unhandled container type kind '" ~ type.kind.to!string ~ "' for type '"
              ~ fullDType.to!string ~ "'");
    }

    if (containerType == ContainerType.None && kind != TypeKind.Namespace)
    {
      if (cType.empty && kind != TypeKind.Callback) // Has no C type and not a callback?
      {
        auto parentTypeNode = cast(TypeNode)parent;
        if (!parentTypeNode || parentTypeNode.containerType != ContainerType.Array) // Warn if not an array container type (handled separately)
          warning("No c:type for D type '" ~ dType.to!string ~ "' in '" ~ fullName.to!string ~ "'");
      }

      if (kind.among(TypeKind.Unknown, TypeKind.Namespace))
        throw new Exception("unhandled type kind '" ~ kind.to!string ~ "' for type '"
            ~ dType.to!string ~ "'");

      if (!elemTypes.empty)
        warning("Unexpected element type in unrecognized container '" ~ fullName.to!string ~ "'");
    }
  }

  /**
   * Add imports for a type node with respect to a repository.
   * Params:
   *   imports = Import symbols object
   *   curRepo = The current repository
   */
  void addImports(ImportSymbols imports, Repo curRepo)
  {
    imports.add(typeRepo.namespace ~ ".c.types");

    if (kind.typeKindHasModule)
    {
      if (!typeObject || !typeObject.disable)
        imports.add(fullDType);
    }
    else if (kind.typeKindIsGlobal)
      imports.add(typeRepo.namespace ~ ".global");

    if (containerType != ContainerType.None) // Add imports for each of the container types
      foreach (elem; elemTypes)
        elem.addImports(imports, curRepo);
  }

  Repo typeRepo; /// Repo containing the dType (can be this.repo)
  dstring dType; /// D type (container type for containers, Gir "name")
  dstring cType; /// C type (container type for containers)
  dstring origDType; /// Original D type (before substitution)
  dstring origCType; /// Original C type (before substitution)
  TypeKind kind; /// Type kind
  Base typeObject; /// Resolved type object for dType

  TypeNode[] elemTypes; /// Container element types (2 for HashTable, 1 for other container types)

  Ownership ownership; /// Ownership of passed value (return values, parameters, and properties)
  ContainerType containerType; /// The type of container or None
  bool zeroTerminated; /// true if array is zero terminated
  int fixedSize = ArrayNotFixed; /// Non-zero if array is a fixed size
  int lengthParamIndex = ArrayNoLengthParam; /// >= 0 if a length parameter index is set
}

enum ArrayNotFixed = 0; /// Value for TypeNode.fixedSize which indicates size is not fixed
enum ArrayNoLengthParam = -1; /// Value used for TypeNode.lengthParamIndex which indicates no length parameter

/// Ownership transfer of a type
enum Ownership
{
  Unset = -1, /// Ownership not specified
  None, /// No transfer of ownership
  Container, /// Transfer container ownership
  Full, /// Transfer container and values
}

immutable dstring[] OwnershipValues = ["none", "container", "full"];

/// Container type
enum ContainerType
{
  None = -2, /// No container
  Array = -1, /// Memory array
  ByteArray, /// GByteArray (uses <array>), enforces element type to be ubyte, does not use a template type
  ArrayG, /// GArray (uses <array>)
  PtrArray, /// GPtrArray (uses <array>)
  List, /// GList
  SList, /// GSList
  HashTable, /// GHashTable (has 2 element types for the key and value)
}

/// Container type string values matching ContainerType
immutable dstring[] ContainerTypeValues =
  ["GLib.ByteArray", "GLib.Array", "GLib.PtrArray", "GLib.List", "GLib.SList", "GLib.HashTable"];

long containerTypeElemCount(ContainerType container)
{
  if (container == ContainerType.None)
    return 0;
  else if (container == ContainerType.HashTable)
    return 2;
  else
    return 1;
}

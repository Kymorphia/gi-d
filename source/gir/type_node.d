module gir.type_node;

import defs;
import gir.alias_;
public import gir.base;
import gir.field;
import gir.func;
import gir.param;
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

  override @property dstring name()
  {
    auto ptn = cast(TypeNode)parent;
    if (ptn && ptn.elemTypes.canFind(this))
      return "[" ~ ptn.elemTypes.countUntil(this).to!dstring ~ "]";

    return super.name;
  }

  override @property void name(dstring val)
  {
    super.name(val);
  }

  /// Get the type kind of a type node
  @property TypeKind kind()
  {
    return _kind;
  }

  /// Set the type kind of a type node
  @property void kind(TypeKind k)
  {
    _kind = k;
    updateUnresolvedFlags(UnresolvedFlags.Kind, _kind == TypeKind.Unknown); // Set or clear unresolved flag
  }

  /// Check if this type is defined in its own module file
  @property bool inModule()
  {
    return false; // Overridden by subclasses such as Structure
  }

  /// Check if this type is defined in the repository global module
  @property bool inGlobal()
  {
    with (TypeKind) return kind.among(BasicAlias, Enum, Flags, Simple, Callback) != 0;
  }

  /// Check if type has been resolved
  @property bool resolved()
  {
    return unresolvedFlags == 0;
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

  /**
   * Update unresolved flags and add/remove to/from Defs.unresolvedTypes as appropriate.
   * Params:
   *   flags = The unresolved flags to set or clear
   *   set = true to set the flags, false to clear them
   */
  void updateUnresolvedFlags(UnresolvedFlags flags, bool set)
  {
    if (!set)
    {
      if (unresolvedFlags)
      {
        unresolvedFlags &= ~flags;

        if (unresolvedFlags)
          repo.defs.unresolvedTypes[this] = unresolvedFlags;
        else
          repo.defs.unresolvedTypes.remove(this);
      }
    }
    else
    {
      unresolvedFlags |= flags;
      repo.defs.unresolvedTypes[this] = unresolvedFlags;
    }
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

      if (dType == "GLib.Array")
        containerType = ContainerType.ArrayG;
    }
    else // Is this a <type> node or other node with "name" and "c:type"? (Structure for example).
    {
      dType = origDType = node.get("name");
      cType = origCType = node.get("c:type");
    }
  }

  /// Fixup independent state (only called once)
  void fixup()
  {
    dstring parseRepoType(dstring type, out Repo outRepo)
    {
      auto t = type.split('.');
      if (t.length > 1)
      {
        outRepo = repo.defs.repoHash.get(t[0], null);
        if (outRepo)
          return t[1];

        warning("Repo '" ~ t[0].to!string ~ "' not found for type '" ~ type.to!string ~ "'");
        type = t[1];
      }

      outRepo = repo;
      return type;
    }

    codeTrap("type.fixup", fullName);

    origDType = parseRepoType(origDType, typeRepo);
    dType = repo.defs.subTypeStr(origDType, repo.defs.dTypeSubs, typeRepo.dTypeSubs);

    if (dType.canFind('.')) // If substituted type contains a repo name, resolve it
      dType = parseRepoType(dType, typeRepo);

    cType = repo.defs.subTypeStr(origCType, repo.defs.cTypeSubs, typeRepo.cTypeSubs);

    foreach (typ; elemTypes) // Fixup container element types
      typ.fixup;

    if (dType == "void*" && cType == "const(void)*") // If dType is void* and cType is const(void)*, make the dType const as well
      dType = "const(void)*";

    if (containerType == ContainerType.Array)
    {
      if (elemTypes.length == 1 && elemTypes[0].cType == "char"
        && lengthParamIndex != ArrayNoLengthParam) // If this is a char[] array, set element type to Basic char, but FuncWriter will consider it as a string.
      {
        elemTypes[0].kind = TypeKind.Basic;
        elemTypes[0].dType = "char";
        info("'" ~ fullName.to!string ~ "' using string for char array with length");
      }
      else if (lengthParamIndex != ArrayNoLengthParam && !elemTypes.empty && elemTypes[0].dType == "ubyte"
        && cType.stripConst.startsWith("char")) // If there is a length parameter, dType is "ubyte", and array type uses char - treat it as a ubyte array
      {
        info("Changing array cType from " ~ cType.to!string ~ " to ubyte for " ~ fullName.to!string);
        elemTypes[0].cType = "ubyte";
        cType = cType.replace("char", "ubyte");
      }
      else if (!elemTypes.empty && elemTypes[0].cType.empty) // Missing array element C type? Try and derive it from array C type
        deriveElemCTypeFromArrayType;
    }
    else if (ContainerTypeValues.canFind(fullDType) && !cast(Structure)this) // Not an array, check if it is another container type and not a structure (the type itself)
      containerType = cast(ContainerType)ContainerTypeValues.countUntil(fullDType);

    if (containerType != ContainerType.None)
    {
      kind = TypeKind.Container;
      dType = null;
    }

    resolve; // Attempt to resolve dependencies
  }

  // Derive array element C type from the array C type
  private void deriveElemCTypeFromArrayType()
  {
    auto elemType = cType.stripConst;
    auto count = elemType.countStars;

    if (count > 0)
    {
      elemType = elemType[0 .. $ - count]; // Strip the stars off

      if (cType.canFind("const") && count > 1)
        elemType = "const(" ~ elemType ~ "*"d.replicate(count - 2) ~ ")*";
      else
        elemType ~= "*"d.replicate(count - 1);

      if (elemType != "void")
        elemTypes[0].origCType = elemType;
    }

    if (elemTypes[0].origCType.empty && elemTypes[0].dType.isBasicType) // Don't use kind, since it isn't resolved yet
      elemTypes[0].origCType = elemTypes[0].dType; // Use D type if unable to derive C type from array C type, as long as D type is Basic

    if (elemTypes[0].origCType)
    {
      elemTypes[0].cType = repo.defs.subTypeStr(elemTypes[0].origCType, repo.defs.cTypeSubs,
        elemTypes[0].typeRepo.cTypeSubs);

      info("Using member C type '" ~ elemTypes[0].cType.to!string ~ "' for D type '"
        ~ elemTypes[0].dType.to!string ~ "' for an array with C type '" ~ cType.to!string ~ "' in "
        ~ fullName.to!string);
    }
  }

  /// Resolve dependencies (may get called multiple times)
  void resolve()
  {
    codeTrap("type.resolve", fullName);

    if (kind != TypeKind.Container)
    {
      if (!typeObject)
        typeObject = typeRepo.typeObjectHash.get(dType, null);

      foreach (i; 0 .. 4) // Resolve aliases (up to 4 dereferences)
        if (cast(Alias)typeObject)
          typeObject = typeRepo.typeObjectHash.get((cast(Alias)typeObject).dType, null);
        else
          break;

      if (kind == TypeKind.Unknown)
        kind = repo.defs.typeKind(dType, typeRepo);

      if (cType.empty && kind == TypeKind.String)
      {
        cType = "char*";
        info(fullName ~ ": Using char* for missing cType");
      }

      with (TypeKind) if (!kind.among(Unknown, Basic, String, Namespace))
        dType = dType.normalizeDTypeName(); // Strip _t from type name and CamelCase it

      if (auto st = cast(Structure)typeObject) // Should only be set to a Structure for non-struct dependencies
      {
        if (cType == "void*" || cType == "const(void)*") // HACK? - Fix anonymous gpointer object parameters to have proper C types
        {
          cType = st.cType ~ "*";
          info(fullName ~ ": Using '" ~ cType ~ "' for anonymous pointer cType");
        }
        else if (cType.empty && !st.cType.empty) // HACK? - Use structure cType if cType is missing
        {
          cType = st.cType ~ "*";
          info(fullName ~ ": Using '" ~ cType ~ "' for missing cType");
        }
      }

      return;
    }

    foreach (tn; elemTypes) // Fixup container element types
    {
      tn.resolve;
      updateUnresolvedFlags(UnresolvedFlags.Element, tn.unresolvedFlags != cast(UnresolvedFlags)0);
    }

    if (dType.empty && (unresolvedFlags & UnresolvedFlags.Element) == 0) // If container D type has not yet been set and elements are resolved
    {
      if (containerType == ContainerType.Array && elemTypes.length == 1)
        dType = elemTypes[0].dType ~ "[]";
      else if (containerType == ContainerType.ArrayG && elemTypes.length == 1)
        dType = "ArrayG!(" ~ elemTypes.map!(x => x.dType ~ ", " ~ x.cType).join(", ") ~ ")";
      else if (containerType == ContainerType.HashTable && elemTypes.length == 2)
        dType = elemTypes[1].dType ~ "[" ~ elemTypes[0].dType ~ "]"; // Uses an associative array
      else if (containerType != ContainerType.ByteArray && elemTypes.length == 1) // ByteArray is not a template
        dType = containerType.to!dstring ~ "!(" ~ elemTypes.map!(x => x.dType ~ ", " ~ x.cType)
          .join(", ") ~ ")"; // All other types use templates
    }
  }

  /// Verify state
  void verify()
  {
    if (unresolvedFlags)
      throw new Exception("Unresolved type '" ~ fullName.to!string ~ "' (flags = " ~ unresolvedFlags.to!string ~ ")");

    foreach (typ; elemTypes)
      if (typ.containerType != ContainerType.None)
        throw new Exception("Nested container types not yet supported");

    if (containerType == ContainerType.Array)
    {
      if (elemTypes.empty)
        throw new Exception("Array type '" ~ cType.to!string ~ "' has no element type");

      if (lengthParamIndex == ArrayNoLengthParam && fixedSize == ArrayNotFixed && !zeroTerminated)
      {
        if (Repo.suggestDefCmds)
          repo.suggestions["Set arrays to be zero-terminated=1"] ~= "set " ~ xmlSelector.to!string ~ (cast(Func)this
            ? ".return-value.array[][zero-terminated] 1" : ".array[][zero-terminated] 1");

        throw new Exception("Array of type '" ~ elemTypes[0].dType.to!string ~ "' has indeterminate length");
      }

      if (elemTypes[0].cType.empty) // Missing array element C type?
        throw new Exception("Could not determine member type for array type '" ~ cType.to!string ~ "'");

      if (cType.empty && fixedSize == 0) // No array C type and not fixed size?
        warning(xmlLocation ~ "No array c:type for array of D type '" ~ dType.to!string ~ "' in '"
            ~ fullName.to!string ~ "'");

      if (elemTypes[0].dType == "ubyte" && cType.canFind("char"))
        throw new Exception("Unsure if array is a null terminated string or not for array cType "
          ~ cType.to!string ~ " element cType " ~ elemTypes[0].cType.to!string ~ " dType "
          ~ elemTypes[0].dType.to!string);
    }

    if (containerType != ContainerType.None)
    {
      auto reqElemTypes = containerTypeElemCount(containerType);

      if (elemTypes.length < reqElemTypes)
        throw new Exception(fullDType.to!string ~ " requires " ~ reqElemTypes.to!string ~ " container type(s), found "
            ~ elemTypes.length.to!string);

      if (elemTypes.length > reqElemTypes)
        warning(xmlLocation ~ "Container '" ~ fullDType.to!string ~ "' has excess types");

      foreach (type; elemTypes)
        if (type.kind.among(TypeKind.Unknown, TypeKind.Namespace))
          throw new Exception("unhandled container type kind '" ~ type.kind.to!string ~ "' for type '"
              ~ fullDType.to!string ~ "'");
    }

    if (containerType == ContainerType.None && kind != TypeKind.Namespace)
    {
      if (cType.empty && kind != TypeKind.Callback) // Has no C type and not a callback?
      {
        auto parentTypeNode = cast(TypeNode)parent;
        if (!parentTypeNode || parentTypeNode.containerType != ContainerType.Array) // Warn if not an array container type (handled separately)
          warning(xmlLocation ~ "No c:type for D type '" ~ dType.to!string ~ "' in '" ~ fullName.to!string ~ "'");
      }

      if (kind.among(TypeKind.Unknown, TypeKind.Namespace))
        throw new Exception("unhandled type kind '" ~ kind.to!string ~ "' for type '"
            ~ dType.to!string ~ "'");

      if (!elemTypes.empty)
        warning(xmlLocation ~ "Unexpected element type in unrecognized container '" ~ fullName.to!string ~ "'");
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
    if (typeObject && typeObject.disable)
      return;

    imports.add(typeRepo.namespace ~ ".Types");

    if (containerType != ContainerType.None)
    {
      if (auto mod = containerType.getModule)
        imports.add(mod);

      foreach (elem; elemTypes) // Add imports for each of the container types
        elem.addImports(imports, curRepo);
    }
    else if (cast(TypeNode)typeObject ? (cast(TypeNode)typeObject).inModule : inModule)
      imports.add(fullDType);
  }

  Repo typeRepo; /// Repo containing the dType (can be this.repo)
  dstring dType; /// D type (container type for containers, Gir "name")
  dstring cType; /// C type (container type for containers)
  dstring origDType; /// Original D type (before substitution)
  dstring origCType; /// Original C type (before substitution)
  private TypeKind _kind; /// Type kind
  Base typeObject; /// Resolved type object for dType
  TypeNode[] elemTypes; /// Container element types (2 for HashTable, 1 for other container types)
  Ownership ownership; /// Ownership of passed value (return values, parameters, and properties)
  ContainerType containerType; /// The type of container or None
  Param lengthParam; /// Set to a length parameter for arrays
  UnresolvedFlags unresolvedFlags; /// Flags of what type references are unresolved (0 if none)
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

/// Kind of a type
enum TypeKind
{
  Unknown, /// Unknown type
  Basic, /// A basic data type
  String, /// A string
  BasicAlias, /// An alias to a basic type
  Enum, /// Enumeration type
  Flags, /// Bitfield flags type
  Callback, /// Callback function type
  Container, /// A container type
  Simple, /// Simple Record or Union with basic fields (Basic, Enum, Flags) and no methods (alias to C type)
  Pointer, /// Opaque Record pointer type with no accessible fields or methods (alias to C type)
  Opaque, /// Opaque Record pointer wrapped by a D class with methods
  Wrap, /// Record or Union wrapped by a D class with defined fields and/or methods
  Boxed, /// A GLib boxed Record type which can have fields
  Reffed, /// Referenced Class type with possible inheritence (not GObject derived), can have fields
  Object, /// A GObject Class
  Interface, /// Interface type
  Namespace, /// Namespace structure (no C type, global module for example)
}

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

/**
 * Get the module name which should be imported for a given container type.
 * Params:
 *   container = The container type
 * Returns: The module name or null if it has no module
 */
dstring getModule(ContainerType container)
{
  if (container == ContainerType.Array || container == ContainerType.HashTable)
    return null;
  else if (container == ContainerType.ArrayG)
    return "GLib.ArrayG";
  else
    return ContainerTypeValues[cast(int)container];
}

/// Basic type names
immutable string[] BasicTypeValues = [
  "bool", "byte", "char", "dchar", "double", "float", "int", "long", "ptrdiff_t", "real", "short", "size_t", "ubyte",
  "uint", "ulong", "ushort", "void*", "void"
];

/// Hash of basic type names to true values
immutable bool[dstring] BasicTypeHash;

shared static this()
{
  foreach (s; BasicTypeValues)
    BasicTypeHash[s.to!dstring] = true;
}

/**
 * Is the type string a basic type?
 * Params:
 *   type = The type string
 * Returns: true if type is a basic type, false otherwise
 */
bool isBasicType(dstring type)
{
  return BasicTypeHash.get(type.stripConstPtr, false);
}

/// Flags which indicate what type references are unresolved
enum UnresolvedFlags
{
  Kind = 1 << 0, /// The TypeNode kind is unresolved
  ParentStruct = 1 << 1, /// The parent structure is unresolved
  Element = 1 << 2, /// A container element is unresolved
}

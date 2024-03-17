module gir.field;

import defs;
import gir.func;
import gir.structure;
import gir.type_node;
import import_symbols;
import utils;

/// Field in a structure
final class Field : TypeNode
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

  // Get field name and handle reserved words by adding an underscore to the field name
  @property dstring subName()
  {
    return repo.defs.symbolName(_name);
  }

  /// Get the field name formatted in D camelCase
  dstring dName()
  {
    return repo.defs.symbolName(_name.camelCase);
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    _name = node.get("name");
    readable = node.get("readable", "1") == "1";
    writable = node.get("writable", "0") == "1";
    introspectable = node.get("introspectable", "1") == "1";
    private_ = node.get("private") == "1";
  }

  override void fixup()
  {
    super.fixup;

    if (callback) // Embedded callback type
    {
      cType = origCType = null;
      dType = origDType = null;
      kind = TypeKind.Callback;
      callback.fixup;
    }
    else if (kind == TypeKind.Callback)
      callback = cast(Func)typeObject;
    else if (directStruct) // Embedded structure
      foreach (f; directStruct.fields)
        f.fixup;
  }

  override void verify()
  {
    if (disable || private_)
      return;

    super.verify;

    auto starCount = cType.countStars;

    if (kind == TypeKind.String && starCount > 1)
      throw new Exception("Array of strings not supported");

    with(TypeKind) if ((kind.among(Basic, BasicAlias, Enum, Flags, Callback) && starCount != 0)
        || (kind.among(String, Simple, Opaque, Wrap, Boxed, Reffed, Object, Interface) && starCount != 1))
      throw new Exception("Unexpected number of pointer references for field " ~ fullName.to!string);

    if (directStruct)
      throw new Exception("Embedded structure fields not supported");

    if (containerType != ContainerType.None)
      throw new Exception("Container type '" ~ containerType.to!string ~ "' not supported");

    if (kind.among(TypeKind.Unknown, TypeKind.Interface, TypeKind.Namespace))
      throw new Exception("Unhandled type '" ~ dType.to!string ~ "' (" ~ kind.to!string ~ ")");

    if (writable && kind.among(TypeKind.Boxed, TypeKind.Wrap, TypeKind.Reffed, TypeKind.Object))
    {
      writable = false;
      warning("Setting writable to false for field " ~ fullName.to!string ~ " with unhandled type '"
          ~ dType.to!string ~ "' (" ~ kind.to!string ~ ")");
    }

    if (callback)
      callback.verify;
    else if (directStruct)
      foreach (f; directStruct.fields)
        f.verify;
  }

  override void addImports(ImportSymbols imports, Repo repo)
  {
    if (callback)
      callback.addImports(imports, repo);
    else
      super.addImports(imports, repo);
  }

  private dstring _name; /// Field name
  Func callback; /// For callback fields (embedded callback type or alias reference)
  Structure directStruct; /// Directly embedded structure or union
  bool readable; /// Readable field?
  bool writable; /// Writable field?
  bool introspectable = true; /// Is field introspectable?
  bool private_; /// Private field?
}

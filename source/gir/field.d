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

    if (callback)
    {
      cType = origCType = null;
      dType = origDType = null;
      kind = TypeKind.Callback;
      callback.fixup;
    }
  }

  override void verify()
  {
    if (disable)
      return;

    if (callback)
      throw new Exception("Callback fields not yet supported");

    super.verify;

    if (containerType != ContainerType.None)
      throw new Exception("Container type '" ~ containerType.to!string ~ "' not supported");

    if (kind.among(TypeKind.Unknown, TypeKind.Callback, TypeKind.Opaque, TypeKind.Interface, TypeKind.Namespace))
      throw new Exception("Unhandled type '" ~ dType.to!string ~ "' (" ~ kind.to!string ~ ")");

    if (writable && kind.among(TypeKind.Boxed, TypeKind.Wrap, TypeKind.Reffed))
    {
      writable = false;
      warning("Setting writable to false for field " ~ fullName.to!string ~ " with unhandled type '"
          ~ dType.to!string ~ "' (" ~ kind.to!string ~ ")");
    }
  }

  override void addImports(ImportSymbols imports, Repo repo)
  {
    if (callback)
      callback.addImports(imports, repo);
    else
      super.addImports(imports, repo);
  }

  private dstring _name; /// Field name
  Func callback; /// For callback fields
  bool readable; /// Readable field?
  bool writable; /// Writable field?
  bool introspectable = true; /// Is field introspectable?
  bool private_; /// Private field?
}

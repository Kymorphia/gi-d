module gir.param;

import std.conv : to;

import gir.type_node;

/// Function parameter
final class Param : TypeNode
{
  this(Repo repo, XmlNode node)
  {
    this.repo = repo;
    fromXml(node);
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    name = node.get("name");
    direction = cast(ParamDirection)node.get("direction");
    ownership = cast(Ownership)node.get("transfer-ownership");
    nullable = node.get("nullable") == "1";
    optional = node.get("optional") == "1";
    allowNone = node.get("allow-none") == "1";
    callerAllocates = node.get("caller-allocates") == "1";
    varargs = node.findChild("varargs") !is null;

    if (auto pVal = "closure" in node.attrs)
      closureIndex = (*pVal).to!int;
    else
      closureIndex = NoClosure;

    if (auto pVal = "destroy" in node.attrs)
      destroyIndex = (*pVal).to!int;
    else
      destroyIndex = NoDestroy;

    scope_ = cast(ParamScope)node.get("scope");
  }

  dstring name; /// Name of parameter
  ParamDirection direction; /// Parameter direction
  Ownership ownership; /// Ownership of value (Gir "transfer-ownership")
  bool nullable; /// Nullable pointer
  bool optional; /// Optional pointer
  bool allowNone; /// Allow none (FIXME - how does this differ from nullable?)
  bool callerAllocates; /// Caller allocates value
  bool varargs; /// Indicates a parameter is a varargs ... elipsis

  int closureIndex = NoClosure; /// Closure parameter index
  int destroyIndex = NoDestroy; /// Destroy parameter index
  ParamScope scope_; /// FIXME
}

/// Direction of a parameter
enum ParamDirection : dstring
{
  In = null, /// Input direction (not actually found in Gir files, since it is the default unspecified value)
  Out = "out", /// Output direction
  InOut = "inout", /// Input and output direction
}

/// Ownership transfer of a type
enum Ownership : dstring
{
  Unset = null, /// Ownership not specified
  None = "none", /// No transfer of ownership
  Container = "container", /// Transfer container ownership
  Full = "full", /// Transfer container and values
}

/// Parameter scope
enum ParamScope : dstring
{
  Unset = null,
  Call = "call", /// FIXME
  Async = "async", /// FIXME
  Notified = "notified", /// FIXME
}

enum NoClosure = -1;
enum NoDestroy = -1;

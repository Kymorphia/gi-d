module gir.func;

import std.conv : to;

import code_writer;
import gir.param;
import gir.repo;
import gir.type_node;
import utils;

/**
 * Function like object. Can be a function, method, signal, callback, etc.
 * The TypeNode parent class stores the return type information.
 */
final class Func : TypeNode
{
  this(Repo repo, XmlNode node)
  {
    this.repo = repo;
    fromXml(node);
  }

  /// Get the function name formatted in D camelCase
  dstring dName()
  {
    return repo.defs.symbolName(name.camelCase);
  }

  /// Returns true if function has an instance parameter
  bool hasInstanceParam()
  {
    return params.length > 0 && params[0].isInstanceParam;
  }

  override void fromXml(XmlNode node)
  {
    Base.fromXml(node);

    if (auto retValNode = node.findChild("return-value"))
    {
      super.fromXml(retValNode); // The return-value node is used for TypeNode
      ownership = cast(Ownership)retValNode.get("transfer-ownership");
      nullable = retValNode.get("nullable") == "1";
    }

    name = node.get("name");
    funcType = cast(FuncType)node.id;
    cName = node.get("c:identifier");

    version_ = node.get("version");
    shadowedBy = node.get("shadowed-by");
    shadows = node.get("shadows");
    invoker = node.get("invoker");
    movedTo = node.get("moved-to");
    introspectable = node.get("introspectable", "1") == "1";
    throws = node.get("throws") == "1";
    action = node.get("action") == "1";
    detailed = node.get("detailed") == "1";
    noHooks = node.get("noHooks") == "1";
    noRecurse = node.get("noRecurse") == "1";
    deprecated_ = node.get("deprecated") == "1";
    deprecatedVersion = node.get("deprecated-version");
    when = cast(SignalWhen)node.get("when");
  }

  /**
   * Get function prototype string for function.
   * Returns: Function prototype string which intentially omits the function name for definition by the caller.
   */
  dstring getCPrototype()
  {
    dstring fnptr = (isArray ? subArrayCType : subCType) ~ " function(";

    foreach (i, p; params)
      fnptr ~= (i > 0 ? ", "d : "") ~ (p.isArray ? p.subArrayCType
          : p.subCType) ~ " " ~ repo.defs.symbolName(p.name.camelCase);

    return fnptr ~ ")";
  }

  dstring name; /// Name of function
  FuncType funcType; /// Function type
  dstring cName; /// C type name (Gir c:identifier)
  Param[] params; /// Parameters

  Ownership ownership; /// Ownership of return value (Gir "return-value:transfer-ownership")
  bool nullable; /// Nullable return value pointer

  dstring version_; /// Version
  dstring shadowedBy; /// Function which shadows this
  dstring shadows; /// Function that this shadows
  dstring invoker; /// Invoker method
  dstring movedTo; /// Function moved to name

  bool introspectable = true; /// Introspectable?
  bool throws; /// Throws exception?
  bool action; /// Signal action (FIXME)
  bool detailed; /// Signal detailed (FIXME)
  bool noHooks; /// Signal no hooks (FIXME)
  bool noRecurse; /// Signal no recurse (FIXME)

  bool deprecated_; /// Deprecated
  dstring deprecatedVersion; /// Deprecated version
  SignalWhen when; /// Signal when
}

enum FuncType : dstring
{
  Function = "function",
  Callback = "callback",
  Constructor = "constructor",
  Signal = "glib:signal",
  Method = "method",
  VirtualMethod = "virtual-method",
  FuncMacro = "function-macro",
}

enum SignalWhen : dstring
{
  Unset = null,
  First = "first",
  Last = "last",
  Cleanup = "cleanup",
}

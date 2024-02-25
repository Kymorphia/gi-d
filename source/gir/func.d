module gir.func;

import std.conv : to;

import code_writer;
import gir.param;
import gir.repo;
import gir.type_node;
import import_symbols;
import utils;

/**
 * Function like object. Can be a function, method, signal, callback, etc.
 * The TypeNode parent class stores the return type information.
 */
final class Func : TypeNode
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

  /// Get the function name formatted in D camelCase
  dstring dName()
  {
    return repo.defs.symbolName(_name.camelCase);
  }

  /// Returns true if function has an instance parameter
  bool hasInstanceParam()
  {
    return params.length > 0 && params[0].isInstanceParam;
  }

  override void fromXml(XmlNode node)
  {
    if (auto retValNode = node.findChild("return-value"))
    {
      super.fromXml(retValNode); // The return-value node is used for TypeNode
      ownership = cast(Ownership)OwnershipValues.countUntil(retValNode.get("transfer-ownership"));
      nullable = retValNode.get("nullable") == "1";
    }

    Base.fromXml(node);

    _name = node.get("name");
    funcType = cast(FuncType)FuncTypeValues.countUntil(node.id);
    cName = node.get("c:identifier");

    if (cName.empty)
      cName = node.get("c:type");

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
    when = cast(SignalWhen)SignalWhenValues.countUntil(node.get("when"));
  }

  override void fixup()
  {
    super.fixup;

    if (!introspectable || !movedTo.empty || funcType == FuncType.VirtualMethod || funcType == FuncType.FuncMacro)
      disable = true;

    if (lengthParamIndex != ArrayNoLengthParam) // Array has a length argument?
    {
      if (hasInstanceParam) // Array length parameter indexes don't count instance parameters
        lengthParamIndex++;

      if (lengthParamIndex < params.length)
      {
        auto lengthParam = params[lengthParamIndex];
        lengthParam.arrayParamIndex = ParamIndexReturnVal;
        lengthParam.isArrayLength = true;
      }
    }

    foreach (pi, pa; params) // Fixup parameters
      pa.fixup;
  }

  override void verify()
  {
    if (disable)
      return;

    void disableFunc(string msg)
    {
      disable = true;
      warning("Disabling function '" ~ fullName.to!string ~ "': " ~ msg);
    }

    try
      super.verify; // Verify the return type
    catch (Exception e)
    {
      disableFunc("Return type error: " ~ e.msg);
      return;
    }

    if (lengthParamIndex != ArrayNoLengthParam) // Array has a length argument?
    {
      if (lengthParamIndex >= params.length)
      {
        disableFunc("invalid return array length parameter index");
        return;
      }

      auto lengthParam = params[lengthParamIndex];
      if (lengthParam.direction != ParamDirection.Out)
      {
        disableFunc("return array length parameter direction must be Out");
        return;
      }
    }

    foreach (pi, pa; params)
    {
      if (pa.isInstanceParam && pi != 0)
        disableFunc("invalid additional instance param '" ~ pa.name.to!string ~ "'");

      try
        pa.verify; // Verify parameter
      catch (Exception e)
        disableFunc("Parameter '" ~ pa.name.to!string ~ "' error: " ~ e.msg);
    }
  }

  override void addImports(ImportSymbols imports, Repo repo)
  {
    super.addImports(imports, repo);

    foreach (param; params)
      param.addImports(imports, repo);
  }

  /**
   * Get function prototype string for function.
   * Returns: Function prototype string which intentially omits the function name for definition by the caller.
   */
  dstring getCPrototype()
  {
    dstring fnptr = cType ~ " function(";

    foreach (i, p; params)
      fnptr ~= (i > 0 ? ", "d : "") ~ p.cType ~ " " ~ repo.defs.symbolName(p.name.camelCase);

    return fnptr ~ ")";
  }

  private dstring _name; /// Name of function
  FuncType funcType; /// Function type
  dstring cName; /// C type name (Gir c:identifier)
  Param[] params; /// Parameters
  bool isCtor; /// Set for the primary constructor of an instance (not a Gir field)

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

enum FuncType
{
  Unknown = -1,
  Function,
  Callback,
  Constructor,
  Signal,
  Method,
  VirtualMethod,
  FuncMacro,
}

immutable dstring[] FuncTypeValues = [
  "function", "callback", "constructor", "glib:signal", "method",
  "virtual-method", "function-macro"
];

enum SignalWhen
{
  Unknown = -1,
  First,
  Last,
  Cleanup,
}

immutable dstring[] SignalWhenValues = ["first", "last", "cleanup"];

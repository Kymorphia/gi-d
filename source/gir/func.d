module gir.func;

import std.conv : to;

import code_writer;
import defs;
import gir.alias_;
import gir.field;
import gir.param;
import gir.repo;
import gir.return_value;
import gir.structure;
import gir.type_node;
import utils;

/**
 * Function like object. Can be a function, method, signal, callback, etc.
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

  /**
   * Get the function name formatted in D camelCase
   * Params:
   *   firstUpper = true to make first character uppercase also (defaults to false)
   */
  dstring dName(bool firstUpper = false)
  {
    return repo.defs.symbolName(_name.camelCase(firstUpper));
  }

  /**
   * Get the function full name formatted in D camelCase, with the namespace separated by a period
   * Params:
   *   firstUpper = true to make first character uppercase also (defaults to false)
   */
  dstring fullDName(bool firstUpper = false)
  {
    dstring full = dName;

    for (auto b = this.parent; b; b = b.parent)
      if (auto s = b.name)
        full = full.length > 0 ? s ~ "." ~ full : s;

    return full;
  }

  /// Returns true if function has an instance parameter
  bool hasInstanceParam()
  {
    return params.length > 0 && params[0].isInstanceParam;
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    _name = origName = node.get("name");
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
    if (!cast(Field)parent)
    {
      _name = repo.defs.subTypeStr(origName, repo.defs.dTypeSubs, repo.dTypeSubs);

      if (funcType == FuncType.Callback && _name == origName)
        _name = _name.normalizeDTypeName();
    }

    super.fixup;

    if (!introspectable || !movedTo.empty || funcType == FuncType.VirtualMethod || funcType == FuncType.FuncMacro
        || !shadowedBy.empty)
      disable = true;

    if (returnVal)
    {
      if (returnVal.lengthParamIndex != ArrayNoLengthParam) // Return array has a length argument?
      {
        if (hasInstanceParam) // Array length parameter indexes don't count instance parameters
          returnVal.lengthParamIndex++;

        if (returnVal.lengthParamIndex < params.length)
        {
          returnVal.lengthParam = params[returnVal.lengthParamIndex];
          returnVal.lengthParam.isLengthReturnArray = true;
        }
      }

      returnVal.fixup; // Fixup return value
    }

    foreach (pa; params) // Fixup parameters
    {
      pa.fixup;

      if (pa.isClosure)
        closureParam = pa;
    }

    if (funcType == FuncType.Callback && !closureParam)
    { // Search for closure parameter if it is not explicitly designated
      foreach (pa; params.retro) // Look in reverse, since it is more likely to be an end parameter
      {
        if (pa.dType == "void*" && pa.name.toLower.canFind("data"))
        {
          pa.isClosure = true;
          closureParam = pa;
          info("Designating parameter '" ~ pa.fullName.to!string ~ "' as closure");
        }
      }
    }
  }

  override void resolve()
  {
    super.resolve;

    if (returnVal)
      returnVal.resolve; // Resolve return value

    foreach (pa; params) // Resolve parameters
      pa.resolve;
  }

  override void verify()
  {
    if (disable)
      return;

    void disableFunc(string msg)
    {
      disable = true;
      warning(xmlLocation ~ "Disabling " ~ (funcType == FuncType.Signal ? "signal '" : "function '" )
        ~ fullName.to!string ~ "': " ~ msg);
    }

    if (!shadows.empty && !shadowsFunc)
    {
      disableFunc("Could not resolve shadows function name " ~ shadows.to!string);
      return;
    }

    if (returnVal)
    {
      try
        returnVal.verify; // Verify the return type
      catch (Exception e)
      {
        disableFunc("Return type error: " ~ e.msg);
        return;
      }
    }

    if (returnVal.containerType == ContainerType.None && returnVal.kind.among(TypeKind.Basic, TypeKind.BasicAlias)
        && returnVal.cType.countStars != 0 && !returnVal.cType.among("void*"d, "const(void)*"d))
      disableFunc("Unexpected basic return type '" ~ returnVal.cType.to!string ~ "'");

    if (funcType == FuncType.Signal)
    {
      if (returnVal.containerType != ContainerType.None)
      {
        disableFunc("signal container return type '" ~ returnVal.containerType.to!string ~ "' not supported");
        return;
      }

      with(TypeKind) if (returnVal.kind.among(Simple, Pointer, Callback, Opaque, Unknown, Namespace))
      {
        disableFunc("signal return type '" ~ returnVal.kind.to!string ~ "' is not supported");
        return;
      }
    }

    if (returnVal)
    {
      if (returnVal.lengthParamIndex != ArrayNoLengthParam)
      {
        if (!returnVal.lengthParam) // Return array has invalid length argument?
        {
          disableFunc("invalid return array length parameter index");
          return;
        }

        if (returnVal.lengthParam.direction != ParamDirection.Out)
        {
          disableFunc("return array length parameter direction must be Out");
          return;
        }
      }
    }

    foreach (pi, pa; params)
    {
      if (pa.isInstanceParam && pi != 0)
        disableFunc("invalid additional instance param '" ~ pa.name.to!string ~ "'");

      if (pa.isClosure && pa != closureParam)
        disableFunc("multiple closure parameters");

      try
        pa.verify; // Verify parameter
      catch (Exception e)
        disableFunc("Parameter '" ~ pa.name.to!string ~ "' error: " ~ e.msg);

      if (!pa.resolved)
        disableFunc("Unresolved parameter '" ~ pa.name.to!string ~ "' of type '" ~ pa.dType.to!string ~ "'");

      // Resolve parameter type aliases to see if any are disabled and disable parameter if so
      for (TypeNode tn = pa.typeObject; tn; tn = typeRepo.typeObjectHash.get((cast(Alias)tn).dType, null))
      {
        if (tn.disable)
          pa.disable = true;

        if (!cast(Alias)tn)
          break;
      }

      if (pa.disable)
        disableFunc("Parameter '" ~ pa.name.to!string ~ "' of type '" ~ pa.dType.to!string ~ "' is disabled");
    }
  }

  /**
   * Get function prototype string for function.
   * Returns: Function prototype string which intentially omits the function name for definition by the caller.
   */
  dstring getCPrototype(dstring funcName = "function")
  {
    dstring proto = returnVal.cType ~ " " ~ funcName ~ "(";

    foreach (i, p; params)
      proto ~= (i > 0 ? ", "d : "") ~ p.cType ~ " " ~ repo.defs.symbolName(p.name.camelCase);

    if (throws)
      proto ~= (params.length > 0 ? ", "d : ""d) ~ "GError** _err";

    return proto ~ ")";
  }

  /**
   * Get delegate prototype for a callback.
   */
  dstring getDelegPrototype()
  {
    dstring proto = "alias " ~ dName ~ " = " ~ returnVal.dType ~ " delegate(";

    foreach (p; params)
    {
      if (p.isClosure || p.isArrayLength)
        continue;

      if (proto[$ - 1] != '(')
        proto ~= ", ";

      proto ~= p.directionStr ~ p.dType ~ " " ~ repo.defs.symbolName(p.dName);
    }

    return proto ~ ");";
  }

  /**
   * Construct a GError Exception class from a "error_quark" function.
   * Returns: D code for the GError exception.
   */
  dstring constructException()
  {
    assert (name.endsWith("error_quark"));

    dstring output;

    auto exceptionName = name[0 .. $ - "error_quark".length];

    auto st = getParentByType!Structure;

    if (!st)
      throw new Exception("Cannot construct exception class from function " ~ fullName.to!string);

    if (!exceptionName.empty)
      exceptionName = st.dType ~ exceptionName.stripRight("_").camelCase(true);
    else
      exceptionName = st.dType;

    output = "class " ~ exceptionName ~ "Exception : ErrorG\n{\n";
    output ~= "this(GError* err)\n{\nsuper(err);\n}\n\n";
    output ~= "this(Code code, string msg)\n{\nsuper(" ~ st.dType ~ "." ~ dName ~ ", cast(int)code, msg);\n}\n";
    output ~= "\nalias Code = G" ~ exceptionName ~ "Error;\n}";

    return output;
  }

  /**
   * Check if a function needs an "override", i.e., has an ancestor or interface with the same name and return/argument types.
   * Returns: true if the function declaration should include "override"
   */
  bool needOverride()
  {
    auto parentClass = cast(Structure)parent ? (cast(Structure)parent).parentStruct : null; // Class type ancestor

    if (funcType != FuncType.Method || !parentClass || parentClass.structType != StructType.Class)
      return false;

    auto funcName = name;

    for (auto klass = parentClass; klass; klass = klass.parentStruct)
    {
      auto cmpFunc = klass.funcNameHash.get(funcName, null);

      if (!cmpFunc || cmpFunc.disable || returnVal.dType != cmpFunc.returnVal.dType
          || params.length != cmpFunc.params.length)
        continue;

      if (params.filter!(x => !x.isInstanceParam).map!(x => x.dType) // Compare dTypes of both functions (skip instance param)
          .equal(cmpFunc.params.filter!(x => !x.isInstanceParam).map!(x => x.dType)))
        return true;
    }

    return false;
  }

  private dstring _name; /// Name of function
  dstring origName; /// Original name
  FuncType funcType; /// Function type
  dstring cName; /// C type name (Gir c:identifier)
  ReturnValue returnVal; /// Return value type
  Param[] params; /// Parameters
  Param closureParam; /// Closure data parameter or null
  bool isCtor; /// Set for the primary constructor of an instance (not a Gir field)
  Func shadowsFunc; /// Resolved function object for shadows

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

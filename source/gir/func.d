module gir.func;

import std.conv : to;

import code_writer;
import defs;
import gir.field;
import gir.param;
import gir.repo;
import gir.structure;
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

  /**
   * Get the function name formatted in D camelCase
   * Params:
   *   firstUpper = true to make first character uppercase also (defaults to false)
   */
  dstring dName(bool firstUpper = false)
  {
    return repo.defs.symbolName(_name.camelCase(firstUpper));
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

    if (lengthParamIndex != ArrayNoLengthParam) // Return array has a length argument?
    {
      if (hasInstanceParam) // Array length parameter indexes don't count instance parameters
        lengthParamIndex++;

      if (lengthParamIndex < params.length)
      {
        lengthParam = params[lengthParamIndex];
        lengthParam.isLengthReturnArray = true;
      }
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

    try
      super.verify; // Verify the return type
    catch (Exception e)
    {
      disableFunc("Return type error: " ~ e.msg);
      return;
    }

    if (containerType == ContainerType.None && kind.among(TypeKind.Basic, TypeKind.BasicAlias) && cType.countStars != 0
        && !cType.among("void*"d, "const(void)*"d))
      disableFunc("Unexpected basic return type '" ~ cType.to!string ~ "'");

    if (!resolved)
      disableFunc("Unresolved return type '" ~ dType.to!string ~ "'");

    if (funcType == FuncType.Signal)
    {
      if (containerType != ContainerType.None)
      {
        disableFunc("signal container return type '" ~ containerType.to!string ~ "' not supported");
        return;
      }

      with(TypeKind) if (kind.among(Simple, Pointer, Callback, Opaque, Unknown, Namespace))
      {
        disableFunc("signal return type '" ~ kind.to!string ~ "' is not supported");
        return;
      }
    }

    if (lengthParamIndex != ArrayNoLengthParam)
    {
      if (!lengthParam) // Return array has invalid length argument?
      {
        disableFunc("invalid return array length parameter index");
        return;
      }

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

      if (pa.isClosure && pa != closureParam)
        disableFunc("multiple closure parameters");

      try
        pa.verify; // Verify parameter
      catch (Exception e)
        disableFunc("Parameter '" ~ pa.name.to!string ~ "' error: " ~ e.msg);

      if (!pa.resolved)
        disableFunc("Unresolved parameter '" ~ pa.name.to!string ~ "' of type '" ~ dType.to!string ~ "'");

      if (pa.disable || (pa.typeObject && pa.typeObject.disable))
        disableFunc("Parameter '" ~ pa.name.to!string ~ "' of type '" ~ pa.dType.to!string ~ "' is disabled");
    }
  }

  override void addImports(ImportSymbols imports, Repo curRepo)
  {
    super.addImports(imports, curRepo);

    if (funcType == FuncType.Callback)
      imports.add(repo.namespace ~ ".Types");

    foreach (param; params)
      param.addImports(imports, curRepo);
  }

  /**
   * Get function prototype string for function.
   * Returns: Function prototype string which intentially omits the function name for definition by the caller.
   */
  dstring getCPrototype(dstring funcName = "function")
  {
    dstring proto = cType ~ " " ~ funcName ~ "(";

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
    dstring proto = "alias " ~ dName ~ " = " ~ dType ~ " delegate(";

    foreach (p; params)
    {
      if (p.isClosure || p.isArrayLength)
        continue;

      if (proto[$ - 1] != '(')
        proto ~= ", ";

      proto ~= p.directionStr ~ p.dType ~ " " ~ p.dName;
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

    auto funcName = dName;

    for (auto klass = parentClass; klass; klass = klass.parentStruct)
    {
      auto cmpFunc = klass.funcNameHash.get(funcName, null);

      if (!cmpFunc || cmpFunc.disable || dType != cmpFunc.dType || params.length != cmpFunc.params.length)
        continue;

      if (params.map!(x => x.dType).equal(cmpFunc.params.map!(x => x.dType))) // Compare dTypes of both functions
        return true;
    }

    return false;
  }

  private dstring _name; /// Name of function
  dstring origName; /// Original name
  FuncType funcType; /// Function type
  dstring cName; /// C type name (Gir c:identifier)
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

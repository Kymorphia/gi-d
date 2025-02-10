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

  /**
   * Get a signal delegate instance parameter name. This is the dType of the parent class with a lowercase first letter.
   * Returns: Signal delegate instance parameter name or null if parent is not a class
   */
  dstring signalDelegInstanceParam()
  {
    if (auto owningClass = cast(Structure)parent)
      if (owningClass != repo.globalStruct)
        return repo.defs.symbolName(owningClass.dType[0].toLower ~ owningClass.dType[1 .. $]);

    return null;
  }

  /**
   * Check if a function is static (not a method, constructor, and not in global module)
   * Returns: true if the function is static, false otherwise
   */
  bool isStatic()
  {
    return funcType != FuncType.Method && !isCtor && parent !is repo.globalStruct;
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

  override void writeDocs(CodeWriter writer)
  {
    if (docContent.length == 0)
      return;

    writer ~= "/**";
    writer ~= "* " ~ gdocToDDoc(docContent, "* ");

    bool preambleShown;
    foreach (pa; params)
    {
      if (pa.isInstanceParam || pa.isArrayLength || pa.isClosure || pa.isDestroy)
        continue;

      if (!preambleShown)
      {
        preambleShown = true;
        writer ~= funcType == FuncType.Signal ? "* Params"d : "* Params:"d; // FIXME - Work around lack of support for Ddoc delegate alias parameter support
      }

      writer ~= "*   " ~ pa.dName ~ " = " ~ gdocToDDoc(pa.docContent, "*     ");
    }

    if (funcType == FuncType.Signal) // Add documentation for the signal callback instance parameter
      writer ~= "*   " ~ signalDelegInstanceParam ~ " = the instance the signal is connected to";

    if (returnVal && returnVal.origDType != "none")
      writer ~= "* Returns: " ~ gdocToDDoc(returnVal.docContent, "*   ");

    if (!docVersion.empty || !docDeprecated.empty)
    {
      writer ~= "";

      if (!docVersion.empty)
        writer ~= "* Version: " ~ docVersion;

      if (!docDeprecated.empty)
        writer ~= "* Deprecated: " ~ gdocToDDoc(docDeprecated, "*   ");
    }

    writer ~= "*/";
  }

  /**
  * Format a GTK doc string to be a DDoc string.
  * Newlines are formatted with a prefix to match the indendation for the comment block.
  * Parameter references are convered to D names and set to bold.
  * Function references func() are changed to the D function/method name and set to bold.
  *
  * Params:
  *   gdoc = The GTK doc string
  *   prefix = The newline wrap prefix
  * Returns: The DDoc formatted string
  */
  dstring gdocToDDoc(dstring gdoc, dstring prefix = "*   ")
  {
    auto paramRe = ctRegex!(r"@(\w)"d);

    gdoc = repo.defs.gdocToDDoc(gdoc, prefix, repo);

    dstring paramReplaceFunc(Captures!(dstring) m)
    {
      foreach (pa; params)
        if (pa.name == m[1])
          return pa.dName;

      return m[1];
    }

    return gdoc.replaceAll!(paramReplaceFunc)(paramRe); // Replace @cName with dName for parameters
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
      active = Active.Disabled;

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

      if (funcType == FuncType.Constructor) // Return actual instance type for constructors, not a GTK convenience type (like GtkWidget)
      {
        auto retSt = cast(Structure)returnVal.typeObject;
        auto parentSt = getParentByType!Structure;

        if (!(retSt is parentSt || returnVal.dType == parentSt.dType))
        {
          info("Changing return value for " ~ fullName.to!string ~ " from type " ~ returnVal.dType.to!string
            ~ " to " ~ parentSt.dType.to!string);

          returnVal.dType = parentSt.dType;
          returnVal.typeObject = parentSt;
        }
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
    if (active != Active.Enabled)
      return;

    void disableFunc(string msg, TypeNode errorNode = null)
    {
      active = Active.Unsupported;
      warning(xmlLocation ~ "Disabling " ~ (funcType == FuncType.Signal ? "signal '" : "function '" )
        ~ fullName.to!string ~ "': " ~ msg);
      TypeNode.dumpSelectorOnWarning(errorNode ? errorNode : this);
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
        disableFunc("Return type error: " ~ e.msg, returnVal);
        return;
      }
    }

    if (returnVal.containerType == ContainerType.None && returnVal.kind.among(TypeKind.Basic, TypeKind.BasicAlias)
        && returnVal.cType.countStars != 0 && !returnVal.cType.among("void*"d, "const(void)*"d))
      disableFunc("Unexpected basic return type '" ~ returnVal.cType.to!string ~ "'", returnVal);

    if (funcType == FuncType.Signal)
    {
      if (returnVal.containerType != ContainerType.None)
      {
        disableFunc("signal container return type '" ~ returnVal.containerType.to!string ~ "' not supported",
          returnVal);
        return;
      }

      with(TypeKind) if (returnVal.kind.among(Simple, Pointer, Callback, Opaque, Unknown, Namespace))
      {
        disableFunc("signal return type '" ~ returnVal.kind.to!string ~ "' is not supported", returnVal);
        return;
      }
    }

    if (returnVal)
    {
      if (returnVal.lengthParamIndex != ArrayNoLengthParam)
      {
        if (!returnVal.lengthParam) // Return array has invalid length argument?
        {
          disableFunc("invalid return array length parameter index", returnVal);
          return;
        }

        if (returnVal.lengthParam.direction != ParamDirection.Out)
        {
          disableFunc("return array length parameter direction must be Out", returnVal.lengthParam);
          return;
        }
      }
    }

    foreach (pi, pa; params)
    {
      if (pa.isInstanceParam && pi != 0)
        disableFunc("invalid additional instance param '" ~ pa.name.to!string ~ "'", pa);

      if (pa.isClosure && pa != closureParam)
        disableFunc("multiple closure parameters", pa);

      try
        pa.verify; // Verify parameter
      catch (Exception e)
        disableFunc("Parameter '" ~ pa.name.to!string ~ "' error: " ~ e.msg, pa);

      if (!pa.resolved)
        disableFunc("Unresolved parameter '" ~ pa.name.to!string ~ "' of type '" ~ pa.dType.to!string ~ "'", pa);

      // Resolve parameter type aliases to see if any are disabled and disable parameter if so
      for (TypeNode tn = pa.typeObject; tn; tn = typeRepo.typeObjectHash.get((cast(Alias)tn).dType, null))
      {
        if (tn.active != Active.Enabled)
          pa.active = tn.active;

        if (!cast(Alias)tn)
          break;
      }

      if (pa.active != Active.Enabled)
        disableFunc("Parameter '" ~ pa.name.to!string ~ "' of type '" ~ pa.dType.to!string ~ "' is disabled", pa);
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
      exceptionName = st.origDType ~ exceptionName.stripRight("_").camelCase(true);
    else
      exceptionName = st.origDType;

    output = "class " ~ exceptionName ~ "Exception : ErrorG\n{\n";
    output ~= "this(GError* err)\n{\nsuper(err);\n}\n\n";
    output ~= "this(Code code, string msg)\n{\nsuper(" ~ st.dType ~ "." ~ dName ~ ", cast(int)code, msg);\n}\n";
    output ~= "\nalias Code = G" ~ exceptionName ~ "Error;\n}";

    return output;
  }

  /**
   * Search a class' ancestry for a method matching this.
   * Params:
   *   st = Structure to search parent ancestry of (null will search from parent of function's class)
   *   outIsIdentical = Output value set to true if method is identical (same return value and args), false otherwise
   * Returns: The matching method or null if none found, not a method, or not a derived class
   */
  Func findMatchingAncestor(Structure st, out bool outIsIdentical)
  {
    if (!st) // If klass not specified, use this function's klass parent
      st = cast(Structure)parent ? (cast(Structure)parent).parentStruct : null;

    if (isStatic || funcType != FuncType.Method || !st || st.structType != StructType.Class)
      return null;

    auto funcName = name;

    for (auto klass = st; klass; klass = klass.parentStruct)
    {
      auto cmpFunc = klass.funcNameHash.get(funcName, null);
      auto retFunc = cmpFunc;

      if (cmpFunc && cmpFunc.shadowedByFunc) // If the method is shadowed by another one, use it instead
        cmpFunc = cmpFunc.shadowedByFunc;

      if (!cmpFunc || cmpFunc.active != Active.Enabled)
        continue;

      outIsIdentical = returnVal.dType == cmpFunc.returnVal.dType
        && params.length == cmpFunc.params.length
        && (params.filter!(x => !x.isInstanceParam).map!(x => x.dType) // Compare dTypes of both functions (skip instance param)
          .equal(cmpFunc.params.filter!(x => !x.isInstanceParam).map!(x => x.dType)));

      return retFunc;
    }

    return null;
  }

  private dstring _name; /// Name of function
  dstring origName; /// Original name
  FuncType funcType; /// Function type
  dstring cName; /// C type name (Gir c:identifier)
  ReturnValue returnVal; /// Return value type
  Param[] params; /// Parameters
  Param closureParam; /// Closure data parameter or null
  bool isCtor; /// Set for the primary constructor of an instance (not a Gir field)
  Func shadowedByFunc; /// Resolved function object for shadowedBy
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
  bool detailed; /// Signal detailed (indicates the signal accepts a detail string)
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

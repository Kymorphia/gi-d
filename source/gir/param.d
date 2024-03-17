module gir.param;

import defs;
import gir.func;
import gir.structure;
import gir.type_node;
import std_includes;
import utils;

/// Function parameter
final class Param : TypeNode
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

  /// Get the parameter name formatted in D camelCase
  dstring dName()
  {
    return repo.defs.symbolName(name.camelCase);
  }

  /// Get direction string (empty for input, "ref " if callerAllocates=1, "out ", or "inout "). Intended for use directly in code generation.
  dstring directionStr()
  {
    if (direction == ParamDirection.In)
      return "";
    else if (callerAllocates && containerType == ContainerType.Array)
      return "ref ";
    else if (direction == ParamDirection.Out)
      return "out ";
    else
      return "inout ";
  }

  override void fromXml(XmlNode node)
  {
    super.fromXml(node);

    _name = node.get("name");
    isInstanceParam = node.id == "instance-parameter";
    direction = cast(ParamDirection)ParamDirectionValues.countUntil(node.get("direction"));
    ownership = cast(Ownership)OwnershipValues.countUntil(node.get("transfer-ownership"));
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

    scope_ = cast(ParamScope)ParamScopeValues.countUntil(node.get("scope"));
  }

  override void fixup()
  {
    if (origDType == "...") // Skip variable args elipsis
      return;

    super.fixup; // Fixup the type node state

    auto func = getParentByType!Func;

    if (lengthParamIndex != ArrayNoLengthParam) // Array has a length argument?
    {
      if (func.hasInstanceParam) // Instance parameters don't count towards index
        lengthParamIndex++;

      if (lengthParamIndex < func.params.length)
      {
        auto lengthParam = func.params[lengthParamIndex];
        lengthParam.arrayParamIndex = cast(int)func.params.countUntil!(x => x is this);
        lengthParam.isArrayLength = true;
      }
    }

    if (closureIndex != NoClosure)
    {
      if (dType != "void*" && dType != "const(void)*") // Is this the callback? (not the closure data parameter)
      {
        if (func.hasInstanceParam) // Instance parameters don't count towards index
          closureIndex++;

        if (closureIndex < func.params.length)
        {
          auto closureParam = func.params[closureIndex];
          closureParam.isClosure = true;
          closureParam.callbackIndex = cast(int)func.params.countUntil!(x => x is this);
        }
      }
      else // Some closure data parameters reference themselves or the callback, ignore such references, but mark parameter as closure data
      {
        isClosure = true;
        closureIndex = NoClosure;
      }
    }

    if (destroyIndex != NoDestroy)
    {
      if (dType != "DestroyNotify") // Is this the callback? (not destroy notify parameter)
      {
        if (func.hasInstanceParam) // Instance parameters don't count towards index
          destroyIndex++;

        if (destroyIndex < func.params.length)
        {
          auto destroyParam = func.params[destroyIndex];
          destroyParam.isDestroy = true;
          destroyParam.callbackIndex = cast(int)func.params.countUntil!(x => x is this);
        }
      }
      else // Some destroy notify parameters reference themselves or the callback, ignore such references, but mark parameter as a destroy notify
      {
        isDestroy = true;
        destroyIndex = NoDestroy; // Ignore destroy notify parameter references to itself or the callback
      }
    }

    if (cType == "GByteArray*" && direction == ParamDirection.Out) // HACK?: Out GByteArray* is more like InOut
    {
      direction = ParamDirection.InOut;
      info("Using InOut direction for GByteArray* parameter instead of Out");
    }
  }

  override void verify()
  {
    super.verify;

    auto func = getParentByType!Func;

    if (func.funcType == FuncType.Signal)
    {
      if (containerType != ContainerType.None)
        throw new Exception("Signal parameter container type '" ~ containerType.to!string ~ "' not supported");

      if (direction != ParamDirection.In)
        throw new Exception("Signal parameter direction '" ~ direction.to!string ~ "' not supported");

      with(TypeKind) if (kind.among(Simple, Opaque, Callback, Unknown, Namespace))
        throw new Exception("Signal parameter kind '" ~ kind.to!string ~ "' not supported");

      return;
    }

    if (containerType == ContainerType.HashTable)
    {
      if (direction != ParamDirection.Out)
        throw new Exception("HashTable " ~ direction.to!string ~ " parameters not supported");
    }
    else if (containerType != ContainerType.None)
    {
      if ((direction == ParamDirection.In && ownership != Ownership.None) || direction == ParamDirection.InOut)
        throw new Exception("Container " ~ containerType.to!string ~ " parameter with direction "
          ~ direction.to!string ~ " ownership " ~ ownership.to!string ~ " not supported");
    }

    if (containerType == ContainerType.None && kind == TypeKind.Basic && direction == ParamDirection.In
        && cType.countStars > 0 && dType != cType)
      throw new Exception(
          "Basic input parameter type '" ~ dType.to!string ~ "' has unexpected C type '"
          ~ cType.to!string ~ "'");

    if (lengthParamIndex != ArrayNoLengthParam) // Array has a length argument?
    {
      if (lengthParamIndex >= func.params.length)
        throw new Exception("Invalid array length parameter index");

      auto lengthParam = func.params[lengthParamIndex];

      if ((direction == ParamDirection.In && lengthParam.direction == ParamDirection.Out)
          || (direction == ParamDirection.InOut && lengthParam.direction == ParamDirection.Out))
        throw new Exception("Array length parameter direction '" ~ to!string(
            lengthParam.direction) ~ "' is incompatible with array direction '" ~ direction.to!string ~ "'");
    }

    if (closureIndex != NoClosure)
    {
      if (kind != TypeKind.Callback)
        throw new Exception("Non-callback parameter has closure");

      if (closureIndex >= func.params.length)
        throw new Exception("Invalid closure data parameter index");

      auto closureParam = func.params[closureIndex];

      if (closureParam.direction != ParamDirection.In || closureParam.dType != "void*")
        throw new Exception("Closure data should be a void* input parameter");

      auto closureCount = (cast(Func)typeObject).params.count!(x => x.isClosure);
      if (closureCount != 1)
        throw new Exception("Parameter callback must have one closure argument");

      if (destroyIndex != NoDestroy)
      {
        if (destroyIndex >= func.params.length)
          throw new Exception("Invalid destroy notify callback parameter index");

        auto destroyParam = func.params[destroyIndex];

        if (destroyParam.direction != ParamDirection.In || destroyParam.dType != "DestroyNotify")
          throw new Exception("Destroy notify callback should be a DestroyNotify input parameter");
      }
    }
    else if (destroyIndex != NoDestroy)
      throw new Exception("Parameter without a closure has a destroy notify");

    if (auto cb = cast(Func)typeObject)
      if (!isDestroy && !cb.closureParam && scope_ != ParamScope.Call)
        throw new Exception ("Callback parameters with scope '" ~ scope_.to!string
          ~ "' should have a closure parameter");
  }

  private dstring _name; /// Name of parameter
  bool isInstanceParam; /// true if this parameter is the instance parameter
  bool isArrayLength; /// true if this parameter is an array length
  int arrayParamIndex; /// If isArrayLength is true, the parameter index of the array or ParamIndexReturnVal if the array is the return value
  ParamDirection direction; /// Parameter direction
  bool nullable; /// Nullable pointer
  bool optional; /// Optional pointer
  bool allowNone; /// Allow none (FIXME - how does this differ from nullable?)
  bool callerAllocates; /// Caller allocates value
  bool varargs; /// Indicates a parameter is a varargs ... elipsis
  bool isClosure; /// Is this a closure user_data parameter?
  bool isDestroy; /// Is this a destroy notification callback parameter?
  int closureIndex = NoClosure; /// Closure parameter index (user data for a callback parameter)
  int destroyIndex = NoDestroy; /// Destroy parameter index (destroy notify for a callback parameter)
  int callbackIndex = NoCallback; /// If isClosure or isDestroy is true then this is the callback parameter index
  ParamScope scope_; /// Scope of the callback closure data
}

/// Value used for arrayParamIndex to indicate it is the length for the return value
enum ParamIndexReturnVal = -1;

/// Direction of a parameter
enum ParamDirection
{
  In = -1, /// Input direction (not actually found in Gir files, since it is the default unspecified value)
  Out, /// Output direction
  InOut, /// Input and output direction
}

immutable dstring[] ParamDirectionValues = ["out", "inout"];

/// Callback parameter closure data scope (how long it should remain frozen, so that it is not collected)
enum ParamScope
{
  Unset = -1, // FIXME - What should the default be?
  Call, /// For the duration of the function call
  Async, /// Until a single call to the callback function (possibly after the function returns)
  Notified, /// Until the destroy notify function is called
  Forever, /// Should be allocated for the duration of the program
}

immutable dstring[] ParamScopeValues = ["call", "async", "notified", "forever"];

enum NoClosure = -1;
enum NoDestroy = -1;
enum NoCallback = -1;

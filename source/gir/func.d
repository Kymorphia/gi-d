module gir.func;

import gir.type;

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
  First = "first",
  Last = "last",
  Cleanup = "cleanup",
}

class Func
{
  dstring name; /// Name of function
  FuncType funcType; /// Function type
  dstring cType; /// C type name
  dstring cIdentifier; /// C function name
  Type returnValue; /// Return value type
  ArrayInfo returnArray; /// Array info for array return values
  Param[] params; /// Parameters

  dstring version_; /// Version
  dstring shadowedBy; /// Function which shadows this
  dstring shadows; /// Function that this shadows
  dstring invoker; /// Invoker method
  dstring movedTo; /// Function moved to name

  bool deprecated_; /// Deprecated
  dstring deprecatedVersion; /// Deprecated version
  bool introspectable; /// Introspectable?
  bool throws; /// Throws exception?
  bool action; /// Signal action (FIXME)
  bool detailed; /// Signal detailed (FIXME)
  bool noHooks; /// Signal no hooks (FIXME)
  bool noRecurse; /// Signal no recurse (FIXME)
  SignalWhen when; /// Signal when

  dstring sourceFilename; /// Source filename
  uint sourceLine; /// Source line number
  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line number
}

/// Direction of a parameter
enum ParamDirection : dstring
{
  In = "in", /// Input direction (not actually found in Gir files, since it is the default unspecified value)
  Out = "out", /// Output direction
  InOut = "inout", /// Input and output direction
}

/// Parameter scope
enum ParamScope : dstring
{
  Call = "call", /// FIXME
  Async = "async", /// FIXME
  Notified = "notified", /// FIXME
}

/// Function parameter
class Param
{
  dstring name;
  Type type;
  ParamDirection direction;
  Ownership transferOwnership;
  ArrayInfo array;
  bool allowNone;
  bool callerAllocates;
  bool nullable;
  bool optional;
  bool varargs;

  uint closureParam;
  uint destroyParam;
  ParamScope scope_;

  dstring docFilename; /// Documentation filename
  uint docLine; /// Documentation line number
}

module GObject.CClosure;

import GObject.Closure;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GCClosure is a specialization of #GClosure for C function callbacks.
 */
class CClosure
{
  GCClosure cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.CClosure");

    cInstance = *cast(GCClosure*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Closure closure()
  {
    return new Closure(cast(GClosure*)&(cast(GCClosure*)cPtr).closure);
  }

  /**
   * A #GClosureMarshal function for use with signals with handlers that
   * take two boxed pointers as arguments and return a boolean.  If you
   * have such a signal, you will probably also need to use an
   * accumulator, such as [GObject.Global.signalAccumulatorTrueHandled].
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalBOOLEANBOXEDBOXED(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_BOOLEAN__BOXED_BOXED(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with handlers that
   * take a flags type as an argument and return a boolean.  If you have
   * such a signal, you will probably also need to use an accumulator,
   * such as [GObject.Global.signalAccumulatorTrueHandled].
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalBOOLEANFLAGS(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_BOOLEAN__FLAGS(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with handlers that
   * take a #GObject and a pointer and produce a string.  It is highly
   * unlikely that your signal handler fits this description.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalSTRINGOBJECTPOINTER(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_STRING__OBJECT_POINTER(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * boolean argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDBOOLEAN(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__BOOLEAN(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * argument which is any boxed pointer type.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDBOXED(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__BOXED(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * character argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDCHAR(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__CHAR(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with one
   * double-precision floating point argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDDOUBLE(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__DOUBLE(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * argument with an enumerated type.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDENUM(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__ENUM(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * argument with a flags types.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDFLAGS(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__FLAGS(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with one
   * single-precision floating point argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDFLOAT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__FLOAT(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * integer argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDINT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__INT(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with with a single
   * long integer argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDLONG(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__LONG(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * #GObject argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDOBJECT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__OBJECT(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * argument of type #GParamSpec.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDPARAM(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__PARAM(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single raw
   * pointer argument type.
   * If it is possible, it is better to use one of the more specific
   * functions such as g_cclosure_marshal_VOID__OBJECT$(LPAREN)$(RPAREN) or
   * g_cclosure_marshal_VOID__OBJECT$(LPAREN)$(RPAREN).
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDPOINTER(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__POINTER(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single string
   * argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDSTRING(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__STRING(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * unsigned character argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDUCHAR(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__UCHAR(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with with a single
   * unsigned integer argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDUINT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__UINT(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with an unsigned int
   * and a pointer as arguments.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDUINTPOINTER(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__UINT_POINTER(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * unsigned long integer argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDULONG(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__ULONG(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with a single
   * #GVariant argument.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDVARIANT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__VARIANT(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A #GClosureMarshal function for use with signals with no arguments.
   * Params:
   *   closure = A #GClosure.
   *   returnValue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalVOIDVOID(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__VOID(closure ? cast(GClosure*)closure.cPtr(false) : null, returnValue ? cast(GValue*)returnValue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }

  /**
   * A generic marshaller function implemented via
   * [libffi](http://sourceware.org/libffi/).
   * Normally this function is not passed explicitly to [GObject.Global.signalNew],
   * but used automatically by GLib when specifying a %NULL marshaller.
   * Params:
   *   closure = A #GClosure.
   *   returnGvalue = A #GValue to store the return value. May be %NULL
   *     if the callback of closure doesn't return a value.
   *   nParamValues = The length of the param_values array.
   *   paramValues = An array of #GValues holding the arguments
   *     on which to invoke the callback of closure.
   *   invocationHint = The invocation hint given as the last argument to
   *     [GObject.Closure.invoke].
   *   marshalData = Additional data specified when registering the
   *     marshaller, see [GObject.Closure.setMarshal] and
   *     [GObject.Closure.setMetaMarshal]
   */
  static void marshalGeneric(Closure closure, Value returnGvalue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_generic(closure ? cast(GClosure*)closure.cPtr(false) : null, returnGvalue ? cast(GValue*)returnGvalue.cPtr(false) : null, nParamValues, paramValues ? cast(GValue*)paramValues.cPtr(false) : null, invocationHint, marshalData);
  }
}

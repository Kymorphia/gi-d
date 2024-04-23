module GObject.CClosure;

import GLib.c.functions;
import GObject.Closure;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GCClosure))
  {
    return cast(T*)&cInstance;
  }

  @property Closure closure()
  {
    return new Closure(cast(GClosure*)&cPtr!GCClosure.closure);
  }

  /**
   * A #GClosureMarshal function for use with signals with handlers that
   * take two boxed pointers as arguments and return a boolean.  If you
   * have such a signal, you will probably also need to use an
   * accumulator, such as g_signal_accumulator_true_handled().
   */
  static void marshalBOOLEANBOXEDBOXED(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_BOOLEAN__BOXED_BOXED(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `gboolean (*callback) (gpointer instance, gint arg1, gpointer user_data)` where the #gint parameter
   * denotes a flags type.
   */
  static void marshalBOOLEANFLAGS(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_BOOLEAN__FLAGS(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `gchar* (*callback) (gpointer instance, GObject *arg1, gpointer arg2, gpointer user_data)`.
   */
  static void marshalSTRINGOBJECTPOINTER(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_STRING__OBJECT_POINTER(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gboolean arg1, gpointer user_data)`.
   */
  static void marshalVOIDBOOLEAN(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__BOOLEAN(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, GBoxed *arg1, gpointer user_data)`.
   */
  static void marshalVOIDBOXED(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__BOXED(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gchar arg1, gpointer user_data)`.
   */
  static void marshalVOIDCHAR(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__CHAR(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gdouble arg1, gpointer user_data)`.
   */
  static void marshalVOIDDOUBLE(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__DOUBLE(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gint arg1, gpointer user_data)` where the #gint parameter denotes an enumeration type..
   */
  static void marshalVOIDENUM(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__ENUM(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gint arg1, gpointer user_data)` where the #gint parameter denotes a flags type.
   */
  static void marshalVOIDFLAGS(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__FLAGS(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gfloat arg1, gpointer user_data)`.
   */
  static void marshalVOIDFLOAT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__FLOAT(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gint arg1, gpointer user_data)`.
   */
  static void marshalVOIDINT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__INT(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, glong arg1, gpointer user_data)`.
   */
  static void marshalVOIDLONG(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__LONG(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, GObject *arg1, gpointer user_data)`.
   */
  static void marshalVOIDOBJECT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__OBJECT(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, GParamSpec *arg1, gpointer user_data)`.
   */
  static void marshalVOIDPARAM(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__PARAM(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gpointer arg1, gpointer user_data)`.
   */
  static void marshalVOIDPOINTER(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__POINTER(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, const gchar *arg1, gpointer user_data)`.
   */
  static void marshalVOIDSTRING(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__STRING(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, guchar arg1, gpointer user_data)`.
   */
  static void marshalVOIDUCHAR(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__UCHAR(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, guint arg1, gpointer user_data)`.
   */
  static void marshalVOIDUINT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__UINT(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, guint arg1, gpointer arg2, gpointer user_data)`.
   */
  static void marshalVOIDUINTPOINTER(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__UINT_POINTER(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gulong arg1, gpointer user_data)`.
   */
  static void marshalVOIDULONG(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__ULONG(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, GVariant *arg1, gpointer user_data)`.
   */
  static void marshalVOIDVARIANT(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__VARIANT(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A marshaller for a #GCClosure with a callback of type
   * `void (*callback) (gpointer instance, gpointer user_data)`.
   */
  static void marshalVOIDVOID(Closure closure, Value returnValue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_VOID__VOID(closure ? closure.cPtr!GClosure : null, returnValue ? returnValue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }

  /**
   * A generic marshaller function implemented via
   * [libffi](http://sourceware.org/libffi/).
   *
   * Normally this function is not passed explicitly to g_signal_new(),
   * but used automatically by GLib when specifying a %NULL marshaller.
   */
  static void marshalGeneric(Closure closure, Value returnGvalue, uint nParamValues, Value paramValues, void* invocationHint, void* marshalData)
  {
    g_cclosure_marshal_generic(closure ? closure.cPtr!GClosure : null, returnGvalue ? returnGvalue.cPtr!GValue : null, nParamValues, paramValues ? paramValues.cPtr!GValue : null, invocationHint, marshalData);
  }
}

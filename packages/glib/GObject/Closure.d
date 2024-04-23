module GObject.Closure;

import GLib.Boxed;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A #GClosure represents a callback supplied by the programmer.
 *
 * It will generally comprise a function of some kind and a marshaller
 * used to call it. It is the responsibility of the marshaller to
 * convert the arguments for the invocation from #GValues into
 * a suitable form, perform the callback on the converted arguments,
 * and transform the return value back into a #GValue.
 *
 * In the case of C programs, a closure usually just holds a pointer
 * to a function and maybe a data argument, and the marshaller
 * converts between #GValue and native C types. The GObject
 * library provides the #GCClosure type for this purpose. Bindings for
 * other languages need marshallers which convert between #GValues
 * and suitable representations in the runtime of the language in
 * order to use functions written in that language as callbacks. Use
 * g_closure_set_marshal() to set the marshaller on such a custom
 * closure implementation.
 *
 * Within GObject, closures play an important role in the
 * implementation of signals. When a signal is registered, the
 * @c_marshaller argument to g_signal_new() specifies the default C
 * marshaller for any closure which is connected to this
 * signal. GObject provides a number of C marshallers for this
 * purpose, see the g_cclosure_marshal_*() functions. Additional C
 * marshallers can be generated with the [glib-genmarshal][glib-genmarshal]
 * utility.  Closures can be explicitly connected to signals with
 * g_signal_connect_closure(), but it usually more convenient to let
 * GObject create a closure automatically by using one of the
 * g_signal_connect_*() functions which take a callback function/user
 * data pair.
 *
 * Using closures has a number of important advantages over a simple
 * callback function/data pointer combination:
 *
 * - Closures allow the callee to get the types of the callback parameters,
 * which means that language bindings don't have to write individual glue
 * for each callback type.
 *
 * - The reference counting of #GClosure makes it easy to handle reentrancy
 * right; if a callback is removed while it is being invoked, the closure
 * and its parameters won't be freed until the invocation finishes.
 *
 * - g_closure_invalidate() and invalidation notifiers allow callbacks to be
 * automatically removed when the objects they point to go away.
 */
class Closure : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GClosure))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_closure_get_type();
  }

  @property uint inMarshal()
  {
    return cPtr!GClosure.inMarshal;
  }

  @property void inMarshal(uint propval)
  {
    cPtr!GClosure.inMarshal = propval;
  }

  @property uint isInvalid()
  {
    return cPtr!GClosure.isInvalid;
  }

  @property void isInvalid(uint propval)
  {
    cPtr!GClosure.isInvalid = propval;
  }

  alias MarshalFuncType = extern(C) void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData);

  @property MarshalFuncType marshal()
  {
    return cPtr!GClosure.marshal;
  }

  /**
   * a newly allocated #GClosure
   */
  static Closure newObject(uint sizeofClosure, ObjectG object)
  {
    GClosure* _cretval;
    _cretval = g_closure_new_object(sizeofClosure, object ? object.cPtr!ObjectC : null);
    Closure _retval = new Closure(cast(GClosure*)_cretval, true);
    return _retval;
  }

  /**
   * a floating reference to a new #GClosure
   */
  static Closure newSimple(uint sizeofClosure, void* data)
  {
    GClosure* _cretval;
    _cretval = g_closure_new_simple(sizeofClosure, data);
    Closure _retval = new Closure(cast(GClosure*)_cretval, true);
    return _retval;
  }

  /**
   * Sets a flag on the closure to indicate that its calling
   * environment has become invalid, and thus causes any future
   * invocations of g_closure_invoke() on this @closure to be
   * ignored.
   *
   * Also, invalidation notifiers installed on the closure will
   * be called at this point. Note that unless you are holding a
   * reference to the closure yourself, the invalidation notifiers may
   * unref the closure and cause it to be destroyed, so if you need to
   * access the closure after calling g_closure_invalidate(), make sure
   * that you've previously called g_closure_ref().
   *
   * Note that g_closure_invalidate() will also be called when the
   * reference count of a closure drops to zero (unless it has already
   * been invalidated before).
   */
  void invalidate()
  {
    g_closure_invalidate(cPtr!GClosure);
  }

  /**
   * Takes over the initial ownership of a closure.
   *
   * Each closure is initially created in a "floating" state, which means
   * that the initial reference count is not owned by any caller.
   *
   * This function checks to see if the object is still floating, and if so,
   * unsets the floating state and decreases the reference count. If the
   * closure is not floating, g_closure_sink() does nothing.
   *
   * The reason for the existence of the floating state is to prevent
   * cumbersome code sequences like:
   *
   * |[<!-- language="C" -->
   * closure = g_cclosure_new (cb_func, cb_data);
   * g_source_set_closure (source, closure);
   * g_closure_unref (closure); // GObject doesn't really need this
   * ]|
   *
   * Because g_source_set_closure() (and similar functions) take ownership of the
   * initial reference count, if it is unowned, we instead can write:
   *
   * |[<!-- language="C" -->
   * g_source_set_closure (source, g_cclosure_new (cb_func, cb_data));
   * ]|
   *
   * Generally, this function is used together with g_closure_ref(). An example
   * of storing a closure for later notification looks like:
   *
   * |[<!-- language="C" -->
   * static GClosure *notify_closure = NULL;
   * void
   * foo_notify_set_closure (GClosure *closure)
   * {
   * if (notify_closure)
   * g_closure_unref (notify_closure);
   * notify_closure = closure;
   * if (notify_closure)
   * {
   * g_closure_ref (notify_closure);
   * g_closure_sink (notify_closure);
   * }
   * }
   * ]|
   *
   * Because g_closure_sink() may decrement the reference count of a closure
   * (if it hasn't been called on @closure yet) just like g_closure_unref(),
   * g_closure_ref() should be called prior to this function.
   */
  void sink()
  {
    g_closure_sink(cPtr!GClosure);
  }
}

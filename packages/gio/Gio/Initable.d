module Gio.Initable;

public import Gio.InitableIfaceProxy;
import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Parameter;
import GObject.Types;
import Gid.gid;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GInitable` is implemented by objects that can fail during
 * initialization. If an object implements this interface then
 * it must be initialized as the first thing after construction,
 * either via [Gio.Initable.init_] or [Gio.AsyncInitable.initAsync]
 * $(LPAREN)the latter is only available if it also implements [Gio.AsyncInitable]$(RPAREN).
 * If the object is not initialized, or initialization returns with an
 * error, then all operations on the object except `[GObject.ObjectG.ref_]` and
 * `[GObject.ObjectG.unref]` are considered to be invalid, and have undefined
 * behaviour. They will often fail with func@GLib.critical or
 * func@GLib.warning, but this must not be relied on.
 * Users of objects implementing this are not intended to use
 * the interface method directly, instead it will be used automatically
 * in various ways. For C applications you generally just call
 * [Gio.Initable.new_] directly, or indirectly via a `foo_thing_new()` wrapper.
 * This will call [Gio.Initable.init_] under the cover, returning `NULL`
 * and setting a `GError` on failure $(LPAREN)at which point the instance is
 * unreferenced$(RPAREN).
 * For bindings in languages where the native constructor supports
 * exceptions the binding could check for objects implementing `GInitable`
 * during normal construction and automatically initialize them, throwing
 * an exception on failure.
 */
interface Initable
{

  static GType getType()
  {
    return g_initable_get_type();
  }

  /**
   * Helper function for constructing #GInitable object. This is
   * similar to [GObject.ObjectG.newv] but also initializes the object
   * and returns %NULL, setting an error on failure.
   * Params:
   *   objectType = a #GType supporting #GInitable.
   *   parameters = the parameters to use to construct the object
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a newly allocated
   *   #GObject, or %NULL on error

   * Deprecated: Use [GObject.ObjectG.newWithProperties] and
   *   [Gio.Initable.init_] instead. See #GParameter for more information.
   */
  static ObjectG newv(GType objectType, Parameter[] parameters, Cancellable cancellable)
  {
    ObjectC* _cretval;
    uint _nParameters;
    if (parameters)
      _nParameters = cast(uint)parameters.length;

    GParameter[] _tmpparameters;
    foreach (obj; parameters)
      _tmpparameters ~= obj.cInstance;
    GParameter* _parameters = _tmpparameters.ptr;

    GError *_err;
    _cretval = g_initable_newv(objectType, _nParameters, _parameters, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Initializes the object implementing the interface.
   * This method is intended for language bindings. If writing in C,
   * [Gio.Initable.new_] should typically be used instead.
   * The object must be initialized before any real use after initial
   * construction, either with this function or [Gio.AsyncInitable.initAsync].
   * Implementations may also support cancellation. If cancellable is not %NULL,
   * then initialization can be cancelled by triggering the cancellable object
   * from another thread. If the operation was cancelled, the error
   * %G_IO_ERROR_CANCELLED will be returned. If cancellable is not %NULL and
   * the object doesn't support cancellable initialization the error
   * %G_IO_ERROR_NOT_SUPPORTED will be returned.
   * If the object is not initialized, or initialization returns with an
   * error, then all operations on the object except [GObject.ObjectG.ref_] and
   * [GObject.ObjectG.unref] are considered to be invalid, and have undefined
   * behaviour. See the [introduction][ginitable] for more details.
   * Callers should not assume that a class which implements #GInitable can be
   * initialized multiple times, unless the class explicitly documents itself as
   * supporting this. Generally, a class’ implementation of init$(LPAREN)$(RPAREN) can assume
   * $(LPAREN)and assert$(RPAREN) that it will only be called once. Previously, this documentation
   * recommended all #GInitable implementations should be idempotent; that
   * recommendation was relaxed in GLib 2.54.
   * If a class explicitly supports being initialized multiple times, it is
   * recommended that the method is idempotent: multiple calls with the same
   * arguments should return the same results. Only the first call initializes
   * the object; further calls return the result of the first call.
   * One reason why a class might need to support idempotent initialization is if
   * it is designed to be used via the singleton pattern, with a
   * #GObjectClass.constructor that sometimes returns an existing instance.
   * In this pattern, a caller would expect to be able to call [Gio.Initable.init_]
   * on the result of [GObject.ObjectG.new_], regardless of whether it is in fact a new
   * instance.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if successful. If an error has occurred, this function will
   *   return %FALSE and set error appropriately if present.
   */
  bool init_(Cancellable cancellable);
}

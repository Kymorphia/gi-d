module Gio.InitableT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import GObject.Parameter;
public import GObject.Types;
public import Gid.Gid;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GInitable is implemented by objects that can fail during
 * initialization. If an object implements this interface then
 * it must be initialized as the first thing after construction,
 * either via g_initable_init() or g_async_initable_init_async()
 * (the latter is only available if it also implements #GAsyncInitable).
 *
 * If the object is not initialized, or initialization returns with an
 * error, then all operations on the object except g_object_ref() and
 * g_object_unref() are considered to be invalid, and have undefined
 * behaviour. They will often fail with g_critical() or g_warning(), but
 * this must not be relied on.
 *
 * Users of objects implementing this are not intended to use
 * the interface method directly, instead it will be used automatically
 * in various ways. For C applications you generally just call
 * g_initable_new() directly, or indirectly via a foo_thing_new() wrapper.
 * This will call g_initable_init() under the cover, returning %NULL and
 * setting a #GError on failure (at which point the instance is
 * unreferenced).
 *
 * For bindings in languages where the native constructor supports
 * exceptions the binding could check for objects implementing %GInitable
 * during normal construction and automatically initialize them, throwing
 * an exception on failure.
 */
template InitableT(TStruct)
{

  /**
   * a newly allocated
   * #GObject, or %NULL on error
   */
  static ObjectG newv(GType objectType, Parameter[] parameters, Cancellable cancellable)
  {
    ObjectC* _cretval;
    GParameter[] _tmpparameters;
    foreach (obj; parameters)
      _tmpparameters ~= obj.cInstance;
    GParameter* _parameters = _tmpparameters.ptr;

    GError *_err;
    _cretval = g_initable_newv(objectType, parameters ? cast(uint)parameters.length : 0, _parameters, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if successful. If an error has occurred, this function will
   * return %FALSE and set @error appropriately if present.
   */
  override bool init_(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_initable_init(cPtr!GInitable, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

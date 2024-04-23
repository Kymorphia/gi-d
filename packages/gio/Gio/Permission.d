module Gio.Permission;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GPermission represents the status of the caller's permission to
 * perform a certain action.
 *
 * You can query if the action is currently allowed and if it is
 * possible to acquire the permission so that the action will be allowed
 * in the future.
 *
 * There is also an API to actually acquire the permission and one to
 * release it.
 *
 * As an example, a #GPermission might represent the ability for the
 * user to write to a #GSettings object.  This #GPermission object could
 * then be used to decide if it is appropriate to show a "Click here to
 * unlock" button in a dialog and to provide the mechanism to invoke
 * when that button is clicked.
 */
class Permission : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_permission_get_type();
  }

  /**
   * %TRUE if the permission was successfully acquired
   */
  bool acquire(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_permission_acquire(cPtr!GPermission, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Attempts to acquire the permission represented by @permission.
   *
   * This is the first half of the asynchronous version of
   * g_permission_acquire().
   */
  void acquireAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_permission_acquire_async(cPtr!GPermission, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the permission was successfully acquired
   */
  bool acquireFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_permission_acquire_finish(cPtr!GPermission, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the value of the 'allowed' property
   */
  bool getAllowed()
  {
    bool _retval;
    _retval = g_permission_get_allowed(cPtr!GPermission);
    return _retval;
  }

  /**
   * the value of the 'can-acquire' property
   */
  bool getCanAcquire()
  {
    bool _retval;
    _retval = g_permission_get_can_acquire(cPtr!GPermission);
    return _retval;
  }

  /**
   * the value of the 'can-release' property
   */
  bool getCanRelease()
  {
    bool _retval;
    _retval = g_permission_get_can_release(cPtr!GPermission);
    return _retval;
  }

  /**
   * This function is called by the #GPermission implementation to update
   * the properties of the permission.  You should never call this
   * function except from a #GPermission implementation.
   *
   * GObject notify signals are generated, as appropriate.
   */
  void implUpdate(bool allowed, bool canAcquire, bool canRelease)
  {
    g_permission_impl_update(cPtr!GPermission, allowed, canAcquire, canRelease);
  }

  /**
   * %TRUE if the permission was successfully released
   */
  bool release(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_permission_release(cPtr!GPermission, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Attempts to release the permission represented by @permission.
   *
   * This is the first half of the asynchronous version of
   * g_permission_release().
   */
  void releaseAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_permission_release_async(cPtr!GPermission, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the permission was successfully released
   */
  bool releaseFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_permission_release_finish(cPtr!GPermission, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

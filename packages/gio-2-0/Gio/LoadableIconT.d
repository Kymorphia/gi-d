module Gio.LoadableIconT;

public import Gio.LoadableIconIfaceProxy;
public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.AsyncResult;
public import Gio.AsyncResultT;
public import Gio.Cancellable;
public import Gio.InputStream;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GLoadableIcon` extends the [Gio.Icon] interface and adds the ability
 * to load icons from streams.
 */
template LoadableIconT()
{

  /**
   * Loads a loadable icon. For the asynchronous version of this function,
   * see [Gio.LoadableIcon.loadAsync].
   * Params:
   *   size = an integer.
   *   type = a location to store the type of the loaded
   *     icon, %NULL to ignore.
   *   cancellable = optional #GCancellable object, %NULL to
   *     ignore.
   * Returns: a #GInputStream to read the icon from.
   */
  override InputStream load(int size, out string type, Cancellable cancellable)
  {
    GInputStream* _cretval;
    char* _type;
    GError *_err;
    _cretval = g_loadable_icon_load(cast(GLoadableIcon*)cPtr, size, &_type, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true) : null;
    type = _type.fromCString(true);
    return _retval;
  }

  /**
   * Loads an icon asynchronously. To finish this function, see
   * [Gio.LoadableIcon.loadFinish]. For the synchronous, blocking
   * version of this function, see [Gio.LoadableIcon.load].
   * Params:
   *   size = an integer.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  override void loadAsync(int size, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_loadable_icon_load_async(cast(GLoadableIcon*)cPtr, size, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous icon load started in [Gio.LoadableIcon.loadAsync].
   * Params:
   *   res = a #GAsyncResult.
   *   type = a location to store the type of the loaded
   *     icon, %NULL to ignore.
   * Returns: a #GInputStream to read the icon from.
   */
  override InputStream loadFinish(AsyncResult res, out string type)
  {
    GInputStream* _cretval;
    char* _type;
    GError *_err;
    _cretval = g_loadable_icon_load_finish(cast(GLoadableIcon*)cPtr, res ? cast(GAsyncResult*)(cast(ObjectG)res).cPtr(false) : null, &_type, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true) : null;
    type = _type.fromCString(true);
    return _retval;
  }
}

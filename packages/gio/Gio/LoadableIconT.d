module Gio.LoadableIconT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.InputStream;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * Extends the #GIcon interface and adds the ability to
 * load icons from streams.
 */
template LoadableIconT(TStruct)
{

  /**
   * a #GInputStream to read the icon from.
   */
  override InputStream load(int size, out string type, Cancellable cancellable)
  {
    GInputStream* _cretval;
    char* _type;
    GError *_err;
    _cretval = g_loadable_icon_load(cPtr!GLoadableIcon, size, &_type, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true);
    type = _type.fromCString(true);
    return _retval;
  }

  /**
   * Loads an icon asynchronously. To finish this function, see
   * g_loadable_icon_load_finish(). For the synchronous, blocking
   * version of this function, see g_loadable_icon_load().
   */
  override void loadAsync(int size, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_loadable_icon_load_async(cPtr!GLoadableIcon, size, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GInputStream to read the icon from.
   */
  override InputStream loadFinish(AsyncResult res, out string type)
  {
    GInputStream* _cretval;
    char* _type;
    GError *_err;
    _cretval = g_loadable_icon_load_finish(cPtr!GLoadableIcon, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_type, &_err);
    if (_err)
      throw new ErrorG(_err);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true);
    type = _type.fromCString(true);
    return _retval;
  }
}

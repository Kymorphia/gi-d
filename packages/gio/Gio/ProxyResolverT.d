module Gio.ProxyResolverT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GProxyResolver provides synchronous and asynchronous network proxy
 * resolution. #GProxyResolver is used within #GSocketClient through
 * the method g_socket_connectable_proxy_enumerate().
 *
 * Implementations of #GProxyResolver based on libproxy and GNOME settings can
 * be found in glib-networking. GIO comes with an implementation for use inside
 * Flatpak portals.
 */
template ProxyResolverT(TStruct)
{

  /**
   * the default #GProxyResolver, which
   * will be a dummy object if no proxy resolver is available
   */
  static ProxyResolver getDefault()
  {
    GProxyResolver* _cretval;
    _cretval = g_proxy_resolver_get_default();
    ProxyResolver _retval = ObjectG.getDObject!ProxyResolver(cast(GProxyResolver*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if @resolver is supported.
   */
  override bool isSupported()
  {
    bool _retval;
    _retval = g_proxy_resolver_is_supported(cPtr!GProxyResolver);
    return _retval;
  }

  /**
   * A
   * NULL-terminated array of proxy URIs. Must be freed
   * with g_strfreev().
   */
  override string[] lookup(string uri, Cancellable cancellable)
  {
    char** _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_proxy_resolver_lookup(cPtr!GProxyResolver, _uri, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Asynchronous lookup of proxy. See g_proxy_resolver_lookup() for more
   * details.
   */
  override void lookupAsync(string uri, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _uri = uri.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_proxy_resolver_lookup_async(cPtr!GProxyResolver, _uri, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * A
   * NULL-terminated array of proxy URIs. Must be freed
   * with g_strfreev().
   */
  override string[] lookupFinish(AsyncResult result)
  {
    char** _cretval;
    GError *_err;
    _cretval = g_proxy_resolver_lookup_finish(cPtr!GProxyResolver, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }
}

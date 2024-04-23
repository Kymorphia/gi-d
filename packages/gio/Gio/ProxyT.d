module Gio.ProxyT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.IOStream;
public import Gio.ProxyAddress;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * A #GProxy handles connecting to a remote host via a given type of
 * proxy server. It is implemented by the 'gio-proxy' extension point.
 * The extensions are named after their proxy protocol name. As an
 * example, a SOCKS5 proxy implementation can be retrieved with the
 * name 'socks5' using the function
 * g_io_extension_point_get_extension_by_name().
 */
template ProxyT(TStruct)
{

  /**
   * return a #GProxy or NULL if protocol
   * is not supported.
   */
  static Proxy getDefaultForProtocol(string protocol)
  {
    GProxy* _cretval;
    const(char)* _protocol = protocol.toCString(false);
    _cretval = g_proxy_get_default_for_protocol(_protocol);
    Proxy _retval = ObjectG.getDObject!Proxy(cast(GProxy*)_cretval, true);
    return _retval;
  }

  /**
   * a #GIOStream that will replace @connection. This might
   * be the same as @connection, in which case a reference
   * will be added.
   */
  override IOStream connect(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable)
  {
    GIOStream* _cretval;
    GError *_err;
    _cretval = g_proxy_connect(cPtr!GProxy, connection ? connection.cPtr!GIOStream : null, proxyAddress ? proxyAddress.cPtr!GProxyAddress : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    IOStream _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronous version of g_proxy_connect().
   */
  override void connectAsync(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_proxy_connect_async(cPtr!GProxy, connection ? connection.cPtr!GIOStream : null, proxyAddress ? proxyAddress.cPtr!GProxyAddress : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GIOStream.
   */
  override IOStream connectFinish(AsyncResult result)
  {
    GIOStream* _cretval;
    GError *_err;
    _cretval = g_proxy_connect_finish(cPtr!GProxy, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    IOStream _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if hostname resolution is supported.
   */
  override bool supportsHostname()
  {
    bool _retval;
    _retval = g_proxy_supports_hostname(cPtr!GProxy);
    return _retval;
  }
}

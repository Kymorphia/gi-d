module Gio.Proxy;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.ProxyAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GProxy handles connecting to a remote host via a given type of
 * proxy server. It is implemented by the 'gio-proxy' extension point.
 * The extensions are named after their proxy protocol name. As an
 * example, a SOCKS5 proxy implementation can be retrieved with the
 * name 'socks5' using the function
 * g_io_extension_point_get_extension_by_name().
 */
interface Proxy
{

  static GType getType()
  {
    return g_proxy_get_type();
  }

  /**
   * return a #GProxy or NULL if protocol
   * is not supported.
   */
  static Proxy getDefaultForProtocol(string protocol);

  /**
   * a #GIOStream that will replace @connection. This might
   * be the same as @connection, in which case a reference
   * will be added.
   */
  IOStream connect(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable);

  /**
   * Asynchronous version of g_proxy_connect().
   */
  void connectAsync(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a #GIOStream.
   */
  IOStream connectFinish(AsyncResult result);

  /**
   * %TRUE if hostname resolution is supported.
   */
  bool supportsHostname();
}

module Gio.ProxyResolver;

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
 * #GProxyResolver provides synchronous and asynchronous network proxy
 * resolution. #GProxyResolver is used within #GSocketClient through
 * the method g_socket_connectable_proxy_enumerate().
 *
 * Implementations of #GProxyResolver based on libproxy and GNOME settings can
 * be found in glib-networking. GIO comes with an implementation for use inside
 * Flatpak portals.
 */
interface ProxyResolver
{

  static GType getType()
  {
    return g_proxy_resolver_get_type();
  }

  /**
   * the default #GProxyResolver, which
   * will be a dummy object if no proxy resolver is available
   */
  static ProxyResolver getDefault();

  /**
   * %TRUE if @resolver is supported.
   */
  bool isSupported();

  /**
   * A
   * NULL-terminated array of proxy URIs. Must be freed
   * with g_strfreev().
   */
  string[] lookup(string uri, Cancellable cancellable);

  /**
   * Asynchronous lookup of proxy. See g_proxy_resolver_lookup() for more
   * details.
   */
  void lookupAsync(string uri, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * A
   * NULL-terminated array of proxy URIs. Must be freed
   * with g_strfreev().
   */
  string[] lookupFinish(AsyncResult result);
}

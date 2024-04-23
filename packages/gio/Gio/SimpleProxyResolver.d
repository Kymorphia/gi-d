module Gio.SimpleProxyResolver;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.ProxyResolver;
import Gio.ProxyResolverT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSimpleProxyResolver is a simple #GProxyResolver implementation
 * that handles a single default proxy, multiple URI-scheme-specific
 * proxies, and a list of hosts that proxies should not be used for.
 *
 * #GSimpleProxyResolver is never the default proxy resolver, but it
 * can be used as the base class for another proxy resolver
 * implementation, or it can be created and used manually, such as
 * with g_socket_client_set_proxy_resolver().
 */
class SimpleProxyResolver : ObjectG, ProxyResolver
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_simple_proxy_resolver_get_type();
  }

  mixin ProxyResolverT!GSimpleProxyResolver;

  /**
   * a new #GSimpleProxyResolver
   */
  static ProxyResolver new_(string defaultProxy, string[] ignoreHosts)
  {
    GProxyResolver* _cretval;
    const(char)* _defaultProxy = defaultProxy.toCString(false);
    char*[] _tmpignoreHosts;
    foreach (s; ignoreHosts)
      _tmpignoreHosts ~= s.toCString(false);
    _tmpignoreHosts ~= null;
    char** _ignoreHosts = _tmpignoreHosts.ptr;
    _cretval = g_simple_proxy_resolver_new(_defaultProxy, _ignoreHosts);
    ProxyResolver _retval = ObjectG.getDObject!ProxyResolver(cast(GProxyResolver*)_cretval, true);
    return _retval;
  }

  /**
   * Sets the default proxy on @resolver, to be used for any URIs that
   * don't match #GSimpleProxyResolver:ignore-hosts or a proxy set
   * via g_simple_proxy_resolver_set_uri_proxy().
   *
   * If @default_proxy starts with "socks://",
   * #GSimpleProxyResolver will treat it as referring to all three of
   * the socks5, socks4a, and socks4 proxy types.
   */
  void setDefaultProxy(string defaultProxy)
  {
    const(char)* _defaultProxy = defaultProxy.toCString(false);
    g_simple_proxy_resolver_set_default_proxy(cPtr!GSimpleProxyResolver, _defaultProxy);
  }

  /**
   * Sets the list of ignored hosts.
   *
   * See #GSimpleProxyResolver:ignore-hosts for more details on how the
   * @ignore_hosts argument is interpreted.
   */
  void setIgnoreHosts(string[] ignoreHosts)
  {
    char*[] _tmpignoreHosts;
    foreach (s; ignoreHosts)
      _tmpignoreHosts ~= s.toCString(false);
    _tmpignoreHosts ~= null;
    char** _ignoreHosts = _tmpignoreHosts.ptr;
    g_simple_proxy_resolver_set_ignore_hosts(cPtr!GSimpleProxyResolver, _ignoreHosts);
  }

  /**
   * Adds a URI-scheme-specific proxy to @resolver; URIs whose scheme
   * matches @uri_scheme (and which don't match
   * #GSimpleProxyResolver:ignore-hosts) will be proxied via @proxy.
   *
   * As with #GSimpleProxyResolver:default-proxy, if @proxy starts with
   * "socks://", #GSimpleProxyResolver will treat it
   * as referring to all three of the socks5, socks4a, and socks4 proxy
   * types.
   */
  void setUriProxy(string uriScheme, string proxy)
  {
    const(char)* _uriScheme = uriScheme.toCString(false);
    const(char)* _proxy = proxy.toCString(false);
    g_simple_proxy_resolver_set_uri_proxy(cPtr!GSimpleProxyResolver, _uriScheme, _proxy);
  }
}

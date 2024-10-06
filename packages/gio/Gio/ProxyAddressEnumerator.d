module Gio.ProxyAddressEnumerator;

import Gid.gid;
import Gio.SocketAddressEnumerator;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GProxyAddressEnumerator` is a wrapper around
 * [Gio.SocketAddressEnumerator] which takes the [Gio.SocketAddress]
 * instances returned by the [Gio.SocketAddressEnumerator]
 * and wraps them in [Gio.ProxyAddress] instances, using the given
 * property@Gio.ProxyAddressEnumerator:proxy-resolver.
 * This enumerator will be returned $(LPAREN)for example, by
 * [Gio.SocketConnectable.enumerate]$(RPAREN) as appropriate when a proxy is
 * configured; there should be no need to manually wrap a
 * [Gio.SocketAddressEnumerator] instance with one.
 */
class ProxyAddressEnumerator : SocketAddressEnumerator
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_proxy_address_enumerator_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

module Gio.ProxyAddressEnumerator;

import Gid.Gid;
import Gio.SocketAddressEnumerator;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GProxyAddressEnumerator is a wrapper around #GSocketAddressEnumerator which
 * takes the #GSocketAddress instances returned by the #GSocketAddressEnumerator
 * and wraps them in #GProxyAddress instances, using the given
 * #GProxyAddressEnumerator:proxy-resolver.
 *
 * This enumerator will be returned (for example, by
 * g_socket_connectable_enumerate()) as appropriate when a proxy is configured;
 * there should be no need to manually wrap a #GSocketAddressEnumerator instance
 * with one.
 */
class ProxyAddressEnumerator : SocketAddressEnumerator
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_proxy_address_enumerator_get_type();
  }
}

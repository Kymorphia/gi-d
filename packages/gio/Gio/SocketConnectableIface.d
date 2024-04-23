module Gio.SocketConnectableIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.SocketAddressEnumerator;
import Gio.SocketConnectable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for returning a #GSocketAddressEnumerator
 * and #GProxyAddressEnumerator
 */
class SocketConnectableIface
{
  GSocketConnectableIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketConnectableIface");

    cInstance = *cast(GSocketConnectableIface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketConnectableIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GSocketConnectableIface.gIface);
  }

  alias EnumerateFuncType = extern(C) GSocketAddressEnumerator* function(GSocketConnectable* connectable);

  @property EnumerateFuncType enumerate()
  {
    return cPtr!GSocketConnectableIface.enumerate;
  }

  alias ProxyEnumerateFuncType = extern(C) GSocketAddressEnumerator* function(GSocketConnectable* connectable);

  @property ProxyEnumerateFuncType proxyEnumerate()
  {
    return cPtr!GSocketConnectableIface.proxyEnumerate;
  }

  alias ToStringFuncType = extern(C) char* function(GSocketConnectable* connectable);

  @property ToStringFuncType toString_()
  {
    return cPtr!GSocketConnectableIface.toString_;
  }
}

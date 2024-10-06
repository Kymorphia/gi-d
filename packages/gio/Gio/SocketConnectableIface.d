module Gio.SocketConnectableIface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GSocketConnectableIface*)cPtr).gIface);
  }

  alias EnumerateFuncType = extern(C) GSocketAddressEnumerator* function(GSocketConnectable* connectable);

  @property EnumerateFuncType enumerate()
  {
    return (cast(GSocketConnectableIface*)cPtr).enumerate;
  }

  alias ProxyEnumerateFuncType = extern(C) GSocketAddressEnumerator* function(GSocketConnectable* connectable);

  @property ProxyEnumerateFuncType proxyEnumerate()
  {
    return (cast(GSocketConnectableIface*)cPtr).proxyEnumerate;
  }

  alias ToStringFuncType = extern(C) char* function(GSocketConnectable* connectable);

  @property ToStringFuncType toString_()
  {
    return (cast(GSocketConnectableIface*)cPtr).toString_;
  }
}

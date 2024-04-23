module Gio.ProxyAddressClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.InetSocketAddressClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GProxyAddress.
 */
class ProxyAddressClass
{
  GProxyAddressClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ProxyAddressClass");

    cInstance = *cast(GProxyAddressClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GProxyAddressClass))
  {
    return cast(T*)&cInstance;
  }

  @property InetSocketAddressClass parentClass()
  {
    return new InetSocketAddressClass(cast(GInetSocketAddressClass*)&cPtr!GProxyAddressClass.parentClass);
  }
}

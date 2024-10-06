module Gio.ProxyAddressClass;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property InetSocketAddressClass parentClass()
  {
    return new InetSocketAddressClass(cast(GInetSocketAddressClass*)&(cast(GProxyAddressClass*)cPtr).parentClass);
  }
}

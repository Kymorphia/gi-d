module Gio.ProxyAddressEnumeratorClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GProxyAddressEnumerator.
 */
class ProxyAddressEnumeratorClass
{
  GProxyAddressEnumeratorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ProxyAddressEnumeratorClass");

    cInstance = *cast(GProxyAddressEnumeratorClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GProxyAddressEnumeratorClass))
  {
    return cast(T*)&cInstance;
  }
}

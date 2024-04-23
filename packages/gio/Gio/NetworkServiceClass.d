module Gio.NetworkServiceClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

class NetworkServiceClass
{
  GNetworkServiceClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.NetworkServiceClass");

    cInstance = *cast(GNetworkServiceClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GNetworkServiceClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GNetworkServiceClass.parentClass);
  }
}

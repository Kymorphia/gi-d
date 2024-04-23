module Gio.InetSocketAddressClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.SocketAddressClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class InetSocketAddressClass
{
  GInetSocketAddressClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.InetSocketAddressClass");

    cInstance = *cast(GInetSocketAddressClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GInetSocketAddressClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketAddressClass parentClass()
  {
    return new SocketAddressClass(cast(GSocketAddressClass*)&cPtr!GInetSocketAddressClass.parentClass);
  }
}

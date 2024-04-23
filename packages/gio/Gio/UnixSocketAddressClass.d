module Gio.UnixSocketAddressClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.SocketAddressClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class UnixSocketAddressClass
{
  GUnixSocketAddressClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.UnixSocketAddressClass");

    cInstance = *cast(GUnixSocketAddressClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GUnixSocketAddressClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketAddressClass parentClass()
  {
    return new SocketAddressClass(cast(GSocketAddressClass*)&cPtr!GUnixSocketAddressClass.parentClass);
  }
}

module Gio.UnixConnectionClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.SocketConnectionClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class UnixConnectionClass
{
  GUnixConnectionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.UnixConnectionClass");

    cInstance = *cast(GUnixConnectionClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GUnixConnectionClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketConnectionClass parentClass()
  {
    return new SocketConnectionClass(cast(GSocketConnectionClass*)&cPtr!GUnixConnectionClass.parentClass);
  }
}

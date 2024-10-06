module Gio.UnixConnectionClass;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property SocketConnectionClass parentClass()
  {
    return new SocketConnectionClass(cast(GSocketConnectionClass*)&(cast(GUnixConnectionClass*)cPtr).parentClass);
  }
}

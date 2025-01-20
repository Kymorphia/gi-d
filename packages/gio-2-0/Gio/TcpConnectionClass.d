module Gio.TcpConnectionClass;

import Gid.gid;
import Gio.SocketConnectionClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class TcpConnectionClass
{
  GTcpConnectionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TcpConnectionClass");

    cInstance = *cast(GTcpConnectionClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property SocketConnectionClass parentClass()
  {
    return new SocketConnectionClass(cast(GSocketConnectionClass*)&(cast(GTcpConnectionClass*)cPtr).parentClass);
  }
}

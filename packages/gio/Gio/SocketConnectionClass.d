module Gio.SocketConnectionClass;

import Gid.gid;
import Gio.IOStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class SocketConnectionClass
{
  GSocketConnectionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketConnectionClass");

    cInstance = *cast(GSocketConnectionClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property IOStreamClass parentClass()
  {
    return new IOStreamClass(cast(GIOStreamClass*)&(cast(GSocketConnectionClass*)cPtr).parentClass);
  }
}

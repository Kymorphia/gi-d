module Gio.SocketClientClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class SocketClientClass
{
  GSocketClientClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketClientClass");

    cInstance = *cast(GSocketClientClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GSocketClientClass*)cPtr).parentClass);
  }

  alias EventFuncType = extern(C) void function(GSocketClient* client, GSocketClientEvent event, GSocketConnectable* connectable, GIOStream* connection);

  @property EventFuncType event()
  {
    return (cast(GSocketClientClass*)cPtr).event;
  }
}

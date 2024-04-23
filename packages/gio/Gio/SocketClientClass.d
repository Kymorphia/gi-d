module Gio.SocketClientClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.IOStream;
import Gio.SocketClient;
import Gio.SocketConnectable;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketClientClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GSocketClientClass.parentClass);
  }

  alias EventFuncType = extern(C) void function(GSocketClient* client, GSocketClientEvent event, GSocketConnectable* connectable, GIOStream* connection);

  @property EventFuncType event()
  {
    return cPtr!GSocketClientClass.event;
  }
}

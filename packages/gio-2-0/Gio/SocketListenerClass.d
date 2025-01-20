module Gio.SocketListenerClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GSocketListener.
 */
class SocketListenerClass
{
  GSocketListenerClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketListenerClass");

    cInstance = *cast(GSocketListenerClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GSocketListenerClass*)cPtr).parentClass);
  }

  alias ChangedFuncType = extern(C) void function(GSocketListener* listener);

  @property ChangedFuncType changed()
  {
    return (cast(GSocketListenerClass*)cPtr).changed;
  }

  alias EventFuncType = extern(C) void function(GSocketListener* listener, GSocketListenerEvent event, GSocket* socket);

  @property EventFuncType event()
  {
    return (cast(GSocketListenerClass*)cPtr).event;
  }
}

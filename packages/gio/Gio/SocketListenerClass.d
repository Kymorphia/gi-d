module Gio.SocketListenerClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.Socket;
import Gio.SocketListener;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketListenerClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GSocketListenerClass.parentClass);
  }

  alias ChangedFuncType = extern(C) void function(GSocketListener* listener);

  @property ChangedFuncType changed()
  {
    return cPtr!GSocketListenerClass.changed;
  }

  alias EventFuncType = extern(C) void function(GSocketListener* listener, GSocketListenerEvent event, GSocket* socket);

  @property EventFuncType event()
  {
    return cPtr!GSocketListenerClass.event;
  }
}

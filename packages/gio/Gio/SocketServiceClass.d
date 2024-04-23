module Gio.SocketServiceClass;

import GLib.c.functions;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.SocketConnection;
import Gio.SocketListenerClass;
import Gio.SocketService;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GSocketService.
 */
class SocketServiceClass
{
  GSocketServiceClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketServiceClass");

    cInstance = *cast(GSocketServiceClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketServiceClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketListenerClass parentClass()
  {
    return new SocketListenerClass(cast(GSocketListenerClass*)&cPtr!GSocketServiceClass.parentClass);
  }

  alias IncomingFuncType = extern(C) bool function(GSocketService* service, GSocketConnection* connection, ObjectC* sourceObject);

  @property IncomingFuncType incoming()
  {
    return cPtr!GSocketServiceClass.incoming;
  }
}

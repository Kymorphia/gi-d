module Gio.ThreadedSocketServiceClass;

import GLib.c.functions;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.SocketConnection;
import Gio.SocketServiceClass;
import Gio.ThreadedSocketService;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class ThreadedSocketServiceClass
{
  GThreadedSocketServiceClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ThreadedSocketServiceClass");

    cInstance = *cast(GThreadedSocketServiceClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GThreadedSocketServiceClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketServiceClass parentClass()
  {
    return new SocketServiceClass(cast(GSocketServiceClass*)&cPtr!GThreadedSocketServiceClass.parentClass);
  }

  alias RunFuncType = extern(C) bool function(GThreadedSocketService* service, GSocketConnection* connection, ObjectC* sourceObject);

  @property RunFuncType run()
  {
    return cPtr!GThreadedSocketServiceClass.run;
  }
}

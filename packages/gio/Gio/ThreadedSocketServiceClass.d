module Gio.ThreadedSocketServiceClass;

import Gid.gid;
import Gio.SocketServiceClass;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property SocketServiceClass parentClass()
  {
    return new SocketServiceClass(cast(GSocketServiceClass*)&(cast(GThreadedSocketServiceClass*)cPtr).parentClass);
  }

  alias RunFuncType = extern(C) bool function(GThreadedSocketService* service, GSocketConnection* connection, ObjectC* sourceObject);

  @property RunFuncType run()
  {
    return (cast(GThreadedSocketServiceClass*)cPtr).run;
  }
}

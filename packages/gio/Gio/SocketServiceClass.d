module Gio.SocketServiceClass;

import Gid.gid;
import Gio.SocketListenerClass;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property SocketListenerClass parentClass()
  {
    return new SocketListenerClass(cast(GSocketListenerClass*)&(cast(GSocketServiceClass*)cPtr).parentClass);
  }

  alias IncomingFuncType = extern(C) bool function(GSocketService* service, GSocketConnection* connection, ObjectC* sourceObject);

  @property IncomingFuncType incoming()
  {
    return (cast(GSocketServiceClass*)cPtr).incoming;
  }
}

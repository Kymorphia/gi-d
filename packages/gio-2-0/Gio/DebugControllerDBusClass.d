module Gio.DebugControllerDBusClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GDebugControllerDBus.
 */
class DebugControllerDBusClass
{
  GDebugControllerDBusClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DebugControllerDBusClass");

    cInstance = *cast(GDebugControllerDBusClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GDebugControllerDBusClass*)cPtr).parentClass);
  }

  alias AuthorizeFuncType = extern(C) bool function(GDebugControllerDBus* controller, GDBusMethodInvocation* invocation);

  @property AuthorizeFuncType authorize()
  {
    return (cast(GDebugControllerDBusClass*)cPtr).authorize;
  }
}

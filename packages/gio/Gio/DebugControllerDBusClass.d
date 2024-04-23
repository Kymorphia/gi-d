module Gio.DebugControllerDBusClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.DBusMethodInvocation;
import Gio.DebugControllerDBus;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDebugControllerDBusClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GDebugControllerDBusClass.parentClass);
  }

  alias AuthorizeFuncType = extern(C) bool function(GDebugControllerDBus* controller, GDBusMethodInvocation* invocation);

  @property AuthorizeFuncType authorize()
  {
    return cPtr!GDebugControllerDBusClass.authorize;
  }
}

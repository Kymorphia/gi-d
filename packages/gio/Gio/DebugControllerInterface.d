module Gio.DebugControllerInterface;

import GLib.c.functions;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GDebugController.
 */
class DebugControllerInterface
{
  GDebugControllerInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DebugControllerInterface");

    cInstance = *cast(GDebugControllerInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDebugControllerInterface))
  {
    return cast(T*)&cInstance;
  }
}

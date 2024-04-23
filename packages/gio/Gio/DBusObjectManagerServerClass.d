module Gio.DBusObjectManagerServerClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GDBusObjectManagerServer.
 */
class DBusObjectManagerServerClass
{
  GDBusObjectManagerServerClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusObjectManagerServerClass");

    cInstance = *cast(GDBusObjectManagerServerClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusObjectManagerServerClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GDBusObjectManagerServerClass.parentClass);
  }
}

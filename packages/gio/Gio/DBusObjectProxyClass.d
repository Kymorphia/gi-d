module Gio.DBusObjectProxyClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GDBusObjectProxy.
 */
class DBusObjectProxyClass
{
  GDBusObjectProxyClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusObjectProxyClass");

    cInstance = *cast(GDBusObjectProxyClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusObjectProxyClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GDBusObjectProxyClass.parentClass);
  }
}

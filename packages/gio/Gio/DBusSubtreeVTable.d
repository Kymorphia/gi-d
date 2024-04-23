module Gio.DBusSubtreeVTable;

import GLib.c.functions;
import Gid.Gid;
import Gio.DBusConnection;
import Gio.DBusInterfaceInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Virtual table for handling subtrees registered with g_dbus_connection_register_subtree().
 */
class DBusSubtreeVTable
{
  GDBusSubtreeVTable cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusSubtreeVTable");

    cInstance = *cast(GDBusSubtreeVTable*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusSubtreeVTable))
  {
    return cast(T*)&cInstance;
  }

  @property GDBusSubtreeEnumerateFunc enumerate()
  {
    return cPtr!GDBusSubtreeVTable.enumerate;
  }

  @property void enumerate(GDBusSubtreeEnumerateFunc propval)
  {
    cPtr!GDBusSubtreeVTable.enumerate = propval;
  }

  @property GDBusSubtreeIntrospectFunc introspect()
  {
    return cPtr!GDBusSubtreeVTable.introspect;
  }

  @property void introspect(GDBusSubtreeIntrospectFunc propval)
  {
    cPtr!GDBusSubtreeVTable.introspect = propval;
  }
}

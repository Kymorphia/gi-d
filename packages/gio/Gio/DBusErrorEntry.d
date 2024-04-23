module Gio.DBusErrorEntry;

import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Struct used in g_dbus_error_register_error_domain().
 */
class DBusErrorEntry
{
  GDBusErrorEntry cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusErrorEntry");

    cInstance = *cast(GDBusErrorEntry*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusErrorEntry))
  {
    return cast(T*)&cInstance;
  }

  @property int errorCode()
  {
    return cPtr!GDBusErrorEntry.errorCode;
  }

  @property void errorCode(int propval)
  {
    cPtr!GDBusErrorEntry.errorCode = propval;
  }

  @property string dbusErrorName()
  {
    return cPtr!GDBusErrorEntry.dbusErrorName.fromCString(false);
  }

  @property void dbusErrorName(string propval)
  {
    g_free(cast(void*)cPtr!GDBusErrorEntry.dbusErrorName);
    cPtr!GDBusErrorEntry.dbusErrorName = propval.toCString(true);
  }
}

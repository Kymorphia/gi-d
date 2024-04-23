module Gio.DBusSignalInfo;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a signal on a D-Bus interface.
 */
class DBusSignalInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDBusSignalInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_signal_info_get_type();
  }

  @property int refCount()
  {
    return cPtr!GDBusSignalInfo.refCount;
  }

  @property void refCount(int propval)
  {
    cPtr!GDBusSignalInfo.refCount = propval;
  }

  @property string name()
  {
    return cPtr!GDBusSignalInfo.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GDBusSignalInfo.name);
    cPtr!GDBusSignalInfo.name = propval.toCString(true);
  }
}

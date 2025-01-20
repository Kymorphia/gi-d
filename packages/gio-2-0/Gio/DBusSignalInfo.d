module Gio.DBusSignalInfo;

import GLib.Boxed;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a signal on a D-Bus interface.
 */
class DBusSignalInfo : Boxed
{

  this()
  {
    super(safeMalloc(GDBusSignalInfo.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_signal_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int refCount()
  {
    return (cast(GDBusSignalInfo*)cPtr).refCount;
  }

  @property void refCount(int propval)
  {
    (cast(GDBusSignalInfo*)cPtr).refCount = propval;
  }

  @property string name()
  {
    return (cast(GDBusSignalInfo*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GDBusSignalInfo*)cPtr).name);
    (cast(GDBusSignalInfo*)cPtr).name = propval.toCString(true);
  }
}

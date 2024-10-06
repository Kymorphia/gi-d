module Gio.DBusMethodInfo;

import GLib.Boxed;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a method on an D-Bus interface.
 */
class DBusMethodInfo : Boxed
{

  this()
  {
    super(safeMalloc(GDBusMethodInfo.sizeof), true);
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
    return g_dbus_method_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int refCount()
  {
    return (cast(GDBusMethodInfo*)cPtr).refCount;
  }

  @property void refCount(int propval)
  {
    (cast(GDBusMethodInfo*)cPtr).refCount = propval;
  }

  @property string name()
  {
    return (cast(GDBusMethodInfo*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GDBusMethodInfo*)cPtr).name);
    (cast(GDBusMethodInfo*)cPtr).name = propval.toCString(true);
  }
}

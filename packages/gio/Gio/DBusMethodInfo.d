module Gio.DBusMethodInfo;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a method on an D-Bus interface.
 */
class DBusMethodInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDBusMethodInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_method_info_get_type();
  }

  @property int refCount()
  {
    return cPtr!GDBusMethodInfo.refCount;
  }

  @property void refCount(int propval)
  {
    cPtr!GDBusMethodInfo.refCount = propval;
  }

  @property string name()
  {
    return cPtr!GDBusMethodInfo.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GDBusMethodInfo.name);
    cPtr!GDBusMethodInfo.name = propval.toCString(true);
  }
}

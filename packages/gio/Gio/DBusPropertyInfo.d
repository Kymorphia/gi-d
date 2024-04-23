module Gio.DBusPropertyInfo;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a D-Bus property on a D-Bus interface.
 */
class DBusPropertyInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDBusPropertyInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_property_info_get_type();
  }

  @property int refCount()
  {
    return cPtr!GDBusPropertyInfo.refCount;
  }

  @property void refCount(int propval)
  {
    cPtr!GDBusPropertyInfo.refCount = propval;
  }

  @property string name()
  {
    return cPtr!GDBusPropertyInfo.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GDBusPropertyInfo.name);
    cPtr!GDBusPropertyInfo.name = propval.toCString(true);
  }

  @property string signature()
  {
    return cPtr!GDBusPropertyInfo.signature.fromCString(false);
  }

  @property void signature(string propval)
  {
    g_free(cast(void*)cPtr!GDBusPropertyInfo.signature);
    cPtr!GDBusPropertyInfo.signature = propval.toCString(true);
  }

  @property DBusPropertyInfoFlags flags()
  {
    return cast(DBusPropertyInfoFlags)cPtr!GDBusPropertyInfo.flags;
  }

  @property void flags(DBusPropertyInfoFlags propval)
  {
    cPtr!GDBusPropertyInfo.flags = cast(GDBusPropertyInfoFlags)propval;
  }
}

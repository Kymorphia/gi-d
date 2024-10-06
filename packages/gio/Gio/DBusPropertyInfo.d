module Gio.DBusPropertyInfo;

import GLib.Boxed;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a D-Bus property on a D-Bus interface.
 */
class DBusPropertyInfo : Boxed
{

  this()
  {
    super(safeMalloc(GDBusPropertyInfo.sizeof), true);
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
    return g_dbus_property_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int refCount()
  {
    return (cast(GDBusPropertyInfo*)cPtr).refCount;
  }

  @property void refCount(int propval)
  {
    (cast(GDBusPropertyInfo*)cPtr).refCount = propval;
  }

  @property string name()
  {
    return (cast(GDBusPropertyInfo*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GDBusPropertyInfo*)cPtr).name);
    (cast(GDBusPropertyInfo*)cPtr).name = propval.toCString(true);
  }

  @property string signature()
  {
    return (cast(GDBusPropertyInfo*)cPtr).signature.fromCString(false);
  }

  @property void signature(string propval)
  {
    safeFree(cast(void*)(cast(GDBusPropertyInfo*)cPtr).signature);
    (cast(GDBusPropertyInfo*)cPtr).signature = propval.toCString(true);
  }

  @property DBusPropertyInfoFlags flags()
  {
    return cast(DBusPropertyInfoFlags)(cast(GDBusPropertyInfo*)cPtr).flags;
  }

  @property void flags(DBusPropertyInfoFlags propval)
  {
    (cast(GDBusPropertyInfo*)cPtr).flags = cast(GDBusPropertyInfoFlags)propval;
  }
}

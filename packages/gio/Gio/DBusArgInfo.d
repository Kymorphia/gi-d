module Gio.DBusArgInfo;

import GLib.Boxed;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about an argument for a method or a signal.
 */
class DBusArgInfo : Boxed
{

  this()
  {
    super(safeMalloc(GDBusArgInfo.sizeof), true);
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
    return g_dbus_arg_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int refCount()
  {
    return (cast(GDBusArgInfo*)cPtr).refCount;
  }

  @property void refCount(int propval)
  {
    (cast(GDBusArgInfo*)cPtr).refCount = propval;
  }

  @property string name()
  {
    return (cast(GDBusArgInfo*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GDBusArgInfo*)cPtr).name);
    (cast(GDBusArgInfo*)cPtr).name = propval.toCString(true);
  }

  @property string signature()
  {
    return (cast(GDBusArgInfo*)cPtr).signature.fromCString(false);
  }

  @property void signature(string propval)
  {
    safeFree(cast(void*)(cast(GDBusArgInfo*)cPtr).signature);
    (cast(GDBusArgInfo*)cPtr).signature = propval.toCString(true);
  }
}

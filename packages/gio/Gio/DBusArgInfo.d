module Gio.DBusArgInfo;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about an argument for a method or a signal.
 */
class DBusArgInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDBusArgInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_arg_info_get_type();
  }

  @property int refCount()
  {
    return cPtr!GDBusArgInfo.refCount;
  }

  @property void refCount(int propval)
  {
    cPtr!GDBusArgInfo.refCount = propval;
  }

  @property string name()
  {
    return cPtr!GDBusArgInfo.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GDBusArgInfo.name);
    cPtr!GDBusArgInfo.name = propval.toCString(true);
  }

  @property string signature()
  {
    return cPtr!GDBusArgInfo.signature.fromCString(false);
  }

  @property void signature(string propval)
  {
    g_free(cast(void*)cPtr!GDBusArgInfo.signature);
    cPtr!GDBusArgInfo.signature = propval.toCString(true);
  }
}

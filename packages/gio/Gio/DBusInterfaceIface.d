module Gio.DBusInterfaceIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterface;
import Gio.DBusInterfaceInfo;
import Gio.DBusObject;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Base type for D-Bus interfaces.
 */
class DBusInterfaceIface
{
  GDBusInterfaceIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusInterfaceIface");

    cInstance = *cast(GDBusInterfaceIface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusInterfaceIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface parentIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDBusInterfaceIface.parentIface);
  }

  alias GetInfoFuncType = extern(C) GDBusInterfaceInfo* function(GDBusInterface* interface_);

  @property GetInfoFuncType getInfo()
  {
    return cPtr!GDBusInterfaceIface.getInfo;
  }

  alias GetObjectFuncType = extern(C) GDBusObject* function(GDBusInterface* interface_);

  @property GetObjectFuncType getObject()
  {
    return cPtr!GDBusInterfaceIface.getObject;
  }

  alias SetObjectFuncType = extern(C) void function(GDBusInterface* interface_, GDBusObject* object);

  @property SetObjectFuncType setObject()
  {
    return cPtr!GDBusInterfaceIface.setObject;
  }

  alias DupObjectFuncType = extern(C) GDBusObject* function(GDBusInterface* interface_);

  @property DupObjectFuncType dupObject()
  {
    return cPtr!GDBusInterfaceIface.dupObject;
  }
}

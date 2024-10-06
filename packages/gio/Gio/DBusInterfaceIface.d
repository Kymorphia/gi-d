module Gio.DBusInterfaceIface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface parentIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDBusInterfaceIface*)cPtr).parentIface);
  }

  alias GetInfoFuncType = extern(C) GDBusInterfaceInfo* function(GDBusInterface* interface_);

  @property GetInfoFuncType getInfo()
  {
    return (cast(GDBusInterfaceIface*)cPtr).getInfo;
  }

  alias GetObjectFuncType = extern(C) GDBusObject* function(GDBusInterface* interface_);

  @property GetObjectFuncType getObject()
  {
    return (cast(GDBusInterfaceIface*)cPtr).getObject;
  }

  alias SetObjectFuncType = extern(C) void function(GDBusInterface* interface_, GDBusObject* object);

  @property SetObjectFuncType setObject()
  {
    return (cast(GDBusInterfaceIface*)cPtr).setObject;
  }

  alias DupObjectFuncType = extern(C) GDBusObject* function(GDBusInterface* interface_);

  @property DupObjectFuncType dupObject()
  {
    return (cast(GDBusInterfaceIface*)cPtr).dupObject;
  }
}

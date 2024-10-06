module Gio.DBusObjectIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Base object type for D-Bus objects.
 */
class DBusObjectIface
{
  GDBusObjectIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusObjectIface");

    cInstance = *cast(GDBusObjectIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface parentIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDBusObjectIface*)cPtr).parentIface);
  }

  alias GetObjectPathFuncType = extern(C) const(char)* function(GDBusObject* object);

  @property GetObjectPathFuncType getObjectPath()
  {
    return (cast(GDBusObjectIface*)cPtr).getObjectPath;
  }

  alias GetInterfacesFuncType = extern(C) GList* function(GDBusObject* object);

  @property GetInterfacesFuncType getInterfaces()
  {
    return (cast(GDBusObjectIface*)cPtr).getInterfaces;
  }

  alias GetInterfaceFuncType = extern(C) GDBusInterface* function(GDBusObject* object, const(char)* interfaceName);

  @property GetInterfaceFuncType getInterface()
  {
    return (cast(GDBusObjectIface*)cPtr).getInterface;
  }

  alias InterfaceAddedFuncType = extern(C) void function(GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceAddedFuncType interfaceAdded()
  {
    return (cast(GDBusObjectIface*)cPtr).interfaceAdded;
  }

  alias InterfaceRemovedFuncType = extern(C) void function(GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceRemovedFuncType interfaceRemoved()
  {
    return (cast(GDBusObjectIface*)cPtr).interfaceRemoved;
  }
}

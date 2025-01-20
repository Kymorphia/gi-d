module Gio.DBusObjectManagerIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Base type for D-Bus object managers.
 */
class DBusObjectManagerIface
{
  GDBusObjectManagerIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusObjectManagerIface");

    cInstance = *cast(GDBusObjectManagerIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface parentIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDBusObjectManagerIface*)cPtr).parentIface);
  }

  alias GetObjectPathFuncType = extern(C) const(char)* function(GDBusObjectManager* manager);

  @property GetObjectPathFuncType getObjectPath()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).getObjectPath;
  }

  alias GetObjectsFuncType = extern(C) GList* function(GDBusObjectManager* manager);

  @property GetObjectsFuncType getObjects()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).getObjects;
  }

  alias GetObjectFuncType = extern(C) GDBusObject* function(GDBusObjectManager* manager, const(char)* objectPath);

  @property GetObjectFuncType getObject()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).getObject;
  }

  alias GetInterfaceFuncType = extern(C) GDBusInterface* function(GDBusObjectManager* manager, const(char)* objectPath, const(char)* interfaceName);

  @property GetInterfaceFuncType getInterface()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).getInterface;
  }

  alias ObjectAddedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object);

  @property ObjectAddedFuncType objectAdded()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).objectAdded;
  }

  alias ObjectRemovedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object);

  @property ObjectRemovedFuncType objectRemoved()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).objectRemoved;
  }

  alias InterfaceAddedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceAddedFuncType interfaceAdded()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).interfaceAdded;
  }

  alias InterfaceRemovedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceRemovedFuncType interfaceRemoved()
  {
    return (cast(GDBusObjectManagerIface*)cPtr).interfaceRemoved;
  }
}

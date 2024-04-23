module Gio.DBusObjectManagerIface;

import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterface;
import Gio.DBusObject;
import Gio.DBusObjectManager;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusObjectManagerIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface parentIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDBusObjectManagerIface.parentIface);
  }

  alias GetObjectPathFuncType = extern(C) const(char)* function(GDBusObjectManager* manager);

  @property GetObjectPathFuncType getObjectPath()
  {
    return cPtr!GDBusObjectManagerIface.getObjectPath;
  }

  alias GetObjectsFuncType = extern(C) GList* function(GDBusObjectManager* manager);

  @property GetObjectsFuncType getObjects()
  {
    return cPtr!GDBusObjectManagerIface.getObjects;
  }

  alias GetObjectFuncType = extern(C) GDBusObject* function(GDBusObjectManager* manager, const(char)* objectPath);

  @property GetObjectFuncType getObject()
  {
    return cPtr!GDBusObjectManagerIface.getObject;
  }

  alias GetInterfaceFuncType = extern(C) GDBusInterface* function(GDBusObjectManager* manager, const(char)* objectPath, const(char)* interfaceName);

  @property GetInterfaceFuncType getInterface()
  {
    return cPtr!GDBusObjectManagerIface.getInterface;
  }

  alias ObjectAddedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object);

  @property ObjectAddedFuncType objectAdded()
  {
    return cPtr!GDBusObjectManagerIface.objectAdded;
  }

  alias ObjectRemovedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object);

  @property ObjectRemovedFuncType objectRemoved()
  {
    return cPtr!GDBusObjectManagerIface.objectRemoved;
  }

  alias InterfaceAddedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceAddedFuncType interfaceAdded()
  {
    return cPtr!GDBusObjectManagerIface.interfaceAdded;
  }

  alias InterfaceRemovedFuncType = extern(C) void function(GDBusObjectManager* manager, GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceRemovedFuncType interfaceRemoved()
  {
    return cPtr!GDBusObjectManagerIface.interfaceRemoved;
  }
}

module Gio.DBusObjectIface;

import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterface;
import Gio.DBusObject;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusObjectIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface parentIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDBusObjectIface.parentIface);
  }

  alias GetObjectPathFuncType = extern(C) const(char)* function(GDBusObject* object);

  @property GetObjectPathFuncType getObjectPath()
  {
    return cPtr!GDBusObjectIface.getObjectPath;
  }

  alias GetInterfacesFuncType = extern(C) GList* function(GDBusObject* object);

  @property GetInterfacesFuncType getInterfaces()
  {
    return cPtr!GDBusObjectIface.getInterfaces;
  }

  alias GetInterfaceFuncType = extern(C) GDBusInterface* function(GDBusObject* object, const(char)* interfaceName);

  @property GetInterfaceFuncType getInterface()
  {
    return cPtr!GDBusObjectIface.getInterface;
  }

  alias InterfaceAddedFuncType = extern(C) void function(GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceAddedFuncType interfaceAdded()
  {
    return cPtr!GDBusObjectIface.interfaceAdded;
  }

  alias InterfaceRemovedFuncType = extern(C) void function(GDBusObject* object, GDBusInterface* interface_);

  @property InterfaceRemovedFuncType interfaceRemoved()
  {
    return cPtr!GDBusObjectIface.interfaceRemoved;
  }
}

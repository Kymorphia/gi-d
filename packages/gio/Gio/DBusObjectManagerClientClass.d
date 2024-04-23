module Gio.DBusObjectManagerClientClass;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.DBusObjectManagerClient;
import Gio.DBusObjectProxy;
import Gio.DBusProxy;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GDBusObjectManagerClient.
 */
class DBusObjectManagerClientClass
{
  GDBusObjectManagerClientClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusObjectManagerClientClass");

    cInstance = *cast(GDBusObjectManagerClientClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusObjectManagerClientClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GDBusObjectManagerClientClass.parentClass);
  }

  alias InterfaceProxySignalFuncType = extern(C) void function(GDBusObjectManagerClient* manager, GDBusObjectProxy* objectProxy, GDBusProxy* interfaceProxy, const(char)* senderName, const(char)* signalName, GVariant* parameters);

  @property InterfaceProxySignalFuncType interfaceProxySignal()
  {
    return cPtr!GDBusObjectManagerClientClass.interfaceProxySignal;
  }

  alias InterfaceProxyPropertiesChangedFuncType = extern(C) void function(GDBusObjectManagerClient* manager, GDBusObjectProxy* objectProxy, GDBusProxy* interfaceProxy, GVariant* changedProperties, const(char*)* invalidatedProperties);

  @property InterfaceProxyPropertiesChangedFuncType interfaceProxyPropertiesChanged()
  {
    return cPtr!GDBusObjectManagerClientClass.interfaceProxyPropertiesChanged;
  }
}

module Gio.DBusProxyClass;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import Gid.Gid;
import Gio.DBusProxy;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GDBusProxy.
 */
class DBusProxyClass
{
  GDBusProxyClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusProxyClass");

    cInstance = *cast(GDBusProxyClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusProxyClass))
  {
    return cast(T*)&cInstance;
  }

  alias GPropertiesChangedFuncType = extern(C) void function(GDBusProxy* proxy, GVariant* changedProperties, const(char*)* invalidatedProperties);

  @property GPropertiesChangedFuncType gPropertiesChanged()
  {
    return cPtr!GDBusProxyClass.gPropertiesChanged;
  }

  alias GSignalFuncType = extern(C) void function(GDBusProxy* proxy, const(char)* senderName, const(char)* signalName, GVariant* parameters);

  @property GSignalFuncType gSignal()
  {
    return cPtr!GDBusProxyClass.gSignal;
  }
}

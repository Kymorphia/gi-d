module Gio.DBusProxyClass;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias GPropertiesChangedFuncType = extern(C) void function(GDBusProxy* proxy, VariantC* changedProperties, const(char*)* invalidatedProperties);

  @property GPropertiesChangedFuncType gPropertiesChanged()
  {
    return (cast(GDBusProxyClass*)cPtr).gPropertiesChanged;
  }

  alias GSignalFuncType = extern(C) void function(GDBusProxy* proxy, const(char)* senderName, const(char)* signalName, VariantC* parameters);

  @property GSignalFuncType gSignal()
  {
    return (cast(GDBusProxyClass*)cPtr).gSignal;
  }
}

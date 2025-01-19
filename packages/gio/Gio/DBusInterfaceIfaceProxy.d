module Gio.DBusInterfaceIfaceProxy;

import GObject.ObjectG;
import Gio.DBusInterface;
import Gio.DBusInterfaceT;

/// Proxy object for Gio.DBusInterface interface when a GObject has no applicable D binding
class DBusInterfaceIfaceProxy : IfaceProxy, DBusInterface
{
  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(DBusInterface);
  }

  mixin DBusInterfaceT!();
}

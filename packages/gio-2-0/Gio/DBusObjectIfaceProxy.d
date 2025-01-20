module Gio.DBusObjectIfaceProxy;

import GObject.ObjectG;
import Gio.DBusObject;
import Gio.DBusObjectT;

/// Proxy object for Gio.DBusObject interface when a GObject has no applicable D binding
class DBusObjectIfaceProxy : IfaceProxy, DBusObject
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
    return typeid(DBusObject);
  }

  mixin DBusObjectT!();
}

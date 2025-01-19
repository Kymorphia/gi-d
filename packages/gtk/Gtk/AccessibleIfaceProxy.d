module Gtk.AccessibleIfaceProxy;

import GObject.ObjectG;
import Gtk.Accessible;
import Gtk.AccessibleT;

/// Proxy object for Gtk.Accessible interface when a GObject has no applicable D binding
class AccessibleIfaceProxy : IfaceProxy, Accessible
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
    return typeid(Accessible);
  }

  mixin AccessibleT!();
}

module Gtk.ActionableIfaceProxy;

import GObject.ObjectG;
import Gtk.Actionable;
import Gtk.ActionableT;

/// Proxy object for Gtk.Actionable interface when a GObject has no applicable D binding
class ActionableIfaceProxy : IfaceProxy, Actionable
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
    return typeid(Actionable);
  }

  mixin ActionableT!();
}

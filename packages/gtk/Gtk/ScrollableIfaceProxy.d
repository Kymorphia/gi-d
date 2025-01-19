module Gtk.ScrollableIfaceProxy;

import GObject.ObjectG;
import Gtk.Scrollable;
import Gtk.ScrollableT;

/// Proxy object for Gtk.Scrollable interface when a GObject has no applicable D binding
class ScrollableIfaceProxy : IfaceProxy, Scrollable
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
    return typeid(Scrollable);
  }

  mixin ScrollableT!();
}

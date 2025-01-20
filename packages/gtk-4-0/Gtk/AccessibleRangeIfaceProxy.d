module Gtk.AccessibleRangeIfaceProxy;

import GObject.ObjectG;
import Gtk.AccessibleRange;
import Gtk.AccessibleRangeT;

/// Proxy object for Gtk.AccessibleRange interface when a GObject has no applicable D binding
class AccessibleRangeIfaceProxy : IfaceProxy, AccessibleRange
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
    return typeid(AccessibleRange);
  }

  mixin AccessibleRangeT!();
}

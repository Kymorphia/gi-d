module Gtk.CellLayoutIfaceProxy;

import GObject.ObjectG;
import Gtk.CellLayout;
import Gtk.CellLayoutT;

/// Proxy object for Gtk.CellLayout interface when a GObject has no applicable D binding
class CellLayoutIfaceProxy : IfaceProxy, CellLayout
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
    return typeid(CellLayout);
  }

  mixin CellLayoutT!();
}

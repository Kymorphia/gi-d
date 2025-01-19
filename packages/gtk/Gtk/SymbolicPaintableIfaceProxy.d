module Gtk.SymbolicPaintableIfaceProxy;

import GObject.ObjectG;
import Gtk.SymbolicPaintable;
import Gtk.SymbolicPaintableT;

/// Proxy object for Gtk.SymbolicPaintable interface when a GObject has no applicable D binding
class SymbolicPaintableIfaceProxy : IfaceProxy, SymbolicPaintable
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
    return typeid(SymbolicPaintable);
  }

  mixin SymbolicPaintableT!();
}

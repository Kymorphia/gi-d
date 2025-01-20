module Gtk.SelectionModelIfaceProxy;

import GObject.ObjectG;
import Gtk.SelectionModel;
import Gtk.SelectionModelT;

/// Proxy object for Gtk.SelectionModel interface when a GObject has no applicable D binding
class SelectionModelIfaceProxy : IfaceProxy, SelectionModel
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
    return typeid(SelectionModel);
  }

  mixin SelectionModelT!();
}

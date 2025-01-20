module Gtk.TreeDragDestIfaceProxy;

import GObject.ObjectG;
import Gtk.TreeDragDest;
import Gtk.TreeDragDestT;

/// Proxy object for Gtk.TreeDragDest interface when a GObject has no applicable D binding
class TreeDragDestIfaceProxy : IfaceProxy, TreeDragDest
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
    return typeid(TreeDragDest);
  }

  mixin TreeDragDestT!();
}

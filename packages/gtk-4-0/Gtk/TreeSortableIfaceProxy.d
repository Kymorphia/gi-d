module Gtk.TreeSortableIfaceProxy;

import GObject.ObjectG;
import Gtk.TreeSortable;
import Gtk.TreeSortableT;

/// Proxy object for Gtk.TreeSortable interface when a GObject has no applicable D binding
class TreeSortableIfaceProxy : IfaceProxy, TreeSortable
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
    return typeid(TreeSortable);
  }

  mixin TreeSortableT!();
}

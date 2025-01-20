module Gtk.TreeDragSourceIfaceProxy;

import GObject.ObjectG;
import Gtk.TreeDragSource;
import Gtk.TreeDragSourceT;

/// Proxy object for Gtk.TreeDragSource interface when a GObject has no applicable D binding
class TreeDragSourceIfaceProxy : IfaceProxy, TreeDragSource
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
    return typeid(TreeDragSource);
  }

  mixin TreeDragSourceT!();
}

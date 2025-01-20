module Gtk.TreeModelIfaceProxy;

import GObject.ObjectG;
import Gtk.TreeModel;
import Gtk.TreeModelT;

/// Proxy object for Gtk.TreeModel interface when a GObject has no applicable D binding
class TreeModelIfaceProxy : IfaceProxy, TreeModel
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
    return typeid(TreeModel);
  }

  mixin TreeModelT!();
}

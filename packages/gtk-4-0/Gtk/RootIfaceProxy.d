module Gtk.RootIfaceProxy;

import GObject.ObjectG;
import Gtk.Root;
import Gtk.RootT;

/// Proxy object for Gtk.Root interface when a GObject has no applicable D binding
class RootIfaceProxy : IfaceProxy, Root
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
    return typeid(Root);
  }

  mixin RootT!();
}

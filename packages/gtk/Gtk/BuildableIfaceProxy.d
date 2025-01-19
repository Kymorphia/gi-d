module Gtk.BuildableIfaceProxy;

import GObject.ObjectG;
import Gtk.Buildable;
import Gtk.BuildableT;

/// Proxy object for Gtk.Buildable interface when a GObject has no applicable D binding
class BuildableIfaceProxy : IfaceProxy, Buildable
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
    return typeid(Buildable);
  }

  mixin BuildableT!();
}

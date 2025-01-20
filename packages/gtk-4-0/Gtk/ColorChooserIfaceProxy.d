module Gtk.ColorChooserIfaceProxy;

import GObject.ObjectG;
import Gtk.ColorChooser;
import Gtk.ColorChooserT;

/// Proxy object for Gtk.ColorChooser interface when a GObject has no applicable D binding
class ColorChooserIfaceProxy : IfaceProxy, ColorChooser
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
    return typeid(ColorChooser);
  }

  mixin ColorChooserT!();
}

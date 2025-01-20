module Gtk.FontChooserIfaceProxy;

import GObject.ObjectG;
import Gtk.FontChooser;
import Gtk.FontChooserT;

/// Proxy object for Gtk.FontChooser interface when a GObject has no applicable D binding
class FontChooserIfaceProxy : IfaceProxy, FontChooser
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
    return typeid(FontChooser);
  }

  mixin FontChooserT!();
}

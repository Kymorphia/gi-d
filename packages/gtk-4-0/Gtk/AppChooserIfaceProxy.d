module Gtk.AppChooserIfaceProxy;

import GObject.ObjectG;
import Gtk.AppChooser;
import Gtk.AppChooserT;

/// Proxy object for Gtk.AppChooser interface when a GObject has no applicable D binding
class AppChooserIfaceProxy : IfaceProxy, AppChooser
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
    return typeid(AppChooser);
  }

  mixin AppChooserT!();
}

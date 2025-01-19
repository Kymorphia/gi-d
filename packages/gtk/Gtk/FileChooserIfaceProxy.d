module Gtk.FileChooserIfaceProxy;

import GObject.ObjectG;
import Gtk.FileChooser;
import Gtk.FileChooserT;

/// Proxy object for Gtk.FileChooser interface when a GObject has no applicable D binding
class FileChooserIfaceProxy : IfaceProxy, FileChooser
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
    return typeid(FileChooser);
  }

  mixin FileChooserT!();
}

module Gtk.SectionModelIfaceProxy;

import GObject.ObjectG;
import Gtk.SectionModel;
import Gtk.SectionModelT;

/// Proxy object for Gtk.SectionModel interface when a GObject has no applicable D binding
class SectionModelIfaceProxy : IfaceProxy, SectionModel
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
    return typeid(SectionModel);
  }

  mixin SectionModelT!();
}

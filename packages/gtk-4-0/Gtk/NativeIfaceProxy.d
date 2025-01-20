module Gtk.NativeIfaceProxy;

import GObject.ObjectG;
import Gtk.Native;
import Gtk.NativeT;

/// Proxy object for Gtk.Native interface when a GObject has no applicable D binding
class NativeIfaceProxy : IfaceProxy, Native
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
    return typeid(Native);
  }

  mixin NativeT!();
}

module Gio.DatagramBasedIfaceProxy;

import GObject.ObjectG;
import Gio.DatagramBased;
import Gio.DatagramBasedT;

/// Proxy object for Gio.DatagramBased interface when a GObject has no applicable D binding
class DatagramBasedIfaceProxy : IfaceProxy, DatagramBased
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
    return typeid(DatagramBased);
  }

  mixin DatagramBasedT!();
}

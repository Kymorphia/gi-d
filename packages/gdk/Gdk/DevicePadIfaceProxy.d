module Gdk.DevicePadIfaceProxy;

import GObject.ObjectG;
import Gdk.DevicePad;
import Gdk.DevicePadT;

/// Proxy object for Gdk.DevicePad interface when a GObject has no applicable D binding
class DevicePadIfaceProxy : IfaceProxy, DevicePad
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
    return typeid(DevicePad);
  }

  mixin DevicePadT!();
}

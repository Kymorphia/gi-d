module Gio.VolumeIfaceProxy;

import GObject.ObjectG;
import Gio.Volume;
import Gio.VolumeT;

/// Proxy object for Gio.Volume interface when a GObject has no applicable D binding
class VolumeIfaceProxy : IfaceProxy, Volume
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
    return typeid(Volume);
  }

  mixin VolumeT!();
}

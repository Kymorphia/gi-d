module Gio.MountIfaceProxy;

import GObject.ObjectG;
import Gio.Mount;
import Gio.MountT;

/// Proxy object for Gio.Mount interface when a GObject has no applicable D binding
class MountIfaceProxy : IfaceProxy, Mount
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
    return typeid(Mount);
  }

  mixin MountT!();
}

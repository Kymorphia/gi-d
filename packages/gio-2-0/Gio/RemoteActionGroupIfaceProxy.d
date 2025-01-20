module Gio.RemoteActionGroupIfaceProxy;

import GObject.ObjectG;
import Gio.RemoteActionGroup;
import Gio.RemoteActionGroupT;

/// Proxy object for Gio.RemoteActionGroup interface when a GObject has no applicable D binding
class RemoteActionGroupIfaceProxy : IfaceProxy, RemoteActionGroup
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
    return typeid(RemoteActionGroup);
  }

  mixin RemoteActionGroupT!();
}

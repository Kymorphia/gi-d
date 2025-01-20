module Gio.NetworkMonitorIfaceProxy;

import GObject.ObjectG;
import Gio.NetworkMonitor;
import Gio.NetworkMonitorT;

/// Proxy object for Gio.NetworkMonitor interface when a GObject has no applicable D binding
class NetworkMonitorIfaceProxy : IfaceProxy, NetworkMonitor
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
    return typeid(NetworkMonitor);
  }

  mixin NetworkMonitorT!();
}

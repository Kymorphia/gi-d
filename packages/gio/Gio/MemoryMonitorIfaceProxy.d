module Gio.MemoryMonitorIfaceProxy;

import GObject.ObjectG;
import Gio.MemoryMonitor;
import Gio.MemoryMonitorT;

/// Proxy object for Gio.MemoryMonitor interface when a GObject has no applicable D binding
class MemoryMonitorIfaceProxy : IfaceProxy, MemoryMonitor
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
    return typeid(MemoryMonitor);
  }

  mixin MemoryMonitorT!();
}

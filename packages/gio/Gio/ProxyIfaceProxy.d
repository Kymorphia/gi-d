module Gio.ProxyIfaceProxy;

import GObject.ObjectG;
import Gio.Proxy;
import Gio.ProxyT;

/// Proxy object for Gio.Proxy interface when a GObject has no applicable D binding
class ProxyIfaceProxy : IfaceProxy, Proxy
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
    return typeid(Proxy);
  }

  mixin ProxyT!();
}

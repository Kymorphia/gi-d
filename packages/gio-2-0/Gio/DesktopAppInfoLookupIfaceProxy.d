module Gio.DesktopAppInfoLookupIfaceProxy;

import GObject.ObjectG;
import Gio.DesktopAppInfoLookup;
import Gio.DesktopAppInfoLookupT;

/// Proxy object for Gio.DesktopAppInfoLookup interface when a GObject has no applicable D binding
class DesktopAppInfoLookupIfaceProxy : IfaceProxy, DesktopAppInfoLookup
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
    return typeid(DesktopAppInfoLookup);
  }

  mixin DesktopAppInfoLookupT!();
}

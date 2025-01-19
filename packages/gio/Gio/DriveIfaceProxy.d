module Gio.DriveIfaceProxy;

import GObject.ObjectG;
import Gio.Drive;
import Gio.DriveT;

/// Proxy object for Gio.Drive interface when a GObject has no applicable D binding
class DriveIfaceProxy : IfaceProxy, Drive
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
    return typeid(Drive);
  }

  mixin DriveT!();
}

module Gio.IconIfaceProxy;

import GObject.ObjectG;
import Gio.Icon;
import Gio.IconT;

/// Proxy object for Gio.Icon interface when a GObject has no applicable D binding
class IconIfaceProxy : IfaceProxy, Icon
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
    return typeid(Icon);
  }

  mixin IconT!();
}

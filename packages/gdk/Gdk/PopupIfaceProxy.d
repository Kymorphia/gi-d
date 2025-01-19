module Gdk.PopupIfaceProxy;

import GObject.ObjectG;
import Gdk.Popup;
import Gdk.PopupT;

/// Proxy object for Gdk.Popup interface when a GObject has no applicable D binding
class PopupIfaceProxy : IfaceProxy, Popup
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
    return typeid(Popup);
  }

  mixin PopupT!();
}

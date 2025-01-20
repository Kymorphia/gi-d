module Gio.ListModelIfaceProxy;

import GObject.ObjectG;
import Gio.ListModel;
import Gio.ListModelT;

/// Proxy object for Gio.ListModel interface when a GObject has no applicable D binding
class ListModelIfaceProxy : IfaceProxy, ListModel
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
    return typeid(ListModel);
  }

  mixin ListModelT!();
}

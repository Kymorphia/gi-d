module Gio.ActionGroupIfaceProxy;

import GObject.ObjectG;
import Gio.ActionGroup;
import Gio.ActionGroupT;

/// Proxy object for Gio.ActionGroup interface when a GObject has no applicable D binding
class ActionGroupIfaceProxy : IfaceProxy, ActionGroup
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
    return typeid(ActionGroup);
  }

  mixin ActionGroupT!();
}

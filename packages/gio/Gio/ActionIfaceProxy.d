module Gio.ActionIfaceProxy;

import GObject.ObjectG;
import Gio.Action;
import Gio.ActionT;

/// Proxy object for Gio.Action interface when a GObject has no applicable D binding
class ActionIfaceProxy : IfaceProxy, Action
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
    return typeid(Action);
  }

  mixin ActionT!();
}

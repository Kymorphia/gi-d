module Gio.DebugControllerIfaceProxy;

import GObject.ObjectG;
import Gio.DebugController;
import Gio.DebugControllerT;

/// Proxy object for Gio.DebugController interface when a GObject has no applicable D binding
class DebugControllerIfaceProxy : IfaceProxy, DebugController
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
    return typeid(DebugController);
  }

  mixin DebugControllerT!();
}

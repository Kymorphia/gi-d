module Gdk.DragSurfaceIfaceProxy;

import GObject.ObjectG;
import Gdk.DragSurface;
import Gdk.DragSurfaceT;

/// Proxy object for Gdk.DragSurface interface when a GObject has no applicable D binding
class DragSurfaceIfaceProxy : IfaceProxy, DragSurface
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
    return typeid(DragSurface);
  }

  mixin DragSurfaceT!();
}

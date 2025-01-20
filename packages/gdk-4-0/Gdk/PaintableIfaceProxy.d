module Gdk.PaintableIfaceProxy;

import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;

/// Proxy object for Gdk.Paintable interface when a GObject has no applicable D binding
class PaintableIfaceProxy : IfaceProxy, Paintable
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
    return typeid(Paintable);
  }

  mixin PaintableT!();
}

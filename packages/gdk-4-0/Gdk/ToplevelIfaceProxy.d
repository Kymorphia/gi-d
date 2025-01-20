module Gdk.ToplevelIfaceProxy;

import GObject.ObjectG;
import Gdk.Toplevel;
import Gdk.ToplevelT;

/// Proxy object for Gdk.Toplevel interface when a GObject has no applicable D binding
class ToplevelIfaceProxy : IfaceProxy, Toplevel
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
    return typeid(Toplevel);
  }

  mixin ToplevelT!();
}

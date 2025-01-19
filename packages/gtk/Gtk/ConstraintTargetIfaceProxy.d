module Gtk.ConstraintTargetIfaceProxy;

import GObject.ObjectG;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;

/// Proxy object for Gtk.ConstraintTarget interface when a GObject has no applicable D binding
class ConstraintTargetIfaceProxy : IfaceProxy, ConstraintTarget
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
    return typeid(ConstraintTarget);
  }

  mixin ConstraintTargetT!();
}

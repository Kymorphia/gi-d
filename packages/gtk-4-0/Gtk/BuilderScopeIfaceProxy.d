module Gtk.BuilderScopeIfaceProxy;

import GObject.ObjectG;
import Gtk.BuilderScope;
import Gtk.BuilderScopeT;

/// Proxy object for Gtk.BuilderScope interface when a GObject has no applicable D binding
class BuilderScopeIfaceProxy : IfaceProxy, BuilderScope
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
    return typeid(BuilderScope);
  }

  mixin BuilderScopeT!();
}

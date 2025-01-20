module Gtk.AccessibleTextIfaceProxy;

import GObject.ObjectG;
import Gtk.AccessibleText;
import Gtk.AccessibleTextT;

/// Proxy object for Gtk.AccessibleText interface when a GObject has no applicable D binding
class AccessibleTextIfaceProxy : IfaceProxy, AccessibleText
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
    return typeid(AccessibleText);
  }

  mixin AccessibleTextT!();
}

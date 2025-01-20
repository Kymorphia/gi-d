module Gtk.ShortcutManagerIfaceProxy;

import GObject.ObjectG;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;

/// Proxy object for Gtk.ShortcutManager interface when a GObject has no applicable D binding
class ShortcutManagerIfaceProxy : IfaceProxy, ShortcutManager
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
    return typeid(ShortcutManager);
  }

  mixin ShortcutManagerT!();
}

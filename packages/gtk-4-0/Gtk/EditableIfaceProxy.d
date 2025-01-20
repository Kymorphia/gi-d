module Gtk.EditableIfaceProxy;

import GObject.ObjectG;
import Gtk.Editable;
import Gtk.EditableT;

/// Proxy object for Gtk.Editable interface when a GObject has no applicable D binding
class EditableIfaceProxy : IfaceProxy, Editable
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
    return typeid(Editable);
  }

  mixin EditableT!();
}

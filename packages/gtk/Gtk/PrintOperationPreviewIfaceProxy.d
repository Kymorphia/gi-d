module Gtk.PrintOperationPreviewIfaceProxy;

import GObject.ObjectG;
import Gtk.PrintOperationPreview;
import Gtk.PrintOperationPreviewT;

/// Proxy object for Gtk.PrintOperationPreview interface when a GObject has no applicable D binding
class PrintOperationPreviewIfaceProxy : IfaceProxy, PrintOperationPreview
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
    return typeid(PrintOperationPreview);
  }

  mixin PrintOperationPreviewT!();
}

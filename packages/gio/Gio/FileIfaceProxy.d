module Gio.FileIfaceProxy;

import GObject.ObjectG;
import Gio.File;
import Gio.FileT;

/// Proxy object for Gio.File interface when a GObject has no applicable D binding
class FileIfaceProxy : IfaceProxy, File
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
    return typeid(File);
  }

  mixin FileT!();
}

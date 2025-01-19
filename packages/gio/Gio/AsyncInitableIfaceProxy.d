module Gio.AsyncInitableIfaceProxy;

import GObject.ObjectG;
import Gio.AsyncInitable;
import Gio.AsyncInitableT;

/// Proxy object for Gio.AsyncInitable interface when a GObject has no applicable D binding
class AsyncInitableIfaceProxy : IfaceProxy, AsyncInitable
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
    return typeid(AsyncInitable);
  }

  mixin AsyncInitableT!();
}

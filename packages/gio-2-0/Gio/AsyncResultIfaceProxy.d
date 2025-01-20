module Gio.AsyncResultIfaceProxy;

import GObject.ObjectG;
import Gio.AsyncResult;
import Gio.AsyncResultT;

/// Proxy object for Gio.AsyncResult interface when a GObject has no applicable D binding
class AsyncResultIfaceProxy : IfaceProxy, AsyncResult
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
    return typeid(AsyncResult);
  }

  mixin AsyncResultT!();
}

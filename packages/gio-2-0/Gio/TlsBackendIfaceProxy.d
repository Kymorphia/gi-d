module Gio.TlsBackendIfaceProxy;

import GObject.ObjectG;
import Gio.TlsBackend;
import Gio.TlsBackendT;

/// Proxy object for Gio.TlsBackend interface when a GObject has no applicable D binding
class TlsBackendIfaceProxy : IfaceProxy, TlsBackend
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
    return typeid(TlsBackend);
  }

  mixin TlsBackendT!();
}

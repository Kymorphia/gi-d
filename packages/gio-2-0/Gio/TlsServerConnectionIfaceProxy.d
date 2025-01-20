module Gio.TlsServerConnectionIfaceProxy;

import GObject.ObjectG;
import Gio.TlsServerConnection;
import Gio.TlsServerConnectionT;

/// Proxy object for Gio.TlsServerConnection interface when a GObject has no applicable D binding
class TlsServerConnectionIfaceProxy : IfaceProxy, TlsServerConnection
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
    return typeid(TlsServerConnection);
  }

  mixin TlsServerConnectionT!();
}

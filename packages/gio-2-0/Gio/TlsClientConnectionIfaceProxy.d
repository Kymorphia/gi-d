module Gio.TlsClientConnectionIfaceProxy;

import GObject.ObjectG;
import Gio.TlsClientConnection;
import Gio.TlsClientConnectionT;

/// Proxy object for Gio.TlsClientConnection interface when a GObject has no applicable D binding
class TlsClientConnectionIfaceProxy : IfaceProxy, TlsClientConnection
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
    return typeid(TlsClientConnection);
  }

  mixin TlsClientConnectionT!();
}

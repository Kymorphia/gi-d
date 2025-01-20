module Gio.DtlsServerConnectionIfaceProxy;

import GObject.ObjectG;
import Gio.DtlsServerConnection;
import Gio.DtlsServerConnectionT;

/// Proxy object for Gio.DtlsServerConnection interface when a GObject has no applicable D binding
class DtlsServerConnectionIfaceProxy : IfaceProxy, DtlsServerConnection
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
    return typeid(DtlsServerConnection);
  }

  mixin DtlsServerConnectionT!();
}

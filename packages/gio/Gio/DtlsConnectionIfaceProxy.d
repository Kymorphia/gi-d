module Gio.DtlsConnectionIfaceProxy;

import GObject.ObjectG;
import Gio.DtlsConnection;
import Gio.DtlsConnectionT;

/// Proxy object for Gio.DtlsConnection interface when a GObject has no applicable D binding
class DtlsConnectionIfaceProxy : IfaceProxy, DtlsConnection
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
    return typeid(DtlsConnection);
  }

  mixin DtlsConnectionT!();
}

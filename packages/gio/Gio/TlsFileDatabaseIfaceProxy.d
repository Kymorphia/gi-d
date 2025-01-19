module Gio.TlsFileDatabaseIfaceProxy;

import GObject.ObjectG;
import Gio.TlsFileDatabase;
import Gio.TlsFileDatabaseT;

/// Proxy object for Gio.TlsFileDatabase interface when a GObject has no applicable D binding
class TlsFileDatabaseIfaceProxy : IfaceProxy, TlsFileDatabase
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
    return typeid(TlsFileDatabase);
  }

  mixin TlsFileDatabaseT!();
}

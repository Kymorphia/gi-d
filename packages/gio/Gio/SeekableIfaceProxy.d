module Gio.SeekableIfaceProxy;

import GObject.ObjectG;
import Gio.Seekable;
import Gio.SeekableT;

/// Proxy object for Gio.Seekable interface when a GObject has no applicable D binding
class SeekableIfaceProxy : IfaceProxy, Seekable
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
    return typeid(Seekable);
  }

  mixin SeekableT!();
}

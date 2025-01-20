module Gio.PollableInputStreamIfaceProxy;

import GObject.ObjectG;
import Gio.PollableInputStream;
import Gio.PollableInputStreamT;

/// Proxy object for Gio.PollableInputStream interface when a GObject has no applicable D binding
class PollableInputStreamIfaceProxy : IfaceProxy, PollableInputStream
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
    return typeid(PollableInputStream);
  }

  mixin PollableInputStreamT!();
}

module Gio.PollableOutputStreamIfaceProxy;

import GObject.ObjectG;
import Gio.PollableOutputStream;
import Gio.PollableOutputStreamT;

/// Proxy object for Gio.PollableOutputStream interface when a GObject has no applicable D binding
class PollableOutputStreamIfaceProxy : IfaceProxy, PollableOutputStream
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
    return typeid(PollableOutputStream);
  }

  mixin PollableOutputStreamT!();
}

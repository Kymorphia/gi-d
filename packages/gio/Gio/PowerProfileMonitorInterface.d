module Gio.PowerProfileMonitorInterface;

import GLib.c.functions;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GPowerProfileMonitor.
 */
class PowerProfileMonitorInterface
{
  GPowerProfileMonitorInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.PowerProfileMonitorInterface");

    cInstance = *cast(GPowerProfileMonitorInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GPowerProfileMonitorInterface))
  {
    return cast(T*)&cInstance;
  }
}

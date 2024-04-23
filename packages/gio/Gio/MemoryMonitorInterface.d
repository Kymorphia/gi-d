module Gio.MemoryMonitorInterface;

import GLib.c.functions;
import Gid.Gid;
import Gio.MemoryMonitor;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GMemoryMonitor.
 */
class MemoryMonitorInterface
{
  GMemoryMonitorInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MemoryMonitorInterface");

    cInstance = *cast(GMemoryMonitorInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMemoryMonitorInterface))
  {
    return cast(T*)&cInstance;
  }

  alias LowMemoryWarningFuncType = extern(C) void function(GMemoryMonitor* monitor, GMemoryMonitorWarningLevel level);

  @property LowMemoryWarningFuncType lowMemoryWarning()
  {
    return cPtr!GMemoryMonitorInterface.lowMemoryWarning;
  }
}

module Gio.MemoryMonitorInterface;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias LowMemoryWarningFuncType = extern(C) void function(GMemoryMonitor* monitor, GMemoryMonitorWarningLevel level);

  @property LowMemoryWarningFuncType lowMemoryWarning()
  {
    return (cast(GMemoryMonitorInterface*)cPtr).lowMemoryWarning;
  }
}

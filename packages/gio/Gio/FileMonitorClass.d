module Gio.FileMonitorClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FileMonitorClass
{
  GFileMonitorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileMonitorClass");

    cInstance = *cast(GFileMonitorClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GFileMonitorClass*)cPtr).parentClass);
  }

  alias ChangedFuncType = extern(C) void function(GFileMonitor* monitor, GFile* file, GFile* otherFile, GFileMonitorEvent eventType);

  @property ChangedFuncType changed()
  {
    return (cast(GFileMonitorClass*)cPtr).changed;
  }

  alias CancelFuncType = extern(C) bool function(GFileMonitor* monitor);

  @property CancelFuncType cancel()
  {
    return (cast(GFileMonitorClass*)cPtr).cancel;
  }
}

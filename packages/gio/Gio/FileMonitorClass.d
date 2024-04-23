module Gio.FileMonitorClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.File;
import Gio.FileMonitor;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileMonitorClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GFileMonitorClass.parentClass);
  }

  alias ChangedFuncType = extern(C) void function(GFileMonitor* monitor, GFile* file, GFile* otherFile, GFileMonitorEvent eventType);

  @property ChangedFuncType changed()
  {
    return cPtr!GFileMonitorClass.changed;
  }

  alias CancelFuncType = extern(C) bool function(GFileMonitor* monitor);

  @property CancelFuncType cancel()
  {
    return cPtr!GFileMonitorClass.cancel;
  }
}

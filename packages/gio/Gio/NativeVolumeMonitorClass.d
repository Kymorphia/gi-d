module Gio.NativeVolumeMonitorClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.VolumeMonitorClass;
import Gio.c.functions;
import Gio.c.types;

class NativeVolumeMonitorClass
{
  GNativeVolumeMonitorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.NativeVolumeMonitorClass");

    cInstance = *cast(GNativeVolumeMonitorClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GNativeVolumeMonitorClass))
  {
    return cast(T*)&cInstance;
  }

  @property VolumeMonitorClass parentClass()
  {
    return new VolumeMonitorClass(cast(GVolumeMonitorClass*)&cPtr!GNativeVolumeMonitorClass.parentClass);
  }
}

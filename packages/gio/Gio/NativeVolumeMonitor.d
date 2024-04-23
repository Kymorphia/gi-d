module Gio.NativeVolumeMonitor;

import Gid.Gid;
import Gio.Types;
import Gio.VolumeMonitor;
import Gio.c.functions;
import Gio.c.types;

class NativeVolumeMonitor : VolumeMonitor
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_native_volume_monitor_get_type();
  }
}

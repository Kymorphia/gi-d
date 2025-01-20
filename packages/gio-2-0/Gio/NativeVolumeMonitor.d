module Gio.NativeVolumeMonitor;

import Gid.gid;
import Gio.Types;
import Gio.VolumeMonitor;
import Gio.c.functions;
import Gio.c.types;

class NativeVolumeMonitor : VolumeMonitor
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_native_volume_monitor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

module Gdk.Snapshot;

import GObject.ObjectG;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * Base type for snapshot operations.
 * The subclass of `GdkSnapshot` used by GTK is [GtkSnapshot](../gtk4/class.Snapshot.html).
 */
class Snapshot : ObjectG
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
    return gdk_snapshot_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

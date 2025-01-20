module Gdk.ProximityEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to the proximity of a tool to a device.
 */
class ProximityEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.ProximityEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }
}

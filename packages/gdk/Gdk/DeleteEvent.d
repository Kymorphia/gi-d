module Gdk.DeleteEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to closing a top-level surface.
 */
class DeleteEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.DeleteEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }
}

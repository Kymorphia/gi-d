module Gdk.MotionEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to a pointer or touch device motion.
 */
class MotionEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.MotionEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }
}

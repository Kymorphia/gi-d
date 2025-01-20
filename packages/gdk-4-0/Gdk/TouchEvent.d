module Gdk.TouchEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to a touch-based device.
 */
class TouchEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.TouchEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }

  /**
   * Extracts whether a touch event is emulating a pointer event.
   * Returns: %TRUE if event is emulating
   */
  bool getEmulatingPointer()
  {
    bool _retval;
    _retval = gdk_touch_event_get_emulating_pointer(cast(GdkEvent*)cPtr);
    return _retval;
  }
}

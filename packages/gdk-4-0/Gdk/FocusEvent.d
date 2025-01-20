module Gdk.FocusEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to a keyboard focus change.
 */
class FocusEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.FocusEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }

  /**
   * Extracts whether this event is about focus entering or
   * leaving the surface.
   * Returns: %TRUE of the focus is entering
   */
  bool getIn()
  {
    bool _retval;
    _retval = gdk_focus_event_get_in(cast(GdkEvent*)cPtr);
    return _retval;
  }
}

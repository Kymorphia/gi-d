module Gdk.ButtonEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to a button on a pointer device.
 */
class ButtonEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.ButtonEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }

  /**
   * Extract the button number from a button event.
   * Returns: the button of event
   */
  uint getButton()
  {
    uint _retval;
    _retval = gdk_button_event_get_button(cast(GdkEvent*)cPtr);
    return _retval;
  }
}

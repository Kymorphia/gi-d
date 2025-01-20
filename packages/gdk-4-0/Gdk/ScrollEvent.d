module Gdk.ScrollEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to a scrolling motion.
 */
class ScrollEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.ScrollEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }

  /**
   * Extracts the scroll deltas of a scroll event.
   * The deltas will be zero unless the scroll direction
   * is %GDK_SCROLL_SMOOTH.
   * For the representation unit of these deltas, see
   * [Gdk.ScrollEvent.getUnit].
   * Params:
   *   deltaX = return location for x scroll delta
   *   deltaY = return location for y scroll delta
   */
  void getDeltas(out double deltaX, out double deltaY)
  {
    gdk_scroll_event_get_deltas(cast(GdkEvent*)cPtr, cast(double*)&deltaX, cast(double*)&deltaY);
  }

  /**
   * Extracts the direction of a scroll event.
   * Returns: the scroll direction of event
   */
  ScrollDirection getDirection()
  {
    GdkScrollDirection _cretval;
    _cretval = gdk_scroll_event_get_direction(cast(GdkEvent*)cPtr);
    ScrollDirection _retval = cast(ScrollDirection)_cretval;
    return _retval;
  }

  /**
   * Extracts the scroll delta unit of a scroll event.
   * The unit will always be %GDK_SCROLL_UNIT_WHEEL if the scroll direction is not
   * %GDK_SCROLL_SMOOTH.
   * Returns: the scroll unit.
   */
  ScrollUnit getUnit()
  {
    GdkScrollUnit _cretval;
    _cretval = gdk_scroll_event_get_unit(cast(GdkEvent*)cPtr);
    ScrollUnit _retval = cast(ScrollUnit)_cretval;
    return _retval;
  }

  /**
   * Check whether a scroll event is a stop scroll event.
   * Scroll sequences with smooth scroll information may provide
   * a stop scroll event once the interaction with the device finishes,
   * e.g. by lifting a finger. This stop scroll event is the signal
   * that a widget may trigger kinetic scrolling based on the current
   * velocity.
   * Stop scroll events always have a delta of 0/0.
   * Returns: %TRUE if the event is a scroll stop event
   */
  bool isStop()
  {
    bool _retval;
    _retval = gdk_scroll_event_is_stop(cast(GdkEvent*)cPtr);
    return _retval;
  }
}

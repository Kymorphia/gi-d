module Gdk.CrossingEvent;

import Gdk.Event;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event caused by a pointing device moving between surfaces.
 */
class CrossingEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.CrossingEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }

  /**
   * Extracts the notify detail from a crossing event.
   * Returns: the notify detail of event
   */
  NotifyType getDetail()
  {
    GdkNotifyType _cretval;
    _cretval = gdk_crossing_event_get_detail(cast(GdkEvent*)cPtr);
    NotifyType _retval = cast(NotifyType)_cretval;
    return _retval;
  }

  /**
   * Checks if the event surface is the focus surface.
   * Returns: %TRUE if the surface is the focus surface
   */
  bool getFocus()
  {
    bool _retval;
    _retval = gdk_crossing_event_get_focus(cast(GdkEvent*)cPtr);
    return _retval;
  }

  /**
   * Extracts the crossing mode from a crossing event.
   * Returns: the mode of event
   */
  CrossingMode getMode()
  {
    GdkCrossingMode _cretval;
    _cretval = gdk_crossing_event_get_mode(cast(GdkEvent*)cPtr);
    CrossingMode _retval = cast(CrossingMode)_cretval;
    return _retval;
  }
}

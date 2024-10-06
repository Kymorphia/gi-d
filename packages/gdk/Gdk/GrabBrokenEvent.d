module Gdk.GrabBrokenEvent;

import GObject.ObjectG;
import Gdk.Event;
import Gdk.Surface;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * An event related to a broken windowing system grab.
 */
class GrabBrokenEvent : Event
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.GrabBrokenEvent");

    super(cast(GdkEvent*)ptr, ownedRef);
  }

  /**
   * Extracts the grab surface from a grab broken event.
   * Returns: the grab surface of event
   */
  Surface getGrabSurface()
  {
    GdkSurface* _cretval;
    _cretval = gdk_grab_broken_event_get_grab_surface(cast(GdkEvent*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether the grab broken event is for an implicit grab.
   * Returns: %TRUE if the an implicit grab was broken
   */
  bool getImplicit()
  {
    bool _retval;
    _retval = gdk_grab_broken_event_get_implicit(cast(GdkEvent*)cPtr);
    return _retval;
  }
}

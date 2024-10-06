module Gdk.EventSequence;

import GLib.Boxed;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * `GdkEventSequence` is an opaque type representing a sequence
 * of related touch events.
 */
class EventSequence : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gdk_event_sequence_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

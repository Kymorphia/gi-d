module HarfBuzz.Map;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for holding integer-to-integer hash maps.
 */
class Map : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_map_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_map_get_type();
  }
}

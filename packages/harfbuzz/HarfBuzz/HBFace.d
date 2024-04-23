module HarfBuzz.HBFace;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for holding font faces.
 */
class HBFace : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_face_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_face_get_type();
  }
}

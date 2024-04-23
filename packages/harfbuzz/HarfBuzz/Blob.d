module HarfBuzz.Blob;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type for blobs. A blob wraps a chunk of binary
 * data and facilitates its lifecycle management between
 * a client program and HarfBuzz.
 */
class Blob : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_blob_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_blob_get_type();
  }
}

module HarfBuzz.Blob;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_blob_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

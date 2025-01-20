module HarfBuzz.Buffer;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * The main structure holding the input text and its properties before shaping,
 * and output glyphs and their information after shaping.
 */
class Buffer : Boxed
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
    return hb_gobject_buffer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

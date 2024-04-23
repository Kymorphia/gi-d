module HarfBuzz.Buffer;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
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

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_buffer_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_buffer_get_type();
  }
}

module HarfBuzz.GlyphInfo;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * The #hb_glyph_info_t is the structure that holds information about the
 * glyphs and their relation to input text.
 */
class GlyphInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_glyph_info_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_glyph_info_get_type();
  }

  @property Codepoint codepoint()
  {
    return cPtr!hb_glyph_info_t.codepoint;
  }

  @property void codepoint(Codepoint propval)
  {
    cPtr!hb_glyph_info_t.codepoint = propval;
  }

  @property uint cluster()
  {
    return cPtr!hb_glyph_info_t.cluster;
  }

  @property void cluster(uint propval)
  {
    cPtr!hb_glyph_info_t.cluster = propval;
  }
}

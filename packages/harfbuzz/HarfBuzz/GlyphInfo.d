module HarfBuzz.GlyphInfo;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * The #hb_glyph_info_t is the structure that holds information about the
 * glyphs and their relation to input text.
 */
class GlyphInfo : Boxed
{

  this()
  {
    super(safeMalloc(hb_glyph_info_t.sizeof), true);
  }

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
    return hb_gobject_glyph_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Codepoint codepoint()
  {
    return (cast(hb_glyph_info_t*)cPtr).codepoint;
  }

  @property void codepoint(Codepoint propval)
  {
    (cast(hb_glyph_info_t*)cPtr).codepoint = propval;
  }

  @property uint cluster()
  {
    return (cast(hb_glyph_info_t*)cPtr).cluster;
  }

  @property void cluster(uint propval)
  {
    (cast(hb_glyph_info_t*)cPtr).cluster = propval;
  }
}

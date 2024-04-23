module HarfBuzz.GlyphPosition;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * The #hb_glyph_position_t is the structure that holds the positions of the
 * glyph in both horizontal and vertical directions. All positions in
 * #hb_glyph_position_t are relative to the current point.
 */
class GlyphPosition : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_glyph_position_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_glyph_position_get_type();
  }

  @property Position xAdvance()
  {
    return cPtr!hb_glyph_position_t.xAdvance;
  }

  @property void xAdvance(Position propval)
  {
    cPtr!hb_glyph_position_t.xAdvance = propval;
  }

  @property Position yAdvance()
  {
    return cPtr!hb_glyph_position_t.yAdvance;
  }

  @property void yAdvance(Position propval)
  {
    cPtr!hb_glyph_position_t.yAdvance = propval;
  }

  @property Position xOffset()
  {
    return cPtr!hb_glyph_position_t.xOffset;
  }

  @property void xOffset(Position propval)
  {
    cPtr!hb_glyph_position_t.xOffset = propval;
  }

  @property Position yOffset()
  {
    return cPtr!hb_glyph_position_t.yOffset;
  }

  @property void yOffset(Position propval)
  {
    cPtr!hb_glyph_position_t.yOffset = propval;
  }
}

module HarfBuzz.GlyphPosition;

import GLib.Boxed;
import Gid.gid;
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

  this()
  {
    super(safeMalloc(hb_glyph_position_t.sizeof), true);
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
    return hb_gobject_glyph_position_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Position xAdvance()
  {
    return (cast(hb_glyph_position_t*)cPtr).xAdvance;
  }

  @property void xAdvance(Position propval)
  {
    (cast(hb_glyph_position_t*)cPtr).xAdvance = propval;
  }

  @property Position yAdvance()
  {
    return (cast(hb_glyph_position_t*)cPtr).yAdvance;
  }

  @property void yAdvance(Position propval)
  {
    (cast(hb_glyph_position_t*)cPtr).yAdvance = propval;
  }

  @property Position xOffset()
  {
    return (cast(hb_glyph_position_t*)cPtr).xOffset;
  }

  @property void xOffset(Position propval)
  {
    (cast(hb_glyph_position_t*)cPtr).xOffset = propval;
  }

  @property Position yOffset()
  {
    return (cast(hb_glyph_position_t*)cPtr).yOffset;
  }

  @property void yOffset(Position propval)
  {
    (cast(hb_glyph_position_t*)cPtr).yOffset = propval;
  }
}

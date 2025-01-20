module HarfBuzz.OtMathGlyphPart;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type to hold information for a "part" component of a math-variant glyph.
 * Large variants for stretchable math glyphs $(LPAREN)such as parentheses$(RPAREN) can be constructed
 * on the fly from parts.
 */
class OtMathGlyphPart : Boxed
{

  this()
  {
    super(safeMalloc(hb_ot_math_glyph_part_t.sizeof), true);
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
    return hb_gobject_ot_math_glyph_part_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Codepoint glyph()
  {
    return (cast(hb_ot_math_glyph_part_t*)cPtr).glyph;
  }

  @property void glyph(Codepoint propval)
  {
    (cast(hb_ot_math_glyph_part_t*)cPtr).glyph = propval;
  }

  @property Position startConnectorLength()
  {
    return (cast(hb_ot_math_glyph_part_t*)cPtr).startConnectorLength;
  }

  @property void startConnectorLength(Position propval)
  {
    (cast(hb_ot_math_glyph_part_t*)cPtr).startConnectorLength = propval;
  }

  @property Position endConnectorLength()
  {
    return (cast(hb_ot_math_glyph_part_t*)cPtr).endConnectorLength;
  }

  @property void endConnectorLength(Position propval)
  {
    (cast(hb_ot_math_glyph_part_t*)cPtr).endConnectorLength = propval;
  }

  @property Position fullAdvance()
  {
    return (cast(hb_ot_math_glyph_part_t*)cPtr).fullAdvance;
  }

  @property void fullAdvance(Position propval)
  {
    (cast(hb_ot_math_glyph_part_t*)cPtr).fullAdvance = propval;
  }

  @property OtMathGlyphPartFlags flags()
  {
    return cast(OtMathGlyphPartFlags)(cast(hb_ot_math_glyph_part_t*)cPtr).flags;
  }

  @property void flags(OtMathGlyphPartFlags propval)
  {
    (cast(hb_ot_math_glyph_part_t*)cPtr).flags = cast(hb_ot_math_glyph_part_flags_t)propval;
  }
}

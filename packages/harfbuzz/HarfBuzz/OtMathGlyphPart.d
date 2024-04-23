module HarfBuzz.OtMathGlyphPart;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type to hold information for a "part" component of a math-variant glyph.
 * Large variants for stretchable math glyphs (such as parentheses) can be constructed
 * on the fly from parts.
 */
class OtMathGlyphPart : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_ot_math_glyph_part_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_ot_math_glyph_part_get_type();
  }

  @property Codepoint glyph()
  {
    return cPtr!hb_ot_math_glyph_part_t.glyph;
  }

  @property void glyph(Codepoint propval)
  {
    cPtr!hb_ot_math_glyph_part_t.glyph = propval;
  }

  @property Position startConnectorLength()
  {
    return cPtr!hb_ot_math_glyph_part_t.startConnectorLength;
  }

  @property void startConnectorLength(Position propval)
  {
    cPtr!hb_ot_math_glyph_part_t.startConnectorLength = propval;
  }

  @property Position endConnectorLength()
  {
    return cPtr!hb_ot_math_glyph_part_t.endConnectorLength;
  }

  @property void endConnectorLength(Position propval)
  {
    cPtr!hb_ot_math_glyph_part_t.endConnectorLength = propval;
  }

  @property Position fullAdvance()
  {
    return cPtr!hb_ot_math_glyph_part_t.fullAdvance;
  }

  @property void fullAdvance(Position propval)
  {
    cPtr!hb_ot_math_glyph_part_t.fullAdvance = propval;
  }

  @property OtMathGlyphPartFlags flags()
  {
    return cast(OtMathGlyphPartFlags)cPtr!hb_ot_math_glyph_part_t.flags;
  }

  @property void flags(OtMathGlyphPartFlags propval)
  {
    cPtr!hb_ot_math_glyph_part_t.flags = cast(hb_ot_math_glyph_part_flags_t)propval;
  }
}

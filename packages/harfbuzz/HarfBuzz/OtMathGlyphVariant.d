module HarfBuzz.OtMathGlyphVariant;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type to hold math-variant information for a glyph.
 */
class OtMathGlyphVariant : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_ot_math_glyph_variant_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_ot_math_glyph_variant_get_type();
  }

  @property Codepoint glyph()
  {
    return cPtr!hb_ot_math_glyph_variant_t.glyph;
  }

  @property void glyph(Codepoint propval)
  {
    cPtr!hb_ot_math_glyph_variant_t.glyph = propval;
  }

  @property Position advance()
  {
    return cPtr!hb_ot_math_glyph_variant_t.advance;
  }

  @property void advance(Position propval)
  {
    cPtr!hb_ot_math_glyph_variant_t.advance = propval;
  }
}

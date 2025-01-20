module HarfBuzz.OtMathGlyphVariant;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Data type to hold math-variant information for a glyph.
 */
class OtMathGlyphVariant : Boxed
{

  this()
  {
    super(safeMalloc(hb_ot_math_glyph_variant_t.sizeof), true);
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
    return hb_gobject_ot_math_glyph_variant_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Codepoint glyph()
  {
    return (cast(hb_ot_math_glyph_variant_t*)cPtr).glyph;
  }

  @property void glyph(Codepoint propval)
  {
    (cast(hb_ot_math_glyph_variant_t*)cPtr).glyph = propval;
  }

  @property Position advance()
  {
    return (cast(hb_ot_math_glyph_variant_t*)cPtr).advance;
  }

  @property void advance(Position propval)
  {
    (cast(hb_ot_math_glyph_variant_t*)cPtr).advance = propval;
  }
}

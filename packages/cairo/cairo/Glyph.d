module cairo.Glyph;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * The #cairo_glyph_t structure holds information about a single glyph
 * when drawing or measuring text. A font is $(LPAREN)in simple terms$(RPAREN) a
 * collection of shapes used to draw text. A glyph is one of these
 * shapes. There can be multiple glyphs for a single character
 * $(LPAREN)alternates to be used in different contexts, for example$(RPAREN), or a
 * glyph can be a <firstterm>ligature</firstterm> of multiple
 * characters. Cairo doesn't expose any way of converting input text
 * into glyphs, so in order to use the Cairo interfaces that take
 * arrays of glyphs, you must directly access the appropriate
 * underlying font system.
 * Note that the offsets given by @x and @y are not cumulative. When
 * drawing or measuring text, each glyph is individually positioned
 * with respect to the overall origin
 */
class Glyph : Boxed
{

  this()
  {
    super(safeMalloc(cairo_glyph_t.sizeof), true);
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
    return cairo_gobject_glyph_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property ulong index()
  {
    return (cast(cairo_glyph_t*)cPtr).index;
  }

  @property void index(ulong propval)
  {
    (cast(cairo_glyph_t*)cPtr).index = propval;
  }

  @property double x()
  {
    return (cast(cairo_glyph_t*)cPtr).x;
  }

  @property void x(double propval)
  {
    (cast(cairo_glyph_t*)cPtr).x = propval;
  }

  @property double y()
  {
    return (cast(cairo_glyph_t*)cPtr).y;
  }

  @property void y(double propval)
  {
    (cast(cairo_glyph_t*)cPtr).y = propval;
  }
}

module HarfBuzz.PaintFuncs;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Glyph paint callbacks.
 * The callbacks assume that the caller maintains a stack
 * of current transforms, clips and intermediate surfaces,
 * as evidenced by the pairs of push/pop callbacks. The
 * push/pop calls will be properly nested, so it is fine
 * to store the different kinds of object on a single stack.
 * Not all callbacks are required for all kinds of glyphs.
 * For rendering COLRv0 or non-color outline glyphs, the
 * gradient callbacks are not needed, and the composite
 * callback only needs to handle simple alpha compositing
 * $(LPAREN)#HB_PAINT_COMPOSITE_MODE_SRC_OVER$(RPAREN).
 * The paint-image callback is only needed for glyphs
 * with image blobs in the CBDT, sbix or SVG tables.
 * The custom-palette-color callback is only necessary if
 * you want to override colors from the font palette with
 * custom colors.
 */
class PaintFuncs : Boxed
{

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
    return hb_gobject_paint_funcs_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

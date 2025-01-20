module HarfBuzz.DrawFuncs;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Glyph draw callbacks.
 * #hb_draw_move_to_func_t, #hb_draw_line_to_func_t and
 * #hb_draw_cubic_to_func_t calls are necessary to be defined but we translate
 * #hb_draw_quadratic_to_func_t calls to #hb_draw_cubic_to_func_t if the
 * callback isn't defined.
 */
class DrawFuncs : Boxed
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
    return hb_gobject_draw_funcs_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}

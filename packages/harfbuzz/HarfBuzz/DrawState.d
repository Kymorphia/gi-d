module HarfBuzz.DrawState;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Current drawing state.
 */
class DrawState : Boxed
{

  this()
  {
    super(safeMalloc(hb_draw_state_t.sizeof), true);
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
    return hb_gobject_draw_state_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Bool pathOpen()
  {
    return (cast(hb_draw_state_t*)cPtr).pathOpen;
  }

  @property void pathOpen(Bool propval)
  {
    (cast(hb_draw_state_t*)cPtr).pathOpen = propval;
  }

  @property float pathStartX()
  {
    return (cast(hb_draw_state_t*)cPtr).pathStartX;
  }

  @property void pathStartX(float propval)
  {
    (cast(hb_draw_state_t*)cPtr).pathStartX = propval;
  }

  @property float pathStartY()
  {
    return (cast(hb_draw_state_t*)cPtr).pathStartY;
  }

  @property void pathStartY(float propval)
  {
    (cast(hb_draw_state_t*)cPtr).pathStartY = propval;
  }

  @property float currentX()
  {
    return (cast(hb_draw_state_t*)cPtr).currentX;
  }

  @property void currentX(float propval)
  {
    (cast(hb_draw_state_t*)cPtr).currentX = propval;
  }

  @property float currentY()
  {
    return (cast(hb_draw_state_t*)cPtr).currentY;
  }

  @property void currentY(float propval)
  {
    (cast(hb_draw_state_t*)cPtr).currentY = propval;
  }
}

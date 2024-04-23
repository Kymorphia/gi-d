module HarfBuzz.DrawState;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Current drawing state.
 */
class DrawState : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_draw_state_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_draw_state_get_type();
  }

  @property Bool pathOpen()
  {
    return cPtr!hb_draw_state_t.pathOpen;
  }

  @property void pathOpen(Bool propval)
  {
    cPtr!hb_draw_state_t.pathOpen = propval;
  }

  @property float pathStartX()
  {
    return cPtr!hb_draw_state_t.pathStartX;
  }

  @property void pathStartX(float propval)
  {
    cPtr!hb_draw_state_t.pathStartX = propval;
  }

  @property float pathStartY()
  {
    return cPtr!hb_draw_state_t.pathStartY;
  }

  @property void pathStartY(float propval)
  {
    cPtr!hb_draw_state_t.pathStartY = propval;
  }

  @property float currentX()
  {
    return cPtr!hb_draw_state_t.currentX;
  }

  @property void currentX(float propval)
  {
    cPtr!hb_draw_state_t.currentX = propval;
  }

  @property float currentY()
  {
    return cPtr!hb_draw_state_t.currentY;
  }

  @property void currentY(float propval)
  {
    cPtr!hb_draw_state_t.currentY = propval;
  }
}

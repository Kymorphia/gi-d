module HarfBuzz.ColorStop;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Information about a color stop on a color line.
 *
 * Color lines typically have offsets ranging between 0 and 1,
 * but that is not required.
 *
 * Note: despite @color being unpremultiplied here, interpolation in
 * gradients shall happen in premultiplied space. See the OpenType spec
 * [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
 * section for details.
 */
class ColorStop : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_color_stop_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_color_stop_get_type();
  }

  @property float offset()
  {
    return cPtr!hb_color_stop_t.offset;
  }

  @property void offset(float propval)
  {
    cPtr!hb_color_stop_t.offset = propval;
  }

  @property Bool isForeground()
  {
    return cPtr!hb_color_stop_t.isForeground;
  }

  @property void isForeground(Bool propval)
  {
    cPtr!hb_color_stop_t.isForeground = propval;
  }

  @property Color color()
  {
    return cPtr!hb_color_stop_t.color;
  }

  @property void color(Color propval)
  {
    cPtr!hb_color_stop_t.color = propval;
  }
}

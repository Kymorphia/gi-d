module HarfBuzz.ColorStop;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * Information about a color stop on a color line.
 * Color lines typically have offsets ranging between 0 and 1,
 * but that is not required.
 * Note: despite @color being unpremultiplied here, interpolation in
 * gradients shall happen in premultiplied space. See the OpenType spec
 * [COLR](https://learn.microsoft.com/en-us/typography/opentype/spec/colr)
 * section for details.
 */
class ColorStop : Boxed
{

  this()
  {
    super(safeMalloc(hb_color_stop_t.sizeof), true);
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
    return hb_gobject_color_stop_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property float offset()
  {
    return (cast(hb_color_stop_t*)cPtr).offset;
  }

  @property void offset(float propval)
  {
    (cast(hb_color_stop_t*)cPtr).offset = propval;
  }

  @property Bool isForeground()
  {
    return (cast(hb_color_stop_t*)cPtr).isForeground;
  }

  @property void isForeground(Bool propval)
  {
    (cast(hb_color_stop_t*)cPtr).isForeground = propval;
  }

  @property Color color()
  {
    return (cast(hb_color_stop_t*)cPtr).color;
  }

  @property void color(Color propval)
  {
    (cast(hb_color_stop_t*)cPtr).color = propval;
  }
}

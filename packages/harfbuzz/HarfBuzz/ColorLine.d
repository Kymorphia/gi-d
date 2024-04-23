module HarfBuzz.ColorLine;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import HarfBuzz.ColorStop;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * A struct containing color information for a gradient.
 */
class ColorLine : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == hb_color_line_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return hb_gobject_color_line_get_type();
  }

  @property hb_color_line_get_color_stops_func_t getColorStops()
  {
    return cPtr!hb_color_line_t.getColorStops;
  }

  @property void getColorStops(hb_color_line_get_color_stops_func_t propval)
  {
    cPtr!hb_color_line_t.getColorStops = propval;
  }

  @property hb_color_line_get_extend_func_t getExtend()
  {
    return cPtr!hb_color_line_t.getExtend;
  }

  @property void getExtend(hb_color_line_get_extend_func_t propval)
  {
    cPtr!hb_color_line_t.getExtend = propval;
  }
}

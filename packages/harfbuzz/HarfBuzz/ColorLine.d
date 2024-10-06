module HarfBuzz.ColorLine;

import GLib.Boxed;
import Gid.gid;
import HarfBuzz.Types;
import HarfBuzz.c.functions;
import HarfBuzz.c.types;

/**
 * A struct containing color information for a gradient.
 */
class ColorLine : Boxed
{

  this()
  {
    super(safeMalloc(hb_color_line_t.sizeof), true);
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
    return hb_gobject_color_line_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property hb_color_line_get_color_stops_func_t getColorStops()
  {
    return (cast(hb_color_line_t*)cPtr).getColorStops;
  }

  @property void getColorStops(hb_color_line_get_color_stops_func_t propval)
  {
    (cast(hb_color_line_t*)cPtr).getColorStops = propval;
  }

  @property hb_color_line_get_extend_func_t getExtend()
  {
    return (cast(hb_color_line_t*)cPtr).getExtend;
  }

  @property void getExtend(hb_color_line_get_extend_func_t propval)
  {
    (cast(hb_color_line_t*)cPtr).getExtend = propval;
  }
}

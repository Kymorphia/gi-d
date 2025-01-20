module cairo.RectangleInt;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A data structure for holding a rectangle with integer coordinates.
 */
class RectangleInt : Boxed
{

  this()
  {
    super(safeMalloc(cairo_rectangle_int_t.sizeof), true);
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
    return cairo_gobject_rectangle_int_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int x()
  {
    return (cast(cairo_rectangle_int_t*)cPtr).x;
  }

  @property void x(int propval)
  {
    (cast(cairo_rectangle_int_t*)cPtr).x = propval;
  }

  @property int y()
  {
    return (cast(cairo_rectangle_int_t*)cPtr).y;
  }

  @property void y(int propval)
  {
    (cast(cairo_rectangle_int_t*)cPtr).y = propval;
  }

  @property int width()
  {
    return (cast(cairo_rectangle_int_t*)cPtr).width;
  }

  @property void width(int propval)
  {
    (cast(cairo_rectangle_int_t*)cPtr).width = propval;
  }

  @property int height()
  {
    return (cast(cairo_rectangle_int_t*)cPtr).height;
  }

  @property void height(int propval)
  {
    (cast(cairo_rectangle_int_t*)cPtr).height = propval;
  }
}

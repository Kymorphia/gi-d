module cairo.Rectangle;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A data structure for holding a rectangle.
 */
class Rectangle : Boxed
{

  this()
  {
    super(safeMalloc(cairo_rectangle_t.sizeof), true);
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
    return cairo_gobject_rectangle_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property double x()
  {
    return (cast(cairo_rectangle_t*)cPtr).x;
  }

  @property void x(double propval)
  {
    (cast(cairo_rectangle_t*)cPtr).x = propval;
  }

  @property double y()
  {
    return (cast(cairo_rectangle_t*)cPtr).y;
  }

  @property void y(double propval)
  {
    (cast(cairo_rectangle_t*)cPtr).y = propval;
  }

  @property double width()
  {
    return (cast(cairo_rectangle_t*)cPtr).width;
  }

  @property void width(double propval)
  {
    (cast(cairo_rectangle_t*)cPtr).width = propval;
  }

  @property double height()
  {
    return (cast(cairo_rectangle_t*)cPtr).height;
  }

  @property void height(double propval)
  {
    (cast(cairo_rectangle_t*)cPtr).height = propval;
  }
}

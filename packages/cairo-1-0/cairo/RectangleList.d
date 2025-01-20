module cairo.RectangleList;

import GLib.Boxed;
import Gid.gid;
import cairo.Rectangle;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A data structure for holding a dynamically allocated
 * array of rectangles.
 */
class RectangleList : Boxed
{

  this()
  {
    super(safeMalloc(cairo_rectangle_list_t.sizeof), true);
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
    return cairo_gobject_rectangle_list_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Status status()
  {
    return cast(Status)(cast(cairo_rectangle_list_t*)cPtr).status;
  }

  @property void status(Status propval)
  {
    (cast(cairo_rectangle_list_t*)cPtr).status = cast(cairo_status_t)propval;
  }

  @property Rectangle rectangles()
  {
    return new Rectangle(cast(cairo_rectangle_t*)(cast(cairo_rectangle_list_t*)cPtr).rectangles);
  }

  @property int numRectangles()
  {
    return (cast(cairo_rectangle_list_t*)cPtr).numRectangles;
  }

  @property void numRectangles(int propval)
  {
    (cast(cairo_rectangle_list_t*)cPtr).numRectangles = propval;
  }
}

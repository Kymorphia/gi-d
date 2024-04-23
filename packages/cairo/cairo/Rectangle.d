module cairo.Rectangle;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

class Rectangle : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == cairo_rectangle_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return cairo_gobject_rectangle_get_type();
  }

  @property double x()
  {
    return cPtr!cairo_rectangle_t.x;
  }

  @property void x(double propval)
  {
    cPtr!cairo_rectangle_t.x = propval;
  }

  @property double y()
  {
    return cPtr!cairo_rectangle_t.y;
  }

  @property void y(double propval)
  {
    cPtr!cairo_rectangle_t.y = propval;
  }

  @property double width()
  {
    return cPtr!cairo_rectangle_t.width;
  }

  @property void width(double propval)
  {
    cPtr!cairo_rectangle_t.width = propval;
  }

  @property double height()
  {
    return cPtr!cairo_rectangle_t.height;
  }

  @property void height(double propval)
  {
    cPtr!cairo_rectangle_t.height = propval;
  }
}

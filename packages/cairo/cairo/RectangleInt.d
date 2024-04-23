module cairo.RectangleInt;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

class RectangleInt : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == cairo_rectangle_int_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return cairo_gobject_rectangle_int_get_type();
  }

  @property int x()
  {
    return cPtr!cairo_rectangle_int_t.x;
  }

  @property void x(int propval)
  {
    cPtr!cairo_rectangle_int_t.x = propval;
  }

  @property int y()
  {
    return cPtr!cairo_rectangle_int_t.y;
  }

  @property void y(int propval)
  {
    cPtr!cairo_rectangle_int_t.y = propval;
  }

  @property int width()
  {
    return cPtr!cairo_rectangle_int_t.width;
  }

  @property void width(int propval)
  {
    cPtr!cairo_rectangle_int_t.width = propval;
  }

  @property int height()
  {
    return cPtr!cairo_rectangle_int_t.height;
  }

  @property void height(int propval)
  {
    cPtr!cairo_rectangle_int_t.height = propval;
  }
}

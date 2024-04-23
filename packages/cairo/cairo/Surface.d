module cairo.Surface;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import cairo.c.functions;
import cairo.c.types;

class Surface : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == cairo_surface_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return cairo_gobject_surface_get_type();
  }
}

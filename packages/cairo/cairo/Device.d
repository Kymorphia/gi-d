module cairo.Device;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import cairo.c.functions;
import cairo.c.types;

class Device : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == cairo_device_t))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return cairo_gobject_device_get_type();
  }
}

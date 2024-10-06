module Gtk.ScaleClass;

import Gid.gid;
import Gtk.RangeClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class ScaleClass
{
  GtkScaleClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ScaleClass");

    cInstance = *cast(GtkScaleClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property RangeClass parentClass()
  {
    return new RangeClass(cast(GtkRangeClass*)&(cast(GtkScaleClass*)cPtr).parentClass);
  }

  alias GetLayoutOffsetsFuncType = extern(C) void function(GtkScale* scale, int* x, int* y);

  @property GetLayoutOffsetsFuncType getLayoutOffsets()
  {
    return (cast(GtkScaleClass*)cPtr).getLayoutOffsets;
  }
}

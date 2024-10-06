module Gtk.FrameClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class FrameClass
{
  GtkFrameClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.FrameClass");

    cInstance = *cast(GtkFrameClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkFrameClass*)cPtr).parentClass);
  }

  alias ComputeChildAllocationFuncType = extern(C) void function(GtkFrame* frame, GtkAllocation* allocation);

  @property ComputeChildAllocationFuncType computeChildAllocation()
  {
    return (cast(GtkFrameClass*)cPtr).computeChildAllocation;
  }
}

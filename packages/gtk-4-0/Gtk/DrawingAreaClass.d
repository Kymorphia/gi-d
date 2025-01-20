module Gtk.DrawingAreaClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class DrawingAreaClass
{
  GtkDrawingAreaClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.DrawingAreaClass");

    cInstance = *cast(GtkDrawingAreaClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkDrawingAreaClass*)cPtr).parentClass);
  }

  alias ResizeFuncType = extern(C) void function(GtkDrawingArea* area, int width, int height);

  @property ResizeFuncType resize()
  {
    return (cast(GtkDrawingAreaClass*)cPtr).resize;
  }
}

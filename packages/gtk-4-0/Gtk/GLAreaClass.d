module Gtk.GLAreaClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkGLAreaClass` structure contains only private data.
 */
class GLAreaClass
{
  GtkGLAreaClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.GLAreaClass");

    cInstance = *cast(GtkGLAreaClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias RenderFuncType = extern(C) bool function(GtkGLArea* area, GdkGLContext* context);

  @property RenderFuncType render()
  {
    return (cast(GtkGLAreaClass*)cPtr).render;
  }

  alias ResizeFuncType = extern(C) void function(GtkGLArea* area, int width, int height);

  @property ResizeFuncType resize()
  {
    return (cast(GtkGLAreaClass*)cPtr).resize;
  }
}

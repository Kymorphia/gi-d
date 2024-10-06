module Gtk.LayoutManagerClass;

import GObject.Types;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkLayoutManagerClass` structure contains only private data, and
 * should only be accessed through the provided API, or when subclassing
 * `GtkLayoutManager`.
 */
class LayoutManagerClass
{
  GtkLayoutManagerClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.LayoutManagerClass");

    cInstance = *cast(GtkLayoutManagerClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias GetRequestModeFuncType = extern(C) GtkSizeRequestMode function(GtkLayoutManager* manager, GtkWidget* widget);

  @property GetRequestModeFuncType getRequestMode()
  {
    return (cast(GtkLayoutManagerClass*)cPtr).getRequestMode;
  }

  alias MeasureFuncType = extern(C) void function(GtkLayoutManager* manager, GtkWidget* widget, GtkOrientation orientation, int forSize, int* minimum, int* natural, int* minimumBaseline, int* naturalBaseline);

  @property MeasureFuncType measure()
  {
    return (cast(GtkLayoutManagerClass*)cPtr).measure;
  }

  alias AllocateFuncType = extern(C) void function(GtkLayoutManager* manager, GtkWidget* widget, int width, int height, int baseline);

  @property AllocateFuncType allocate()
  {
    return (cast(GtkLayoutManagerClass*)cPtr).allocate;
  }

  @property GType layoutChildType()
  {
    return (cast(GtkLayoutManagerClass*)cPtr).layoutChildType;
  }

  alias CreateLayoutChildFuncType = extern(C) GtkLayoutChild* function(GtkLayoutManager* manager, GtkWidget* widget, GtkWidget* forChild);

  @property CreateLayoutChildFuncType createLayoutChild()
  {
    return (cast(GtkLayoutManagerClass*)cPtr).createLayoutChild;
  }

  alias RootFuncType = extern(C) void function(GtkLayoutManager* manager);

  @property RootFuncType root()
  {
    return (cast(GtkLayoutManagerClass*)cPtr).root;
  }

  alias UnrootFuncType = extern(C) void function(GtkLayoutManager* manager);

  @property UnrootFuncType unroot()
  {
    return (cast(GtkLayoutManagerClass*)cPtr).unroot;
  }
}

module Gtk.WidgetPaintableClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class WidgetPaintableClass
{
  GtkWidgetPaintableClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.WidgetPaintableClass");

    cInstance = *cast(GtkWidgetPaintableClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkWidgetPaintableClass*)cPtr).parentClass);
  }
}

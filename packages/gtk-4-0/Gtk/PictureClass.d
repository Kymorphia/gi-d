module Gtk.PictureClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class PictureClass
{
  GtkPictureClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.PictureClass");

    cInstance = *cast(GtkPictureClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkPictureClass*)cPtr).parentClass);
  }
}

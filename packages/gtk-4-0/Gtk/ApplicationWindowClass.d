module Gtk.ApplicationWindowClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WindowClass;
import Gtk.c.functions;
import Gtk.c.types;

class ApplicationWindowClass
{
  GtkApplicationWindowClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ApplicationWindowClass");

    cInstance = *cast(GtkApplicationWindowClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WindowClass parentClass()
  {
    return new WindowClass(cast(GtkWindowClass*)&(cast(GtkApplicationWindowClass*)cPtr).parentClass);
  }
}

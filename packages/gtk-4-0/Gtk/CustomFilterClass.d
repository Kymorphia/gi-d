module Gtk.CustomFilterClass;

import Gid.gid;
import Gtk.FilterClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CustomFilterClass
{
  GtkCustomFilterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CustomFilterClass");

    cInstance = *cast(GtkCustomFilterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property FilterClass parentClass()
  {
    return new FilterClass(cast(GtkFilterClass*)&(cast(GtkCustomFilterClass*)cPtr).parentClass);
  }
}

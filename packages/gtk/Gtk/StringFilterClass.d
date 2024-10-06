module Gtk.StringFilterClass;

import Gid.gid;
import Gtk.FilterClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class StringFilterClass
{
  GtkStringFilterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.StringFilterClass");

    cInstance = *cast(GtkStringFilterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property FilterClass parentClass()
  {
    return new FilterClass(cast(GtkFilterClass*)&(cast(GtkStringFilterClass*)cPtr).parentClass);
  }
}

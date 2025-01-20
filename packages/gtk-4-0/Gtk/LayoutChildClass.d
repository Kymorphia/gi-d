module Gtk.LayoutChildClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class LayoutChildClass
{
  GtkLayoutChildClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.LayoutChildClass");

    cInstance = *cast(GtkLayoutChildClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}

module Gtk.FixedLayoutChildClass;

import Gid.gid;
import Gtk.LayoutChildClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class FixedLayoutChildClass
{
  GtkFixedLayoutChildClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.FixedLayoutChildClass");

    cInstance = *cast(GtkFixedLayoutChildClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property LayoutChildClass parentClass()
  {
    return new LayoutChildClass(cast(GtkLayoutChildClass*)&(cast(GtkFixedLayoutChildClass*)cPtr).parentClass);
  }
}

module Gtk.CustomLayoutClass;

import Gid.gid;
import Gtk.LayoutManagerClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CustomLayoutClass
{
  GtkCustomLayoutClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CustomLayoutClass");

    cInstance = *cast(GtkCustomLayoutClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property LayoutManagerClass parentClass()
  {
    return new LayoutManagerClass(cast(GtkLayoutManagerClass*)&(cast(GtkCustomLayoutClass*)cPtr).parentClass);
  }
}

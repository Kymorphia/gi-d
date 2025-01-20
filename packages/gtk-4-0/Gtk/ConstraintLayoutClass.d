module Gtk.ConstraintLayoutClass;

import Gid.gid;
import Gtk.LayoutManagerClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class ConstraintLayoutClass
{
  GtkConstraintLayoutClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ConstraintLayoutClass");

    cInstance = *cast(GtkConstraintLayoutClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property LayoutManagerClass parentClass()
  {
    return new LayoutManagerClass(cast(GtkLayoutManagerClass*)&(cast(GtkConstraintLayoutClass*)cPtr).parentClass);
  }
}

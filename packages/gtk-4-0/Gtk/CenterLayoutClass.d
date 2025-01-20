module Gtk.CenterLayoutClass;

import Gid.gid;
import Gtk.LayoutManagerClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CenterLayoutClass
{
  GtkCenterLayoutClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CenterLayoutClass");

    cInstance = *cast(GtkCenterLayoutClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property LayoutManagerClass parentClass()
  {
    return new LayoutManagerClass(cast(GtkLayoutManagerClass*)&(cast(GtkCenterLayoutClass*)cPtr).parentClass);
  }
}

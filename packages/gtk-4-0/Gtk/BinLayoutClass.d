module Gtk.BinLayoutClass;

import Gid.gid;
import Gtk.LayoutManagerClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class BinLayoutClass
{
  GtkBinLayoutClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.BinLayoutClass");

    cInstance = *cast(GtkBinLayoutClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property LayoutManagerClass parentClass()
  {
    return new LayoutManagerClass(cast(GtkLayoutManagerClass*)&(cast(GtkBinLayoutClass*)cPtr).parentClass);
  }
}

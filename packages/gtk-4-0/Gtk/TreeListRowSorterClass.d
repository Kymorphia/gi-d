module Gtk.TreeListRowSorterClass;

import Gid.gid;
import Gtk.SorterClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class TreeListRowSorterClass
{
  GtkTreeListRowSorterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TreeListRowSorterClass");

    cInstance = *cast(GtkTreeListRowSorterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property SorterClass parentClass()
  {
    return new SorterClass(cast(GtkSorterClass*)&(cast(GtkTreeListRowSorterClass*)cPtr).parentClass);
  }
}

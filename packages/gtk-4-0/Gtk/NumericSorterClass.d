module Gtk.NumericSorterClass;

import Gid.gid;
import Gtk.SorterClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class NumericSorterClass
{
  GtkNumericSorterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.NumericSorterClass");

    cInstance = *cast(GtkNumericSorterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property SorterClass parentClass()
  {
    return new SorterClass(cast(GtkSorterClass*)&(cast(GtkNumericSorterClass*)cPtr).parentClass);
  }
}

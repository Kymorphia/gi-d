module Gtk.SorterClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The virtual table for `GtkSorter`.
 */
class SorterClass
{
  GtkSorterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.SorterClass");

    cInstance = *cast(GtkSorterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkSorterClass*)cPtr).parentClass);
  }

  alias CompareFuncType = extern(C) GtkOrdering function(GtkSorter* self, ObjectC* item1, ObjectC* item2);

  @property CompareFuncType compare()
  {
    return (cast(GtkSorterClass*)cPtr).compare;
  }

  alias GetOrderFuncType = extern(C) GtkSorterOrder function(GtkSorter* self);

  @property GetOrderFuncType getOrder()
  {
    return (cast(GtkSorterClass*)cPtr).getOrder;
  }
}

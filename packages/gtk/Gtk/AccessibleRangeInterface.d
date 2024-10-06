module Gtk.AccessibleRangeInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class AccessibleRangeInterface
{
  GtkAccessibleRangeInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.AccessibleRangeInterface");

    cInstance = *cast(GtkAccessibleRangeInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkAccessibleRangeInterface*)cPtr).gIface);
  }

  alias SetCurrentValueFuncType = extern(C) bool function(GtkAccessibleRange* self, double value);

  @property SetCurrentValueFuncType setCurrentValue()
  {
    return (cast(GtkAccessibleRangeInterface*)cPtr).setCurrentValue;
  }
}

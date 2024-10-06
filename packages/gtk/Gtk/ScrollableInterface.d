module Gtk.ScrollableInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class ScrollableInterface
{
  GtkScrollableInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ScrollableInterface");

    cInstance = *cast(GtkScrollableInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface baseIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkScrollableInterface*)cPtr).baseIface);
  }

  alias GetBorderFuncType = extern(C) bool function(GtkScrollable* scrollable, GtkBorder* border);

  @property GetBorderFuncType getBorder()
  {
    return (cast(GtkScrollableInterface*)cPtr).getBorder;
  }
}

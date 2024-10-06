module Gtk.StyleContextClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class StyleContextClass
{
  GtkStyleContextClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.StyleContextClass");

    cInstance = *cast(GtkStyleContextClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkStyleContextClass*)cPtr).parentClass);
  }

  alias ChangedFuncType = extern(C) void function(GtkStyleContext* context);

  @property ChangedFuncType changed()
  {
    return (cast(GtkStyleContextClass*)cPtr).changed;
  }
}

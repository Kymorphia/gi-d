module Gtk.IMContextSimpleClass;

import Gid.gid;
import Gtk.IMContextClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class IMContextSimpleClass
{
  GtkIMContextSimpleClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.IMContextSimpleClass");

    cInstance = *cast(GtkIMContextSimpleClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property IMContextClass parentClass()
  {
    return new IMContextClass(cast(GtkIMContextClass*)&(cast(GtkIMContextSimpleClass*)cPtr).parentClass);
  }
}

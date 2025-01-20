module Gtk.MapListModelClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class MapListModelClass
{
  GtkMapListModelClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.MapListModelClass");

    cInstance = *cast(GtkMapListModelClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkMapListModelClass*)cPtr).parentClass);
  }
}

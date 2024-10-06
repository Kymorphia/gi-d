module Gtk.FilterClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class FilterClass
{
  GtkFilterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.FilterClass");

    cInstance = *cast(GtkFilterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkFilterClass*)cPtr).parentClass);
  }

  alias MatchFuncType = extern(C) bool function(GtkFilter* self, ObjectC* item);

  @property MatchFuncType match()
  {
    return (cast(GtkFilterClass*)cPtr).match;
  }

  alias GetStrictnessFuncType = extern(C) GtkFilterMatch function(GtkFilter* self);

  @property GetStrictnessFuncType getStrictness()
  {
    return (cast(GtkFilterClass*)cPtr).getStrictness;
  }
}

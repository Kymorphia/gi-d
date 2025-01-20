module Gtk.ApplicationClass;

import Gid.gid;
import Gio.ApplicationClass : DGioApplicationClass = ApplicationClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class ApplicationClass
{
  GtkApplicationClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ApplicationClass");

    cInstance = *cast(GtkApplicationClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property DGioApplicationClass parentClass()
  {
    return new DGioApplicationClass(cast(GApplicationClass*)&(cast(GtkApplicationClass*)cPtr).parentClass);
  }

  alias WindowAddedFuncType = extern(C) void function(GtkApplication* application, GtkWindow* window);

  @property WindowAddedFuncType windowAdded()
  {
    return (cast(GtkApplicationClass*)cPtr).windowAdded;
  }

  alias WindowRemovedFuncType = extern(C) void function(GtkApplication* application, GtkWindow* window);

  @property WindowRemovedFuncType windowRemoved()
  {
    return (cast(GtkApplicationClass*)cPtr).windowRemoved;
  }
}

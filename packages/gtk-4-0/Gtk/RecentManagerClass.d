module Gtk.RecentManagerClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkRecentManagerClass` contains only private data.
 */
class RecentManagerClass
{
  GtkRecentManagerClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.RecentManagerClass");

    cInstance = *cast(GtkRecentManagerClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias ChangedFuncType = extern(C) void function(GtkRecentManager* manager);

  @property ChangedFuncType changed()
  {
    return (cast(GtkRecentManagerClass*)cPtr).changed;
  }

  alias GtkRecent1FuncType = extern(C) void function();

  @property GtkRecent1FuncType GtkRecent1()
  {
    return (cast(GtkRecentManagerClass*)cPtr).GtkRecent1;
  }

  alias GtkRecent2FuncType = extern(C) void function();

  @property GtkRecent2FuncType GtkRecent2()
  {
    return (cast(GtkRecentManagerClass*)cPtr).GtkRecent2;
  }

  alias GtkRecent3FuncType = extern(C) void function();

  @property GtkRecent3FuncType GtkRecent3()
  {
    return (cast(GtkRecentManagerClass*)cPtr).GtkRecent3;
  }

  alias GtkRecent4FuncType = extern(C) void function();

  @property GtkRecent4FuncType GtkRecent4()
  {
    return (cast(GtkRecentManagerClass*)cPtr).GtkRecent4;
  }
}

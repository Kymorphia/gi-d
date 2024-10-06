module Gtk.TreeSortableIface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class TreeSortableIface
{
  GtkTreeSortableIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TreeSortableIface");

    cInstance = *cast(GtkTreeSortableIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias SortColumnChangedFuncType = extern(C) void function(GtkTreeSortable* sortable);

  @property SortColumnChangedFuncType sortColumnChanged()
  {
    return (cast(GtkTreeSortableIface*)cPtr).sortColumnChanged;
  }

  alias GetSortColumnIdFuncType = extern(C) bool function(GtkTreeSortable* sortable, int* sortColumnId, GtkSortType* order);

  @property GetSortColumnIdFuncType getSortColumnId()
  {
    return (cast(GtkTreeSortableIface*)cPtr).getSortColumnId;
  }

  alias SetSortColumnIdFuncType = extern(C) void function(GtkTreeSortable* sortable, int sortColumnId, GtkSortType order);

  @property SetSortColumnIdFuncType setSortColumnId()
  {
    return (cast(GtkTreeSortableIface*)cPtr).setSortColumnId;
  }

  alias SetSortFuncFuncType = extern(C) void function(GtkTreeSortable* sortable, int sortColumnId, GtkTreeIterCompareFunc sortFunc, void* userData, GDestroyNotify destroy);

  @property SetSortFuncFuncType setSortFunc()
  {
    return (cast(GtkTreeSortableIface*)cPtr).setSortFunc;
  }

  alias SetDefaultSortFuncFuncType = extern(C) void function(GtkTreeSortable* sortable, GtkTreeIterCompareFunc sortFunc, void* userData, GDestroyNotify destroy);

  @property SetDefaultSortFuncFuncType setDefaultSortFunc()
  {
    return (cast(GtkTreeSortableIface*)cPtr).setDefaultSortFunc;
  }

  alias HasDefaultSortFuncFuncType = extern(C) bool function(GtkTreeSortable* sortable);

  @property HasDefaultSortFuncFuncType hasDefaultSortFunc()
  {
    return (cast(GtkTreeSortableIface*)cPtr).hasDefaultSortFunc;
  }
}

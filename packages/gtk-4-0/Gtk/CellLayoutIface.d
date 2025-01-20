module Gtk.CellLayoutIface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CellLayoutIface
{
  GtkCellLayoutIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CellLayoutIface");

    cInstance = *cast(GtkCellLayoutIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias PackStartFuncType = extern(C) void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, bool expand);

  @property PackStartFuncType packStart()
  {
    return (cast(GtkCellLayoutIface*)cPtr).packStart;
  }

  alias PackEndFuncType = extern(C) void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, bool expand);

  @property PackEndFuncType packEnd()
  {
    return (cast(GtkCellLayoutIface*)cPtr).packEnd;
  }

  alias ClearFuncType = extern(C) void function(GtkCellLayout* cellLayout);

  @property ClearFuncType clear()
  {
    return (cast(GtkCellLayoutIface*)cPtr).clear;
  }

  alias AddAttributeFuncType = extern(C) void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, const(char)* attribute, int column);

  @property AddAttributeFuncType addAttribute()
  {
    return (cast(GtkCellLayoutIface*)cPtr).addAttribute;
  }

  alias SetCellDataFuncFuncType = extern(C) void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, GtkCellLayoutDataFunc func, void* funcData, GDestroyNotify destroy);

  @property SetCellDataFuncFuncType setCellDataFunc()
  {
    return (cast(GtkCellLayoutIface*)cPtr).setCellDataFunc;
  }

  alias ClearAttributesFuncType = extern(C) void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell);

  @property ClearAttributesFuncType clearAttributes()
  {
    return (cast(GtkCellLayoutIface*)cPtr).clearAttributes;
  }

  alias ReorderFuncType = extern(C) void function(GtkCellLayout* cellLayout, GtkCellRenderer* cell, int position);

  @property ReorderFuncType reorder()
  {
    return (cast(GtkCellLayoutIface*)cPtr).reorder;
  }

  alias GetCellsFuncType = extern(C) GList* function(GtkCellLayout* cellLayout);

  @property GetCellsFuncType getCells()
  {
    return (cast(GtkCellLayoutIface*)cPtr).getCells;
  }

  alias GetAreaFuncType = extern(C) GtkCellArea* function(GtkCellLayout* cellLayout);

  @property GetAreaFuncType getArea()
  {
    return (cast(GtkCellLayoutIface*)cPtr).getArea;
  }
}

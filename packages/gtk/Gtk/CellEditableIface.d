module Gtk.CellEditableIface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CellEditableIface
{
  GtkCellEditableIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CellEditableIface");

    cInstance = *cast(GtkCellEditableIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias EditingDoneFuncType = extern(C) void function(GtkCellEditable* cellEditable);

  @property EditingDoneFuncType editingDone()
  {
    return (cast(GtkCellEditableIface*)cPtr).editingDone;
  }

  alias RemoveWidgetFuncType = extern(C) void function(GtkCellEditable* cellEditable);

  @property RemoveWidgetFuncType removeWidget()
  {
    return (cast(GtkCellEditableIface*)cPtr).removeWidget;
  }

  alias StartEditingFuncType = extern(C) void function(GtkCellEditable* cellEditable, GdkEvent* event);

  @property StartEditingFuncType startEditing()
  {
    return (cast(GtkCellEditableIface*)cPtr).startEditing;
  }
}

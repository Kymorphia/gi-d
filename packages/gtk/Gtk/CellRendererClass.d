module Gtk.CellRendererClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CellRendererClass
{
  GtkCellRendererClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CellRendererClass");

    cInstance = *cast(GtkCellRendererClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias GetRequestModeFuncType = extern(C) GtkSizeRequestMode function(GtkCellRenderer* cell);

  @property GetRequestModeFuncType getRequestMode()
  {
    return (cast(GtkCellRendererClass*)cPtr).getRequestMode;
  }

  alias GetPreferredWidthFuncType = extern(C) void function(GtkCellRenderer* cell, GtkWidget* widget, int* minimumSize, int* naturalSize);

  @property GetPreferredWidthFuncType getPreferredWidth()
  {
    return (cast(GtkCellRendererClass*)cPtr).getPreferredWidth;
  }

  alias GetPreferredHeightForWidthFuncType = extern(C) void function(GtkCellRenderer* cell, GtkWidget* widget, int width, int* minimumHeight, int* naturalHeight);

  @property GetPreferredHeightForWidthFuncType getPreferredHeightForWidth()
  {
    return (cast(GtkCellRendererClass*)cPtr).getPreferredHeightForWidth;
  }

  alias GetPreferredHeightFuncType = extern(C) void function(GtkCellRenderer* cell, GtkWidget* widget, int* minimumSize, int* naturalSize);

  @property GetPreferredHeightFuncType getPreferredHeight()
  {
    return (cast(GtkCellRendererClass*)cPtr).getPreferredHeight;
  }

  alias GetPreferredWidthForHeightFuncType = extern(C) void function(GtkCellRenderer* cell, GtkWidget* widget, int height, int* minimumWidth, int* naturalWidth);

  @property GetPreferredWidthForHeightFuncType getPreferredWidthForHeight()
  {
    return (cast(GtkCellRendererClass*)cPtr).getPreferredWidthForHeight;
  }

  alias GetAlignedAreaFuncType = extern(C) void function(GtkCellRenderer* cell, GtkWidget* widget, GtkCellRendererState flags, const(GdkRectangle)* cellArea, GdkRectangle* alignedArea);

  @property GetAlignedAreaFuncType getAlignedArea()
  {
    return (cast(GtkCellRendererClass*)cPtr).getAlignedArea;
  }

  alias SnapshotFuncType = extern(C) void function(GtkCellRenderer* cell, GtkSnapshot* snapshot, GtkWidget* widget, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags);

  @property SnapshotFuncType snapshot()
  {
    return (cast(GtkCellRendererClass*)cPtr).snapshot;
  }

  alias ActivateFuncType = extern(C) bool function(GtkCellRenderer* cell, GdkEvent* event, GtkWidget* widget, const(char)* path, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags);

  @property ActivateFuncType activate()
  {
    return (cast(GtkCellRendererClass*)cPtr).activate;
  }

  alias StartEditingFuncType = extern(C) GtkCellEditable* function(GtkCellRenderer* cell, GdkEvent* event, GtkWidget* widget, const(char)* path, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags);

  @property StartEditingFuncType startEditing()
  {
    return (cast(GtkCellRendererClass*)cPtr).startEditing;
  }

  alias EditingCanceledFuncType = extern(C) void function(GtkCellRenderer* cell);

  @property EditingCanceledFuncType editingCanceled()
  {
    return (cast(GtkCellRendererClass*)cPtr).editingCanceled;
  }

  alias EditingStartedFuncType = extern(C) void function(GtkCellRenderer* cell, GtkCellEditable* editable, const(char)* path);

  @property EditingStartedFuncType editingStarted()
  {
    return (cast(GtkCellRendererClass*)cPtr).editingStarted;
  }
}

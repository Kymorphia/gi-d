module Gtk.CellAreaContextClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CellAreaContextClass
{
  GtkCellAreaContextClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CellAreaContextClass");

    cInstance = *cast(GtkCellAreaContextClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias AllocateFuncType = extern(C) void function(GtkCellAreaContext* context, int width, int height);

  @property AllocateFuncType allocate()
  {
    return (cast(GtkCellAreaContextClass*)cPtr).allocate;
  }

  alias ResetFuncType = extern(C) void function(GtkCellAreaContext* context);

  @property ResetFuncType reset()
  {
    return (cast(GtkCellAreaContextClass*)cPtr).reset;
  }

  alias GetPreferredHeightForWidthFuncType = extern(C) void function(GtkCellAreaContext* context, int width, int* minimumHeight, int* naturalHeight);

  @property GetPreferredHeightForWidthFuncType getPreferredHeightForWidth()
  {
    return (cast(GtkCellAreaContextClass*)cPtr).getPreferredHeightForWidth;
  }

  alias GetPreferredWidthForHeightFuncType = extern(C) void function(GtkCellAreaContext* context, int height, int* minimumWidth, int* naturalWidth);

  @property GetPreferredWidthForHeightFuncType getPreferredWidthForHeight()
  {
    return (cast(GtkCellAreaContextClass*)cPtr).getPreferredWidthForHeight;
  }
}

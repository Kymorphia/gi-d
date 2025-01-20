module Gtk.CellRendererTextClass;

import Gid.gid;
import Gtk.CellRendererClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CellRendererTextClass
{
  GtkCellRendererTextClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CellRendererTextClass");

    cInstance = *cast(GtkCellRendererTextClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property CellRendererClass parentClass()
  {
    return new CellRendererClass(cast(GtkCellRendererClass*)&(cast(GtkCellRendererTextClass*)cPtr).parentClass);
  }

  alias EditedFuncType = extern(C) void function(GtkCellRendererText* cellRendererText, const(char)* path, const(char)* newText);

  @property EditedFuncType edited()
  {
    return (cast(GtkCellRendererTextClass*)cPtr).edited;
  }
}

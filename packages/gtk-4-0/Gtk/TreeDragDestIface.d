module Gtk.TreeDragDestIface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class TreeDragDestIface
{
  GtkTreeDragDestIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TreeDragDestIface");

    cInstance = *cast(GtkTreeDragDestIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias DragDataReceivedFuncType = extern(C) bool function(GtkTreeDragDest* dragDest, GtkTreePath* dest, const(GValue)* value);

  @property DragDataReceivedFuncType dragDataReceived()
  {
    return (cast(GtkTreeDragDestIface*)cPtr).dragDataReceived;
  }

  alias RowDropPossibleFuncType = extern(C) bool function(GtkTreeDragDest* dragDest, GtkTreePath* destPath, const(GValue)* value);

  @property RowDropPossibleFuncType rowDropPossible()
  {
    return (cast(GtkTreeDragDestIface*)cPtr).rowDropPossible;
  }
}

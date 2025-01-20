module Gtk.TreeDragSourceIface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class TreeDragSourceIface
{
  GtkTreeDragSourceIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TreeDragSourceIface");

    cInstance = *cast(GtkTreeDragSourceIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias RowDraggableFuncType = extern(C) bool function(GtkTreeDragSource* dragSource, GtkTreePath* path);

  @property RowDraggableFuncType rowDraggable()
  {
    return (cast(GtkTreeDragSourceIface*)cPtr).rowDraggable;
  }

  alias DragDataGetFuncType = extern(C) GdkContentProvider* function(GtkTreeDragSource* dragSource, GtkTreePath* path);

  @property DragDataGetFuncType dragDataGet()
  {
    return (cast(GtkTreeDragSourceIface*)cPtr).dragDataGet;
  }

  alias DragDataDeleteFuncType = extern(C) bool function(GtkTreeDragSource* dragSource, GtkTreePath* path);

  @property DragDataDeleteFuncType dragDataDelete()
  {
    return (cast(GtkTreeDragSourceIface*)cPtr).dragDataDelete;
  }
}

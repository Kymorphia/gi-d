module Gtk.TreeDragSourceT;

public import GObject.ObjectG;
public import Gdk.ContentProvider;
public import Gid.gid;
public import Gtk.TreePath;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * Interface for Drag-and-Drop destinations in `GtkTreeView`.

 * Deprecated: List views use widgets to display their contents.
 *   You can use [Gtk.DragSource] to implement a drag source
 */
template TreeDragSourceT(TStruct)
{

  /**
   * Asks the `GtkTreeDragSource` to delete the row at path, because
   * it was moved somewhere else via drag-and-drop. Returns %FALSE
   * if the deletion fails because path no longer exists, or for
   * some model-specific reason. Should robustly handle a path no
   * longer found in the model!
   * Params:
   *   path = row that was being dragged
   * Returns: %TRUE if the row was successfully deleted

   * Deprecated: Use list models instead
   */
  override bool dragDataDelete(TreePath path)
  {
    bool _retval;
    _retval = gtk_tree_drag_source_drag_data_delete(cast(GtkTreeDragSource*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }

  /**
   * Asks the `GtkTreeDragSource` to return a `GdkContentProvider` representing
   * the row at path. Should robustly handle a path no
   * longer found in the model!
   * Params:
   *   path = row that was dragged
   * Returns: a `GdkContentProvider` for the
   *   given path

   * Deprecated: Use list models instead
   */
  override ContentProvider dragDataGet(TreePath path)
  {
    GdkContentProvider* _cretval;
    _cretval = gtk_tree_drag_source_drag_data_get(cast(GtkTreeDragSource*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!ContentProvider(cast(GdkContentProvider*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asks the `GtkTreeDragSource` whether a particular row can be used as
   * the source of a DND operation. If the source doesn’t implement
   * this interface, the row is assumed draggable.
   * Params:
   *   path = row on which user is initiating a drag
   * Returns: %TRUE if the row can be dragged

   * Deprecated: Use list models instead
   */
  override bool rowDraggable(TreePath path)
  {
    bool _retval;
    _retval = gtk_tree_drag_source_row_draggable(cast(GtkTreeDragSource*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }
}

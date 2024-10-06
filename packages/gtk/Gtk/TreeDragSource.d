module Gtk.TreeDragSource;

import GObject.ObjectG;
import Gdk.ContentProvider;
import Gid.gid;
import Gtk.TreePath;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Interface for Drag-and-Drop destinations in `GtkTreeView`.

 * Deprecated: List views use widgets to display their contents.
 *   You can use [Gtk.DragSource] to implement a drag source
 */
interface TreeDragSource
{

  static GType getType()
  {
    return gtk_tree_drag_source_get_type();
  }

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
  bool dragDataDelete(TreePath path);

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
  ContentProvider dragDataGet(TreePath path);

  /**
   * Asks the `GtkTreeDragSource` whether a particular row can be used as
   * the source of a DND operation. If the source doesn’t implement
   * this interface, the row is assumed draggable.
   * Params:
   *   path = row on which user is initiating a drag
   * Returns: %TRUE if the row can be dragged

   * Deprecated: Use list models instead
   */
  bool rowDraggable(TreePath path);
}

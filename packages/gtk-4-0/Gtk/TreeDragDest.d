module Gtk.TreeDragDest;

public import Gtk.TreeDragDestIfaceProxy;
import GObject.Value;
import Gid.gid;
import Gtk.TreePath;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Interface for Drag-and-Drop destinations in `GtkTreeView`.

 * Deprecated: List views use widgets to display their contents.
 *   You can use [Gtk.DropTarget] to implement a drop destination
 */
interface TreeDragDest
{

  static GType getType()
  {
    return gtk_tree_drag_dest_get_type();
  }

  /**
   * Asks the `GtkTreeDragDest` to insert a row before the path dest,
   * deriving the contents of the row from value. If dest is
   * outside the tree so that inserting before it is impossible, %FALSE
   * will be returned. Also, %FALSE may be returned if the new row is
   * not created for some model-specific reason.  Should robustly handle
   * a dest no longer found in the model!
   * Params:
   *   dest = row to drop in front of
   *   value = data to drop
   * Returns: whether a new row was created before position dest

   * Deprecated: Use list models instead
   */
  bool dragDataReceived(TreePath dest, Value value);

  /**
   * Determines whether a drop is possible before the given dest_path,
   * at the same depth as dest_path. i.e., can we drop the data in
   * value at that location. dest_path does not have to
   * exist; the return value will almost certainly be %FALSE if the
   * parent of dest_path doesn’t exist, though.
   * Params:
   *   destPath = destination row
   *   value = the data being dropped
   * Returns: %TRUE if a drop is possible before dest_path

   * Deprecated: Use list models instead
   */
  bool rowDropPossible(TreePath destPath, Value value);
}

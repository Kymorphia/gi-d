module Gtk.TreeSortable;

public import Gtk.TreeSortableIfaceProxy;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The interface for sortable models used by GtkTreeView
 * `GtkTreeSortable` is an interface to be implemented by tree models which
 * support sorting. The `GtkTreeView` uses the methods provided by this interface
 * to sort the model.

 * Deprecated: There is no replacement for this interface. You should
 *   use [Gtk.SortListModel] to wrap your list model instead
 */
interface TreeSortable
{

  static GType getType()
  {
    return gtk_tree_sortable_get_type();
  }

  /**
   * Fills in sort_column_id and order with the current sort column and the
   * order. It returns %TRUE unless the sort_column_id is
   * %GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID or
   * %GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID.
   * Params:
   *   sortColumnId = The sort column id to be filled in
   *   order = The `GtkSortType` to be filled in
   * Returns: %TRUE if the sort column is not one of the special sort
   *   column ids.
   */
  bool getSortColumnId(out int sortColumnId, out SortType order);

  /**
   * Returns %TRUE if the model has a default sort function. This is used
   * primarily by GtkTreeViewColumns in order to determine if a model can
   * go back to the default state, or not.
   * Returns: %TRUE, if the model has a default sort function
   */
  bool hasDefaultSortFunc();

  /**
   * Sets the default comparison function used when sorting to be sort_func.
   * If the current sort column id of sortable is
   * %GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID, then the model will sort using
   * this function.
   * If sort_func is %NULL, then there will be no default comparison function.
   * This means that once the model  has been sorted, it can’t go back to the
   * default state. In this case, when the current sort column id of sortable
   * is %GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID, the model will be unsorted.
   * Params:
   *   sortFunc = The comparison function
   */
  void setDefaultSortFunc(TreeIterCompareFunc sortFunc);

  /**
   * Sets the current sort column to be sort_column_id. The sortable will
   * resort itself to reflect this change, after emitting a
   * `GtkTreeSortable::sort-column-changed` signal. sort_column_id may either be
   * a regular column id, or one of the following special values:
   * - %GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID: the default sort function
   * will be used, if it is set
   * - %GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID: no sorting will occur
   * Params:
   *   sortColumnId = the sort column id to set
   *   order = The sort order of the column
   */
  void setSortColumnId(int sortColumnId, SortType order);

  /**
   * Sets the comparison function used when sorting to be sort_func. If the
   * current sort column id of sortable is the same as sort_column_id, then
   * the model will sort using this function.
   * Params:
   *   sortColumnId = the sort column id to set the function for
   *   sortFunc = The comparison function
   */
  void setSortFunc(int sortColumnId, TreeIterCompareFunc sortFunc);

  /**
   * Emits a `GtkTreeSortable::sort-column-changed` signal on sortable.
   */
  void sortColumnChanged();

  /**
   * The ::sort-column-changed signal is emitted when the sort column
   * or sort order of sortable is changed. The signal is emitted before
   * the contents of sortable are resorted.
   *   treeSortable = the instance the signal is connected to
   */
  alias SortColumnChangedCallback = void delegate(TreeSortable treeSortable);

  /**
   * Connect to SortColumnChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSortColumnChanged(SortColumnChangedCallback dlg, Flag!"After" after = No.After);
}

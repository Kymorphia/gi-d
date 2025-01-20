module Gtk.TreeSortableT;

public import Gtk.TreeSortableIfaceProxy;
public import GObject.DClosure;
public import GObject.ObjectG;
public import Gid.gid;
public import Gtk.TreeIter;
public import Gtk.TreeModel;
public import Gtk.TreeModelT;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * The interface for sortable models used by GtkTreeView
 * `GtkTreeSortable` is an interface to be implemented by tree models which
 * support sorting. The `GtkTreeView` uses the methods provided by this interface
 * to sort the model.

 * Deprecated: There is no replacement for this interface. You should
 *   use [Gtk.SortListModel] to wrap your list model instead
 */
template TreeSortableT()
{

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
  override bool getSortColumnId(out int sortColumnId, out SortType order)
  {
    bool _retval;
    _retval = gtk_tree_sortable_get_sort_column_id(cast(GtkTreeSortable*)cPtr, cast(int*)&sortColumnId, &order);
    return _retval;
  }

  /**
   * Returns %TRUE if the model has a default sort function. This is used
   * primarily by GtkTreeViewColumns in order to determine if a model can
   * go back to the default state, or not.
   * Returns: %TRUE, if the model has a default sort function
   */
  override bool hasDefaultSortFunc()
  {
    bool _retval;
    _retval = gtk_tree_sortable_has_default_sort_func(cast(GtkTreeSortable*)cPtr);
    return _retval;
  }

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
  override void setDefaultSortFunc(TreeIterCompareFunc sortFunc)
  {
    extern(C) int _sortFuncCallback(GtkTreeModel* model, GtkTreeIter* a, GtkTreeIter* b, void* userData)
    {
      auto _dlg = cast(TreeIterCompareFunc*)userData;

      int _retval = (*_dlg)(model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, a ? new TreeIter(cast(void*)a, false) : null, b ? new TreeIter(cast(void*)b, false) : null);
      return _retval;
    }

    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    gtk_tree_sortable_set_default_sort_func(cast(GtkTreeSortable*)cPtr, &_sortFuncCallback, _sortFunc, &thawDelegate);
  }

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
  override void setSortColumnId(int sortColumnId, SortType order)
  {
    gtk_tree_sortable_set_sort_column_id(cast(GtkTreeSortable*)cPtr, sortColumnId, order);
  }

  /**
   * Sets the comparison function used when sorting to be sort_func. If the
   * current sort column id of sortable is the same as sort_column_id, then
   * the model will sort using this function.
   * Params:
   *   sortColumnId = the sort column id to set the function for
   *   sortFunc = The comparison function
   */
  override void setSortFunc(int sortColumnId, TreeIterCompareFunc sortFunc)
  {
    extern(C) int _sortFuncCallback(GtkTreeModel* model, GtkTreeIter* a, GtkTreeIter* b, void* userData)
    {
      auto _dlg = cast(TreeIterCompareFunc*)userData;

      int _retval = (*_dlg)(model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, a ? new TreeIter(cast(void*)a, false) : null, b ? new TreeIter(cast(void*)b, false) : null);
      return _retval;
    }

    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    gtk_tree_sortable_set_sort_func(cast(GtkTreeSortable*)cPtr, sortColumnId, &_sortFuncCallback, _sortFunc, &thawDelegate);
  }

  /**
   * Emits a `GtkTreeSortable::sort-column-changed` signal on sortable.
   */
  override void sortColumnChanged()
  {
    gtk_tree_sortable_sort_column_changed(cast(GtkTreeSortable*)cPtr);
  }

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
  ulong connectSortColumnChanged(SortColumnChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeSortable = getVal!TreeSortable(_paramVals);
      _dgClosure.dlg(treeSortable);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("sort-column-changed", closure, after);
  }
}

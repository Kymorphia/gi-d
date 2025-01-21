module Gtk.TreeSelection;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.TreeView;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The selection object for GtkTreeView
 * The `GtkTreeSelection` object is a helper object to manage the selection
 * for a `GtkTreeView` widget.  The `GtkTreeSelection` object is
 * automatically created when a new `GtkTreeView` widget is created, and
 * cannot exist independently of this widget.  The primary reason the
 * `GtkTreeSelection` objects exists is for cleanliness of code and API.
 * That is, there is no conceptual reason all these functions could not be
 * methods on the `GtkTreeView` widget instead of a separate function.
 * The `GtkTreeSelection` object is gotten from a `GtkTreeView` by calling
 * [Gtk.TreeView.getSelection].  It can be manipulated to check the
 * selection status of the tree, as well as select and deselect individual
 * rows.  Selection is done completely view side.  As a result, multiple
 * views of the same model can have completely different selections.
 * Additionally, you cannot change the selection of a row on the model that
 * is not currently displayed by the view without expanding its parents
 * first.
 * One of the important things to remember when monitoring the selection of
 * a view is that the `GtkTreeSelection`::changed signal is mostly a hint.
 * That is, it may only emit one signal when a range of rows is selected.
 * Additionally, it may on occasion emit a `GtkTreeSelection`::changed signal
 * when nothing has happened $(LPAREN)mostly as a result of programmers calling
 * select_row on an already selected row$(RPAREN).

 * Deprecated: Use [Gtk.SelectionModel] instead
 */
class TreeSelection : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_tree_selection_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the number of rows that have been selected in tree.
   * Returns: The number of rows selected.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  int countSelectedRows()
  {
    int _retval;
    _retval = gtk_tree_selection_count_selected_rows(cast(GtkTreeSelection*)cPtr);
    return _retval;
  }

  /**
   * Gets the selection mode for selection. See
   * [Gtk.TreeSelection.setMode].
   * Returns: the current selection mode

   * Deprecated: Use GtkListView or GtkColumnView
   */
  SelectionMode getMode()
  {
    GtkSelectionMode _cretval;
    _cretval = gtk_tree_selection_get_mode(cast(GtkTreeSelection*)cPtr);
    SelectionMode _retval = cast(SelectionMode)_cretval;
    return _retval;
  }

  /**
   * Sets iter to the currently selected node if selection is set to
   * %GTK_SELECTION_SINGLE or %GTK_SELECTION_BROWSE.  iter may be NULL if you
   * just want to test if selection has any selected nodes.  model is filled
   * with the current model as a convenience.  This function will not work if you
   * use selection is %GTK_SELECTION_MULTIPLE.
   * Params:
   *   model = A pointer to set to the `GtkTreeModel`
   *   iter = The `GtkTreeIter`
   * Returns: TRUE, if there is a selected node.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  bool getSelected(out TreeModel model, out TreeIter iter)
  {
    bool _retval;
    GtkTreeModel* _model;
    GtkTreeIter _iter;
    _retval = gtk_tree_selection_get_selected(cast(GtkTreeSelection*)cPtr, &_model, &_iter);
    model = _model ? ObjectG.getDObject!TreeModel(_model, false) : null;
    iter = new TreeIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Creates a list of path of all selected rows. Additionally, if you are
   * planning on modifying the model after calling this function, you may
   * want to convert the returned list into a list of `GtkTreeRowReference`s.
   * To do this, you can use [Gtk.TreeRowReference.new_].
   * To free the return value, use:
   * |[<!-- language\="C" -->
   * g_list_free_full $(LPAREN)list, $(LPAREN)GDestroyNotify$(RPAREN) gtk_tree_path_free$(RPAREN);
   * ]|
   * Params:
   *   model = A pointer to set to the `GtkTreeModel`
   * Returns: A `GList` containing a `GtkTreePath` for each selected row.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  List!(TreePath) getSelectedRows(out TreeModel model)
  {
    GList* _cretval;
    GtkTreeModel* _model;
    _cretval = gtk_tree_selection_get_selected_rows(cast(GtkTreeSelection*)cPtr, &_model);
    List!(TreePath) _retval = new List!(TreePath)(cast(GList*)_cretval, GidOwnership.Full);
    model = _model ? ObjectG.getDObject!TreeModel(_model, false) : null;
    return _retval;
  }

  /**
   * Returns the tree view associated with selection.
   * Returns: A `GtkTreeView`

   * Deprecated: Use GtkListView or GtkColumnView
   */
  TreeView getTreeView()
  {
    GtkTreeView* _cretval;
    _cretval = gtk_tree_selection_get_tree_view(cast(GtkTreeSelection*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeView(cast(GtkTreeView*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if the row at iter is currently selected.
   * Params:
   *   iter = A valid `GtkTreeIter`
   * Returns: %TRUE, if iter is selected

   * Deprecated: Use GtkListView or GtkColumnView
   */
  bool iterIsSelected(TreeIter iter)
  {
    bool _retval;
    _retval = gtk_tree_selection_iter_is_selected(cast(GtkTreeSelection*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns %TRUE if the row pointed to by path is currently selected.  If path
   * does not point to a valid location, %FALSE is returned
   * Params:
   *   path = A `GtkTreePath` to check selection on.
   * Returns: %TRUE if path is selected.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  bool pathIsSelected(TreePath path)
  {
    bool _retval;
    _retval = gtk_tree_selection_path_is_selected(cast(GtkTreeSelection*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }

  /**
   * Selects all the nodes. selection must be set to %GTK_SELECTION_MULTIPLE
   * mode.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void selectAll()
  {
    gtk_tree_selection_select_all(cast(GtkTreeSelection*)cPtr);
  }

  /**
   * Selects the specified iterator.
   * Params:
   *   iter = The `GtkTreeIter` to be selected.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void selectIter(TreeIter iter)
  {
    gtk_tree_selection_select_iter(cast(GtkTreeSelection*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
  }

  /**
   * Select the row at path.
   * Params:
   *   path = The `GtkTreePath` to be selected.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void selectPath(TreePath path)
  {
    gtk_tree_selection_select_path(cast(GtkTreeSelection*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Selects a range of nodes, determined by start_path and end_path inclusive.
   * selection must be set to %GTK_SELECTION_MULTIPLE mode.
   * Params:
   *   startPath = The initial node of the range.
   *   endPath = The final node of the range.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void selectRange(TreePath startPath, TreePath endPath)
  {
    gtk_tree_selection_select_range(cast(GtkTreeSelection*)cPtr, startPath ? cast(GtkTreePath*)startPath.cPtr(false) : null, endPath ? cast(GtkTreePath*)endPath.cPtr(false) : null);
  }

  /**
   * Calls a function for each selected node. Note that you cannot modify
   * the tree or selection from within this function. As a result,
   * [Gtk.TreeSelection.getSelectedRows] might be more useful.
   * Params:
   *   func = The function to call for each selected node.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void selectedForeach(TreeSelectionForeachFunc func)
  {
    extern(C) void _funcCallback(GtkTreeModel* model, GtkTreePath* path, GtkTreeIter* iter, void* data)
    {
      auto _dlg = cast(TreeSelectionForeachFunc*)data;

      (*_dlg)(model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, path ? new TreePath(cast(void*)path, false) : null, iter ? new TreeIter(cast(void*)iter, false) : null);
    }

    auto _func = cast(void*)&func;
    gtk_tree_selection_selected_foreach(cast(GtkTreeSelection*)cPtr, &_funcCallback, _func);
  }

  /**
   * Sets the selection mode of the selection.  If the previous type was
   * %GTK_SELECTION_MULTIPLE, then the anchor is kept selected, if it was
   * previously selected.
   * Params:
   *   type = The selection mode

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void setMode(SelectionMode type)
  {
    gtk_tree_selection_set_mode(cast(GtkTreeSelection*)cPtr, type);
  }

  /**
   * Sets the selection function.
   * If set, this function is called before any node is selected or unselected,
   * giving some control over which nodes are selected. The select function
   * should return %TRUE if the state of the node may be toggled, and %FALSE
   * if the state of the node should be left unchanged.
   * Params:
   *   func = The selection function. May be %NULL

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void setSelectFunction(TreeSelectionFunc func)
  {
    extern(C) bool _funcCallback(GtkTreeSelection* selection, GtkTreeModel* model, GtkTreePath* path, bool pathCurrentlySelected, void* data)
    {
      auto _dlg = cast(TreeSelectionFunc*)data;

      bool _retval = (*_dlg)(selection ? ObjectG.getDObject!TreeSelection(cast(void*)selection, false) : null, model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, path ? new TreePath(cast(void*)path, false) : null, pathCurrentlySelected);
      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_tree_selection_set_select_function(cast(GtkTreeSelection*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Unselects all the nodes.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void unselectAll()
  {
    gtk_tree_selection_unselect_all(cast(GtkTreeSelection*)cPtr);
  }

  /**
   * Unselects the specified iterator.
   * Params:
   *   iter = The `GtkTreeIter` to be unselected.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void unselectIter(TreeIter iter)
  {
    gtk_tree_selection_unselect_iter(cast(GtkTreeSelection*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
  }

  /**
   * Unselects the row at path.
   * Params:
   *   path = The `GtkTreePath` to be unselected.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void unselectPath(TreePath path)
  {
    gtk_tree_selection_unselect_path(cast(GtkTreeSelection*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Unselects a range of nodes, determined by start_path and end_path
   * inclusive.
   * Params:
   *   startPath = The initial node of the range.
   *   endPath = The initial node of the range.

   * Deprecated: Use GtkListView or GtkColumnView
   */
  void unselectRange(TreePath startPath, TreePath endPath)
  {
    gtk_tree_selection_unselect_range(cast(GtkTreeSelection*)cPtr, startPath ? cast(GtkTreePath*)startPath.cPtr(false) : null, endPath ? cast(GtkTreePath*)endPath.cPtr(false) : null);
  }

  /**
   * Emitted whenever the selection has $(LPAREN)possibly$(RPAREN) changed. Please note that
   * this signal is mostly a hint.  It may only be emitted once when a range
   * of rows are selected, and it may occasionally be emitted when nothing
   * has happened.
   *   treeSelection = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(TreeSelection treeSelection);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeSelection = getVal!TreeSelection(_paramVals);
      _dgClosure.dlg(treeSelection);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }
}

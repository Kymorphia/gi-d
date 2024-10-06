module Gtk.TreeModelSort;

import GObject.ObjectG;
import Gid.gid;
import Gtk.TreeDragSource;
import Gtk.TreeDragSourceT;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.TreeSortable;
import Gtk.TreeSortableT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A GtkTreeModel which makes an underlying tree model sortable
 * The `GtkTreeModelSort` is a model which implements the `GtkTreeSortable`
 * interface.  It does not hold any data itself, but rather is created with
 * a child model and proxies its data.  It has identical column types to
 * this child model, and the changes in the child are propagated.  The
 * primary purpose of this model is to provide a way to sort a different
 * model without modifying it. Note that the sort function used by
 * `GtkTreeModelSort` is not guaranteed to be stable.
 * The use of this is best demonstrated through an example.  In the
 * following sample code we create two `GtkTreeView` widgets each with a
 * view of the same data.  As the model is wrapped here by a
 * `GtkTreeModelSort`, the two `GtkTreeView`s can each sort their
 * view of the data without affecting the other.  By contrast, if we
 * simply put the same model in each widget, then sorting the first would
 * sort the second.
 * ## Using a `GtkTreeModelSort`
 * |[<!-- language\="C" -->
 * {
 * GtkTreeView *tree_view1;
 * GtkTreeView *tree_view2;
 * GtkTreeModel *sort_model1;
 * GtkTreeModel *sort_model2;
 * GtkTreeModel *child_model;
 * // get the child model
 * child_model \= get_my_model $(LPAREN)$(RPAREN);
 * // Create the first tree
 * sort_model1 \= gtk_tree_model_sort_new_with_model $(LPAREN)child_model$(RPAREN);
 * tree_view1 \= gtk_tree_view_new_with_model $(LPAREN)sort_model1$(RPAREN);
 * // Create the second tree
 * sort_model2 \= gtk_tree_model_sort_new_with_model $(LPAREN)child_model$(RPAREN);
 * tree_view2 \= gtk_tree_view_new_with_model $(LPAREN)sort_model2$(RPAREN);
 * // Now we can sort the two models independently
 * gtk_tree_sortable_set_sort_column_id $(LPAREN)GTK_TREE_SORTABLE $(LPAREN)sort_model1$(RPAREN),
 * COLUMN_1, GTK_SORT_ASCENDING$(RPAREN);
 * gtk_tree_sortable_set_sort_column_id $(LPAREN)GTK_TREE_SORTABLE $(LPAREN)sort_model2$(RPAREN),
 * COLUMN_1, GTK_SORT_DESCENDING$(RPAREN);
 * }
 * ]|
 * To demonstrate how to access the underlying child model from the sort
 * model, the next example will be a callback for the `GtkTreeSelection`
 * `GtkTreeSelection::changed` signal.  In this callback, we get a string
 * from COLUMN_1 of the model.  We then modify the string, find the same
 * selected row on the child model, and change the row there.
 * ## Accessing the child model of in a selection changed callback
 * |[<!-- language\="C" -->
 * void
 * selection_changed $(LPAREN)GtkTreeSelection *selection, gpointer data$(RPAREN)
 * {
 * GtkTreeModel *sort_model \= NULL;
 * GtkTreeModel *child_model;
 * GtkTreeIter sort_iter;
 * GtkTreeIter child_iter;
 * char *some_data \= NULL;
 * char *modified_data;
 * // Get the current selected row and the model.
 * if $(LPAREN)! gtk_tree_selection_get_selected $(LPAREN)selection,
 * &sort_model,
 * &sort_iter$(RPAREN)$(RPAREN)
 * return;
 * // Look up the current value on the selected row and get
 * // a new value to change it to.
 * gtk_tree_model_get $(LPAREN)GTK_TREE_MODEL $(LPAREN)sort_model$(RPAREN), &sort_iter,
 * COLUMN_1, &some_data,
 * -1$(RPAREN);
 * modified_data \= change_the_data $(LPAREN)some_data$(RPAREN);
 * g_free $(LPAREN)some_data$(RPAREN);
 * // Get an iterator on the child model, instead of the sort model.
 * gtk_tree_model_sort_convert_iter_to_child_iter $(LPAREN)GTK_TREE_MODEL_SORT $(LPAREN)sort_model$(RPAREN),
 * &child_iter,
 * &sort_iter$(RPAREN);
 * // Get the child model and change the value of the row. In this
 * // example, the child model is a GtkListStore. It could be any other
 * // type of model, though.
 * child_model \= gtk_tree_model_sort_get_model $(LPAREN)GTK_TREE_MODEL_SORT $(LPAREN)sort_model$(RPAREN)$(RPAREN);
 * gtk_list_store_set $(LPAREN)GTK_LIST_STORE $(LPAREN)child_model$(RPAREN), &child_iter,
 * COLUMN_1, &modified_data,
 * -1$(RPAREN);
 * g_free $(LPAREN)modified_data$(RPAREN);
 * }
 * ]|

 * Deprecated: Use [Gtk.SortListModel] instead
 */
class TreeModelSort : ObjectG, TreeDragSource, TreeModel, TreeSortable
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
    return gtk_tree_model_sort_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin TreeDragSourceT!GtkTreeModelSort;
  mixin TreeModelT!GtkTreeModelSort;
  mixin TreeSortableT!GtkTreeModelSort;

  /**
   * Creates a new `GtkTreeModelSort`, with child_model as the child model.
   * Params:
   *   childModel = A `GtkTreeModel`
   * Returns: A new `GtkTreeModelSort`.
   */
  static TreeModelSort newWithModel(TreeModel childModel)
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_tree_model_sort_new_with_model(childModel ? cast(GtkTreeModel*)(cast(ObjectG)childModel).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModelSort(cast(GtkTreeModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function should almost never be called.  It clears the tree_model_sort
   * of any cached iterators that haven’t been reffed with
   * [Gtk.TreeModel.refNode].  This might be useful if the child model being
   * sorted is static $(LPAREN)and doesn’t change often$(RPAREN) and there has been a lot of
   * unreffed access to nodes.  As a side effect of this function, all unreffed
   * iters will be invalid.
   */
  void clearCache()
  {
    gtk_tree_model_sort_clear_cache(cast(GtkTreeModelSort*)cPtr);
  }

  /**
   * Sets sort_iter to point to the row in tree_model_sort that corresponds to
   * the row pointed at by child_iter.  If sort_iter was not set, %FALSE
   * is returned.  Note: a boolean is only returned since 2.14.
   * Params:
   *   sortIter = An uninitialized `GtkTreeIter`
   *   childIter = A valid `GtkTreeIter` pointing to a row on the child model
   * Returns: %TRUE, if sort_iter was set, i.e. if sort_iter is a
   *   valid iterator pointer to a visible row in the child model.
   */
  bool convertChildIterToIter(out TreeIter sortIter, TreeIter childIter)
  {
    bool _retval;
    GtkTreeIter _sortIter;
    _retval = gtk_tree_model_sort_convert_child_iter_to_iter(cast(GtkTreeModelSort*)cPtr, &_sortIter, childIter ? cast(GtkTreeIter*)childIter.cPtr(false) : null);
    sortIter = new TreeIter(cast(void*)&_sortIter, false);
    return _retval;
  }

  /**
   * Converts child_path to a path relative to tree_model_sort.  That is,
   * child_path points to a path in the child model.  The returned path will
   * point to the same row in the sorted model.  If child_path isn’t a valid
   * path on the child model, then %NULL is returned.
   * Params:
   *   childPath = A `GtkTreePath` to convert
   * Returns: A newly allocated `GtkTreePath`
   */
  TreePath convertChildPathToPath(TreePath childPath)
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_model_sort_convert_child_path_to_path(cast(GtkTreeModelSort*)cPtr, childPath ? cast(GtkTreePath*)childPath.cPtr(false) : null);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets child_iter to point to the row pointed to by sorted_iter.
   * Params:
   *   childIter = An uninitialized `GtkTreeIter`
   *   sortedIter = A valid `GtkTreeIter` pointing to a row on tree_model_sort.
   */
  void convertIterToChildIter(out TreeIter childIter, TreeIter sortedIter)
  {
    GtkTreeIter _childIter;
    gtk_tree_model_sort_convert_iter_to_child_iter(cast(GtkTreeModelSort*)cPtr, &_childIter, sortedIter ? cast(GtkTreeIter*)sortedIter.cPtr(false) : null);
    childIter = new TreeIter(cast(void*)&_childIter, false);
  }

  /**
   * Converts sorted_path to a path on the child model of tree_model_sort.
   * That is, sorted_path points to a location in tree_model_sort.  The
   * returned path will point to the same location in the model not being
   * sorted.  If sorted_path does not point to a location in the child model,
   * %NULL is returned.
   * Params:
   *   sortedPath = A `GtkTreePath` to convert
   * Returns: A newly allocated `GtkTreePath`
   */
  TreePath convertPathToChildPath(TreePath sortedPath)
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_model_sort_convert_path_to_child_path(cast(GtkTreeModelSort*)cPtr, sortedPath ? cast(GtkTreePath*)sortedPath.cPtr(false) : null);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the model the `GtkTreeModelSort` is sorting.
   * Returns: the "child model" being sorted
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_tree_model_sort_get_model(cast(GtkTreeModelSort*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * > This function is slow. Only use it for debugging and/or testing
   * > purposes.
   * Checks if the given iter is a valid iter for this `GtkTreeModelSort`.
   * Params:
   *   iter = A `GtkTreeIter`
   * Returns: %TRUE if the iter is valid, %FALSE if the iter is invalid.
   */
  bool iterIsValid(TreeIter iter)
  {
    bool _retval;
    _retval = gtk_tree_model_sort_iter_is_valid(cast(GtkTreeModelSort*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * This resets the default sort function to be in the “unsorted” state.  That
   * is, it is in the same order as the child model. It will re-sort the model
   * to be in the same order as the child model only if the `GtkTreeModelSort`
   * is in “unsorted” state.
   */
  void resetDefaultSortFunc()
  {
    gtk_tree_model_sort_reset_default_sort_func(cast(GtkTreeModelSort*)cPtr);
  }
}

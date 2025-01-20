module Gtk.TreeModelFilter;

import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gid.gid;
import Gtk.TreeDragSource;
import Gtk.TreeDragSourceT;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkTreeModel` which hides parts of an underlying tree model
 * A `GtkTreeModelFilter` is a tree model which wraps another tree model,
 * and can do the following things:
 * - Filter specific rows, based on data from a “visible column”, a column
 * storing booleans indicating whether the row should be filtered or not,
 * or based on the return value of a “visible function”, which gets a
 * model, iter and user_data and returns a boolean indicating whether the
 * row should be filtered or not.
 * - Modify the “appearance” of the model, using a modify function.
 * This is extremely powerful and allows for just changing some
 * values and also for creating a completely different model based
 * on the given child model.
 * - Set a different root node, also known as a “virtual root”. You can pass
 * in a `GtkTreePath` indicating the root node for the filter at construction
 * time.
 * The basic API is similar to `GtkTreeModelSort`. For an example on its usage,
 * see the section on `GtkTreeModelSort`.
 * When using `GtkTreeModelFilter`, it is important to realize that
 * `GtkTreeModelFilter` maintains an internal cache of all nodes which are
 * visible in its clients. The cache is likely to be a subtree of the tree
 * exposed by the child model. `GtkTreeModelFilter` will not cache the entire
 * child model when unnecessary to not compromise the caching mechanism
 * that is exposed by the reference counting scheme. If the child model
 * implements reference counting, unnecessary signals may not be emitted
 * because of reference counting rule 3, see the `GtkTreeModel`
 * documentation. $(LPAREN)Note that e.g. `GtkTreeStore` does not implement
 * reference counting and will always emit all signals, even when
 * the receiving node is not visible$(RPAREN).
 * Because of this, limitations for possible visible functions do apply.
 * In general, visible functions should only use data or properties from
 * the node for which the visibility state must be determined, its siblings
 * or its parents. Usually, having a dependency on the state of any child
 * node is not possible, unless references are taken on these explicitly.
 * When no such reference exists, no signals may be received for these child
 * nodes $(LPAREN)see reference counting rule number 3 in the `GtkTreeModel` section$(RPAREN).
 * Determining the visibility state of a given node based on the state
 * of its child nodes is a frequently occurring use case. Therefore,
 * `GtkTreeModelFilter` explicitly supports this. For example, when a node
 * does not have any children, you might not want the node to be visible.
 * As soon as the first row is added to the node’s child level $(LPAREN)or the
 * last row removed$(RPAREN), the node’s visibility should be updated.
 * This introduces a dependency from the node on its child nodes. In order
 * to accommodate this, `GtkTreeModelFilter` must make sure the necessary
 * signals are received from the child model. This is achieved by building,
 * for all nodes which are exposed as visible nodes to `GtkTreeModelFilter`'s
 * clients, the child level $(LPAREN)if any$(RPAREN) and take a reference on the first node
 * in this level. Furthermore, for every row-inserted, row-changed or
 * row-deleted signal $(LPAREN)also these which were not handled because the node
 * was not cached$(RPAREN), `GtkTreeModelFilter` will check if the visibility state
 * of any parent node has changed.
 * Beware, however, that this explicit support is limited to these two
 * cases. For example, if you want a node to be visible only if two nodes
 * in a child’s child level $(LPAREN)2 levels deeper$(RPAREN) are visible, you are on your
 * own. In this case, either rely on `GtkTreeStore` to emit all signals
 * because it does not implement reference counting, or for models that
 * do implement reference counting, obtain references on these child levels
 * yourself.

 * Deprecated: Use [Gtk.FilterListModel] instead.
 */
class TreeModelFilter : ObjectG, TreeDragSource, TreeModel
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
    return gtk_tree_model_filter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin TreeDragSourceT!();
  mixin TreeModelT!();

  /**
   * This function should almost never be called. It clears the filter
   * of any cached iterators that haven’t been reffed with
   * [Gtk.TreeModel.refNode]. This might be useful if the child model
   * being filtered is static $(LPAREN)and doesn’t change often$(RPAREN) and there has been
   * a lot of unreffed access to nodes. As a side effect of this function,
   * all unreffed iters will be invalid.
   */
  void clearCache()
  {
    gtk_tree_model_filter_clear_cache(cast(GtkTreeModelFilter*)cPtr);
  }

  /**
   * Sets filter_iter to point to the row in filter that corresponds to the
   * row pointed at by child_iter.  If filter_iter was not set, %FALSE is
   * returned.
   * Params:
   *   filterIter = An uninitialized `GtkTreeIter`
   *   childIter = A valid `GtkTreeIter` pointing to a row on the child model.
   * Returns: %TRUE, if filter_iter was set, i.e. if child_iter is a
   *   valid iterator pointing to a visible row in child model.
   */
  bool convertChildIterToIter(out TreeIter filterIter, TreeIter childIter)
  {
    bool _retval;
    GtkTreeIter _filterIter;
    _retval = gtk_tree_model_filter_convert_child_iter_to_iter(cast(GtkTreeModelFilter*)cPtr, &_filterIter, childIter ? cast(GtkTreeIter*)childIter.cPtr(false) : null);
    filterIter = new TreeIter(cast(void*)&_filterIter, false);
    return _retval;
  }

  /**
   * Converts child_path to a path relative to filter. That is, child_path
   * points to a path in the child model. The rerturned path will point to the
   * same row in the filtered model. If child_path isn’t a valid path on the
   * child model or points to a row which is not visible in filter, then %NULL
   * is returned.
   * Params:
   *   childPath = A `GtkTreePath` to convert.
   * Returns: A newly allocated `GtkTreePath`
   */
  TreePath convertChildPathToPath(TreePath childPath)
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_model_filter_convert_child_path_to_path(cast(GtkTreeModelFilter*)cPtr, childPath ? cast(GtkTreePath*)childPath.cPtr(false) : null);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets child_iter to point to the row pointed to by filter_iter.
   * Params:
   *   childIter = An uninitialized `GtkTreeIter`
   *   filterIter = A valid `GtkTreeIter` pointing to a row on filter.
   */
  void convertIterToChildIter(out TreeIter childIter, TreeIter filterIter)
  {
    GtkTreeIter _childIter;
    gtk_tree_model_filter_convert_iter_to_child_iter(cast(GtkTreeModelFilter*)cPtr, &_childIter, filterIter ? cast(GtkTreeIter*)filterIter.cPtr(false) : null);
    childIter = new TreeIter(cast(void*)&_childIter, false);
  }

  /**
   * Converts filter_path to a path on the child model of filter. That is,
   * filter_path points to a location in filter. The returned path will
   * point to the same location in the model not being filtered. If filter_path
   * does not point to a location in the child model, %NULL is returned.
   * Params:
   *   filterPath = A `GtkTreePath` to convert.
   * Returns: A newly allocated `GtkTreePath`
   */
  TreePath convertPathToChildPath(TreePath filterPath)
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_model_filter_convert_path_to_child_path(cast(GtkTreeModelFilter*)cPtr, filterPath ? cast(GtkTreePath*)filterPath.cPtr(false) : null);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a pointer to the child model of filter.
   * Returns: A pointer to a `GtkTreeModel`
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_tree_model_filter_get_model(cast(GtkTreeModelFilter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Emits ::row_changed for each row in the child model, which causes
   * the filter to re-evaluate whether a row is visible or not.
   */
  void refilter()
  {
    gtk_tree_model_filter_refilter(cast(GtkTreeModelFilter*)cPtr);
  }

  /**
   * With the n_columns and types parameters, you give an array of column
   * types for this model $(LPAREN)which will be exposed to the parent model/view$(RPAREN).
   * The func, data and destroy parameters are for specifying the modify
   * function. The modify function will get called for each
   * data access, the goal of the modify function is to return the data which
   * should be displayed at the location specified using the parameters of the
   * modify function.
   * Note that [Gtk.TreeModelFilter.setModifyFunc]
   * can only be called once for a given filter model.
   * Params:
   *   types = The `GType`s of the columns.
   *   func = A `GtkTreeModelFilterModifyFunc`
   */
  void setModifyFunc(GType[] types, TreeModelFilterModifyFunc func)
  {
    extern(C) void _funcCallback(GtkTreeModel* model, GtkTreeIter* iter, GValue* value, int column, void* data)
    {
      auto _dlg = cast(TreeModelFilterModifyFunc*)data;
      auto _value = new Value(value, false);

      (*_dlg)(model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, iter ? new TreeIter(cast(void*)iter, false) : null, _value, column);
       *value = *cast(GValue*)_value.cPtr;

    }

    int _nColumns;
    if (types)
      _nColumns = cast(int)types.length;

    auto _types = cast(GType*)types.ptr;
    auto _func = freezeDelegate(cast(void*)&func);
    gtk_tree_model_filter_set_modify_func(cast(GtkTreeModelFilter*)cPtr, _nColumns, _types, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Sets column of the child_model to be the column where filter should
   * look for visibility information. columns should be a column of type
   * %G_TYPE_BOOLEAN, where %TRUE means that a row is visible, and %FALSE
   * if not.
   * Note that [Gtk.TreeModelFilter.setVisibleFunc] or
   * [Gtk.TreeModelFilter.setVisibleColumn] can only be called
   * once for a given filter model.
   * Params:
   *   column = A `int` which is the column containing the visible information
   */
  void setVisibleColumn(int column)
  {
    gtk_tree_model_filter_set_visible_column(cast(GtkTreeModelFilter*)cPtr, column);
  }

  /**
   * Sets the visible function used when filtering the filter to be func.
   * The function should return %TRUE if the given row should be visible and
   * %FALSE otherwise.
   * If the condition calculated by the function changes over time $(LPAREN)e.g.
   * because it depends on some global parameters$(RPAREN), you must call
   * [Gtk.TreeModelFilter.refilter] to keep the visibility information
   * of the model up-to-date.
   * Note that func is called whenever a row is inserted, when it may still
   * be empty. The visible function should therefore take special care of empty
   * rows, like in the example below.
   * |[<!-- language\="C" -->
   * static gboolean
   * visible_func $(LPAREN)GtkTreeModel *model,
   * GtkTreeIter  *iter,
   * gpointer      data$(RPAREN)
   * {
   * // Visible if row is non-empty and first column is “HI”
   * char *str;
   * gboolean visible \= FALSE;
   * gtk_tree_model_get $(LPAREN)model, iter, 0, &str, -1$(RPAREN);
   * if $(LPAREN)str && strcmp $(LPAREN)str, "HI"$(RPAREN) \=\= 0$(RPAREN)
   * visible \= TRUE;
   * g_free $(LPAREN)str$(RPAREN);
   * return visible;
   * }
   * ]|
   * Note that [Gtk.TreeModelFilter.setVisibleFunc] or
   * [Gtk.TreeModelFilter.setVisibleColumn] can only be called
   * once for a given filter model.
   * Params:
   *   func = A `GtkTreeModelFilterVisibleFunc`, the visible function
   */
  void setVisibleFunc(TreeModelFilterVisibleFunc func)
  {
    extern(C) bool _funcCallback(GtkTreeModel* model, GtkTreeIter* iter, void* data)
    {
      auto _dlg = cast(TreeModelFilterVisibleFunc*)data;

      bool _retval = (*_dlg)(model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, iter ? new TreeIter(cast(void*)iter, false) : null);
      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_tree_model_filter_set_visible_func(cast(GtkTreeModelFilter*)cPtr, &_funcCallback, _func, &thawDelegate);
  }
}

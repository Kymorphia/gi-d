module Gtk.TreeStore;

import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gid.gid;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.TreeDragDest;
import Gtk.TreeDragDestT;
import Gtk.TreeDragSource;
import Gtk.TreeDragSourceT;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreeSortable;
import Gtk.TreeSortableT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A tree-like data structure that can be used with the [Gtk.TreeView].
 * The `GtkTreeStore` object is a list model for use with a `GtkTreeView`
 * widget. It implements the [Gtk.TreeModel] interface, and consequently,
 * can use all of the methods available there. It also implements the
 * [Gtk.TreeSortable] interface so it can be sorted by the view.
 * Finally, it also implements the tree [drag][Gtk.TreeDragSource]
 * and [drop][Gtk.TreeDragDest] interfaces.
 * `GtkTreeStore` is deprecated since GTK 4.10, and should not be used in newly
 * written code. You should use [Gtk.TreeListModel] for a tree-like model
 * object.
 * ## GtkTreeStore as GtkBuildable
 * The GtkTreeStore implementation of the `GtkBuildable` interface allows
 * to specify the model columns with a `<columns>` element that may contain
 * multiple `<column>` elements, each specifying one model column. The “type”
 * attribute specifies the data type for the column.
 * An example of a UI Definition fragment for a tree store:
 * ```xml
 * <object class\="GtkTreeStore">
 * <columns>
 * <column type\="gchararray"/>
 * <column type\="gchararray"/>
 * <column type\="gint"/>
 * </columns>
 * </object>
 * ```

 * Deprecated: Use [Gtk.TreeListModel] instead
 */
class TreeStore : ObjectG, Buildable, TreeDragDest, TreeDragSource, TreeModel, TreeSortable
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
    return gtk_tree_store_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin BuildableT!GtkTreeStore;
  mixin TreeDragDestT!GtkTreeStore;
  mixin TreeDragSourceT!GtkTreeStore;
  mixin TreeModelT!GtkTreeStore;
  mixin TreeSortableT!GtkTreeStore;

  /**
   * Creates a new tree store.
   * This constructor is meant for language bindings.
   * Params:
   *   types = an array of `GType` types for the columns, from first to last
   * Returns: a new `GtkTreeStore`

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  static TreeStore new_(GType[] types)
  {
    GtkTreeStore* _cretval;
    int _nColumns;
    if (types)
      _nColumns = cast(int)types.length;

    auto _types = cast(GType*)types.ptr;
    _cretval = gtk_tree_store_newv(_nColumns, _types);
    auto _retval = _cretval ? ObjectG.getDObject!TreeStore(cast(GtkTreeStore*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Appends a new row to tree_store.
   * If parent is non-%NULL, then it will append the new row after the last
   * child of parent, otherwise it will append a row to the top level.
   * The iter parameter will be changed to point to this new row. The row will
   * be empty after this function is called. To fill in values, you need to call
   * [Gtk.TreeStore.set] or [Gtk.TreeStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the appended row
   *   parent = A valid `GtkTreeIter`

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void append(out TreeIter iter, TreeIter parent)
  {
    GtkTreeIter _iter;
    gtk_tree_store_append(cast(GtkTreeStore*)cPtr, &_iter, parent ? cast(GtkTreeIter*)parent.cPtr(false) : null);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Removes all rows from tree_store

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void clear()
  {
    gtk_tree_store_clear(cast(GtkTreeStore*)cPtr);
  }

  /**
   * Creates a new row at position.
   * If parent is non-%NULL, then the row will be made a child of parent.
   * Otherwise, the row will be created at the toplevel.
   * If position is `-1` or is larger than the number of rows at that level,
   * then the new row will be inserted to the end of the list.
   * The iter parameter will be changed to point to this new row. The row
   * will be empty after this function is called. To fill in values, you
   * need to call [Gtk.TreeStore.set] or [Gtk.TreeStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the new row
   *   parent = A valid `GtkTreeIter`
   *   position = position to insert the new row, or -1 for last

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void insert(out TreeIter iter, TreeIter parent, int position)
  {
    GtkTreeIter _iter;
    gtk_tree_store_insert(cast(GtkTreeStore*)cPtr, &_iter, parent ? cast(GtkTreeIter*)parent.cPtr(false) : null, position);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Inserts a new row after sibling.
   * If sibling is %NULL, then the row will be prepended to parent’s children.
   * If parent and sibling are %NULL, then the row will be prepended to the
   * toplevel.
   * If both sibling and parent are set, then parent must be the parent
   * of sibling. When sibling is set, parent is optional.
   * The iter parameter will be changed to point to this new row. The row will
   * be empty after this function is called. To fill in values, you need to call
   * [Gtk.TreeStore.set] or [Gtk.TreeStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the new row
   *   parent = A valid `GtkTreeIter`
   *   sibling = A valid `GtkTreeIter`

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void insertAfter(out TreeIter iter, TreeIter parent, TreeIter sibling)
  {
    GtkTreeIter _iter;
    gtk_tree_store_insert_after(cast(GtkTreeStore*)cPtr, &_iter, parent ? cast(GtkTreeIter*)parent.cPtr(false) : null, sibling ? cast(GtkTreeIter*)sibling.cPtr(false) : null);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Inserts a new row before sibling.
   * If sibling is %NULL, then the row will be appended to parent’s children.
   * If parent and sibling are %NULL, then the row will be appended to the
   * toplevel.
   * If both sibling and parent are set, then parent must be the parent
   * of sibling. When sibling is set, parent is optional.
   * The iter parameter will be changed to point to this new row. The row will
   * be empty after this function is called. To fill in values, you need to call
   * [Gtk.TreeStore.set] or [Gtk.TreeStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the new row
   *   parent = A valid `GtkTreeIter`
   *   sibling = A valid `GtkTreeIter`

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void insertBefore(out TreeIter iter, TreeIter parent, TreeIter sibling)
  {
    GtkTreeIter _iter;
    gtk_tree_store_insert_before(cast(GtkTreeStore*)cPtr, &_iter, parent ? cast(GtkTreeIter*)parent.cPtr(false) : null, sibling ? cast(GtkTreeIter*)sibling.cPtr(false) : null);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * A variant of [Gtk.TreeStore.insertWithValues] which takes
   * the columns and values as two arrays, instead of varargs.
   * This function is mainly intended for language bindings.
   * Params:
   *   iter = An unset `GtkTreeIter` to set the new row
   *   parent = A valid `GtkTreeIter`
   *   position = position to insert the new row, or -1 for last
   *   columns = an array of column numbers
   *   values = an array of GValues

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void insertWithValues(out TreeIter iter, TreeIter parent, int position, int[] columns, Value[] values)
  {
    GtkTreeIter _iter;
    int _nValues;
    if (columns)
      _nValues = cast(int)columns.length;

    auto _columns = cast(int*)columns.ptr;
    if (values)
      _nValues = cast(int)values.length;

    GValue[] _tmpvalues;
    foreach (obj; values)
      _tmpvalues ~= *cast(GValue*)obj.cPtr;
    GValue* _values = _tmpvalues.ptr;
    gtk_tree_store_insert_with_valuesv(cast(GtkTreeStore*)cPtr, &_iter, parent ? cast(GtkTreeIter*)parent.cPtr(false) : null, position, _columns, _values, _nValues);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Checks if iter is an ancestor of descendant.
   * Params:
   *   iter = A valid `GtkTreeIter`
   *   descendant = A valid `GtkTreeIter`
   * Returns: true if iter is an ancestor of descendant, and false otherwise

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  bool isAncestor(TreeIter iter, TreeIter descendant)
  {
    bool _retval;
    _retval = gtk_tree_store_is_ancestor(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, descendant ? cast(GtkTreeIter*)descendant.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the depth of the position pointed by the iterator
   * The depth will be 0 for anything on the root level, 1 for anything down
   * a level, etc.
   * Params:
   *   iter = A valid `GtkTreeIter`
   * Returns: The depth of the position pointed by the iterator

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  int iterDepth(TreeIter iter)
  {
    int _retval;
    _retval = gtk_tree_store_iter_depth(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks if the given iter is a valid iter for this `GtkTreeStore`.
   * This function is slow. Only use it for debugging and/or testing
   * purposes.
   * Params:
   *   iter = the iterator to check
   * Returns: true if the iter is valid, and false otherwise

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  bool iterIsValid(TreeIter iter)
  {
    bool _retval;
    _retval = gtk_tree_store_iter_is_valid(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves iter in tree_store to the position after position.
   * iter and position should be in the same level.
   * Note that this function only works with unsorted stores.
   * If position is %NULL, iter will be moved to the start of the level.
   * Params:
   *   iter = A `GtkTreeIter`.
   *   position = A `GtkTreeIter`.

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void moveAfter(TreeIter iter, TreeIter position)
  {
    gtk_tree_store_move_after(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, position ? cast(GtkTreeIter*)position.cPtr(false) : null);
  }

  /**
   * Moves iter in tree_store to the position before position.
   * iter and position should be in the same level.
   * Note that this function only works with unsorted stores.
   * If position is %NULL, iter will be moved to the end of the level.
   * Params:
   *   iter = A `GtkTreeIter`
   *   position = A `GtkTreeIter`

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void moveBefore(TreeIter iter, TreeIter position)
  {
    gtk_tree_store_move_before(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, position ? cast(GtkTreeIter*)position.cPtr(false) : null);
  }

  /**
   * Prepends a new row to tree_store.
   * If parent is non-%NULL, then it will prepend the new row before the first
   * child of parent, otherwise it will prepend a row to the top level. The
   * `iter` parameter will be changed to point to this new row.  The row will
   * be empty after this function is called. To fill in values, you need to
   * call [Gtk.TreeStore.set] or [Gtk.TreeStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the prepended row
   *   parent = A valid `GtkTreeIter`

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void prepend(out TreeIter iter, TreeIter parent)
  {
    GtkTreeIter _iter;
    gtk_tree_store_prepend(cast(GtkTreeStore*)cPtr, &_iter, parent ? cast(GtkTreeIter*)parent.cPtr(false) : null);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Removes iter from tree_store.
   * After being removed, iter is set to the next valid row at that level, or
   * invalidated if it previously pointed to the last one.
   * Params:
   *   iter = A valid `GtkTreeIter`
   * Returns: true if iter is still valid, and false otherwise

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  bool remove(TreeIter iter)
  {
    bool _retval;
    _retval = gtk_tree_store_remove(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Sets the type of the columns in a tree store.
   * This function is meant primarily for types that inherit from
   * `GtkTreeStore`, and should only be used when constructing a new
   * `GtkTreeStore`.
   * This functions cannot be called after a row has been added,
   * or a method on the `GtkTreeModel` interface is called on the
   * tree store.
   * Params:
   *   types = An array of `GType` types, one for each column

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void setColumnTypes(GType[] types)
  {
    int _nColumns;
    if (types)
      _nColumns = cast(int)types.length;

    auto _types = cast(GType*)types.ptr;
    gtk_tree_store_set_column_types(cast(GtkTreeStore*)cPtr, _nColumns, _types);
  }

  /**
   * Sets the data in the cell specified by iter and column.
   * The type of value must be convertible to the type of the
   * column.
   * Params:
   *   iter = A valid `GtkTreeIter` for the row being modified
   *   column = column number to modify
   *   value = new value for the cell

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void setValue(TreeIter iter, int column, Value value)
  {
    gtk_tree_store_set_value(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, column, value ? cast(GValue*)value.cPtr(false) : null);
  }

  /**
   * A variant of [Gtk.TreeStore.setValist] which takes
   * the columns and values as two arrays, instead of using variadic
   * arguments.
   * This function is mainly intended for language bindings or in case
   * the number of columns to change is not known until run-time.
   * Params:
   *   iter = A valid `GtkTreeIter` for the row being modified
   *   columns = an array of column numbers
   *   values = an array of GValues

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void set(TreeIter iter, int[] columns, Value[] values)
  {
    int _nValues;
    if (columns)
      _nValues = cast(int)columns.length;

    auto _columns = cast(int*)columns.ptr;
    if (values)
      _nValues = cast(int)values.length;

    GValue[] _tmpvalues;
    foreach (obj; values)
      _tmpvalues ~= *cast(GValue*)obj.cPtr;
    GValue* _values = _tmpvalues.ptr;
    gtk_tree_store_set_valuesv(cast(GtkTreeStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, _columns, _values, _nValues);
  }

  /**
   * Swaps a and b in the same level of tree_store.
   * Note that this function only works with unsorted stores.
   * Params:
   *   a = A `GtkTreeIter`.
   *   b = Another `GtkTreeIter`.

   * Deprecated: Use [Gtk.TreeListModel] instead
   */
  void swap(TreeIter a, TreeIter b)
  {
    gtk_tree_store_swap(cast(GtkTreeStore*)cPtr, a ? cast(GtkTreeIter*)a.cPtr(false) : null, b ? cast(GtkTreeIter*)b.cPtr(false) : null);
  }
}

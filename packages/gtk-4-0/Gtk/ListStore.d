module Gtk.ListStore;

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
 * A list-like data structure that can be used with the [Gtk.TreeView].
 * The `GtkListStore` object is a list model for use with a `GtkTreeView`
 * widget.  It implements the `GtkTreeModel` interface, and consequentialy,
 * can use all of the methods available there.  It also implements the
 * `GtkTreeSortable` interface so it can be sorted by the view.
 * Finally, it also implements the tree
 * [drag](iface.TreeDragSource.html) and [drop](iface.TreeDragDest.html)
 * interfaces.
 * The `GtkListStore` can accept most `GType`s as a column type, though
 * it can’t accept all custom types.  Internally, it will keep a copy of
 * data passed in $(LPAREN)such as a string or a boxed pointer$(RPAREN).  Columns that
 * accept `GObject`s are handled a little differently.  The
 * `GtkListStore` will keep a reference to the object instead of copying the
 * value.  As a result, if the object is modified, it is up to the
 * application writer to call [Gtk.TreeModel.rowChanged] to emit the
 * signal@Gtk.TreeModel::row_changed signal. This most commonly affects lists
 * with [Gdk.Texture]s stored.
 * An example for creating a simple list store:
 * ```c
 * enum {
 * COLUMN_STRING,
 * COLUMN_INT,
 * COLUMN_BOOLEAN,
 * N_COLUMNS
 * };
 * {
 * GtkListStore *list_store;
 * GtkTreePath *path;
 * GtkTreeIter iter;
 * int i;
 * list_store \= gtk_list_store_new $(LPAREN)N_COLUMNS,
 * G_TYPE_STRING,
 * G_TYPE_INT,
 * G_TYPE_BOOLEAN$(RPAREN);
 * for $(LPAREN)i \= 0; i < 10; i++$(RPAREN)
 * {
 * char *some_data;
 * some_data \= get_some_data $(LPAREN)i$(RPAREN);
 * // Add a new row to the model
 * gtk_list_store_append $(LPAREN)list_store, &iter$(RPAREN);
 * gtk_list_store_set $(LPAREN)list_store, &iter,
 * COLUMN_STRING, some_data,
 * COLUMN_INT, i,
 * COLUMN_BOOLEAN,  FALSE,
 * -1$(RPAREN);
 * // As the store will keep a copy of the string internally,
 * // we free some_data.
 * g_free $(LPAREN)some_data$(RPAREN);
 * }
 * // Modify a particular row
 * path \= gtk_tree_path_new_from_string $(LPAREN)"4"$(RPAREN);
 * gtk_tree_model_get_iter $(LPAREN)GTK_TREE_MODEL $(LPAREN)list_store$(RPAREN),
 * &iter,
 * path$(RPAREN);
 * gtk_tree_path_free $(LPAREN)path$(RPAREN);
 * gtk_list_store_set $(LPAREN)list_store, &iter,
 * COLUMN_BOOLEAN, TRUE,
 * -1$(RPAREN);
 * }
 * ```
 * `GtkListStore` is deprecated since GTK 4.10, and should not be used in newly
 * written code. You should use [Gio.DGioListStore] instead, and the various
 * list models provided by GTK.
 * ## Performance Considerations
 * Internally, the `GtkListStore` was originally implemented with a linked list
 * with a tail pointer.  As a result, it was fast at data insertion and deletion,
 * and not fast at random data access.  The `GtkListStore` sets the
 * `GTK_TREE_MODEL_ITERS_PERSIST` flag, which means that `GtkTreeIter`s can be
 * cached while the row exists.  Thus, if access to a particular row is needed
 * often and your code is expected to run on older versions of GTK, it is worth
 * keeping the iter around.
 * ## Atomic Operations
 * It is important to note that only the methods
 * [Gtk.ListStore.insertWithValues] and [Gtk.ListStore.insertWithValuesv]
 * are atomic, in the sense that the row is being appended to the store and the
 * values filled in in a single operation with regard to `GtkTreeModel` signaling.
 * In contrast, using e.g. [Gtk.ListStore.append] and then [Gtk.ListStore.set]
 * will first create a row, which triggers the `GtkTreeModel::row-inserted` signal
 * on `GtkListStore`. The row, however, is still empty, and any signal handler
 * connecting to `GtkTreeModel::row-inserted` on this particular store should be prepared
 * for the situation that the row might be empty. This is especially important
 * if you are wrapping the `GtkListStore` inside a `GtkTreeModel`Filter and are
 * using a `GtkTreeModel`FilterVisibleFunc. Using any of the non-atomic operations
 * to append rows to the `GtkListStore` will cause the
 * `GtkTreeModel`FilterVisibleFunc to be visited with an empty row first; the
 * function must be prepared for that.
 * ## GtkListStore as GtkBuildable
 * The GtkListStore implementation of the [Gtk.Buildable] interface allows
 * to specify the model columns with a `<columns>` element that may contain
 * multiple `<column>` elements, each specifying one model column. The “type”
 * attribute specifies the data type for the column.
 * Additionally, it is possible to specify content for the list store
 * in the UI definition, with the `<data>` element. It can contain multiple
 * `<row>` elements, each specifying to content for one row of the list model.
 * Inside a `<row>`, the `<col>` elements specify the content for individual cells.
 * Note that it is probably more common to define your models in the code,
 * and one might consider it a layering violation to specify the content of
 * a list store in a UI definition, data, not presentation, and common wisdom
 * is to separate the two, as far as possible.
 * An example of a UI Definition fragment for a list store:
 * ```xml
 * <object class\="GtkListStore">
 * <columns>
 * <column type\="gchararray"/>
 * <column type\="gchararray"/>
 * <column type\="gint"/>
 * </columns>
 * <data>
 * <row>
 * <col id\="0">John</col>
 * <col id\="1">Doe</col>
 * <col id\="2">25</col>
 * </row>
 * <row>
 * <col id\="0">Johan</col>
 * <col id\="1">Dahlin</col>
 * <col id\="2">50</col>
 * </row>
 * </data>
 * </object>
 * ```

 * Deprecated: Use [Gio.DGioListStore] instead
 */
class ListStore : ObjectG, Buildable, TreeDragDest, TreeDragSource, TreeModel, TreeSortable
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
    return gtk_list_store_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin BuildableT!();
  mixin TreeDragDestT!();
  mixin TreeDragSourceT!();
  mixin TreeModelT!();
  mixin TreeSortableT!();

  /**
   * Creates a new `GtkListStore`.
   * This function is meant to be used by language bindings.
   * Params:
   *   types = an array of `GType` types for the columns, from first to last
   * Returns: a new `GtkListStore`

   * Deprecated: Use [Gio.DGioListStore] instead
   */
  static ListStore new_(GType[] types)
  {
    GtkListStore* _cretval;
    int _nColumns;
    if (types)
      _nColumns = cast(int)types.length;

    auto _types = cast(GType*)types.ptr;
    _cretval = gtk_list_store_newv(_nColumns, _types);
    auto _retval = _cretval ? ObjectG.getDObject!ListStore(cast(GtkListStore*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Appends a new row to list_store.  iter will be changed to point to this new
   * row.  The row will be empty after this function is called.  To fill in
   * values, you need to call [Gtk.ListStore.set] or [Gtk.ListStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the appended row

   * Deprecated: Use list models
   */
  void append(out TreeIter iter)
  {
    GtkTreeIter _iter;
    gtk_list_store_append(cast(GtkListStore*)cPtr, &_iter);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Removes all rows from the list store.

   * Deprecated: Use list models
   */
  void clear()
  {
    gtk_list_store_clear(cast(GtkListStore*)cPtr);
  }

  /**
   * Creates a new row at position.  iter will be changed to point to this new
   * row.  If position is -1 or is larger than the number of rows on the list,
   * then the new row will be appended to the list. The row will be empty after
   * this function is called.  To fill in values, you need to call
   * [Gtk.ListStore.set] or [Gtk.ListStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the new row
   *   position = position to insert the new row, or -1 for last

   * Deprecated: Use list models
   */
  void insert(out TreeIter iter, int position)
  {
    GtkTreeIter _iter;
    gtk_list_store_insert(cast(GtkListStore*)cPtr, &_iter, position);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Inserts a new row after sibling. If sibling is %NULL, then the row will be
   * prepended to the beginning of the list. iter will be changed to point to
   * this new row. The row will be empty after this function is called. To fill
   * in values, you need to call [Gtk.ListStore.set] or [Gtk.ListStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the new row
   *   sibling = A valid `GtkTreeIter`

   * Deprecated: Use list models
   */
  void insertAfter(out TreeIter iter, TreeIter sibling)
  {
    GtkTreeIter _iter;
    gtk_list_store_insert_after(cast(GtkListStore*)cPtr, &_iter, sibling ? cast(GtkTreeIter*)sibling.cPtr(false) : null);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Inserts a new row before sibling. If sibling is %NULL, then the row will
   * be appended to the end of the list. iter will be changed to point to this
   * new row. The row will be empty after this function is called. To fill in
   * values, you need to call [Gtk.ListStore.set] or [Gtk.ListStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the new row
   *   sibling = A valid `GtkTreeIter`

   * Deprecated: Use list models
   */
  void insertBefore(out TreeIter iter, TreeIter sibling)
  {
    GtkTreeIter _iter;
    gtk_list_store_insert_before(cast(GtkListStore*)cPtr, &_iter, sibling ? cast(GtkTreeIter*)sibling.cPtr(false) : null);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * A variant of [Gtk.ListStore.insertWithValues] which
   * takes the columns and values as two arrays, instead of
   * varargs.
   * This function is mainly intended for language-bindings.
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the new row
   *   position = position to insert the new row, or -1 for last
   *   columns = an array of column numbers
   *   values = an array of GValues

   * Deprecated: Use list models
   */
  void insertWithValues(out TreeIter iter, int position, int[] columns, Value[] values)
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
    gtk_list_store_insert_with_valuesv(cast(GtkListStore*)cPtr, &_iter, position, _columns, _values, _nValues);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Checks if the given iter is a valid iter for this `GtkListStore`.
   * This function is slow. Only use it for debugging and/or testing
   * purposes.
   * Params:
   *   iter = the iterator to check
   * Returns: %TRUE if the iter is valid, %FALSE if the iter is invalid.

   * Deprecated: Use list models
   */
  bool iterIsValid(TreeIter iter)
  {
    bool _retval;
    _retval = gtk_list_store_iter_is_valid(cast(GtkListStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves iter in store to the position after position. Note that this
   * function only works with unsorted stores. If position is %NULL, iter
   * will be moved to the start of the list.
   * Params:
   *   iter = A `GtkTreeIter`
   *   position = A `GtkTreeIter`

   * Deprecated: Use list models
   */
  void moveAfter(TreeIter iter, TreeIter position)
  {
    gtk_list_store_move_after(cast(GtkListStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, position ? cast(GtkTreeIter*)position.cPtr(false) : null);
  }

  /**
   * Moves iter in store to the position before position. Note that this
   * function only works with unsorted stores. If position is %NULL, iter
   * will be moved to the end of the list.
   * Params:
   *   iter = A `GtkTreeIter`
   *   position = A `GtkTreeIter`

   * Deprecated: Use list models
   */
  void moveBefore(TreeIter iter, TreeIter position)
  {
    gtk_list_store_move_before(cast(GtkListStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, position ? cast(GtkTreeIter*)position.cPtr(false) : null);
  }

  /**
   * Prepends a new row to list_store. iter will be changed to point to this new
   * row. The row will be empty after this function is called. To fill in
   * values, you need to call [Gtk.ListStore.set] or [Gtk.ListStore.setValue].
   * Params:
   *   iter = An unset `GtkTreeIter` to set to the prepend row

   * Deprecated: Use list models
   */
  void prepend(out TreeIter iter)
  {
    GtkTreeIter _iter;
    gtk_list_store_prepend(cast(GtkListStore*)cPtr, &_iter);
    iter = new TreeIter(cast(void*)&_iter, false);
  }

  /**
   * Removes the given row from the list store.  After being removed,
   * iter is set to be the next valid row, or invalidated if it pointed
   * to the last row in list_store.
   * Params:
   *   iter = A valid `GtkTreeIter`
   * Returns: %TRUE if iter is valid, %FALSE if not.

   * Deprecated: Use list models
   */
  bool remove(TreeIter iter)
  {
    bool _retval;
    _retval = gtk_list_store_remove(cast(GtkListStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
    return _retval;
  }

  /**
   * Reorders store to follow the order indicated by new_order. Note that
   * this function only works with unsorted stores.
   * Params:
   *   newOrder = an array of integers mapping the new
   *     position of each child to its old position before the re-ordering,
   *     i.e. new_order`[newpos] \= oldpos`. It must have
   *     exactly as many items as the list store’s length.

   * Deprecated: Use list models
   */
  void reorder(int[] newOrder)
  {
    auto _newOrder = cast(int*)(newOrder ~ int.init).ptr;
    gtk_list_store_reorder(cast(GtkListStore*)cPtr, _newOrder);
  }

  /**
   * Sets the types of the columns of a list store.
   * This function is meant primarily for objects that inherit
   * from `GtkListStore`, and should only be used when constructing
   * a new instance.
   * This function cannot be called after a row has been added, or
   * a method on the `GtkTreeModel` interface is called.
   * Params:
   *   types = An array length n of `GType`s

   * Deprecated: Use list models
   */
  void setColumnTypes(GType[] types)
  {
    int _nColumns;
    if (types)
      _nColumns = cast(int)types.length;

    auto _types = cast(GType*)types.ptr;
    gtk_list_store_set_column_types(cast(GtkListStore*)cPtr, _nColumns, _types);
  }

  /**
   * Sets the data in the cell specified by iter and column.
   * The type of value must be convertible to the type of the
   * column.
   * Params:
   *   iter = A valid `GtkTreeIter` for the row being modified
   *   column = column number to modify
   *   value = new value for the cell

   * Deprecated: Use list models
   */
  void setValue(TreeIter iter, int column, Value value)
  {
    gtk_list_store_set_value(cast(GtkListStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, column, value ? cast(GValue*)value.cPtr(false) : null);
  }

  /**
   * A variant of [Gtk.ListStore.setValist] which
   * takes the columns and values as two arrays, instead of
   * varargs. This function is mainly intended for
   * language-bindings and in case the number of columns to
   * change is not known until run-time.
   * Params:
   *   iter = A valid `GtkTreeIter` for the row being modified
   *   columns = an array of column numbers
   *   values = an array of GValues

   * Deprecated: Use list models
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
    gtk_list_store_set_valuesv(cast(GtkListStore*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, _columns, _values, _nValues);
  }

  /**
   * Swaps a and b in store. Note that this function only works with
   * unsorted stores.
   * Params:
   *   a = A `GtkTreeIter`
   *   b = Another `GtkTreeIter`

   * Deprecated: Use list models
   */
  void swap(TreeIter a, TreeIter b)
  {
    gtk_list_store_swap(cast(GtkListStore*)cPtr, a ? cast(GtkTreeIter*)a.cPtr(false) : null, b ? cast(GtkTreeIter*)b.cPtr(false) : null);
  }
}

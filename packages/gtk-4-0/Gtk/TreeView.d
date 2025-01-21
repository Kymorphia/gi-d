module Gtk.TreeView;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gdk.ContentFormats;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gdk.Rectangle;
import Gdk.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellRenderer;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Editable;
import Gtk.EditableT;
import Gtk.Scrollable;
import Gtk.ScrollableT;
import Gtk.Tooltip;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.TreeSelection;
import Gtk.TreeViewColumn;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A widget for displaying both trees and lists
 * Widget that displays any object that implements the [Gtk.TreeModel] interface.
 * Please refer to the [tree widget conceptual overview](section-tree-widget.html)
 * for an overview of all the objects and data types related to the tree
 * widget and how they work together.
 * ## Coordinate systems in GtkTreeView API
 * Several different coordinate systems are exposed in the `GtkTreeView` API.
 * These are:
 * ![](tree-view-coordinates.png)
 * - Widget coordinates: Coordinates relative to the widget $(LPAREN)usually `widget->window`$(RPAREN).
 * - Bin window coordinates: Coordinates relative to the window that GtkTreeView renders to.
 * - Tree coordinates: Coordinates relative to the entire scrollable area of GtkTreeView. These
 * coordinates start at $(LPAREN)0, 0$(RPAREN) for row 0 of the tree.
 * Several functions are available for converting between the different
 * coordinate systems.  The most common translations are between widget and bin
 * window coordinates and between bin window and tree coordinates. For the
 * former you can use [Gtk.TreeView.convertWidgetToBinWindowCoords]
 * $(LPAREN)and vice versa$(RPAREN), for the latter [Gtk.TreeView.convertBinWindowToTreeCoords]
 * $(LPAREN)and vice versa$(RPAREN).
 * ## `GtkTreeView` as `GtkBuildable`
 * The `GtkTreeView` implementation of the `GtkBuildable` interface accepts
 * [Gtk.TreeViewColumn] objects as `<child>` elements and exposes the
 * internal [Gtk.TreeSelection] in UI definitions.
 * An example of a UI definition fragment with `GtkTreeView`:
 * ```xml
 * <object class\="GtkTreeView" id\="treeview">
 * <property name\="model">liststore1</property>
 * <child>
 * <object class\="GtkTreeViewColumn" id\="test-column">
 * <property name\="title">Test</property>
 * <child>
 * <object class\="GtkCellRendererText" id\="test-renderer"/>
 * <attributes>
 * <attribute name\="text">1</attribute>
 * </attributes>
 * </child>
 * </object>
 * </child>
 * <child internal-child\="selection">
 * <object class\="GtkTreeSelection" id\="selection">
 * <signal name\="changed" handler\="on_treeview_selection_changed"/>
 * </object>
 * </child>
 * </object>
 * ```
 * ## CSS nodes
 * ```
 * treeview.view
 * ├── header
 * │   ├── button
 * │   │   ╰── [sort-indicator]
 * ┊   ┊
 * │   ╰── button
 * │       ╰── [sort-indicator]
 * │
 * ├── [rubberband]
 * ╰── [dndtarget]
 * ```
 * `GtkTreeView` has a main CSS node with name `treeview` and style class `.view`.
 * It has a subnode with name `header`, which is the parent for all the column
 * header widgets' CSS nodes.
 * Each column header consists of a `button`, which among other content, has a
 * child with name `sort-indicator`, which carries the `.ascending` or `.descending`
 * style classes when the column header should show a sort indicator. The CSS
 * is expected to provide a suitable image using the `-gtk-icon-source` property.
 * For rubberband selection, a subnode with name `rubberband` is used.
 * For the drop target location during DND, a subnode with name `dndtarget` is used.

 * Deprecated: Use [Gtk.ListView] for lists, and [Gtk.ColumnView]
 *   for tabular lists
 */
class TreeView : Widget, Scrollable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_tree_view_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ScrollableT!();

  /**
   * Creates a new `GtkTreeView` widget.
   * Returns: A newly created `GtkTreeView` widget.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_tree_view_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkTreeView` widget with the model initialized to model.
   * Params:
   *   model = the model.
   * Returns: A newly created `GtkTreeView` widget.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  static TreeView newWithModel(TreeModel model)
  {
    GtkWidget* _cretval;
    _cretval = gtk_tree_view_new_with_model(model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!TreeView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Appends column to the list of columns. If tree_view has “fixed_height”
   * mode enabled, then column must have its “sizing” property set to be
   * GTK_TREE_VIEW_COLUMN_FIXED.
   * Params:
   *   column = The `GtkTreeViewColumn` to add.
   * Returns: The number of columns in tree_view after appending.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  int appendColumn(TreeViewColumn column)
  {
    int _retval;
    _retval = gtk_tree_view_append_column(cast(GtkTreeView*)cPtr, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null);
    return _retval;
  }

  /**
   * Recursively collapses all visible, expanded nodes in tree_view.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void collapseAll()
  {
    gtk_tree_view_collapse_all(cast(GtkTreeView*)cPtr);
  }

  /**
   * Collapses a row $(LPAREN)hides its child rows, if they exist$(RPAREN).
   * Params:
   *   path = path to a row in the tree_view
   * Returns: %TRUE if the row was collapsed.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool collapseRow(TreePath path)
  {
    bool _retval;
    _retval = gtk_tree_view_collapse_row(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }

  /**
   * Resizes all columns to their optimal width. Only works after the
   * treeview has been realized.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void columnsAutosize()
  {
    gtk_tree_view_columns_autosize(cast(GtkTreeView*)cPtr);
  }

  /**
   * Converts bin_window coordinates to coordinates for the
   * tree $(LPAREN)the full scrollable area of the tree$(RPAREN).
   * Params:
   *   bx = X coordinate relative to bin_window
   *   by = Y coordinate relative to bin_window
   *   tx = return location for tree X coordinate
   *   ty = return location for tree Y coordinate

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void convertBinWindowToTreeCoords(int bx, int by, out int tx, out int ty)
  {
    gtk_tree_view_convert_bin_window_to_tree_coords(cast(GtkTreeView*)cPtr, bx, by, cast(int*)&tx, cast(int*)&ty);
  }

  /**
   * Converts bin_window coordinates to widget relative coordinates.
   * Params:
   *   bx = bin_window X coordinate
   *   by = bin_window Y coordinate
   *   wx = return location for widget X coordinate
   *   wy = return location for widget Y coordinate

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void convertBinWindowToWidgetCoords(int bx, int by, out int wx, out int wy)
  {
    gtk_tree_view_convert_bin_window_to_widget_coords(cast(GtkTreeView*)cPtr, bx, by, cast(int*)&wx, cast(int*)&wy);
  }

  /**
   * Converts tree coordinates $(LPAREN)coordinates in full scrollable area of the tree$(RPAREN)
   * to bin_window coordinates.
   * Params:
   *   tx = tree X coordinate
   *   ty = tree Y coordinate
   *   bx = return location for X coordinate relative to bin_window
   *   by = return location for Y coordinate relative to bin_window

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void convertTreeToBinWindowCoords(int tx, int ty, out int bx, out int by)
  {
    gtk_tree_view_convert_tree_to_bin_window_coords(cast(GtkTreeView*)cPtr, tx, ty, cast(int*)&bx, cast(int*)&by);
  }

  /**
   * Converts tree coordinates $(LPAREN)coordinates in full scrollable area of the tree$(RPAREN)
   * to widget coordinates.
   * Params:
   *   tx = X coordinate relative to the tree
   *   ty = Y coordinate relative to the tree
   *   wx = return location for widget X coordinate
   *   wy = return location for widget Y coordinate

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void convertTreeToWidgetCoords(int tx, int ty, out int wx, out int wy)
  {
    gtk_tree_view_convert_tree_to_widget_coords(cast(GtkTreeView*)cPtr, tx, ty, cast(int*)&wx, cast(int*)&wy);
  }

  /**
   * Converts widget coordinates to coordinates for the bin_window.
   * Params:
   *   wx = X coordinate relative to the widget
   *   wy = Y coordinate relative to the widget
   *   bx = return location for bin_window X coordinate
   *   by = return location for bin_window Y coordinate

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void convertWidgetToBinWindowCoords(int wx, int wy, out int bx, out int by)
  {
    gtk_tree_view_convert_widget_to_bin_window_coords(cast(GtkTreeView*)cPtr, wx, wy, cast(int*)&bx, cast(int*)&by);
  }

  /**
   * Converts widget coordinates to coordinates for the
   * tree $(LPAREN)the full scrollable area of the tree$(RPAREN).
   * Params:
   *   wx = X coordinate relative to the widget
   *   wy = Y coordinate relative to the widget
   *   tx = return location for tree X coordinate
   *   ty = return location for tree Y coordinate

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void convertWidgetToTreeCoords(int wx, int wy, out int tx, out int ty)
  {
    gtk_tree_view_convert_widget_to_tree_coords(cast(GtkTreeView*)cPtr, wx, wy, cast(int*)&tx, cast(int*)&ty);
  }

  /**
   * Creates a `cairo_surface_t` representation of the row at path.
   * This image is used for a drag icon.
   * Params:
   *   path = a `GtkTreePath` in tree_view
   * Returns: a newly-allocated surface of the drag icon.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  Paintable createRowDragIcon(TreePath path)
  {
    GdkPaintable* _cretval;
    _cretval = gtk_tree_view_create_row_drag_icon(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Paintable(cast(GdkPaintable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Turns tree_view into a drop destination for automatic DND. Calling
   * this method sets `GtkTreeView`:reorderable to %FALSE.
   * Params:
   *   formats = the target formats that the drag will support
   *   actions = the bitmask of possible actions for a drag from this
   *     widget

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void enableModelDragDest(ContentFormats formats, DragAction actions)
  {
    gtk_tree_view_enable_model_drag_dest(cast(GtkTreeView*)cPtr, formats ? cast(GdkContentFormats*)formats.cPtr(false) : null, actions);
  }

  /**
   * Turns tree_view into a drag source for automatic DND. Calling this
   * method sets `GtkTreeView`:reorderable to %FALSE.
   * Params:
   *   startButtonMask = Mask of allowed buttons to start drag
   *   formats = the target formats that the drag will support
   *   actions = the bitmask of possible actions for a drag from this
   *     widget

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void enableModelDragSource(ModifierType startButtonMask, ContentFormats formats, DragAction actions)
  {
    gtk_tree_view_enable_model_drag_source(cast(GtkTreeView*)cPtr, startButtonMask, formats ? cast(GdkContentFormats*)formats.cPtr(false) : null, actions);
  }

  /**
   * Recursively expands all nodes in the tree_view.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void expandAll()
  {
    gtk_tree_view_expand_all(cast(GtkTreeView*)cPtr);
  }

  /**
   * Opens the row so its children are visible.
   * Params:
   *   path = path to a row
   *   openAll = whether to recursively expand, or just expand immediate children
   * Returns: %TRUE if the row existed and had children

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool expandRow(TreePath path, bool openAll)
  {
    bool _retval;
    _retval = gtk_tree_view_expand_row(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, openAll);
    return _retval;
  }

  /**
   * Expands the row at path. This will also expand all parent rows of
   * path as necessary.
   * Params:
   *   path = path to a row.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void expandToPath(TreePath path)
  {
    gtk_tree_view_expand_to_path(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Gets the setting set by [Gtk.TreeView.setActivateOnSingleClick].
   * Returns: %TRUE if row-activated will be emitted on a single click

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getActivateOnSingleClick()
  {
    bool _retval;
    _retval = gtk_tree_view_get_activate_on_single_click(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Fills the bounding rectangle in bin_window coordinates for the cell at the
   * row specified by path and the column specified by column.  If path is
   * %NULL, or points to a node not found in the tree, the y and height fields of
   * the rectangle will be filled with 0. If column is %NULL, the x and width
   * fields will be filled with 0.  The returned rectangle is equivalent to the
   * background_area passed to gtk_cell_renderer_render$(LPAREN)$(RPAREN).  These background
   * areas tile to cover the entire bin window.  Contrast with the cell_area,
   * returned by [Gtk.TreeView.getCellArea], which returns only the cell
   * itself, excluding surrounding borders and the tree expander area.
   * Params:
   *   path = a `GtkTreePath` for the row, or %NULL to get only horizontal coordinates
   *   column = a `GtkTreeViewColumn` for the column, or %NULL to get only vertical coordinates
   *   rect = rectangle to fill with cell background rect

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void getBackgroundArea(TreePath path, TreeViewColumn column, out Rectangle rect)
  {
    GdkRectangle _rect;
    gtk_tree_view_get_background_area(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null, &_rect);
    rect = new Rectangle(cast(void*)&_rect, false);
  }

  /**
   * Fills the bounding rectangle in bin_window coordinates for the cell at the
   * row specified by path and the column specified by column.  If path is
   * %NULL, or points to a path not currently displayed, the y and height fields
   * of the rectangle will be filled with 0. If column is %NULL, the x and width
   * fields will be filled with 0.  The sum of all cell rects does not cover the
   * entire tree; there are extra pixels in between rows, for example. The
   * returned rectangle is equivalent to the cell_area passed to
   * gtk_cell_renderer_render$(LPAREN)$(RPAREN).  This function is only valid if tree_view is
   * realized.
   * Params:
   *   path = a `GtkTreePath` for the row, or %NULL to get only horizontal coordinates
   *   column = a `GtkTreeViewColumn` for the column, or %NULL to get only vertical coordinates
   *   rect = rectangle to fill with cell rect

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void getCellArea(TreePath path, TreeViewColumn column, out Rectangle rect)
  {
    GdkRectangle _rect;
    gtk_tree_view_get_cell_area(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null, &_rect);
    rect = new Rectangle(cast(void*)&_rect, false);
  }

  /**
   * Gets the `GtkTreeViewColumn` at the given position in the #tree_view.
   * Params:
   *   n = The position of the column, counting from 0.
   * Returns: The `GtkTreeViewColumn`, or %NULL if the
   *   position is outside the range of columns.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  TreeViewColumn getColumn(int n)
  {
    GtkTreeViewColumn* _cretval;
    _cretval = gtk_tree_view_get_column(cast(GtkTreeView*)cPtr, n);
    auto _retval = _cretval ? ObjectG.getDObject!TreeViewColumn(cast(GtkTreeViewColumn*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns a `GList` of all the `GtkTreeViewColumn`s currently in tree_view.
   * The returned list must be freed with g_list_free $(LPAREN)$(RPAREN).
   * Returns: A list of `GtkTreeViewColumn`s

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  List!(TreeViewColumn) getColumns()
  {
    GList* _cretval;
    _cretval = gtk_tree_view_get_columns(cast(GtkTreeView*)cPtr);
    List!(TreeViewColumn) _retval = new List!(TreeViewColumn)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Fills in path and focus_column with the current path and focus column.  If
   * the cursor isn’t currently set, then *path will be %NULL.  If no column
   * currently has focus, then *focus_column will be %NULL.
   * The returned `GtkTreePath` must be freed with [Gtk.TreePath.free] when
   * you are done with it.
   * Params:
   *   path = A pointer to be
   *     filled with the current cursor path
   *   focusColumn = A
   *     pointer to be filled with the current focus column

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void getCursor(out TreePath path, out TreeViewColumn focusColumn)
  {
    GtkTreePath* _path;
    GtkTreeViewColumn* _focusColumn;
    gtk_tree_view_get_cursor(cast(GtkTreeView*)cPtr, &_path, &_focusColumn);
    path = new TreePath(cast(void*)_path, true);
    focusColumn = new TreeViewColumn(cast(void*)_focusColumn, false);
  }

  /**
   * Determines the destination row for a given position.  drag_x and
   * drag_y are expected to be in widget coordinates.  This function is only
   * meaningful if tree_view is realized.  Therefore this function will always
   * return %FALSE if tree_view is not realized or does not have a model.
   * Params:
   *   dragX = the position to determine the destination row for
   *   dragY = the position to determine the destination row for
   *   path = Return location for the path of
   *     the highlighted row
   *   pos = Return location for the drop position, or
   *     %NULL
   * Returns: whether there is a row at the given position, %TRUE if this
   *   is indeed the case.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getDestRowAtPos(int dragX, int dragY, out TreePath path, out TreeViewDropPosition pos)
  {
    bool _retval;
    GtkTreePath* _path;
    _retval = gtk_tree_view_get_dest_row_at_pos(cast(GtkTreeView*)cPtr, dragX, dragY, &_path, &pos);
    path = new TreePath(cast(void*)_path, true);
    return _retval;
  }

  /**
   * Gets information about the row that is highlighted for feedback.
   * Params:
   *   path = Return location for the path of the highlighted row
   *   pos = Return location for the drop position

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void getDragDestRow(out TreePath path, out TreeViewDropPosition pos)
  {
    GtkTreePath* _path;
    gtk_tree_view_get_drag_dest_row(cast(GtkTreeView*)cPtr, &_path, &pos);
    path = new TreePath(cast(void*)_path, true);
  }

  /**
   * Returns whether or not the tree allows to start interactive searching
   * by typing in text.
   * Returns: whether or not to let the user search interactively

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getEnableSearch()
  {
    bool _retval;
    _retval = gtk_tree_view_get_enable_search(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns whether or not tree lines are drawn in tree_view.
   * Returns: %TRUE if tree lines are drawn in tree_view, %FALSE
   *   otherwise.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getEnableTreeLines()
  {
    bool _retval;
    _retval = gtk_tree_view_get_enable_tree_lines(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns the column that is the current expander column,
   * or %NULL if none has been set.
   * This column has the expander arrow drawn next to it.
   * Returns: The expander column.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  TreeViewColumn getExpanderColumn()
  {
    GtkTreeViewColumn* _cretval;
    _cretval = gtk_tree_view_get_expander_column(cast(GtkTreeView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeViewColumn(cast(GtkTreeViewColumn*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether fixed height mode is turned on for tree_view.
   * Returns: %TRUE if tree_view is in fixed height mode

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getFixedHeightMode()
  {
    bool _retval;
    _retval = gtk_tree_view_get_fixed_height_mode(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns which grid lines are enabled in tree_view.
   * Returns: a `GtkTreeView`GridLines value indicating which grid lines
   *   are enabled.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  TreeViewGridLines getGridLines()
  {
    GtkTreeViewGridLines _cretval;
    _cretval = gtk_tree_view_get_grid_lines(cast(GtkTreeView*)cPtr);
    TreeViewGridLines _retval = cast(TreeViewGridLines)_cretval;
    return _retval;
  }

  /**
   * Returns whether all header columns are clickable.
   * Returns: %TRUE if all header columns are clickable, otherwise %FALSE

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getHeadersClickable()
  {
    bool _retval;
    _retval = gtk_tree_view_get_headers_clickable(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the headers on the tree_view are visible.
   * Returns: Whether the headers are visible or not.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getHeadersVisible()
  {
    bool _retval;
    _retval = gtk_tree_view_get_headers_visible(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns whether hover expansion mode is turned on for tree_view.
   * Returns: %TRUE if tree_view is in hover expansion mode

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getHoverExpand()
  {
    bool _retval;
    _retval = gtk_tree_view_get_hover_expand(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns whether hover selection mode is turned on for tree_view.
   * Returns: %TRUE if tree_view is in hover selection mode

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getHoverSelection()
  {
    bool _retval;
    _retval = gtk_tree_view_get_hover_selection(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns the amount, in pixels, of extra indentation for child levels
   * in tree_view.
   * Returns: the amount of extra indentation for child levels in
   *   tree_view.  A return value of 0 means that this feature is disabled.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  int getLevelIndentation()
  {
    int _retval;
    _retval = gtk_tree_view_get_level_indentation(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns the model the `GtkTreeView` is based on.  Returns %NULL if the
   * model is unset.
   * Returns: A `GtkTreeModel`

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_tree_view_get_model(cast(GtkTreeView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Queries the number of columns in the given tree_view.
   * Returns: The number of columns in the tree_view

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  uint getNColumns()
  {
    uint _retval;
    _retval = gtk_tree_view_get_n_columns(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Finds the path at the point $(LPAREN)x, y$(RPAREN), relative to bin_window coordinates.
   * That is, x and y are relative to an events coordinates. Widget-relative
   * coordinates must be converted using
   * [Gtk.TreeView.convertWidgetToBinWindowCoords]. It is primarily for
   * things like popup menus. If path is non-%NULL, then it will be filled
   * with the `GtkTreePath` at that point.  This path should be freed with
   * [Gtk.TreePath.free].  If column is non-%NULL, then it will be filled
   * with the column at that point.  cell_x and cell_y return the coordinates
   * relative to the cell background $(LPAREN)i.e. the background_area passed to
   * gtk_cell_renderer_render$(LPAREN)$(RPAREN)$(RPAREN).  This function is only meaningful if
   * tree_view is realized.  Therefore this function will always return %FALSE
   * if tree_view is not realized or does not have a model.
   * For converting widget coordinates $(LPAREN)eg. the ones you get from
   * GtkWidget::query-tooltip$(RPAREN), please see
   * [Gtk.TreeView.convertWidgetToBinWindowCoords].
   * Params:
   *   x = The x position to be identified $(LPAREN)relative to bin_window$(RPAREN).
   *   y = The y position to be identified $(LPAREN)relative to bin_window$(RPAREN).
   *   path = A pointer to a `GtkTreePath`
   *     pointer to be filled in
   *   column = A pointer to
   *     a `GtkTreeViewColumn` pointer to be filled in
   *   cellX = A pointer where the X coordinate
   *     relative to the cell can be placed
   *   cellY = A pointer where the Y coordinate
   *     relative to the cell can be placed
   * Returns: %TRUE if a row exists at that coordinate.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getPathAtPos(int x, int y, out TreePath path, out TreeViewColumn column, out int cellX, out int cellY)
  {
    bool _retval;
    GtkTreePath* _path;
    GtkTreeViewColumn* _column;
    _retval = gtk_tree_view_get_path_at_pos(cast(GtkTreeView*)cPtr, x, y, &_path, &_column, cast(int*)&cellX, cast(int*)&cellY);
    path = new TreePath(cast(void*)_path, true);
    column = new TreeViewColumn(cast(void*)_column, false);
    return _retval;
  }

  /**
   * Retrieves whether the user can reorder the tree via drag-and-drop. See
   * [Gtk.TreeView.setReorderable].
   * Returns: %TRUE if the tree can be reordered.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getReorderable()
  {
    bool _retval;
    _retval = gtk_tree_view_get_reorderable(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns whether rubber banding is turned on for tree_view.  If the
   * selection mode is %GTK_SELECTION_MULTIPLE, rubber banding will allow the
   * user to select multiple rows by dragging the mouse.
   * Returns: %TRUE if rubber banding in tree_view is enabled.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getRubberBanding()
  {
    bool _retval;
    _retval = gtk_tree_view_get_rubber_banding(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Gets the column searched on by the interactive search code.
   * Returns: the column the interactive search code searches in.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  int getSearchColumn()
  {
    int _retval;
    _retval = gtk_tree_view_get_search_column(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns the `GtkEntry` which is currently in use as interactive search
   * entry for tree_view.  In case the built-in entry is being used, %NULL
   * will be returned.
   * Returns: the entry currently in use as search entry.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  Editable getSearchEntry()
  {
    GtkEditable* _cretval;
    _cretval = gtk_tree_view_get_search_entry(cast(GtkTreeView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Editable(cast(GtkEditable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GtkTreeSelection` associated with tree_view.
   * Returns: A `GtkTreeSelection` object.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  TreeSelection getSelection()
  {
    GtkTreeSelection* _cretval;
    _cretval = gtk_tree_view_get_selection(cast(GtkTreeView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeSelection(cast(GtkTreeSelection*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether or not expanders are drawn in tree_view.
   * Returns: %TRUE if expanders are drawn in tree_view, %FALSE
   *   otherwise.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getShowExpanders()
  {
    bool _retval;
    _retval = gtk_tree_view_get_show_expanders(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Returns the column of tree_view’s model which is being used for
   * displaying tooltips on tree_view’s rows.
   * Returns: the index of the tooltip column that is currently being
   *   used, or -1 if this is disabled.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  int getTooltipColumn()
  {
    int _retval;
    _retval = gtk_tree_view_get_tooltip_column(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * This function is supposed to be used in a ::query-tooltip
   * signal handler for `GtkTreeView`. The x, y and keyboard_tip values
   * which are received in the signal handler, should be passed to this
   * function without modification.
   * The return value indicates whether there is a tree view row at the given
   * coordinates $(LPAREN)%TRUE$(RPAREN) or not $(LPAREN)%FALSE$(RPAREN) for mouse tooltips. For keyboard
   * tooltips the row returned will be the cursor row. When %TRUE, then any of
   * model, path and iter which have been provided will be set to point to
   * that row and the corresponding model. x and y will always be converted
   * to be relative to tree_view’s bin_window if keyboard_tooltip is %FALSE.
   * Params:
   *   x = the x coordinate $(LPAREN)relative to widget coordinates$(RPAREN)
   *   y = the y coordinate $(LPAREN)relative to widget coordinates$(RPAREN)
   *   keyboardTip = whether this is a keyboard tooltip or not
   *   model = a pointer to
   *     receive a `GtkTreeModel`
   *   path = a pointer to receive a `GtkTreePath`
   *   iter = a pointer to receive a `GtkTreeIter`
   * Returns: whether or not the given tooltip context points to a row

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getTooltipContext(int x, int y, bool keyboardTip, out TreeModel model, out TreePath path, out TreeIter iter)
  {
    bool _retval;
    GtkTreeModel* _model;
    GtkTreePath* _path;
    GtkTreeIter _iter;
    _retval = gtk_tree_view_get_tooltip_context(cast(GtkTreeView*)cPtr, x, y, keyboardTip, &_model, &_path, &_iter);
    model = _model ? ObjectG.getDObject!TreeModel(_model, false) : null;
    path = new TreePath(cast(void*)_path, true);
    iter = new TreeIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Sets start_path and end_path to be the first and last visible path.
   * Note that there may be invisible paths in between.
   * The paths should be freed with [Gtk.TreePath.free] after use.
   * Params:
   *   startPath = Return location for start of region
   *   endPath = Return location for end of region
   * Returns: %TRUE, if valid paths were placed in start_path and end_path.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool getVisibleRange(out TreePath startPath, out TreePath endPath)
  {
    bool _retval;
    GtkTreePath* _startPath;
    GtkTreePath* _endPath;
    _retval = gtk_tree_view_get_visible_range(cast(GtkTreeView*)cPtr, &_startPath, &_endPath);
    startPath = new TreePath(cast(void*)_startPath, true);
    endPath = new TreePath(cast(void*)_endPath, true);
    return _retval;
  }

  /**
   * Fills visible_rect with the currently-visible region of the
   * buffer, in tree coordinates. Convert to bin_window coordinates with
   * [Gtk.TreeView.convertTreeToBinWindowCoords].
   * Tree coordinates start at 0,0 for row 0 of the tree, and cover the entire
   * scrollable area of the tree.
   * Params:
   *   visibleRect = rectangle to fill

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void getVisibleRect(out Rectangle visibleRect)
  {
    GdkRectangle _visibleRect;
    gtk_tree_view_get_visible_rect(cast(GtkTreeView*)cPtr, &_visibleRect);
    visibleRect = new Rectangle(cast(void*)&_visibleRect, false);
  }

  /**
   * This inserts the column into the tree_view at position.  If position is
   * -1, then the column is inserted at the end. If tree_view has
   * “fixed_height” mode enabled, then column must have its “sizing” property
   * set to be GTK_TREE_VIEW_COLUMN_FIXED.
   * Params:
   *   column = The `GtkTreeViewColumn` to be inserted.
   *   position = The position to insert column in.
   * Returns: The number of columns in tree_view after insertion.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  int insertColumn(TreeViewColumn column, int position)
  {
    int _retval;
    _retval = gtk_tree_view_insert_column(cast(GtkTreeView*)cPtr, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null, position);
    return _retval;
  }

  /**
   * Convenience function that inserts a new column into the `GtkTreeView`
   * with the given cell renderer and a `GtkTreeCellDataFunc` to set cell renderer
   * attributes $(LPAREN)normally using data from the model$(RPAREN). See also
   * [Gtk.TreeViewColumn.setCellDataFunc], [Gtk.TreeViewColumn.packStart].
   * If tree_view has “fixed_height” mode enabled, then the new column will have its
   * “sizing” property set to be GTK_TREE_VIEW_COLUMN_FIXED.
   * Params:
   *   position = Position to insert, -1 for append
   *   title = column title
   *   cell = cell renderer for column
   *   func = function to set attributes of cell renderer
   * Returns: number of columns in the tree view post-insert

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  int insertColumnWithDataFunc(int position, string title, CellRenderer cell, TreeCellDataFunc func)
  {
    extern(C) void _funcCallback(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cell, GtkTreeModel* treeModel, GtkTreeIter* iter, void* data)
    {
      auto _dlg = cast(TreeCellDataFunc*)data;

      (*_dlg)(treeColumn ? ObjectG.getDObject!TreeViewColumn(cast(void*)treeColumn, false) : null, cell ? ObjectG.getDObject!CellRenderer(cast(void*)cell, false) : null, treeModel ? ObjectG.getDObject!TreeModel(cast(void*)treeModel, false) : null, iter ? new TreeIter(cast(void*)iter, false) : null);
    }

    int _retval;
    const(char)* _title = title.toCString(false);
    auto _func = freezeDelegate(cast(void*)&func);
    _retval = gtk_tree_view_insert_column_with_data_func(cast(GtkTreeView*)cPtr, position, _title, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
    return _retval;
  }

  /**
   * Determine whether the point $(LPAREN)x, y$(RPAREN) in tree_view is blank, that is no
   * cell content nor an expander arrow is drawn at the location. If so, the
   * location can be considered as the background. You might wish to take
   * special action on clicks on the background, such as clearing a current
   * selection, having a custom context menu or starting rubber banding.
   * The x and y coordinate that are provided must be relative to bin_window
   * coordinates.  Widget-relative coordinates must be converted using
   * [Gtk.TreeView.convertWidgetToBinWindowCoords].
   * For converting widget coordinates $(LPAREN)eg. the ones you get from
   * GtkWidget::query-tooltip$(RPAREN), please see
   * [Gtk.TreeView.convertWidgetToBinWindowCoords].
   * The path, column, cell_x and cell_y arguments will be filled in
   * likewise as for [Gtk.TreeView.getPathAtPos].  Please see
   * [Gtk.TreeView.getPathAtPos] for more information.
   * Params:
   *   x = The x position to be identified $(LPAREN)relative to bin_window$(RPAREN)
   *   y = The y position to be identified $(LPAREN)relative to bin_window$(RPAREN)
   *   path = A pointer to a `GtkTreePath` pointer to
   *     be filled in
   *   column = A pointer to a
   *     `GtkTreeViewColumn` pointer to be filled in
   *   cellX = A pointer where the X coordinate relative to the
   *     cell can be placed
   *   cellY = A pointer where the Y coordinate relative to the
   *     cell can be placed
   * Returns: %TRUE if the area at the given coordinates is blank,
   *   %FALSE otherwise.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool isBlankAtPos(int x, int y, out TreePath path, out TreeViewColumn column, out int cellX, out int cellY)
  {
    bool _retval;
    GtkTreePath* _path;
    GtkTreeViewColumn* _column;
    _retval = gtk_tree_view_is_blank_at_pos(cast(GtkTreeView*)cPtr, x, y, &_path, &_column, cast(int*)&cellX, cast(int*)&cellY);
    path = new TreePath(cast(void*)_path, true);
    column = new TreeViewColumn(cast(void*)_column, false);
    return _retval;
  }

  /**
   * Returns whether a rubber banding operation is currently being done
   * in tree_view.
   * Returns: %TRUE if a rubber banding operation is currently being
   *   done in tree_view.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool isRubberBandingActive()
  {
    bool _retval;
    _retval = gtk_tree_view_is_rubber_banding_active(cast(GtkTreeView*)cPtr);
    return _retval;
  }

  /**
   * Calls func on all expanded rows.
   * Params:
   *   func = A function to be called

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void mapExpandedRows(TreeViewMappingFunc func)
  {
    extern(C) void _funcCallback(GtkTreeView* treeView, GtkTreePath* path, void* userData)
    {
      auto _dlg = cast(TreeViewMappingFunc*)userData;

      (*_dlg)(treeView ? ObjectG.getDObject!TreeView(cast(void*)treeView, false) : null, path ? new TreePath(cast(void*)path, false) : null);
    }

    auto _func = cast(void*)&func;
    gtk_tree_view_map_expanded_rows(cast(GtkTreeView*)cPtr, &_funcCallback, _func);
  }

  /**
   * Moves column to be after to base_column.  If base_column is %NULL, then
   * column is placed in the first position.
   * Params:
   *   column = The `GtkTreeViewColumn` to be moved.
   *   baseColumn = The `GtkTreeViewColumn` to be moved relative to

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void moveColumnAfter(TreeViewColumn column, TreeViewColumn baseColumn)
  {
    gtk_tree_view_move_column_after(cast(GtkTreeView*)cPtr, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null, baseColumn ? cast(GtkTreeViewColumn*)baseColumn.cPtr(false) : null);
  }

  /**
   * Removes column from tree_view.
   * Params:
   *   column = The `GtkTreeViewColumn` to remove.
   * Returns: The number of columns in tree_view after removing.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  int removeColumn(TreeViewColumn column)
  {
    int _retval;
    _retval = gtk_tree_view_remove_column(cast(GtkTreeView*)cPtr, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null);
    return _retval;
  }

  /**
   * Activates the cell determined by path and column.
   * Params:
   *   path = The `GtkTreePath` to be activated.
   *   column = The `GtkTreeViewColumn` to be activated.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void rowActivated(TreePath path, TreeViewColumn column)
  {
    gtk_tree_view_row_activated(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null);
  }

  /**
   * Returns %TRUE if the node pointed to by path is expanded in tree_view.
   * Params:
   *   path = A `GtkTreePath` to test expansion state.
   * Returns: %TRUE if #path is expanded.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  bool rowExpanded(TreePath path)
  {
    bool _retval;
    _retval = gtk_tree_view_row_expanded(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves the alignments of tree_view to the position specified by column and
   * path.  If column is %NULL, then no horizontal scrolling occurs.  Likewise,
   * if path is %NULL no vertical scrolling occurs.  At a minimum, one of column
   * or path need to be non-%NULL.  row_align determines where the row is
   * placed, and col_align determines where column is placed.  Both are expected
   * to be between 0.0 and 1.0. 0.0 means left/top alignment, 1.0 means
   * right/bottom alignment, 0.5 means center.
   * If use_align is %FALSE, then the alignment arguments are ignored, and the
   * tree does the minimum amount of work to scroll the cell onto the screen.
   * This means that the cell will be scrolled to the edge closest to its current
   * position.  If the cell is currently visible on the screen, nothing is done.
   * This function only works if the model is set, and path is a valid row on the
   * model.  If the model changes before the tree_view is realized, the centered
   * path will be modified to reflect this change.
   * Params:
   *   path = The path of the row to move to
   *   column = The `GtkTreeViewColumn` to move horizontally to
   *   useAlign = whether to use alignment arguments, or %FALSE.
   *   rowAlign = The vertical alignment of the row specified by path.
   *   colAlign = The horizontal alignment of the column specified by column.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void scrollToCell(TreePath path, TreeViewColumn column, bool useAlign, float rowAlign, float colAlign)
  {
    gtk_tree_view_scroll_to_cell(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null, useAlign, rowAlign, colAlign);
  }

  /**
   * Scrolls the tree view such that the top-left corner of the visible
   * area is tree_x, tree_y, where tree_x and tree_y are specified
   * in tree coordinates.  The tree_view must be realized before
   * this function is called.  If it isn't, you probably want to be
   * using [Gtk.TreeView.scrollToCell].
   * If either tree_x or tree_y are -1, then that direction isn’t scrolled.
   * Params:
   *   treeX = X coordinate of new top-left pixel of visible area, or -1
   *   treeY = Y coordinate of new top-left pixel of visible area, or -1

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void scrollToPoint(int treeX, int treeY)
  {
    gtk_tree_view_scroll_to_point(cast(GtkTreeView*)cPtr, treeX, treeY);
  }

  /**
   * Cause the `GtkTreeView`::row-activated signal to be emitted
   * on a single click instead of a double click.
   * Params:
   *   single = %TRUE to emit row-activated on a single click

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setActivateOnSingleClick(bool single)
  {
    gtk_tree_view_set_activate_on_single_click(cast(GtkTreeView*)cPtr, single);
  }

  /**
   * Sets a user function for determining where a column may be dropped when
   * dragged.  This function is called on every column pair in turn at the
   * beginning of a column drag to determine where a drop can take place.  The
   * arguments passed to func are: the tree_view, the `GtkTreeViewColumn` being
   * dragged, the two `GtkTreeViewColumn`s determining the drop spot, and
   * user_data.  If either of the `GtkTreeViewColumn` arguments for the drop spot
   * are %NULL, then they indicate an edge.  If func is set to be %NULL, then
   * tree_view reverts to the default behavior of allowing all columns to be
   * dropped everywhere.
   * Params:
   *   func = A function to determine which columns are reorderable

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setColumnDragFunction(TreeViewColumnDropFunc func)
  {
    extern(C) bool _funcCallback(GtkTreeView* treeView, GtkTreeViewColumn* column, GtkTreeViewColumn* prevColumn, GtkTreeViewColumn* nextColumn, void* data)
    {
      auto _dlg = cast(TreeViewColumnDropFunc*)data;

      bool _retval = (*_dlg)(treeView ? ObjectG.getDObject!TreeView(cast(void*)treeView, false) : null, column ? ObjectG.getDObject!TreeViewColumn(cast(void*)column, false) : null, prevColumn ? ObjectG.getDObject!TreeViewColumn(cast(void*)prevColumn, false) : null, nextColumn ? ObjectG.getDObject!TreeViewColumn(cast(void*)nextColumn, false) : null);
      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_tree_view_set_column_drag_function(cast(GtkTreeView*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Sets the current keyboard focus to be at path, and selects it.  This is
   * useful when you want to focus the user’s attention on a particular row.  If
   * focus_column is not %NULL, then focus is given to the column specified by
   * it. Additionally, if focus_column is specified, and start_editing is
   * %TRUE, then editing should be started in the specified cell.
   * This function is often followed by gtk_widget_grab_focus $(LPAREN)tree_view$(RPAREN)
   * in order to give keyboard focus to the widget.  Please note that editing
   * can only happen when the widget is realized.
   * If path is invalid for model, the current cursor $(LPAREN)if any$(RPAREN) will be unset
   * and the function will return without failing.
   * Params:
   *   path = A `GtkTreePath`
   *   focusColumn = A `GtkTreeViewColumn`
   *   startEditing = %TRUE if the specified cell should start being edited.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setCursor(TreePath path, TreeViewColumn focusColumn, bool startEditing)
  {
    gtk_tree_view_set_cursor(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, focusColumn ? cast(GtkTreeViewColumn*)focusColumn.cPtr(false) : null, startEditing);
  }

  /**
   * Sets the current keyboard focus to be at path, and selects it.  This is
   * useful when you want to focus the user’s attention on a particular row.  If
   * focus_column is not %NULL, then focus is given to the column specified by
   * it. If focus_column and focus_cell are not %NULL, and focus_column
   * contains 2 or more editable or activatable cells, then focus is given to
   * the cell specified by focus_cell. Additionally, if focus_column is
   * specified, and start_editing is %TRUE, then editing should be started in
   * the specified cell.  This function is often followed by
   * gtk_widget_grab_focus $(LPAREN)tree_view$(RPAREN) in order to give keyboard focus to the
   * widget.  Please note that editing can only happen when the widget is
   * realized.
   * If path is invalid for model, the current cursor $(LPAREN)if any$(RPAREN) will be unset
   * and the function will return without failing.
   * Params:
   *   path = A `GtkTreePath`
   *   focusColumn = A `GtkTreeViewColumn`
   *   focusCell = A `GtkCellRenderer`
   *   startEditing = %TRUE if the specified cell should start being edited.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setCursorOnCell(TreePath path, TreeViewColumn focusColumn, CellRenderer focusCell, bool startEditing)
  {
    gtk_tree_view_set_cursor_on_cell(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, focusColumn ? cast(GtkTreeViewColumn*)focusColumn.cPtr(false) : null, focusCell ? cast(GtkCellRenderer*)focusCell.cPtr(false) : null, startEditing);
  }

  /**
   * Sets the row that is highlighted for feedback.
   * If path is %NULL, an existing highlight is removed.
   * Params:
   *   path = The path of the row to highlight
   *   pos = Specifies whether to drop before, after or into the row

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setDragDestRow(TreePath path, TreeViewDropPosition pos)
  {
    gtk_tree_view_set_drag_dest_row(cast(GtkTreeView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, pos);
  }

  /**
   * If enable_search is set, then the user can type in text to search through
   * the tree interactively $(LPAREN)this is sometimes called "typeahead find"$(RPAREN).
   * Note that even if this is %FALSE, the user can still initiate a search
   * using the “start-interactive-search” key binding.
   * Params:
   *   enableSearch = %TRUE, if the user can search interactively

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setEnableSearch(bool enableSearch)
  {
    gtk_tree_view_set_enable_search(cast(GtkTreeView*)cPtr, enableSearch);
  }

  /**
   * Sets whether to draw lines interconnecting the expanders in tree_view.
   * This does not have any visible effects for lists.
   * Params:
   *   enabled = %TRUE to enable tree line drawing, %FALSE otherwise.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setEnableTreeLines(bool enabled)
  {
    gtk_tree_view_set_enable_tree_lines(cast(GtkTreeView*)cPtr, enabled);
  }

  /**
   * Sets the column to draw the expander arrow at. It must be in tree_view.
   * If column is %NULL, then the expander arrow is always at the first
   * visible column.
   * If you do not want expander arrow to appear in your tree, set the
   * expander column to a hidden column.
   * Params:
   *   column = %NULL, or the column to draw the expander arrow at.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setExpanderColumn(TreeViewColumn column)
  {
    gtk_tree_view_set_expander_column(cast(GtkTreeView*)cPtr, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null);
  }

  /**
   * Enables or disables the fixed height mode of tree_view.
   * Fixed height mode speeds up `GtkTreeView` by assuming that all
   * rows have the same height.
   * Only enable this option if all rows are the same height and all
   * columns are of type %GTK_TREE_VIEW_COLUMN_FIXED.
   * Params:
   *   enable = %TRUE to enable fixed height mode

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setFixedHeightMode(bool enable)
  {
    gtk_tree_view_set_fixed_height_mode(cast(GtkTreeView*)cPtr, enable);
  }

  /**
   * Sets which grid lines to draw in tree_view.
   * Params:
   *   gridLines = a `GtkTreeView`GridLines value indicating which grid lines to
   *     enable.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setGridLines(TreeViewGridLines gridLines)
  {
    gtk_tree_view_set_grid_lines(cast(GtkTreeView*)cPtr, gridLines);
  }

  /**
   * Allow the column title buttons to be clicked.
   * Params:
   *   setting = %TRUE if the columns are clickable.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setHeadersClickable(bool setting)
  {
    gtk_tree_view_set_headers_clickable(cast(GtkTreeView*)cPtr, setting);
  }

  /**
   * Sets the visibility state of the headers.
   * Params:
   *   headersVisible = %TRUE if the headers are visible

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setHeadersVisible(bool headersVisible)
  {
    gtk_tree_view_set_headers_visible(cast(GtkTreeView*)cPtr, headersVisible);
  }

  /**
   * Enables or disables the hover expansion mode of tree_view.
   * Hover expansion makes rows expand or collapse if the pointer
   * moves over them.
   * Params:
   *   expand = %TRUE to enable hover selection mode

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setHoverExpand(bool expand)
  {
    gtk_tree_view_set_hover_expand(cast(GtkTreeView*)cPtr, expand);
  }

  /**
   * Enables or disables the hover selection mode of tree_view.
   * Hover selection makes the selected row follow the pointer.
   * Currently, this works only for the selection modes
   * %GTK_SELECTION_SINGLE and %GTK_SELECTION_BROWSE.
   * Params:
   *   hover = %TRUE to enable hover selection mode

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setHoverSelection(bool hover)
  {
    gtk_tree_view_set_hover_selection(cast(GtkTreeView*)cPtr, hover);
  }

  /**
   * Sets the amount of extra indentation for child levels to use in tree_view
   * in addition to the default indentation.  The value should be specified in
   * pixels, a value of 0 disables this feature and in this case only the default
   * indentation will be used.
   * This does not have any visible effects for lists.
   * Params:
   *   indentation = the amount, in pixels, of extra indentation in tree_view.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setLevelIndentation(int indentation)
  {
    gtk_tree_view_set_level_indentation(cast(GtkTreeView*)cPtr, indentation);
  }

  /**
   * Sets the model for a `GtkTreeView`.  If the tree_view already has a model
   * set, it will remove it before setting the new model.  If model is %NULL,
   * then it will unset the old model.
   * Params:
   *   model = The model.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setModel(TreeModel model)
  {
    gtk_tree_view_set_model(cast(GtkTreeView*)cPtr, model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * This function is a convenience function to allow you to reorder
   * models that support the `GtkTreeDragSourceIface` and the
   * `GtkTreeDragDestIface`.  Both `GtkTreeStore` and `GtkListStore` support
   * these.  If reorderable is %TRUE, then the user can reorder the
   * model by dragging and dropping rows. The developer can listen to
   * these changes by connecting to the model’s `GtkTreeModel::row-inserted`
   * and `GtkTreeModel::row-deleted` signals. The reordering is implemented
   * by setting up the tree view as a drag source and destination.
   * Therefore, drag and drop can not be used in a reorderable view for any
   * other purpose.
   * This function does not give you any degree of control over the order -- any
   * reordering is allowed.  If more control is needed, you should probably
   * handle drag and drop manually.
   * Params:
   *   reorderable = %TRUE, if the tree can be reordered.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setReorderable(bool reorderable)
  {
    gtk_tree_view_set_reorderable(cast(GtkTreeView*)cPtr, reorderable);
  }

  /**
   * Sets the row separator function, which is used to determine
   * whether a row should be drawn as a separator. If the row separator
   * function is %NULL, no separators are drawn. This is the default value.
   * Params:
   *   func = a `GtkTreeView`RowSeparatorFunc

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setRowSeparatorFunc(TreeViewRowSeparatorFunc func)
  {
    extern(C) bool _funcCallback(GtkTreeModel* model, GtkTreeIter* iter, void* data)
    {
      auto _dlg = cast(TreeViewRowSeparatorFunc*)data;

      bool _retval = (*_dlg)(model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, iter ? new TreeIter(cast(void*)iter, false) : null);
      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_tree_view_set_row_separator_func(cast(GtkTreeView*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Enables or disables rubber banding in tree_view.  If the selection mode
   * is %GTK_SELECTION_MULTIPLE, rubber banding will allow the user to select
   * multiple rows by dragging the mouse.
   * Params:
   *   enable = %TRUE to enable rubber banding

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setRubberBanding(bool enable)
  {
    gtk_tree_view_set_rubber_banding(cast(GtkTreeView*)cPtr, enable);
  }

  /**
   * Sets column as the column where the interactive search code should
   * search in for the current model.
   * If the search column is set, users can use the “start-interactive-search”
   * key binding to bring up search popup. The enable-search property controls
   * whether simply typing text will also start an interactive search.
   * Note that column refers to a column of the current model. The search
   * column is reset to -1 when the model is changed.
   * Params:
   *   column = the column of the model to search in, or -1 to disable searching

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setSearchColumn(int column)
  {
    gtk_tree_view_set_search_column(cast(GtkTreeView*)cPtr, column);
  }

  /**
   * Sets the entry which the interactive search code will use for this
   * tree_view.  This is useful when you want to provide a search entry
   * in our interface at all time at a fixed position.  Passing %NULL for
   * entry will make the interactive search code use the built-in popup
   * entry again.
   * Params:
   *   entry = the entry the interactive search code of tree_view should use

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setSearchEntry(Editable entry)
  {
    gtk_tree_view_set_search_entry(cast(GtkTreeView*)cPtr, entry ? cast(GtkEditable*)(cast(ObjectG)entry).cPtr(false) : null);
  }

  /**
   * Sets the compare function for the interactive search capabilities; note
   * that somewhat like strcmp$(LPAREN)$(RPAREN) returning 0 for equality
   * `GtkTreeView`SearchEqualFunc returns %FALSE on matches.
   * Params:
   *   searchEqualFunc = the compare function to use during the search

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setSearchEqualFunc(TreeViewSearchEqualFunc searchEqualFunc)
  {
    extern(C) bool _searchEqualFuncCallback(GtkTreeModel* model, int column, const(char)* key, GtkTreeIter* iter, void* searchData)
    {
      auto _dlg = cast(TreeViewSearchEqualFunc*)searchData;
      string _key = key.fromCString(false);

      bool _retval = (*_dlg)(model ? ObjectG.getDObject!TreeModel(cast(void*)model, false) : null, column, _key, iter ? new TreeIter(cast(void*)iter, false) : null);
      return _retval;
    }

    auto _searchEqualFunc = freezeDelegate(cast(void*)&searchEqualFunc);
    gtk_tree_view_set_search_equal_func(cast(GtkTreeView*)cPtr, &_searchEqualFuncCallback, _searchEqualFunc, &thawDelegate);
  }

  /**
   * Sets whether to draw and enable expanders and indent child rows in
   * tree_view.  When disabled there will be no expanders visible in trees
   * and there will be no way to expand and collapse rows by default.  Also
   * note that hiding the expanders will disable the default indentation.  You
   * can set a custom indentation in this case using
   * [Gtk.TreeView.setLevelIndentation].
   * This does not have any visible effects for lists.
   * Params:
   *   enabled = %TRUE to enable expander drawing, %FALSE otherwise.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setShowExpanders(bool enabled)
  {
    gtk_tree_view_set_show_expanders(cast(GtkTreeView*)cPtr, enabled);
  }

  /**
   * Sets the tip area of tooltip to the area path, column and cell have
   * in common.  For example if path is %NULL and column is set, the tip
   * area will be set to the full area covered by column.  See also
   * [Gtk.Tooltip.setTipArea].
   * Note that if path is not specified and cell is set and part of a column
   * containing the expander, the tooltip might not show and hide at the correct
   * position.  In such cases path must be set to the current node under the
   * mouse cursor for this function to operate correctly.
   * See also [Gtk.TreeView.setTooltipColumn] for a simpler alternative.
   * Params:
   *   tooltip = a `GtkTooltip`
   *   path = a `GtkTreePath`
   *   column = a `GtkTreeViewColumn`
   *   cell = a `GtkCellRenderer`

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setTooltipCell(Tooltip tooltip, TreePath path, TreeViewColumn column, CellRenderer cell)
  {
    gtk_tree_view_set_tooltip_cell(cast(GtkTreeView*)cPtr, tooltip ? cast(GtkTooltip*)tooltip.cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null, column ? cast(GtkTreeViewColumn*)column.cPtr(false) : null, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null);
  }

  /**
   * If you only plan to have simple $(LPAREN)text-only$(RPAREN) tooltips on full rows, you
   * can use this function to have `GtkTreeView` handle these automatically
   * for you. column should be set to the column in tree_view’s model
   * containing the tooltip texts, or -1 to disable this feature.
   * When enabled, `GtkWidget:has-tooltip` will be set to %TRUE and
   * tree_view will connect a `GtkWidget::query-tooltip` signal handler.
   * Note that the signal handler sets the text with [Gtk.Tooltip.setMarkup],
   * so &, <, etc have to be escaped in the text.
   * Params:
   *   column = an integer, which is a valid column number for tree_view’s model

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setTooltipColumn(int column)
  {
    gtk_tree_view_set_tooltip_column(cast(GtkTreeView*)cPtr, column);
  }

  /**
   * Sets the tip area of tooltip to be the area covered by the row at path.
   * See also [Gtk.TreeView.setTooltipColumn] for a simpler alternative.
   * See also [Gtk.Tooltip.setTipArea].
   * Params:
   *   tooltip = a `GtkTooltip`
   *   path = a `GtkTreePath`

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void setTooltipRow(Tooltip tooltip, TreePath path)
  {
    gtk_tree_view_set_tooltip_row(cast(GtkTreeView*)cPtr, tooltip ? cast(GtkTooltip*)tooltip.cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Undoes the effect of
   * [Gtk.TreeView.enableModelDragDest]. Calling this method sets
   * `GtkTreeView`:reorderable to %FALSE.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void unsetRowsDragDest()
  {
    gtk_tree_view_unset_rows_drag_dest(cast(GtkTreeView*)cPtr);
  }

  /**
   * Undoes the effect of
   * [Gtk.TreeView.enableModelDragSource]. Calling this method sets
   * `GtkTreeView`:reorderable to %FALSE.

   * Deprecated: Use [Gtk.ListView] or [Gtk.ColumnView] instead
   */
  void unsetRowsDragSource()
  {
    gtk_tree_view_unset_rows_drag_source(cast(GtkTreeView*)cPtr);
  }

  /**
   * The number of columns of the treeview has changed.
   *   treeView = the instance the signal is connected to
   */
  alias ColumnsChangedCallback = void delegate(TreeView treeView);

  /**
   * Connect to ColumnsChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectColumnsChanged(ColumnsChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeView = getVal!TreeView(_paramVals);
      _dgClosure.dlg(treeView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("columns-changed", closure, after);
  }

  /**
   * The position of the cursor $(LPAREN)focused cell$(RPAREN) has changed.
   *   treeView = the instance the signal is connected to
   */
  alias CursorChangedCallback = void delegate(TreeView treeView);

  /**
   * Connect to CursorChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCursorChanged(CursorChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeView = getVal!TreeView(_paramVals);
      _dgClosure.dlg(treeView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cursor-changed", closure, after);
  }

  alias ExpandCollapseCursorRowCallback = bool delegate(bool object, bool p0, bool p1, TreeView treeView);

  /**
   * Connect to ExpandCollapseCursorRow signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectExpandCollapseCursorRow(ExpandCollapseCursorRowCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      auto object = getVal!bool(&_paramVals[1]);
      auto p0 = getVal!bool(&_paramVals[2]);
      auto p1 = getVal!bool(&_paramVals[3]);
      _retval = _dgClosure.dlg(object, p0, p1, treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("expand-collapse-cursor-row", closure, after);
  }

  /**
   * The `GtkTreeView`::move-cursor signal is a [keybinding
   * signal][Gtk.SignalAction] which gets emitted when the user
   * presses one of the cursor keys.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control the cursor
   * programmatically. In contrast to [Gtk.TreeView.setCursor] and
   * [Gtk.TreeView.setCursorOnCell] when moving horizontally
   * `GtkTreeView`::move-cursor does not reset the current selection.
   * Params
   *   step = the granularity of the move, as a `GtkMovementStep`.
   *     %GTK_MOVEMENT_LOGICAL_POSITIONS, %GTK_MOVEMENT_VISUAL_POSITIONS,
   *     %GTK_MOVEMENT_DISPLAY_LINES, %GTK_MOVEMENT_PAGES and
   *     %GTK_MOVEMENT_BUFFER_ENDS are supported.
   *     %GTK_MOVEMENT_LOGICAL_POSITIONS and %GTK_MOVEMENT_VISUAL_POSITIONS
   *     are treated identically.
   *   direction = the direction to move: +1 to move forwards; -1 to move
   *     backwards. The resulting movement is undefined for all other values.
   *   extend = whether to extend the selection
   *   modify = whether to modify the selection
   *   treeView = the instance the signal is connected to
   * Returns: %TRUE if step is supported, %FALSE otherwise.
   */
  alias MoveCursorCallback = bool delegate(MovementStep step, int direction, bool extend, bool modify, TreeView treeView);

  /**
   * Connect to MoveCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMoveCursor(MoveCursorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      auto step = getVal!MovementStep(&_paramVals[1]);
      auto direction = getVal!int(&_paramVals[2]);
      auto extend = getVal!bool(&_paramVals[3]);
      auto modify = getVal!bool(&_paramVals[4]);
      _retval = _dgClosure.dlg(step, direction, extend, modify, treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-cursor", closure, after);
  }

  /**
   * The "row-activated" signal is emitted when the method
   * [Gtk.TreeView.rowActivated] is called.
   * This signal is emitted when the user double-clicks a treeview row with the
   * propertyGtk.TreeView:activate-on-single-click property set to %FALSE,
   * or when the user single-clicks a row when that property set to %TRUE.
   * This signal is also emitted when a non-editable row is selected and one
   * of the keys: <kbd>Space</kbd>, <kbd>Shift</kbd>+<kbd>Space</kbd>,
   * <kbd>Return</kbd> or <kbd>Enter</kbd> is pressed.
   * For selection handling refer to the
   * [tree widget conceptual overview](section-tree-widget.html)
   * as well as `GtkTreeSelection`.
   * Params
   *   path = the `GtkTreePath` for the activated row
   *   column = the `GtkTreeViewColumn` in which the activation occurred
   *   treeView = the instance the signal is connected to
   */
  alias RowActivatedCallback = void delegate(TreePath path, TreeViewColumn column, TreeView treeView);

  /**
   * Connect to RowActivated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRowActivated(RowActivatedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeView = getVal!TreeView(_paramVals);
      auto path = getVal!TreePath(&_paramVals[1]);
      auto column = getVal!TreeViewColumn(&_paramVals[2]);
      _dgClosure.dlg(path, column, treeView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("row-activated", closure, after);
  }

  /**
   * The given row has been collapsed $(LPAREN)child nodes are hidden$(RPAREN).
   * Params
   *   iter = the tree iter of the collapsed row
   *   path = a tree path that points to the row
   *   treeView = the instance the signal is connected to
   */
  alias RowCollapsedCallback = void delegate(TreeIter iter, TreePath path, TreeView treeView);

  /**
   * Connect to RowCollapsed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRowCollapsed(RowCollapsedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeView = getVal!TreeView(_paramVals);
      auto iter = getVal!TreeIter(&_paramVals[1]);
      auto path = getVal!TreePath(&_paramVals[2]);
      _dgClosure.dlg(iter, path, treeView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("row-collapsed", closure, after);
  }

  /**
   * The given row has been expanded $(LPAREN)child nodes are shown$(RPAREN).
   * Params
   *   iter = the tree iter of the expanded row
   *   path = a tree path that points to the row
   *   treeView = the instance the signal is connected to
   */
  alias RowExpandedCallback = void delegate(TreeIter iter, TreePath path, TreeView treeView);

  /**
   * Connect to RowExpanded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRowExpanded(RowExpandedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeView = getVal!TreeView(_paramVals);
      auto iter = getVal!TreeIter(&_paramVals[1]);
      auto path = getVal!TreePath(&_paramVals[2]);
      _dgClosure.dlg(iter, path, treeView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("row-expanded", closure, after);
  }

  alias SelectAllCallback = bool delegate(TreeView treeView);

  /**
   * Connect to SelectAll signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectAll(SelectAllCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      _retval = _dgClosure.dlg(treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-all", closure, after);
  }

  alias SelectCursorParentCallback = bool delegate(TreeView treeView);

  /**
   * Connect to SelectCursorParent signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectCursorParent(SelectCursorParentCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      _retval = _dgClosure.dlg(treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-cursor-parent", closure, after);
  }

  alias SelectCursorRowCallback = bool delegate(bool object, TreeView treeView);

  /**
   * Connect to SelectCursorRow signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectCursorRow(SelectCursorRowCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      auto object = getVal!bool(&_paramVals[1]);
      _retval = _dgClosure.dlg(object, treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-cursor-row", closure, after);
  }

  alias StartInteractiveSearchCallback = bool delegate(TreeView treeView);

  /**
   * Connect to StartInteractiveSearch signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectStartInteractiveSearch(StartInteractiveSearchCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      _retval = _dgClosure.dlg(treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("start-interactive-search", closure, after);
  }

  /**
   * The given row is about to be collapsed $(LPAREN)hide its children nodes$(RPAREN). Use this
   * signal if you need to control the collapsibility of individual rows.
   * Params
   *   iter = the tree iter of the row to collapse
   *   path = a tree path that points to the row
   *   treeView = the instance the signal is connected to
   * Returns: %FALSE to allow collapsing, %TRUE to reject
   */
  alias TestCollapseRowCallback = bool delegate(TreeIter iter, TreePath path, TreeView treeView);

  /**
   * Connect to TestCollapseRow signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectTestCollapseRow(TestCollapseRowCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      auto iter = getVal!TreeIter(&_paramVals[1]);
      auto path = getVal!TreePath(&_paramVals[2]);
      _retval = _dgClosure.dlg(iter, path, treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("test-collapse-row", closure, after);
  }

  /**
   * The given row is about to be expanded $(LPAREN)show its children nodes$(RPAREN). Use this
   * signal if you need to control the expandability of individual rows.
   * Params
   *   iter = the tree iter of the row to expand
   *   path = a tree path that points to the row
   *   treeView = the instance the signal is connected to
   * Returns: %FALSE to allow expansion, %TRUE to reject
   */
  alias TestExpandRowCallback = bool delegate(TreeIter iter, TreePath path, TreeView treeView);

  /**
   * Connect to TestExpandRow signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectTestExpandRow(TestExpandRowCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      auto iter = getVal!TreeIter(&_paramVals[1]);
      auto path = getVal!TreePath(&_paramVals[2]);
      _retval = _dgClosure.dlg(iter, path, treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("test-expand-row", closure, after);
  }

  alias ToggleCursorRowCallback = bool delegate(TreeView treeView);

  /**
   * Connect to ToggleCursorRow signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggleCursorRow(ToggleCursorRowCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      _retval = _dgClosure.dlg(treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-cursor-row", closure, after);
  }

  alias UnselectAllCallback = bool delegate(TreeView treeView);

  /**
   * Connect to UnselectAll signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUnselectAll(UnselectAllCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto treeView = getVal!TreeView(_paramVals);
      _retval = _dgClosure.dlg(treeView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unselect-all", closure, after);
  }
}

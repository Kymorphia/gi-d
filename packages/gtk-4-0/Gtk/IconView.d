module Gtk.IconView;

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
import Gtk.CellArea;
import Gtk.CellLayout;
import Gtk.CellLayoutT;
import Gtk.CellRenderer;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Scrollable;
import Gtk.ScrollableT;
import Gtk.Tooltip;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.TreePath;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkIconView` is a widget which displays data in a grid of icons.
 * `GtkIconView` provides an alternative view on a `GtkTreeModel`.
 * It displays the model as a grid of icons with labels. Like
 * [Gtk.TreeView], it allows to select one or multiple items
 * $(LPAREN)depending on the selection mode, see [Gtk.IconView.setSelectionMode]$(RPAREN).
 * In addition to selection with the arrow keys, `GtkIconView` supports
 * rubberband selection, which is controlled by dragging the pointer.
 * Note that if the tree model is backed by an actual tree store $(LPAREN)as
 * opposed to a flat list where the mapping to icons is obvious$(RPAREN),
 * `GtkIconView` will only display the first level of the tree and
 * ignore the tree’s branches.
 * ## CSS nodes
 * ```
 * iconview.view
 * ╰── [rubberband]
 * ```
 * `GtkIconView` has a single CSS node with name iconview and style class .view.
 * For rubberband selection, a subnode with name rubberband is used.

 * Deprecated: Use [Gtk.GridView] instead
 */
class IconView : Widget, CellLayout, Scrollable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_icon_view_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin CellLayoutT!();
  mixin ScrollableT!();

  /**
   * Creates a new `GtkIconView` widget
   * Returns: A newly created `GtkIconView` widget

   * Deprecated: Use [Gtk.GridView] instead
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_icon_view_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkIconView` widget using the
   * specified area to layout cells inside the icons.
   * Params:
   *   area = the `GtkCellArea` to use to layout cells
   * Returns: A newly created `GtkIconView` widget

   * Deprecated: Use [Gtk.GridView] instead
   */
  static IconView newWithArea(CellArea area)
  {
    GtkWidget* _cretval;
    _cretval = gtk_icon_view_new_with_area(area ? cast(GtkCellArea*)area.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!IconView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkIconView` widget with the model model.
   * Params:
   *   model = The model.
   * Returns: A newly created `GtkIconView` widget.

   * Deprecated: Use [Gtk.GridView] instead
   */
  static IconView newWithModel(TreeModel model)
  {
    GtkWidget* _cretval;
    _cretval = gtk_icon_view_new_with_model(model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!IconView(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a `GdkPaintable` representation of the item at path.
   * This image is used for a drag icon.
   * Params:
   *   path = a `GtkTreePath` in icon_view
   * Returns: a newly-allocated `GdkPaintable` of the drag icon.

   * Deprecated: Use [Gtk.GridView] instead
   */
  Paintable createDragIcon(TreePath path)
  {
    GdkPaintable* _cretval;
    _cretval = gtk_icon_view_create_drag_icon(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Paintable(cast(GdkPaintable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Turns icon_view into a drop destination for automatic DND. Calling this
   * method sets `GtkIconView`:reorderable to %FALSE.
   * Params:
   *   formats = the formats that the drag will support
   *   actions = the bitmask of possible actions for a drag to this
   *     widget

   * Deprecated: Use [Gtk.GridView] instead
   */
  void enableModelDragDest(ContentFormats formats, DragAction actions)
  {
    gtk_icon_view_enable_model_drag_dest(cast(GtkIconView*)cPtr, formats ? cast(GdkContentFormats*)formats.cPtr(false) : null, actions);
  }

  /**
   * Turns icon_view into a drag source for automatic DND. Calling this
   * method sets `GtkIconView`:reorderable to %FALSE.
   * Params:
   *   startButtonMask = Mask of allowed buttons to start drag
   *   formats = the formats that the drag will support
   *   actions = the bitmask of possible actions for a drag from this
   *     widget

   * Deprecated: Use [Gtk.GridView] instead
   */
  void enableModelDragSource(ModifierType startButtonMask, ContentFormats formats, DragAction actions)
  {
    gtk_icon_view_enable_model_drag_source(cast(GtkIconView*)cPtr, startButtonMask, formats ? cast(GdkContentFormats*)formats.cPtr(false) : null, actions);
  }

  /**
   * Gets the setting set by [Gtk.IconView.setActivateOnSingleClick].
   * Returns: %TRUE if item-activated will be emitted on a single click

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getActivateOnSingleClick()
  {
    bool _retval;
    _retval = gtk_icon_view_get_activate_on_single_click(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Fills the bounding rectangle in widget coordinates for the cell specified by
   * path and cell. If cell is %NULL the main cell area is used.
   * This function is only valid if icon_view is realized.
   * Params:
   *   path = a `GtkTreePath`
   *   cell = a `GtkCellRenderer`
   *   rect = rectangle to fill with cell rect
   * Returns: %FALSE if there is no such item, %TRUE otherwise

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getCellRect(TreePath path, CellRenderer cell, out Rectangle rect)
  {
    bool _retval;
    GdkRectangle _rect;
    _retval = gtk_icon_view_get_cell_rect(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null, &_rect);
    rect = new Rectangle(cast(void*)&_rect, false);
    return _retval;
  }

  /**
   * Returns the value of the ::column-spacing property.
   * Returns: the space between columns

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getColumnSpacing()
  {
    int _retval;
    _retval = gtk_icon_view_get_column_spacing(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Returns the value of the ::columns property.
   * Returns: the number of columns, or -1

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getColumns()
  {
    int _retval;
    _retval = gtk_icon_view_get_columns(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Fills in path and cell with the current cursor path and cell.
   * If the cursor isn’t currently set, then *path will be %NULL.
   * If no cell currently has focus, then *cell will be %NULL.
   * The returned `GtkTreePath` must be freed with [Gtk.TreePath.free].
   * Params:
   *   path = Return location for the current
   *     cursor path
   *   cell = Return location the current
   *     focus cell
   * Returns: %TRUE if the cursor is set.

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getCursor(out TreePath path, out CellRenderer cell)
  {
    bool _retval;
    GtkTreePath* _path;
    GtkCellRenderer* _cell;
    _retval = gtk_icon_view_get_cursor(cast(GtkIconView*)cPtr, &_path, &_cell);
    path = new TreePath(cast(void*)_path, true);
    cell = new CellRenderer(cast(void*)_cell, false);
    return _retval;
  }

  /**
   * Determines the destination item for a given position.
   * Params:
   *   dragX = the position to determine the destination item for
   *   dragY = the position to determine the destination item for
   *   path = Return location for the path of the item
   *   pos = Return location for the drop position
   * Returns: whether there is an item at the given position.

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getDestItemAtPos(int dragX, int dragY, out TreePath path, out IconViewDropPosition pos)
  {
    bool _retval;
    GtkTreePath* _path;
    _retval = gtk_icon_view_get_dest_item_at_pos(cast(GtkIconView*)cPtr, dragX, dragY, &_path, &pos);
    path = new TreePath(cast(void*)_path, true);
    return _retval;
  }

  /**
   * Gets information about the item that is highlighted for feedback.
   * Params:
   *   path = Return location for the path of
   *     the highlighted item
   *   pos = Return location for the drop position

   * Deprecated: Use [Gtk.GridView] instead
   */
  void getDragDestItem(out TreePath path, out IconViewDropPosition pos)
  {
    GtkTreePath* _path;
    gtk_icon_view_get_drag_dest_item(cast(GtkIconView*)cPtr, &_path, &pos);
    path = new TreePath(cast(void*)_path, true);
  }

  /**
   * Gets the path and cell for the icon at the given position.
   * Params:
   *   x = The x position to be identified
   *   y = The y position to be identified
   *   path = Return location for the path
   *   cell = Return location for the renderer
   *     responsible for the cell at $(LPAREN)x, y$(RPAREN)
   * Returns: %TRUE if an item exists at the specified position

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getItemAtPos(int x, int y, out TreePath path, out CellRenderer cell)
  {
    bool _retval;
    GtkTreePath* _path;
    GtkCellRenderer* _cell;
    _retval = gtk_icon_view_get_item_at_pos(cast(GtkIconView*)cPtr, x, y, &_path, &_cell);
    path = new TreePath(cast(void*)_path, true);
    cell = new CellRenderer(cast(void*)_cell, false);
    return _retval;
  }

  /**
   * Gets the column in which the item path is currently
   * displayed. Column numbers start at 0.
   * Params:
   *   path = the `GtkTreePath` of the item
   * Returns: The column in which the item is displayed

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getItemColumn(TreePath path)
  {
    int _retval;
    _retval = gtk_icon_view_get_item_column(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the value of the ::item-orientation property which determines
   * whether the labels are drawn beside the icons instead of below.
   * Returns: the relative position of texts and icons

   * Deprecated: Use [Gtk.GridView] instead
   */
  Orientation getItemOrientation()
  {
    GtkOrientation _cretval;
    _cretval = gtk_icon_view_get_item_orientation(cast(GtkIconView*)cPtr);
    Orientation _retval = cast(Orientation)_cretval;
    return _retval;
  }

  /**
   * Returns the value of the ::item-padding property.
   * Returns: the padding around items

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getItemPadding()
  {
    int _retval;
    _retval = gtk_icon_view_get_item_padding(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Gets the row in which the item path is currently
   * displayed. Row numbers start at 0.
   * Params:
   *   path = the `GtkTreePath` of the item
   * Returns: The row in which the item is displayed

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getItemRow(TreePath path)
  {
    int _retval;
    _retval = gtk_icon_view_get_item_row(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the value of the ::item-width property.
   * Returns: the width of a single item, or -1

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getItemWidth()
  {
    int _retval;
    _retval = gtk_icon_view_get_item_width(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Returns the value of the ::margin property.
   * Returns: the space at the borders

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getMargin()
  {
    int _retval;
    _retval = gtk_icon_view_get_margin(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Returns the column with markup text for icon_view.
   * Returns: the markup column, or -1 if it’s unset.

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getMarkupColumn()
  {
    int _retval;
    _retval = gtk_icon_view_get_markup_column(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Returns the model the `GtkIconView` is based on.  Returns %NULL if the
   * model is unset.
   * Returns: The currently used `GtkTreeModel`

   * Deprecated: Use [Gtk.GridView] instead
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_icon_view_get_model(cast(GtkIconView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the path for the icon at the given position.
   * Params:
   *   x = The x position to be identified
   *   y = The y position to be identified
   * Returns: The `GtkTreePath` corresponding
   *   to the icon or %NULL if no icon exists at that position.

   * Deprecated: Use [Gtk.GridView] instead
   */
  TreePath getPathAtPos(int x, int y)
  {
    GtkTreePath* _cretval;
    _cretval = gtk_icon_view_get_path_at_pos(cast(GtkIconView*)cPtr, x, y);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the column with pixbufs for icon_view.
   * Returns: the pixbuf column, or -1 if it’s unset.

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getPixbufColumn()
  {
    int _retval;
    _retval = gtk_icon_view_get_pixbuf_column(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Retrieves whether the user can reorder the list via drag-and-drop.
   * See [Gtk.IconView.setReorderable].
   * Returns: %TRUE if the list can be reordered.

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getReorderable()
  {
    bool _retval;
    _retval = gtk_icon_view_get_reorderable(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Returns the value of the ::row-spacing property.
   * Returns: the space between rows

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getRowSpacing()
  {
    int _retval;
    _retval = gtk_icon_view_get_row_spacing(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Creates a list of paths of all selected items. Additionally, if you are
   * planning on modifying the model after calling this function, you may
   * want to convert the returned list into a list of `GtkTreeRowReferences`.
   * To do this, you can use [Gtk.TreeRowReference.new_].
   * To free the return value, use `g_list_free_full`:
   * |[<!-- language\="C" -->
   * GtkWidget *icon_view \= gtk_icon_view_new $(LPAREN)$(RPAREN);
   * // Use icon_view
   * GList *list \= gtk_icon_view_get_selected_items $(LPAREN)GTK_ICON_VIEW $(LPAREN)icon_view$(RPAREN)$(RPAREN);
   * // use list
   * g_list_free_full $(LPAREN)list, $(LPAREN)GDestroyNotify$(RPAREN) gtk_tree_path_free$(RPAREN);
   * ]|
   * Returns: A `GList` containing a `GtkTreePath` for each selected row.

   * Deprecated: Use [Gtk.GridView] instead
   */
  List!(TreePath) getSelectedItems()
  {
    GList* _cretval;
    _cretval = gtk_icon_view_get_selected_items(cast(GtkIconView*)cPtr);
    List!(TreePath) _retval = new List!(TreePath)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Gets the selection mode of the icon_view.
   * Returns: the current selection mode

   * Deprecated: Use [Gtk.GridView] instead
   */
  SelectionMode getSelectionMode()
  {
    GtkSelectionMode _cretval;
    _cretval = gtk_icon_view_get_selection_mode(cast(GtkIconView*)cPtr);
    SelectionMode _retval = cast(SelectionMode)_cretval;
    return _retval;
  }

  /**
   * Returns the value of the ::spacing property.
   * Returns: the space between cells

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getSpacing()
  {
    int _retval;
    _retval = gtk_icon_view_get_spacing(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Returns the column with text for icon_view.
   * Returns: the text column, or -1 if it’s unset.

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getTextColumn()
  {
    int _retval;
    _retval = gtk_icon_view_get_text_column(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * Returns the column of icon_view’s model which is being used for
   * displaying tooltips on icon_view’s rows.
   * Returns: the index of the tooltip column that is currently being
   *   used, or -1 if this is disabled.

   * Deprecated: Use [Gtk.GridView] instead
   */
  int getTooltipColumn()
  {
    int _retval;
    _retval = gtk_icon_view_get_tooltip_column(cast(GtkIconView*)cPtr);
    return _retval;
  }

  /**
   * This function is supposed to be used in a `GtkWidget::query-tooltip`
   * signal handler for `GtkIconView`. The x, y and keyboard_tip values
   * which are received in the signal handler, should be passed to this
   * function without modification.
   * The return value indicates whether there is an icon view item at the given
   * coordinates $(LPAREN)%TRUE$(RPAREN) or not $(LPAREN)%FALSE$(RPAREN) for mouse tooltips. For keyboard
   * tooltips the item returned will be the cursor item. When %TRUE, then any of
   * model, path and iter which have been provided will be set to point to
   * that row and the corresponding model.
   * Params:
   *   x = the x coordinate $(LPAREN)relative to widget coordinates$(RPAREN)
   *   y = the y coordinate $(LPAREN)relative to widget coordinates$(RPAREN)
   *   keyboardTip = whether this is a keyboard tooltip or not
   *   model = a pointer to receive a `GtkTreeModel`
   *   path = a pointer to receive a `GtkTreePath`
   *   iter = a pointer to receive a `GtkTreeIter`
   * Returns: whether or not the given tooltip context points to an item

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getTooltipContext(int x, int y, bool keyboardTip, out TreeModel model, out TreePath path, out TreeIter iter)
  {
    bool _retval;
    GtkTreeModel* _model;
    GtkTreePath* _path;
    GtkTreeIter _iter;
    _retval = gtk_icon_view_get_tooltip_context(cast(GtkIconView*)cPtr, x, y, keyboardTip, &_model, &_path, &_iter);
    model = _model ? ObjectG.getDObject!TreeModel(_model, false) : null;
    path = new TreePath(cast(void*)_path, true);
    iter = new TreeIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Sets start_path and end_path to be the first and last visible path.
   * Note that there may be invisible paths in between.
   * Both paths should be freed with [Gtk.TreePath.free] after use.
   * Params:
   *   startPath = Return location for start of region
   *   endPath = Return location for end of region
   * Returns: %TRUE, if valid paths were placed in start_path and end_path

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool getVisibleRange(out TreePath startPath, out TreePath endPath)
  {
    bool _retval;
    GtkTreePath* _startPath;
    GtkTreePath* _endPath;
    _retval = gtk_icon_view_get_visible_range(cast(GtkIconView*)cPtr, &_startPath, &_endPath);
    startPath = new TreePath(cast(void*)_startPath, true);
    endPath = new TreePath(cast(void*)_endPath, true);
    return _retval;
  }

  /**
   * Activates the item determined by path.
   * Params:
   *   path = The `GtkTreePath` to be activated

   * Deprecated: Use [Gtk.GridView] instead
   */
  void itemActivated(TreePath path)
  {
    gtk_icon_view_item_activated(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Returns %TRUE if the icon pointed to by path is currently
   * selected. If path does not point to a valid location, %FALSE is returned.
   * Params:
   *   path = A `GtkTreePath` to check selection on.
   * Returns: %TRUE if path is selected.

   * Deprecated: Use [Gtk.GridView] instead
   */
  bool pathIsSelected(TreePath path)
  {
    bool _retval;
    _retval = gtk_icon_view_path_is_selected(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves the alignments of icon_view to the position specified by path.
   * row_align determines where the row is placed, and col_align determines
   * where column is placed.  Both are expected to be between 0.0 and 1.0.
   * 0.0 means left/top alignment, 1.0 means right/bottom alignment, 0.5 means
   * center.
   * If use_align is %FALSE, then the alignment arguments are ignored, and the
   * tree does the minimum amount of work to scroll the item onto the screen.
   * This means that the item will be scrolled to the edge closest to its current
   * position.  If the item is currently visible on the screen, nothing is done.
   * This function only works if the model is set, and path is a valid row on
   * the model. If the model changes before the icon_view is realized, the
   * centered path will be modified to reflect this change.
   * Params:
   *   path = The path of the item to move to.
   *   useAlign = whether to use alignment arguments, or %FALSE.
   *   rowAlign = The vertical alignment of the item specified by path.
   *   colAlign = The horizontal alignment of the item specified by path.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void scrollToPath(TreePath path, bool useAlign, float rowAlign, float colAlign)
  {
    gtk_icon_view_scroll_to_path(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, useAlign, rowAlign, colAlign);
  }

  /**
   * Selects all the icons. icon_view must has its selection mode set
   * to %GTK_SELECTION_MULTIPLE.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void selectAll()
  {
    gtk_icon_view_select_all(cast(GtkIconView*)cPtr);
  }

  /**
   * Selects the row at path.
   * Params:
   *   path = The `GtkTreePath` to be selected.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void selectPath(TreePath path)
  {
    gtk_icon_view_select_path(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Calls a function for each selected icon. Note that the model or
   * selection cannot be modified from within this function.
   * Params:
   *   func = The function to call for each selected icon.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void selectedForeach(IconViewForeachFunc func)
  {
    static IconViewForeachFunc _static_func;

    extern(C) void _funcCallback(GtkIconView* iconView, GtkTreePath* path, void* data)
    {
      _static_func(iconView ? ObjectG.getDObject!IconView(cast(void*)iconView, false) : null, path ? new TreePath(cast(void*)path, false) : null);
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    gtk_icon_view_selected_foreach(cast(GtkIconView*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Causes the `GtkIconView`::item-activated signal to be emitted on
   * a single click instead of a double click.
   * Params:
   *   single = %TRUE to emit item-activated on a single click

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setActivateOnSingleClick(bool single)
  {
    gtk_icon_view_set_activate_on_single_click(cast(GtkIconView*)cPtr, single);
  }

  /**
   * Sets the ::column-spacing property which specifies the space
   * which is inserted between the columns of the icon view.
   * Params:
   *   columnSpacing = the column spacing

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setColumnSpacing(int columnSpacing)
  {
    gtk_icon_view_set_column_spacing(cast(GtkIconView*)cPtr, columnSpacing);
  }

  /**
   * Sets the ::columns property which determines in how
   * many columns the icons are arranged. If columns is
   * -1, the number of columns will be chosen automatically
   * to fill the available area.
   * Params:
   *   columns = the number of columns

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setColumns(int columns)
  {
    gtk_icon_view_set_columns(cast(GtkIconView*)cPtr, columns);
  }

  /**
   * Sets the current keyboard focus to be at path, and selects it.  This is
   * useful when you want to focus the user’s attention on a particular item.
   * If cell is not %NULL, then focus is given to the cell specified by
   * it. Additionally, if start_editing is %TRUE, then editing should be
   * started in the specified cell.
   * This function is often followed by `gtk_widget_grab_focus
   * $(LPAREN)icon_view$(RPAREN)` in order to give keyboard focus to the widget.
   * Please note that editing can only happen when the widget is realized.
   * Params:
   *   path = A `GtkTreePath`
   *   cell = One of the cell renderers of icon_view
   *   startEditing = %TRUE if the specified cell should start being edited.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setCursor(TreePath path, CellRenderer cell, bool startEditing)
  {
    gtk_icon_view_set_cursor(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null, startEditing);
  }

  /**
   * Sets the item that is highlighted for feedback.
   * Params:
   *   path = The path of the item to highlight
   *   pos = Specifies where to drop, relative to the item

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setDragDestItem(TreePath path, IconViewDropPosition pos)
  {
    gtk_icon_view_set_drag_dest_item(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null, pos);
  }

  /**
   * Sets the ::item-orientation property which determines whether the labels
   * are drawn beside the icons instead of below.
   * Params:
   *   orientation = the relative position of texts and icons

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setItemOrientation(Orientation orientation)
  {
    gtk_icon_view_set_item_orientation(cast(GtkIconView*)cPtr, orientation);
  }

  /**
   * Sets the `GtkIconView`:item-padding property which specifies the padding
   * around each of the icon view’s items.
   * Params:
   *   itemPadding = the item padding

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setItemPadding(int itemPadding)
  {
    gtk_icon_view_set_item_padding(cast(GtkIconView*)cPtr, itemPadding);
  }

  /**
   * Sets the ::item-width property which specifies the width
   * to use for each item. If it is set to -1, the icon view will
   * automatically determine a suitable item size.
   * Params:
   *   itemWidth = the width for each item

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setItemWidth(int itemWidth)
  {
    gtk_icon_view_set_item_width(cast(GtkIconView*)cPtr, itemWidth);
  }

  /**
   * Sets the ::margin property which specifies the space
   * which is inserted at the top, bottom, left and right
   * of the icon view.
   * Params:
   *   margin = the margin

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setMargin(int margin)
  {
    gtk_icon_view_set_margin(cast(GtkIconView*)cPtr, margin);
  }

  /**
   * Sets the column with markup information for icon_view to be
   * column. The markup column must be of type `G_TYPE_STRING`.
   * If the markup column is set to something, it overrides
   * the text column set by [Gtk.IconView.setTextColumn].
   * Params:
   *   column = A column in the currently used model, or -1 to display no text

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setMarkupColumn(int column)
  {
    gtk_icon_view_set_markup_column(cast(GtkIconView*)cPtr, column);
  }

  /**
   * Sets the model for a `GtkIconView`.
   * If the icon_view already has a model set, it will remove
   * it before setting the new model.  If model is %NULL, then
   * it will unset the old model.
   * Params:
   *   model = The model.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setModel(TreeModel model)
  {
    gtk_icon_view_set_model(cast(GtkIconView*)cPtr, model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Sets the column with pixbufs for icon_view to be column. The pixbuf
   * column must be of type `GDK_TYPE_PIXBUF`
   * Params:
   *   column = A column in the currently used model, or -1 to disable

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setPixbufColumn(int column)
  {
    gtk_icon_view_set_pixbuf_column(cast(GtkIconView*)cPtr, column);
  }

  /**
   * This function is a convenience function to allow you to reorder models that
   * support the `GtkTreeDragSourceIface` and the `GtkTreeDragDestIface`. Both
   * `GtkTreeStore` and `GtkListStore` support these. If reorderable is %TRUE, then
   * the user can reorder the model by dragging and dropping rows.  The
   * developer can listen to these changes by connecting to the model's
   * row_inserted and row_deleted signals. The reordering is implemented by setting up
   * the icon view as a drag source and destination. Therefore, drag and
   * drop can not be used in a reorderable view for any other purpose.
   * This function does not give you any degree of control over the order -- any
   * reordering is allowed.  If more control is needed, you should probably
   * handle drag and drop manually.
   * Params:
   *   reorderable = %TRUE, if the list of items can be reordered.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setReorderable(bool reorderable)
  {
    gtk_icon_view_set_reorderable(cast(GtkIconView*)cPtr, reorderable);
  }

  /**
   * Sets the ::row-spacing property which specifies the space
   * which is inserted between the rows of the icon view.
   * Params:
   *   rowSpacing = the row spacing

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setRowSpacing(int rowSpacing)
  {
    gtk_icon_view_set_row_spacing(cast(GtkIconView*)cPtr, rowSpacing);
  }

  /**
   * Sets the selection mode of the icon_view.
   * Params:
   *   mode = The selection mode

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setSelectionMode(SelectionMode mode)
  {
    gtk_icon_view_set_selection_mode(cast(GtkIconView*)cPtr, mode);
  }

  /**
   * Sets the ::spacing property which specifies the space
   * which is inserted between the cells $(LPAREN)i.e. the icon and
   * the text$(RPAREN) of an item.
   * Params:
   *   spacing = the spacing

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setSpacing(int spacing)
  {
    gtk_icon_view_set_spacing(cast(GtkIconView*)cPtr, spacing);
  }

  /**
   * Sets the column with text for icon_view to be column. The text
   * column must be of type `G_TYPE_STRING`.
   * Params:
   *   column = A column in the currently used model, or -1 to display no text

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setTextColumn(int column)
  {
    gtk_icon_view_set_text_column(cast(GtkIconView*)cPtr, column);
  }

  /**
   * Sets the tip area of tooltip to the area which cell occupies in
   * the item pointed to by path. See also [Gtk.Tooltip.setTipArea].
   * See also [Gtk.IconView.setTooltipColumn] for a simpler alternative.
   * Params:
   *   tooltip = a `GtkTooltip`
   *   path = a `GtkTreePath`
   *   cell = a `GtkCellRenderer`

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setTooltipCell(Tooltip tooltip, TreePath path, CellRenderer cell)
  {
    gtk_icon_view_set_tooltip_cell(cast(GtkIconView*)cPtr, tooltip ? cast(GtkTooltip*)tooltip.cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null);
  }

  /**
   * If you only plan to have simple $(LPAREN)text-only$(RPAREN) tooltips on full items, you
   * can use this function to have `GtkIconView` handle these automatically
   * for you. column should be set to the column in icon_view’s model
   * containing the tooltip texts, or -1 to disable this feature.
   * When enabled, `GtkWidget:has-tooltip` will be set to %TRUE and
   * icon_view will connect a `GtkWidget::query-tooltip` signal handler.
   * Note that the signal handler sets the text with [Gtk.Tooltip.setMarkup],
   * so &, <, etc have to be escaped in the text.
   * Params:
   *   column = an integer, which is a valid column number for icon_view’s model

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setTooltipColumn(int column)
  {
    gtk_icon_view_set_tooltip_column(cast(GtkIconView*)cPtr, column);
  }

  /**
   * Sets the tip area of tooltip to be the area covered by the item at path.
   * See also [Gtk.IconView.setTooltipColumn] for a simpler alternative.
   * See also [Gtk.Tooltip.setTipArea].
   * Params:
   *   tooltip = a `GtkTooltip`
   *   path = a `GtkTreePath`

   * Deprecated: Use [Gtk.GridView] instead
   */
  void setTooltipItem(Tooltip tooltip, TreePath path)
  {
    gtk_icon_view_set_tooltip_item(cast(GtkIconView*)cPtr, tooltip ? cast(GtkTooltip*)tooltip.cPtr(false) : null, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Unselects all the icons.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void unselectAll()
  {
    gtk_icon_view_unselect_all(cast(GtkIconView*)cPtr);
  }

  /**
   * Unselects the row at path.
   * Params:
   *   path = The `GtkTreePath` to be unselected.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void unselectPath(TreePath path)
  {
    gtk_icon_view_unselect_path(cast(GtkIconView*)cPtr, path ? cast(GtkTreePath*)path.cPtr(false) : null);
  }

  /**
   * Undoes the effect of [Gtk.IconView.enableModelDragDest]. Calling this
   * method sets `GtkIconView`:reorderable to %FALSE.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void unsetModelDragDest()
  {
    gtk_icon_view_unset_model_drag_dest(cast(GtkIconView*)cPtr);
  }

  /**
   * Undoes the effect of [Gtk.IconView.enableModelDragSource]. Calling this
   * method sets `GtkIconView`:reorderable to %FALSE.

   * Deprecated: Use [Gtk.GridView] instead
   */
  void unsetModelDragSource()
  {
    gtk_icon_view_unset_model_drag_source(cast(GtkIconView*)cPtr);
  }

  /**
   * A [keybinding signal][Gtk.SignalAction]
   * which gets emitted when the user activates the currently
   * focused item.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control activation
   * programmatically.
   * The default bindings for this signal are Space, Return and Enter.
   *   iconView = the instance the signal is connected to
   * Returns:
   */
  alias ActivateCursorItemCallback = bool delegate(IconView iconView);

  /**
   * Connect to ActivateCursorItem signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivateCursorItem(ActivateCursorItemCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto iconView = getVal!IconView(_paramVals);
      _retval = _dgClosure.dlg(iconView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-cursor-item", closure, after);
  }

  /**
   * The ::item-activated signal is emitted when the method
   * [Gtk.IconView.itemActivated] is called, when the user double
   * clicks an item with the "activate-on-single-click" property set
   * to %FALSE, or when the user single clicks an item when the
   * "activate-on-single-click" property set to %TRUE. It is also
   * emitted when a non-editable item is selected and one of the keys:
   * Space, Return or Enter is pressed.
   * Params
   *   path = the `GtkTreePath` for the activated item
   *   iconView = the instance the signal is connected to
   */
  alias ItemActivatedCallback = void delegate(TreePath path, IconView iconView);

  /**
   * Connect to ItemActivated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectItemActivated(ItemActivatedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iconView = getVal!IconView(_paramVals);
      auto path = getVal!TreePath(&_paramVals[1]);
      _dgClosure.dlg(path, iconView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("item-activated", closure, after);
  }

  /**
   * The ::move-cursor signal is a
   * [keybinding signal][Gtk.SignalAction]
   * which gets emitted when the user initiates a cursor movement.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control the cursor
   * programmatically.
   * The default bindings for this signal include
   * - Arrow keys which move by individual steps
   * - Home/End keys which move to the first/last item
   * - PageUp/PageDown which move by "pages"
   * All of these will extend the selection when combined with
   * the Shift modifier.
   * Params
   *   step = the granularity of the move, as a `GtkMovementStep`
   *   count = the number of step units to move
   *   extend = whether to extend the selection
   *   modify = whether to modify the selection
   *   iconView = the instance the signal is connected to
   * Returns:
   */
  alias MoveCursorCallback = bool delegate(MovementStep step, int count, bool extend, bool modify, IconView iconView);

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
      auto iconView = getVal!IconView(_paramVals);
      auto step = getVal!MovementStep(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      auto extend = getVal!bool(&_paramVals[3]);
      auto modify = getVal!bool(&_paramVals[4]);
      _retval = _dgClosure.dlg(step, count, extend, modify, iconView);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-cursor", closure, after);
  }

  /**
   * A [keybinding signal][Gtk.SignalAction]
   * which gets emitted when the user selects all items.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control selection
   * programmatically.
   * The default binding for this signal is Ctrl-a.
   *   iconView = the instance the signal is connected to
   */
  alias SelectAllCallback = void delegate(IconView iconView);

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
      auto iconView = getVal!IconView(_paramVals);
      _dgClosure.dlg(iconView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-all", closure, after);
  }

  /**
   * A [keybinding signal][Gtk.SignalAction]
   * which gets emitted when the user selects the item that is currently
   * focused.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control selection
   * programmatically.
   * There is no default binding for this signal.
   *   iconView = the instance the signal is connected to
   */
  alias SelectCursorItemCallback = void delegate(IconView iconView);

  /**
   * Connect to SelectCursorItem signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectCursorItem(SelectCursorItemCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iconView = getVal!IconView(_paramVals);
      _dgClosure.dlg(iconView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-cursor-item", closure, after);
  }

  /**
   * The ::selection-changed signal is emitted when the selection
   * $(LPAREN)i.e. the set of selected items$(RPAREN) changes.
   *   iconView = the instance the signal is connected to
   */
  alias SelectionChangedCallback = void delegate(IconView iconView);

  /**
   * Connect to SelectionChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectionChanged(SelectionChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iconView = getVal!IconView(_paramVals);
      _dgClosure.dlg(iconView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("selection-changed", closure, after);
  }

  /**
   * A [keybinding signal][Gtk.SignalAction]
   * which gets emitted when the user toggles whether the currently
   * focused item is selected or not. The exact effect of this
   * depend on the selection mode.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control selection
   * programmatically.
   * There is no default binding for this signal is Ctrl-Space.
   *   iconView = the instance the signal is connected to
   */
  alias ToggleCursorItemCallback = void delegate(IconView iconView);

  /**
   * Connect to ToggleCursorItem signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggleCursorItem(ToggleCursorItemCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iconView = getVal!IconView(_paramVals);
      _dgClosure.dlg(iconView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-cursor-item", closure, after);
  }

  /**
   * A [keybinding signal][Gtk.SignalAction]
   * which gets emitted when the user unselects all items.
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control selection
   * programmatically.
   * The default binding for this signal is Ctrl-Shift-a.
   *   iconView = the instance the signal is connected to
   */
  alias UnselectAllCallback = void delegate(IconView iconView);

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
      auto iconView = getVal!IconView(_paramVals);
      _dgClosure.dlg(iconView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unselect-all", closure, after);
  }
}

module Gtk.TreeViewColumn;

import GObject.DClosure;
import GObject.InitiallyUnowned;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellArea;
import Gtk.CellLayout;
import Gtk.CellLayoutT;
import Gtk.CellRenderer;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A visible column in a [Gtk.TreeView] widget
 * The `GtkTreeViewColumn` object represents a visible column in a `GtkTreeView` widget.
 * It allows to set properties of the column header, and functions as a holding pen
 * for the cell renderers which determine how the data in the column is displayed.
 * Please refer to the [tree widget conceptual overview](section-tree-widget.html)
 * for an overview of all the objects and data types related to the tree widget and
 * how they work together, and to the [Gtk.TreeView] documentation for specifics
 * about the CSS node structure for treeviews and their headers.

 * Deprecated: Use [Gtk.ColumnView] and [Gtk.ColumnViewColumn]
 *   instead of [Gtk.TreeView] to show a tabular list
 */
class TreeViewColumn : InitiallyUnowned, Buildable, CellLayout
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_tree_view_column_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin BuildableT!GtkTreeViewColumn;
  mixin CellLayoutT!GtkTreeViewColumn;

  /**
   * Creates a new `GtkTreeViewColumn`.
   * Returns: A newly created `GtkTreeViewColumn`.

   * Deprecated: Use GtkColumnView instead
   */
  this()
  {
    GtkTreeViewColumn* _cretval;
    _cretval = gtk_tree_view_column_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkTreeViewColumn` using area to render its cells.
   * Params:
   *   area = the `GtkCellArea` that the newly created column should use to layout cells.
   * Returns: A newly created `GtkTreeViewColumn`.

   * Deprecated: Use GtkColumnView instead
   */
  static TreeViewColumn newWithArea(CellArea area)
  {
    GtkTreeViewColumn* _cretval;
    _cretval = gtk_tree_view_column_new_with_area(area ? cast(GtkCellArea*)area.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!TreeViewColumn(cast(GtkTreeViewColumn*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds an attribute mapping to the list in tree_column.
   * The column is the
   * column of the model to get a value from, and the attribute is the
   * parameter on cell_renderer to be set from the value. So for example
   * if column 2 of the model contains strings, you could have the
   * “text” attribute of a `GtkCellRendererText` get its values from
   * column 2.
   * Params:
   *   cellRenderer = the `GtkCellRenderer` to set attributes on
   *   attribute = An attribute on the renderer
   *   column = The column position on the model to get the attribute from.

   * Deprecated: Use GtkColumnView instead
   */
  void addAttribute(CellRenderer cellRenderer, string attribute, int column)
  {
    const(char)* _attribute = attribute.toCString(false);
    gtk_tree_view_column_add_attribute(cast(GtkTreeViewColumn*)cPtr, cellRenderer ? cast(GtkCellRenderer*)cellRenderer.cPtr(false) : null, _attribute, column);
  }

  /**
   * Obtains the horizontal position and size of a cell in a column.
   * If the  cell is not found in the column, start_pos and width
   * are not changed and %FALSE is returned.
   * Params:
   *   cellRenderer = a `GtkCellRenderer`
   *   xOffset = return location for the horizontal
   *     position of cell within tree_column
   *   width = return location for the width of cell
   * Returns: %TRUE if cell belongs to tree_column

   * Deprecated: Use GtkColumnView instead
   */
  bool cellGetPosition(CellRenderer cellRenderer, out int xOffset, out int width)
  {
    bool _retval;
    _retval = gtk_tree_view_column_cell_get_position(cast(GtkTreeViewColumn*)cPtr, cellRenderer ? cast(GtkCellRenderer*)cellRenderer.cPtr(false) : null, cast(int*)&xOffset, cast(int*)&width);
    return _retval;
  }

  /**
   * Obtains the width and height needed to render the column.  This is used
   * primarily by the `GtkTreeView`.
   * Params:
   *   xOffset = location to return x offset of a cell relative to cell_area
   *   yOffset = location to return y offset of a cell relative to cell_area
   *   width = location to return width needed to render a cell
   *   height = location to return height needed to render a cell

   * Deprecated: Use GtkColumnView instead
   */
  void cellGetSize(out int xOffset, out int yOffset, out int width, out int height)
  {
    gtk_tree_view_column_cell_get_size(cast(GtkTreeViewColumn*)cPtr, cast(int*)&xOffset, cast(int*)&yOffset, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Returns %TRUE if any of the cells packed into the tree_column are visible.
   * For this to be meaningful, you must first initialize the cells with
   * [Gtk.TreeViewColumn.cellSetCellData]
   * Returns: %TRUE, if any of the cells packed into the tree_column are currently visible

   * Deprecated: Use GtkColumnView instead
   */
  bool cellIsVisible()
  {
    bool _retval;
    _retval = gtk_tree_view_column_cell_is_visible(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Sets the cell renderer based on the tree_model and iter.  That is, for
   * every attribute mapping in tree_column, it will get a value from the set
   * column on the iter, and use that value to set the attribute on the cell
   * renderer.  This is used primarily by the `GtkTreeView`.
   * Params:
   *   treeModel = The `GtkTreeModel` to get the cell renderers attributes from.
   *   iter = The `GtkTreeIter` to get the cell renderer’s attributes from.
   *   isExpander = %TRUE, if the row has children
   *   isExpanded = %TRUE, if the row has visible children

   * Deprecated: Use GtkColumnView instead
   */
  void cellSetCellData(TreeModel treeModel, TreeIter iter, bool isExpander, bool isExpanded)
  {
    gtk_tree_view_column_cell_set_cell_data(cast(GtkTreeViewColumn*)cPtr, treeModel ? cast(GtkTreeModel*)(cast(ObjectG)treeModel).cPtr(false) : null, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null, isExpander, isExpanded);
  }

  /**
   * Unsets all the mappings on all renderers on the tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  void clear()
  {
    gtk_tree_view_column_clear(cast(GtkTreeViewColumn*)cPtr);
  }

  /**
   * Clears all existing attributes previously set with
   * [Gtk.TreeViewColumn.setAttributes].
   * Params:
   *   cellRenderer = a `GtkCellRenderer` to clear the attribute mapping on.

   * Deprecated: Use GtkColumnView instead
   */
  void clearAttributes(CellRenderer cellRenderer)
  {
    gtk_tree_view_column_clear_attributes(cast(GtkTreeViewColumn*)cPtr, cellRenderer ? cast(GtkCellRenderer*)cellRenderer.cPtr(false) : null);
  }

  /**
   * Emits the “clicked” signal on the column.  This function will only work if
   * tree_column is clickable.

   * Deprecated: Use GtkColumnView instead
   */
  void clicked()
  {
    gtk_tree_view_column_clicked(cast(GtkTreeViewColumn*)cPtr);
  }

  /**
   * Sets the current keyboard focus to be at cell, if the column contains
   * 2 or more editable and activatable cells.
   * Params:
   *   cell = A `GtkCellRenderer`

   * Deprecated: Use GtkColumnView instead
   */
  void focusCell(CellRenderer cell)
  {
    gtk_tree_view_column_focus_cell(cast(GtkTreeViewColumn*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null);
  }

  /**
   * Returns the current x alignment of tree_column.  This value can range
   * between 0.0 and 1.0.
   * Returns: The current alignent of tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  float getAlignment()
  {
    float _retval;
    _retval = gtk_tree_view_column_get_alignment(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the button used in the treeview column header
   * Returns: The button for the column header.

   * Deprecated: Use GtkColumnView instead
   */
  Widget getButton()
  {
    GtkWidget* _cretval;
    _cretval = gtk_tree_view_column_get_button(cast(GtkTreeViewColumn*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if the user can click on the header for the column.
   * Returns: %TRUE if user can click the column header.

   * Deprecated: Use GtkColumnView instead
   */
  bool getClickable()
  {
    bool _retval;
    _retval = gtk_tree_view_column_get_clickable(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the column expands to fill available space.
   * Returns: %TRUE if the column expands to fill available space.

   * Deprecated: Use GtkColumnView instead
   */
  bool getExpand()
  {
    bool _retval;
    _retval = gtk_tree_view_column_get_expand(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Gets the fixed width of the column.  This may not be the actual displayed
   * width of the column; for that, use [Gtk.TreeViewColumn.getWidth].
   * Returns: The fixed width of the column.

   * Deprecated: Use GtkColumnView instead
   */
  int getFixedWidth()
  {
    int _retval;
    _retval = gtk_tree_view_column_get_fixed_width(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the maximum width in pixels of the tree_column, or -1 if no maximum
   * width is set.
   * Returns: The maximum width of the tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  int getMaxWidth()
  {
    int _retval;
    _retval = gtk_tree_view_column_get_max_width(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the minimum width in pixels of the tree_column, or -1 if no minimum
   * width is set.
   * Returns: The minimum width of the tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  int getMinWidth()
  {
    int _retval;
    _retval = gtk_tree_view_column_get_min_width(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the tree_column can be reordered by the user.
   * Returns: %TRUE if the tree_column can be reordered by the user.

   * Deprecated: Use GtkColumnView instead
   */
  bool getReorderable()
  {
    bool _retval;
    _retval = gtk_tree_view_column_get_reorderable(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the tree_column can be resized by the end user.
   * Returns: %TRUE, if the tree_column can be resized.

   * Deprecated: Use GtkColumnView instead
   */
  bool getResizable()
  {
    bool _retval;
    _retval = gtk_tree_view_column_get_resizable(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the current type of tree_column.
   * Returns: The type of tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  TreeViewColumnSizing getSizing()
  {
    GtkTreeViewColumnSizing _cretval;
    _cretval = gtk_tree_view_column_get_sizing(cast(GtkTreeViewColumn*)cPtr);
    TreeViewColumnSizing _retval = cast(TreeViewColumnSizing)_cretval;
    return _retval;
  }

  /**
   * Gets the logical sort_column_id that the model sorts on
   * when this column is selected for sorting.
   * See [Gtk.TreeViewColumn.setSortColumnId].
   * Returns: the current sort_column_id for this column, or -1 if
   *   this column can’t be used for sorting

   * Deprecated: Use GtkColumnView instead
   */
  int getSortColumnId()
  {
    int _retval;
    _retval = gtk_tree_view_column_get_sort_column_id(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Gets the value set by [Gtk.TreeViewColumn.setSortIndicator].
   * Returns: whether the sort indicator arrow is displayed

   * Deprecated: Use GtkColumnView instead
   */
  bool getSortIndicator()
  {
    bool _retval;
    _retval = gtk_tree_view_column_get_sort_indicator(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Gets the value set by [Gtk.TreeViewColumn.setSortOrder].
   * Returns: the sort order the sort indicator is indicating

   * Deprecated: Use GtkColumnView instead
   */
  SortType getSortOrder()
  {
    GtkSortType _cretval;
    _cretval = gtk_tree_view_column_get_sort_order(cast(GtkTreeViewColumn*)cPtr);
    SortType _retval = cast(SortType)_cretval;
    return _retval;
  }

  /**
   * Returns the spacing of tree_column.
   * Returns: the spacing of tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  int getSpacing()
  {
    int _retval;
    _retval = gtk_tree_view_column_get_spacing(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the title of the widget.
   * Returns: the title of the column. This string should not be
   *   modified or freed.

   * Deprecated: Use GtkColumnView instead
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_tree_view_column_get_title(cast(GtkTreeViewColumn*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the `GtkTreeView` wherein tree_column has been inserted.
   * If column is currently not inserted in any tree view, %NULL is
   * returned.
   * Returns: The tree view wherein column
   *   has been inserted

   * Deprecated: Use GtkColumnView instead
   */
  Widget getTreeView()
  {
    GtkWidget* _cretval;
    _cretval = gtk_tree_view_column_get_tree_view(cast(GtkTreeViewColumn*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if tree_column is visible.
   * Returns: whether the column is visible or not.  If it is visible, then
   *   the tree will show the column.

   * Deprecated: Use GtkColumnView instead
   */
  bool getVisible()
  {
    bool _retval;
    _retval = gtk_tree_view_column_get_visible(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the `GtkWidget` in the button on the column header.
   * If a custom widget has not been set then %NULL is returned.
   * Returns: The `GtkWidget` in the column header

   * Deprecated: Use GtkColumnView instead
   */
  Widget getWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_tree_view_column_get_widget(cast(GtkTreeViewColumn*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the current size of tree_column in pixels.
   * Returns: The current width of tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  int getWidth()
  {
    int _retval;
    _retval = gtk_tree_view_column_get_width(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Returns the current X offset of tree_column in pixels.
   * Returns: The current X offset of tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  int getXOffset()
  {
    int _retval;
    _retval = gtk_tree_view_column_get_x_offset(cast(GtkTreeViewColumn*)cPtr);
    return _retval;
  }

  /**
   * Adds the cell to end of the column. If expand is %FALSE, then the cell
   * is allocated no more space than it needs. Any unused space is divided
   * evenly between cells for which expand is %TRUE.
   * Params:
   *   cell = The `GtkCellRenderer`
   *   expand = %TRUE if cell is to be given extra space allocated to tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  void packEnd(CellRenderer cell, bool expand)
  {
    gtk_tree_view_column_pack_end(cast(GtkTreeViewColumn*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null, expand);
  }

  /**
   * Packs the cell into the beginning of the column. If expand is %FALSE, then
   * the cell is allocated no more space than it needs. Any unused space is divided
   * evenly between cells for which expand is %TRUE.
   * Params:
   *   cell = The `GtkCellRenderer`
   *   expand = %TRUE if cell is to be given extra space allocated to tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  void packStart(CellRenderer cell, bool expand)
  {
    gtk_tree_view_column_pack_start(cast(GtkTreeViewColumn*)cPtr, cell ? cast(GtkCellRenderer*)cell.cPtr(false) : null, expand);
  }

  /**
   * Flags the column, and the cell renderers added to this column, to have
   * their sizes renegotiated.

   * Deprecated: Use GtkColumnView instead
   */
  void queueResize()
  {
    gtk_tree_view_column_queue_resize(cast(GtkTreeViewColumn*)cPtr);
  }

  /**
   * Sets the alignment of the title or custom widget inside the column header.
   * The alignment determines its location inside the button -- 0.0 for left, 0.5
   * for center, 1.0 for right.
   * Params:
   *   xalign = The alignment, which is between [0.0 and 1.0] inclusive.

   * Deprecated: Use GtkColumnView instead
   */
  void setAlignment(float xalign)
  {
    gtk_tree_view_column_set_alignment(cast(GtkTreeViewColumn*)cPtr, xalign);
  }

  /**
   * Sets the `GtkTreeCellDataFunc` to use for the column.
   * This
   * function is used instead of the standard attributes mapping for
   * setting the column value, and should set the value of tree_column's
   * cell renderer as appropriate.  func may be %NULL to remove an
   * older one.
   * Params:
   *   cellRenderer = A `GtkCellRenderer`
   *   func = The `GtkTreeCellDataFunc` to use.

   * Deprecated: Use GtkColumnView instead
   */
  void setCellDataFunc(CellRenderer cellRenderer, TreeCellDataFunc func)
  {
    extern(C) void _funcCallback(GtkTreeViewColumn* treeColumn, GtkCellRenderer* cell, GtkTreeModel* treeModel, GtkTreeIter* iter, void* data)
    {
      auto _dlg = cast(TreeCellDataFunc*)data;

      (*_dlg)(treeColumn ? ObjectG.getDObject!TreeViewColumn(cast(void*)treeColumn, false) : null, cell ? ObjectG.getDObject!CellRenderer(cast(void*)cell, false) : null, treeModel ? ObjectG.getDObject!TreeModel(cast(void*)treeModel, false) : null, iter ? new TreeIter(cast(void*)iter, false) : null);
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_tree_view_column_set_cell_data_func(cast(GtkTreeViewColumn*)cPtr, cellRenderer ? cast(GtkCellRenderer*)cellRenderer.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Sets the header to be active if clickable is %TRUE.  When the header is
   * active, then it can take keyboard focus, and can be clicked.
   * Params:
   *   clickable = %TRUE if the header is active.

   * Deprecated: Use GtkColumnView instead
   */
  void setClickable(bool clickable)
  {
    gtk_tree_view_column_set_clickable(cast(GtkTreeViewColumn*)cPtr, clickable);
  }

  /**
   * Sets the column to take available extra space.  This space is shared equally
   * amongst all columns that have the expand set to %TRUE.  If no column has this
   * option set, then the last column gets all extra space.  By default, every
   * column is created with this %FALSE.
   * Along with “fixed-width”, the “expand” property changes when the column is
   * resized by the user.
   * Params:
   *   expand = %TRUE if the column should expand to fill available space.

   * Deprecated: Use GtkColumnView instead
   */
  void setExpand(bool expand)
  {
    gtk_tree_view_column_set_expand(cast(GtkTreeViewColumn*)cPtr, expand);
  }

  /**
   * If fixed_width is not -1, sets the fixed width of tree_column; otherwise
   * unsets it.  The effective value of fixed_width is clamped between the
   * minimum and maximum width of the column; however, the value stored in the
   * “fixed-width” property is not clamped.  If the column sizing is
   * %GTK_TREE_VIEW_COLUMN_GROW_ONLY or %GTK_TREE_VIEW_COLUMN_AUTOSIZE, setting
   * a fixed width overrides the automatically calculated width.  Note that
   * fixed_width is only a hint to GTK; the width actually allocated to the
   * column may be greater or less than requested.
   * Along with “expand”, the “fixed-width” property changes when the column is
   * resized by the user.
   * Params:
   *   fixedWidth = The new fixed width, in pixels, or -1.

   * Deprecated: Use GtkColumnView instead
   */
  void setFixedWidth(int fixedWidth)
  {
    gtk_tree_view_column_set_fixed_width(cast(GtkTreeViewColumn*)cPtr, fixedWidth);
  }

  /**
   * Sets the maximum width of the tree_column.  If max_width is -1, then the
   * maximum width is unset.  Note, the column can actually be wider than max
   * width if it’s the last column in a view.  In this case, the column expands to
   * fill any extra space.
   * Params:
   *   maxWidth = The maximum width of the column in pixels, or -1.

   * Deprecated: Use GtkColumnView instead
   */
  void setMaxWidth(int maxWidth)
  {
    gtk_tree_view_column_set_max_width(cast(GtkTreeViewColumn*)cPtr, maxWidth);
  }

  /**
   * Sets the minimum width of the tree_column.  If min_width is -1, then the
   * minimum width is unset.
   * Params:
   *   minWidth = The minimum width of the column in pixels, or -1.

   * Deprecated: Use GtkColumnView instead
   */
  void setMinWidth(int minWidth)
  {
    gtk_tree_view_column_set_min_width(cast(GtkTreeViewColumn*)cPtr, minWidth);
  }

  /**
   * If reorderable is %TRUE, then the column can be reordered by the end user
   * dragging the header.
   * Params:
   *   reorderable = %TRUE, if the column can be reordered.

   * Deprecated: Use GtkColumnView instead
   */
  void setReorderable(bool reorderable)
  {
    gtk_tree_view_column_set_reorderable(cast(GtkTreeViewColumn*)cPtr, reorderable);
  }

  /**
   * If resizable is %TRUE, then the user can explicitly resize the column by
   * grabbing the outer edge of the column button.
   * If resizable is %TRUE and
   * sizing mode of the column is %GTK_TREE_VIEW_COLUMN_AUTOSIZE, then the sizing
   * mode is changed to %GTK_TREE_VIEW_COLUMN_GROW_ONLY.
   * Params:
   *   resizable = %TRUE, if the column can be resized

   * Deprecated: Use GtkColumnView instead
   */
  void setResizable(bool resizable)
  {
    gtk_tree_view_column_set_resizable(cast(GtkTreeViewColumn*)cPtr, resizable);
  }

  /**
   * Sets the growth behavior of tree_column to type.
   * Params:
   *   type = The `GtkTreeViewColumn`Sizing.

   * Deprecated: Use GtkColumnView instead
   */
  void setSizing(TreeViewColumnSizing type)
  {
    gtk_tree_view_column_set_sizing(cast(GtkTreeViewColumn*)cPtr, type);
  }

  /**
   * Sets the logical sort_column_id that this column sorts on when this column
   * is selected for sorting.  Doing so makes the column header clickable.
   * Params:
   *   sortColumnId = The sort_column_id of the model to sort on.

   * Deprecated: Use GtkColumnView instead
   */
  void setSortColumnId(int sortColumnId)
  {
    gtk_tree_view_column_set_sort_column_id(cast(GtkTreeViewColumn*)cPtr, sortColumnId);
  }

  /**
   * Call this function with a setting of %TRUE to display an arrow in
   * the header button indicating the column is sorted. Call
   * [Gtk.TreeViewColumn.setSortOrder] to change the direction of
   * the arrow.
   * Params:
   *   setting = %TRUE to display an indicator that the column is sorted

   * Deprecated: Use GtkColumnView instead
   */
  void setSortIndicator(bool setting)
  {
    gtk_tree_view_column_set_sort_indicator(cast(GtkTreeViewColumn*)cPtr, setting);
  }

  /**
   * Changes the appearance of the sort indicator.
   * This does not actually sort the model.  Use
   * [Gtk.TreeViewColumn.setSortColumnId] if you want automatic sorting
   * support.  This function is primarily for custom sorting behavior, and should
   * be used in conjunction with [Gtk.TreeSortable.setSortColumnId] to do
   * that. For custom models, the mechanism will vary.
   * The sort indicator changes direction to indicate normal sort or reverse sort.
   * Note that you must have the sort indicator enabled to see anything when
   * calling this function; see [Gtk.TreeViewColumn.setSortIndicator].
   * Params:
   *   order = sort order that the sort indicator should indicate

   * Deprecated: Use GtkColumnView instead
   */
  void setSortOrder(SortType order)
  {
    gtk_tree_view_column_set_sort_order(cast(GtkTreeViewColumn*)cPtr, order);
  }

  /**
   * Sets the spacing field of tree_column, which is the number of pixels to
   * place between cell renderers packed into it.
   * Params:
   *   spacing = distance between cell renderers in pixels.

   * Deprecated: Use GtkColumnView instead
   */
  void setSpacing(int spacing)
  {
    gtk_tree_view_column_set_spacing(cast(GtkTreeViewColumn*)cPtr, spacing);
  }

  /**
   * Sets the title of the tree_column.  If a custom widget has been set, then
   * this value is ignored.
   * Params:
   *   title = The title of the tree_column.

   * Deprecated: Use GtkColumnView instead
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    gtk_tree_view_column_set_title(cast(GtkTreeViewColumn*)cPtr, _title);
  }

  /**
   * Sets the visibility of tree_column.
   * Params:
   *   visible = %TRUE if the tree_column is visible.

   * Deprecated: Use GtkColumnView instead
   */
  void setVisible(bool visible)
  {
    gtk_tree_view_column_set_visible(cast(GtkTreeViewColumn*)cPtr, visible);
  }

  /**
   * Sets the widget in the header to be widget.  If widget is %NULL, then the
   * header button is set with a `GtkLabel` set to the title of tree_column.
   * Params:
   *   widget = A child `GtkWidget`

   * Deprecated: Use GtkColumnView instead
   */
  void setWidget(Widget widget)
  {
    gtk_tree_view_column_set_widget(cast(GtkTreeViewColumn*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Emitted when the column's header has been clicked.
   *   treeViewColumn = the instance the signal is connected to
   */
  alias ClickedCallback = void delegate(TreeViewColumn treeViewColumn);

  /**
   * Connect to Clicked signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectClicked(ClickedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto treeViewColumn = getVal!TreeViewColumn(_paramVals);
      _dgClosure.dlg(treeViewColumn);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("clicked", closure, (flags & ConnectFlags.After) != 0);
  }
}

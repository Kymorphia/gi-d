module Gtk.ColumnView;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ColumnViewColumn;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.ListItemFactory;
import Gtk.ScrollInfo;
import Gtk.Scrollable;
import Gtk.ScrollableT;
import Gtk.SelectionModel;
import Gtk.SelectionModelT;
import Gtk.Sorter;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkColumnView` presents a large dynamic list of items using multiple columns
 * with headers.
 * `GtkColumnView` uses the factories of its columns to generate a cell widget for
 * each column, for each visible item and displays them together as the row for
 * this item.
 * The property@Gtk.ColumnView:show-row-separators and
 * property@Gtk.ColumnView:show-column-separators properties offer a simple way
 * to display separators between the rows or columns.
 * `GtkColumnView` allows the user to select items according to the selection
 * characteristics of the model. For models that allow multiple selected items,
 * it is possible to turn on *rubberband selection*, using
 * property@Gtk.ColumnView:enable-rubberband.
 * The column view supports sorting that can be customized by the user by
 * clicking on column headers. To set this up, the `GtkSorter` returned by
 * [Gtk.ColumnView.getSorter] must be attached to a sort model for the
 * data that the view is showing, and the columns must have sorters attached to
 * them by calling [Gtk.ColumnViewColumn.setSorter]. The initial sort
 * order can be set with [Gtk.ColumnView.sortByColumn].
 * The column view also supports interactive resizing and reordering of
 * columns, via Drag-and-Drop of the column headers. This can be enabled or
 * disabled with the [Gtk.ColumnView.reorderable] and
 * [Gtk.ColumnViewColumn.resizable] properties.
 * To learn more about the list widget framework, see the
 * [overview](section-list-widget.html).
 * # CSS nodes
 * ```
 * columnview[.column-separators][.rich-list][.navigation-sidebar][.data-table]
 * ├── header
 * │   ├── <column header>
 * ┊   ┊
 * │   ╰── <column header>
 * │
 * ├── listview
 * │
 * ┊
 * ╰── [rubberband]
 * ```
 * `GtkColumnView` uses a single CSS node named columnview. It may carry the
 * .column-separators style class, when property@Gtk.ColumnView:show-column-separators
 * property is set. Header widgets appear below a node with name header.
 * The rows are contained in a `GtkListView` widget, so there is a listview
 * node with the same structure as for a standalone `GtkListView` widget.
 * If property@Gtk.ColumnView:show-row-separators is set, it will be passed
 * on to the list view, causing its CSS node to carry the .separators style class.
 * For rubberband selection, a node with name rubberband is used.
 * The main columnview node may also carry style classes to select
 * the style of [list presentation](section-list-widget.html#list-styles):
 * .rich-list, .navigation-sidebar or .data-table.
 * # Accessibility
 * `GtkColumnView` uses the %GTK_ACCESSIBLE_ROLE_TREE_GRID role, header title
 * widgets are using the %GTK_ACCESSIBLE_ROLE_COLUMN_HEADER role. The row widgets
 * are using the %GTK_ACCESSIBLE_ROLE_ROW role, and individual cells are using
 * the %GTK_ACCESSIBLE_ROLE_GRID_CELL role
 */
class ColumnView : Widget, Scrollable
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
    return gtk_column_view_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ScrollableT!GtkColumnView;

  /**
   * Creates a new `GtkColumnView`.
   * You most likely want to call [Gtk.ColumnView.appendColumn]
   * to add columns next.
   * Params:
   *   model = the list model to use
   * Returns: a new `GtkColumnView`
   */
  this(SelectionModel model)
  {
    GtkWidget* _cretval;
    _cretval = gtk_column_view_new(model ? cast(GtkSelectionModel*)(cast(ObjectG)model).cPtr(true) : null);
    this(_cretval, false);
  }

  /**
   * Appends the column to the end of the columns in self.
   * Params:
   *   column = a `GtkColumnViewColumn` that hasn't been added to a
   *     `GtkColumnView` yet
   */
  void appendColumn(ColumnViewColumn column)
  {
    gtk_column_view_append_column(cast(GtkColumnView*)cPtr, column ? cast(GtkColumnViewColumn*)column.cPtr(false) : null);
  }

  /**
   * Gets the list of columns in this column view.
   * This list is constant over the lifetime of self and can be used to
   * monitor changes to the columns of self by connecting to the
   * ::items-changed signal.
   * Returns: The list managing the columns
   */
  ListModel getColumns()
  {
    GListModel* _cretval;
    _cretval = gtk_column_view_get_columns(cast(GtkColumnView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether rows can be selected by dragging with the mouse.
   * Returns: %TRUE if rubberband selection is enabled
   */
  bool getEnableRubberband()
  {
    bool _retval;
    _retval = gtk_column_view_get_enable_rubberband(cast(GtkColumnView*)cPtr);
    return _retval;
  }

  /**
   * Gets the factory that's currently used to populate section headers.
   * Returns: The factory in use
   */
  ListItemFactory getHeaderFactory()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_column_view_get_header_factory(cast(GtkColumnView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListItemFactory(cast(GtkListItemFactory*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the model that's currently used to read the items displayed.
   * Returns: The model in use
   */
  SelectionModel getModel()
  {
    GtkSelectionModel* _cretval;
    _cretval = gtk_column_view_get_model(cast(GtkColumnView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!SelectionModel(cast(GtkSelectionModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether columns are reorderable.
   * Returns: %TRUE if columns are reorderable
   */
  bool getReorderable()
  {
    bool _retval;
    _retval = gtk_column_view_get_reorderable(cast(GtkColumnView*)cPtr);
    return _retval;
  }

  /**
   * Gets the factory set via [Gtk.ColumnView.setRowFactory].
   * Returns: The factory
   */
  ListItemFactory getRowFactory()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_column_view_get_row_factory(cast(GtkColumnView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListItemFactory(cast(GtkListItemFactory*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the list should show separators
   * between columns.
   * Returns: %TRUE if the list shows column separators
   */
  bool getShowColumnSeparators()
  {
    bool _retval;
    _retval = gtk_column_view_get_show_column_separators(cast(GtkColumnView*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the list should show separators
   * between rows.
   * Returns: %TRUE if the list shows separators
   */
  bool getShowRowSeparators()
  {
    bool _retval;
    _retval = gtk_column_view_get_show_row_separators(cast(GtkColumnView*)cPtr);
    return _retval;
  }

  /**
   * Returns whether rows will be activated on single click and
   * selected on hover.
   * Returns: %TRUE if rows are activated on single click
   */
  bool getSingleClickActivate()
  {
    bool _retval;
    _retval = gtk_column_view_get_single_click_activate(cast(GtkColumnView*)cPtr);
    return _retval;
  }

  /**
   * Returns a special sorter that reflects the users sorting
   * choices in the column view.
   * To allow users to customizable sorting by clicking on column
   * headers, this sorter needs to be set on the sort model underneath
   * the model that is displayed by the view.
   * See [Gtk.ColumnViewColumn.setSorter] for setting up
   * per-column sorting.
   * Here is an example:
   * ```c
   * gtk_column_view_column_set_sorter $(LPAREN)column, sorter$(RPAREN);
   * gtk_column_view_append_column $(LPAREN)view, column$(RPAREN);
   * sorter \= g_object_ref $(LPAREN)gtk_column_view_get_sorter $(LPAREN)view$(RPAREN)$(RPAREN)$(RPAREN);
   * model \= gtk_sort_list_model_new $(LPAREN)store, sorter$(RPAREN);
   * selection \= gtk_no_selection_new $(LPAREN)model$(RPAREN);
   * gtk_column_view_set_model $(LPAREN)view, selection$(RPAREN);
   * ```
   * Returns: the `GtkSorter` of self
   */
  Sorter getSorter()
  {
    GtkSorter* _cretval;
    _cretval = gtk_column_view_get_sorter(cast(GtkColumnView*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Sorter(cast(GtkSorter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the behavior set for the <kbd>Tab</kbd> key.
   * Returns: The behavior of the <kbd>Tab</kbd> key
   */
  ListTabBehavior getTabBehavior()
  {
    GtkListTabBehavior _cretval;
    _cretval = gtk_column_view_get_tab_behavior(cast(GtkColumnView*)cPtr);
    ListTabBehavior _retval = cast(ListTabBehavior)_cretval;
    return _retval;
  }

  /**
   * Inserts a column at the given position in the columns of self.
   * If column is already a column of self, it will be repositioned.
   * Params:
   *   position = the position to insert column at
   *   column = the `GtkColumnViewColumn` to insert
   */
  void insertColumn(uint position, ColumnViewColumn column)
  {
    gtk_column_view_insert_column(cast(GtkColumnView*)cPtr, position, column ? cast(GtkColumnViewColumn*)column.cPtr(false) : null);
  }

  /**
   * Removes the column from the list of columns of self.
   * Params:
   *   column = a `GtkColumnViewColumn` that's part of self
   */
  void removeColumn(ColumnViewColumn column)
  {
    gtk_column_view_remove_column(cast(GtkColumnView*)cPtr, column ? cast(GtkColumnViewColumn*)column.cPtr(false) : null);
  }

  /**
   * Scroll to the row at the given position - or cell if a column is
   * given - and performs the actions specified in flags.
   * This function works no matter if the listview is shown or focused.
   * If it isn't, then the changes will take effect once that happens.
   * Params:
   *   pos = position of the item
   *   column = The column to scroll to
   *     or %NULL to not scroll columns.
   *   flags = actions to perform
   *   scroll = details of how to perform
   *     the scroll operation or %NULL to scroll into view
   */
  void scrollTo(uint pos, ColumnViewColumn column, ListScrollFlags flags, ScrollInfo scroll)
  {
    gtk_column_view_scroll_to(cast(GtkColumnView*)cPtr, pos, column ? cast(GtkColumnViewColumn*)column.cPtr(false) : null, flags, scroll ? cast(GtkScrollInfo*)scroll.cPtr(true) : null);
  }

  /**
   * Sets whether selections can be changed by dragging with the mouse.
   * Params:
   *   enableRubberband = %TRUE to enable rubberband selection
   */
  void setEnableRubberband(bool enableRubberband)
  {
    gtk_column_view_set_enable_rubberband(cast(GtkColumnView*)cPtr, enableRubberband);
  }

  /**
   * Sets the `GtkListItemFactory` to use for populating the
   * [Gtk.ListHeader] objects used in section headers.
   * If this factory is set to %NULL, the list will not show
   * section headers.
   * Params:
   *   factory = the factory to use
   */
  void setHeaderFactory(ListItemFactory factory)
  {
    gtk_column_view_set_header_factory(cast(GtkColumnView*)cPtr, factory ? cast(GtkListItemFactory*)factory.cPtr(false) : null);
  }

  /**
   * Sets the model to use.
   * This must be a [Gtk.SelectionModel].
   * Params:
   *   model = the model to use
   */
  void setModel(SelectionModel model)
  {
    gtk_column_view_set_model(cast(GtkColumnView*)cPtr, model ? cast(GtkSelectionModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Sets whether columns should be reorderable by dragging.
   * Params:
   *   reorderable = whether columns should be reorderable
   */
  void setReorderable(bool reorderable)
  {
    gtk_column_view_set_reorderable(cast(GtkColumnView*)cPtr, reorderable);
  }

  /**
   * Sets the factory used for configuring rows. The factory must be for configuring
   * [Gtk.ColumnViewRow] objects.
   * If this factory is not set - which is the default - then the defaults will be used.
   * This factory is not used to set the widgets displayed in the individual cells. For
   * that see methodGtkColumnViewColumn.set_factory and classGtkColumnViewCell.
   * Params:
   *   factory = The row factory
   */
  void setRowFactory(ListItemFactory factory)
  {
    gtk_column_view_set_row_factory(cast(GtkColumnView*)cPtr, factory ? cast(GtkListItemFactory*)factory.cPtr(false) : null);
  }

  /**
   * Sets whether the list should show separators
   * between columns.
   * Params:
   *   showColumnSeparators = %TRUE to show column separators
   */
  void setShowColumnSeparators(bool showColumnSeparators)
  {
    gtk_column_view_set_show_column_separators(cast(GtkColumnView*)cPtr, showColumnSeparators);
  }

  /**
   * Sets whether the list should show separators
   * between rows.
   * Params:
   *   showRowSeparators = %TRUE to show row separators
   */
  void setShowRowSeparators(bool showRowSeparators)
  {
    gtk_column_view_set_show_row_separators(cast(GtkColumnView*)cPtr, showRowSeparators);
  }

  /**
   * Sets whether rows should be activated on single click and
   * selected on hover.
   * Params:
   *   singleClickActivate = %TRUE to activate items on single click
   */
  void setSingleClickActivate(bool singleClickActivate)
  {
    gtk_column_view_set_single_click_activate(cast(GtkColumnView*)cPtr, singleClickActivate);
  }

  /**
   * Sets the behavior of the <kbd>Tab</kbd> and <kbd>Shift</kbd>+<kbd>Tab</kbd> keys.
   * Params:
   *   tabBehavior = The desired tab behavior
   */
  void setTabBehavior(ListTabBehavior tabBehavior)
  {
    gtk_column_view_set_tab_behavior(cast(GtkColumnView*)cPtr, tabBehavior);
  }

  /**
   * Sets the sorting of the view.
   * This function should be used to set up the initial sorting.
   * At runtime, users can change the sorting of a column view
   * by clicking on the list headers.
   * This call only has an effect if the sorter returned by
   * [Gtk.ColumnView.getSorter] is set on a sort model,
   * and [Gtk.ColumnViewColumn.setSorter] has been called
   * on column to associate a sorter with the column.
   * If column is %NULL, the view will be unsorted.
   * Params:
   *   column = the `GtkColumnViewColumn` to sort by
   *   direction = the direction to sort in
   */
  void sortByColumn(ColumnViewColumn column, SortType direction)
  {
    gtk_column_view_sort_by_column(cast(GtkColumnView*)cPtr, column ? cast(GtkColumnViewColumn*)column.cPtr(false) : null, direction);
  }

  /**
   * Emitted when a row has been activated by the user, usually via activating
   * the GtkListBase|list.activate-item action.
   * This allows for a convenient way to handle activation in a columnview.
   * See [Gtk.ListItem.setActivatable] for details on how to use this
   * signal.
   * Params
   *   position = position of item to activate
   *   columnView = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(uint position, ColumnView columnView);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto columnView = getVal!ColumnView(_paramVals);
      auto position = getVal!uint(&_paramVals[1]);
      _dgClosure.dlg(position, columnView);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }
}

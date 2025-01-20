module Gtk.ListBox;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Adjustment;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.ListBoxRow;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkListBox` is a vertical list.
 * A `GtkListBox` only contains `GtkListBoxRow` children. These rows can
 * by dynamically sorted and filtered, and headers can be added dynamically
 * depending on the row content. It also allows keyboard and mouse navigation
 * and selection like a typical list.
 * Using `GtkListBox` is often an alternative to `GtkTreeView`, especially
 * when the list contents has a more complicated layout than what is allowed
 * by a `GtkCellRenderer`, or when the contents is interactive $(LPAREN)i.e. has a
 * button in it$(RPAREN).
 * Although a `GtkListBox` must have only `GtkListBoxRow` children, you can
 * add any kind of widget to it via [Gtk.ListBox.prepend],
 * [Gtk.ListBox.append] and [Gtk.ListBox.insert] and a
 * `GtkListBoxRow` widget will automatically be inserted between the list
 * and the widget.
 * `GtkListBoxRows` can be marked as activatable or selectable. If a row is
 * activatable, signal@Gtk.ListBox::row-activated will be emitted for it when
 * the user tries to activate it. If it is selectable, the row will be marked
 * as selected when the user tries to select it.
 * # GtkListBox as GtkBuildable
 * The `GtkListBox` implementation of the `GtkBuildable` interface supports
 * setting a child as the placeholder by specifying “placeholder” as the “type”
 * attribute of a `<child>` element. See [Gtk.ListBox.setPlaceholder]
 * for info.
 * # CSS nodes
 * |[<!-- language\="plain" -->
 * list[.separators][.rich-list][.navigation-sidebar][.boxed-list]
 * ╰── row[.activatable]
 * ]|
 * `GtkListBox` uses a single CSS node named list. It may carry the .separators
 * style class, when the property@Gtk.ListBox:show-separators property is set.
 * Each `GtkListBoxRow` uses a single CSS node named row. The row nodes get the
 * .activatable style class added when appropriate.
 * It may also carry the .boxed-list style class. In this case, the list will be
 * automatically surrounded by a frame and have separators.
 * The main list node may also carry style classes to select
 * the style of [list presentation](section-list-widget.html#list-styles):
 * .rich-list, .navigation-sidebar or .data-table.
 * # Accessibility
 * `GtkListBox` uses the %GTK_ACCESSIBLE_ROLE_LIST role and `GtkListBoxRow` uses
 * the %GTK_ACCESSIBLE_ROLE_LIST_ITEM role.
 */
class ListBox : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_list_box_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkListBox` container.
   * Returns: a new `GtkListBox`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_list_box_new();
    this(_cretval, false);
  }

  /**
   * Append a widget to the list.
   * If a sort function is set, the widget will
   * actually be inserted at the calculated position.
   * Params:
   *   child = the `GtkWidget` to add
   */
  void append(Widget child)
  {
    gtk_list_box_append(cast(GtkListBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Binds model to box.
   * If box was already bound to a model, that previous binding is
   * destroyed.
   * The contents of box are cleared and then filled with widgets that
   * represent items from model. box is updated whenever model changes.
   * If model is %NULL, box is left empty.
   * It is undefined to add or remove widgets directly $(LPAREN)for example, with
   * [Gtk.ListBox.insert]$(RPAREN) while box is bound to a model.
   * Note that using a model is incompatible with the filtering and sorting
   * functionality in `GtkListBox`. When using a model, filtering and sorting
   * should be implemented by the model.
   * Params:
   *   model = the `GListModel` to be bound to box
   *   createWidgetFunc = a function that creates widgets for items
   *     or %NULL in case you also passed %NULL as model
   */
  void bindModel(ListModel model, ListBoxCreateWidgetFunc createWidgetFunc)
  {
    extern(C) GtkWidget* _createWidgetFuncCallback(ObjectC* item, void* userData)
    {
      Widget _dretval;
      auto _dlg = cast(ListBoxCreateWidgetFunc*)userData;

      _dretval = (*_dlg)(item ? ObjectG.getDObject!ObjectG(cast(void*)item, false) : null);
      GtkWidget* _retval = cast(GtkWidget*)_dretval.cPtr(true);

      return _retval;
    }

    auto _createWidgetFunc = freezeDelegate(cast(void*)&createWidgetFunc);
    gtk_list_box_bind_model(cast(GtkListBox*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null, &_createWidgetFuncCallback, _createWidgetFunc, &thawDelegate);
  }

  /**
   * Add a drag highlight to a row.
   * This is a helper function for implementing DnD onto a `GtkListBox`.
   * The passed in row will be highlighted by setting the
   * %GTK_STATE_FLAG_DROP_ACTIVE state and any previously highlighted
   * row will be unhighlighted.
   * The row will also be unhighlighted when the widget gets
   * a drag leave event.
   * Params:
   *   row = a `GtkListBoxRow`
   */
  void dragHighlightRow(ListBoxRow row)
  {
    gtk_list_box_drag_highlight_row(cast(GtkListBox*)cPtr, row ? cast(GtkListBoxRow*)row.cPtr(false) : null);
  }

  /**
   * If a row has previously been highlighted via [Gtk.ListBox.dragHighlightRow],
   * it will have the highlight removed.
   */
  void dragUnhighlightRow()
  {
    gtk_list_box_drag_unhighlight_row(cast(GtkListBox*)cPtr);
  }

  /**
   * Returns whether rows activate on single clicks.
   * Returns: %TRUE if rows are activated on single click, %FALSE otherwise
   */
  bool getActivateOnSingleClick()
  {
    bool _retval;
    _retval = gtk_list_box_get_activate_on_single_click(cast(GtkListBox*)cPtr);
    return _retval;
  }

  /**
   * Gets the adjustment $(LPAREN)if any$(RPAREN) that the widget uses to
   * for vertical scrolling.
   * Returns: the adjustment
   */
  Adjustment getAdjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_list_box_get_adjustment(cast(GtkListBox*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the n-th child in the list $(LPAREN)not counting headers$(RPAREN).
   * If index_ is negative or larger than the number of items in the
   * list, %NULL is returned.
   * Params:
   *   index = the index of the row
   * Returns: the child `GtkWidget`
   */
  ListBoxRow getRowAtIndex(int index)
  {
    GtkListBoxRow* _cretval;
    _cretval = gtk_list_box_get_row_at_index(cast(GtkListBox*)cPtr, index);
    auto _retval = _cretval ? ObjectG.getDObject!ListBoxRow(cast(GtkListBoxRow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the row at the y position.
   * Params:
   *   y = position
   * Returns: the row
   */
  ListBoxRow getRowAtY(int y)
  {
    GtkListBoxRow* _cretval;
    _cretval = gtk_list_box_get_row_at_y(cast(GtkListBox*)cPtr, y);
    auto _retval = _cretval ? ObjectG.getDObject!ListBoxRow(cast(GtkListBoxRow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the selected row, or %NULL if no rows are selected.
   * Note that the box may allow multiple selection, in which
   * case you should use [Gtk.ListBox.selectedForeach] to
   * find all selected rows.
   * Returns: the selected row
   */
  ListBoxRow getSelectedRow()
  {
    GtkListBoxRow* _cretval;
    _cretval = gtk_list_box_get_selected_row(cast(GtkListBox*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListBoxRow(cast(GtkListBoxRow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a list of all selected children.
   * Returns: A `GList` containing the `GtkWidget` for each selected child.
   *   Free with [GLib.List.free] when done.
   */
  List!(ListBoxRow, GtkListBoxRow) getSelectedRows()
  {
    GList* _cretval;
    _cretval = gtk_list_box_get_selected_rows(cast(GtkListBox*)cPtr);
    List!(ListBoxRow, GtkListBoxRow) _retval = new List!(ListBoxRow, GtkListBoxRow)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Gets the selection mode of the listbox.
   * Returns: a `GtkSelectionMode`
   */
  SelectionMode getSelectionMode()
  {
    GtkSelectionMode _cretval;
    _cretval = gtk_list_box_get_selection_mode(cast(GtkListBox*)cPtr);
    SelectionMode _retval = cast(SelectionMode)_cretval;
    return _retval;
  }

  /**
   * Returns whether the list box should show separators
   * between rows.
   * Returns: %TRUE if the list box shows separators
   */
  bool getShowSeparators()
  {
    bool _retval;
    _retval = gtk_list_box_get_show_separators(cast(GtkListBox*)cPtr);
    return _retval;
  }

  /**
   * Insert the child into the box at position.
   * If a sort function is
   * set, the widget will actually be inserted at the calculated position.
   * If position is -1, or larger than the total number of items in the
   * box, then the child will be appended to the end.
   * Params:
   *   child = the `GtkWidget` to add
   *   position = the position to insert child in
   */
  void insert(Widget child, int position)
  {
    gtk_list_box_insert(cast(GtkListBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, position);
  }

  /**
   * Update the filtering for all rows.
   * Call this when result
   * of the filter function on the box is changed due
   * to an external factor. For instance, this would be used
   * if the filter function just looked for a specific search
   * string and the entry with the search string has changed.
   */
  void invalidateFilter()
  {
    gtk_list_box_invalidate_filter(cast(GtkListBox*)cPtr);
  }

  /**
   * Update the separators for all rows.
   * Call this when result
   * of the header function on the box is changed due
   * to an external factor.
   */
  void invalidateHeaders()
  {
    gtk_list_box_invalidate_headers(cast(GtkListBox*)cPtr);
  }

  /**
   * Update the sorting for all rows.
   * Call this when result
   * of the sort function on the box is changed due
   * to an external factor.
   */
  void invalidateSort()
  {
    gtk_list_box_invalidate_sort(cast(GtkListBox*)cPtr);
  }

  /**
   * Prepend a widget to the list.
   * If a sort function is set, the widget will
   * actually be inserted at the calculated position.
   * Params:
   *   child = the `GtkWidget` to add
   */
  void prepend(Widget child)
  {
    gtk_list_box_prepend(cast(GtkListBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Removes a child from box.
   * Params:
   *   child = the child to remove
   */
  void remove(Widget child)
  {
    gtk_list_box_remove(cast(GtkListBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Removes all rows from box.
   * This function does nothing if box is backed by a model.
   */
  void removeAll()
  {
    gtk_list_box_remove_all(cast(GtkListBox*)cPtr);
  }

  /**
   * Select all children of box, if the selection mode allows it.
   */
  void selectAll()
  {
    gtk_list_box_select_all(cast(GtkListBox*)cPtr);
  }

  /**
   * Make row the currently selected row.
   * Params:
   *   row = The row to select
   */
  void selectRow(ListBoxRow row)
  {
    gtk_list_box_select_row(cast(GtkListBox*)cPtr, row ? cast(GtkListBoxRow*)row.cPtr(false) : null);
  }

  /**
   * Calls a function for each selected child.
   * Note that the selection cannot be modified from within this function.
   * Params:
   *   func = the function to call for each selected child
   */
  void selectedForeach(ListBoxForeachFunc func)
  {
    static ListBoxForeachFunc _static_func;

    extern(C) void _funcCallback(GtkListBox* box, GtkListBoxRow* row, void* userData)
    {
      _static_func(box ? ObjectG.getDObject!ListBox(cast(void*)box, false) : null, row ? ObjectG.getDObject!ListBoxRow(cast(void*)row, false) : null);
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    gtk_list_box_selected_foreach(cast(GtkListBox*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * If single is %TRUE, rows will be activated when you click on them,
   * otherwise you need to double-click.
   * Params:
   *   single = a boolean
   */
  void setActivateOnSingleClick(bool single)
  {
    gtk_list_box_set_activate_on_single_click(cast(GtkListBox*)cPtr, single);
  }

  /**
   * Sets the adjustment $(LPAREN)if any$(RPAREN) that the widget uses to
   * for vertical scrolling.
   * For instance, this is used to get the page size for
   * PageUp/Down key handling.
   * In the normal case when the box is packed inside
   * a `GtkScrolledWindow` the adjustment from that will
   * be picked up automatically, so there is no need
   * to manually do that.
   * Params:
   *   adjustment = the adjustment
   */
  void setAdjustment(Adjustment adjustment)
  {
    gtk_list_box_set_adjustment(cast(GtkListBox*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
  }

  /**
   * By setting a filter function on the box one can decide dynamically which
   * of the rows to show.
   * For instance, to implement a search function on a list that
   * filters the original list to only show the matching rows.
   * The filter_func will be called for each row after the call, and
   * it will continue to be called each time a row changes $(LPAREN)via
   * [Gtk.ListBoxRow.changed]$(RPAREN) or when [Gtk.ListBox.invalidateFilter]
   * is called.
   * Note that using a filter function is incompatible with using a model
   * $(LPAREN)see [Gtk.ListBox.bindModel]$(RPAREN).
   * Params:
   *   filterFunc = callback that lets you filter which rows to show
   */
  void setFilterFunc(ListBoxFilterFunc filterFunc)
  {
    extern(C) bool _filterFuncCallback(GtkListBoxRow* row, void* userData)
    {
      auto _dlg = cast(ListBoxFilterFunc*)userData;

      bool _retval = (*_dlg)(row ? ObjectG.getDObject!ListBoxRow(cast(void*)row, false) : null);
      return _retval;
    }

    auto _filterFunc = freezeDelegate(cast(void*)&filterFunc);
    gtk_list_box_set_filter_func(cast(GtkListBox*)cPtr, &_filterFuncCallback, _filterFunc, &thawDelegate);
  }

  /**
   * Sets a header function.
   * By setting a header function on the box one can dynamically add headers
   * in front of rows, depending on the contents of the row and its position
   * in the list.
   * For instance, one could use it to add headers in front of the first item
   * of a new kind, in a list sorted by the kind.
   * The update_header can look at the current header widget using
   * [Gtk.ListBoxRow.getHeader] and either update the state of the widget
   * as needed, or set a new one using [Gtk.ListBoxRow.setHeader]. If no
   * header is needed, set the header to %NULL.
   * Note that you may get many calls update_header to this for a particular
   * row when e.g. changing things that don’t affect the header. In this case
   * it is important for performance to not blindly replace an existing header
   * with an identical one.
   * The update_header function will be called for each row after the call,
   * and it will continue to be called each time a row changes $(LPAREN)via
   * [Gtk.ListBoxRow.changed]$(RPAREN) and when the row before changes $(LPAREN)either
   * by [Gtk.ListBoxRow.changed] on the previous row, or when the previous
   * row becomes a different row$(RPAREN). It is also called for all rows when
   * [Gtk.ListBox.invalidateHeaders] is called.
   * Params:
   *   updateHeader = callback that lets you add row headers
   */
  void setHeaderFunc(ListBoxUpdateHeaderFunc updateHeader)
  {
    extern(C) void _updateHeaderCallback(GtkListBoxRow* row, GtkListBoxRow* before, void* userData)
    {
      auto _dlg = cast(ListBoxUpdateHeaderFunc*)userData;

      (*_dlg)(row ? ObjectG.getDObject!ListBoxRow(cast(void*)row, false) : null, before ? ObjectG.getDObject!ListBoxRow(cast(void*)before, false) : null);
    }

    auto _updateHeader = freezeDelegate(cast(void*)&updateHeader);
    gtk_list_box_set_header_func(cast(GtkListBox*)cPtr, &_updateHeaderCallback, _updateHeader, &thawDelegate);
  }

  /**
   * Sets the placeholder widget that is shown in the list when
   * it doesn't display any visible children.
   * Params:
   *   placeholder = a `GtkWidget`
   */
  void setPlaceholder(Widget placeholder)
  {
    gtk_list_box_set_placeholder(cast(GtkListBox*)cPtr, placeholder ? cast(GtkWidget*)placeholder.cPtr(false) : null);
  }

  /**
   * Sets how selection works in the listbox.
   * Params:
   *   mode = The `GtkSelectionMode`
   */
  void setSelectionMode(SelectionMode mode)
  {
    gtk_list_box_set_selection_mode(cast(GtkListBox*)cPtr, mode);
  }

  /**
   * Sets whether the list box should show separators
   * between rows.
   * Params:
   *   showSeparators = %TRUE to show separators
   */
  void setShowSeparators(bool showSeparators)
  {
    gtk_list_box_set_show_separators(cast(GtkListBox*)cPtr, showSeparators);
  }

  /**
   * Sets a sort function.
   * By setting a sort function on the box one can dynamically reorder
   * the rows of the list, based on the contents of the rows.
   * The sort_func will be called for each row after the call, and will
   * continue to be called each time a row changes $(LPAREN)via
   * [Gtk.ListBoxRow.changed]$(RPAREN) and when [Gtk.ListBox.invalidateSort]
   * is called.
   * Note that using a sort function is incompatible with using a model
   * $(LPAREN)see [Gtk.ListBox.bindModel]$(RPAREN).
   * Params:
   *   sortFunc = the sort function
   */
  void setSortFunc(ListBoxSortFunc sortFunc)
  {
    extern(C) int _sortFuncCallback(GtkListBoxRow* row1, GtkListBoxRow* row2, void* userData)
    {
      auto _dlg = cast(ListBoxSortFunc*)userData;

      int _retval = (*_dlg)(row1 ? ObjectG.getDObject!ListBoxRow(cast(void*)row1, false) : null, row2 ? ObjectG.getDObject!ListBoxRow(cast(void*)row2, false) : null);
      return _retval;
    }

    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    gtk_list_box_set_sort_func(cast(GtkListBox*)cPtr, &_sortFuncCallback, _sortFunc, &thawDelegate);
  }

  /**
   * Unselect all children of box, if the selection mode allows it.
   */
  void unselectAll()
  {
    gtk_list_box_unselect_all(cast(GtkListBox*)cPtr);
  }

  /**
   * Unselects a single row of box, if the selection mode allows it.
   * Params:
   *   row = the row to unselect
   */
  void unselectRow(ListBoxRow row)
  {
    gtk_list_box_unselect_row(cast(GtkListBox*)cPtr, row ? cast(GtkListBoxRow*)row.cPtr(false) : null);
  }

  alias ActivateCursorRowCallback = void delegate(ListBox listBox);

  /**
   * Connect to ActivateCursorRow signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivateCursorRow(ActivateCursorRowCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto listBox = getVal!ListBox(_paramVals);
      _dgClosure.dlg(listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-cursor-row", closure, after);
  }

  alias MoveCursorCallback = void delegate(MovementStep object, int p0, bool p1, bool p2, ListBox listBox);

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
      auto listBox = getVal!ListBox(_paramVals);
      auto object = getVal!MovementStep(&_paramVals[1]);
      auto p0 = getVal!int(&_paramVals[2]);
      auto p1 = getVal!bool(&_paramVals[3]);
      auto p2 = getVal!bool(&_paramVals[4]);
      _dgClosure.dlg(object, p0, p1, p2, listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-cursor", closure, after);
  }

  /**
   * Emitted when a row has been activated by the user.
   * Params
   *   row = the activated row
   *   listBox = the instance the signal is connected to
   */
  alias RowActivatedCallback = void delegate(ListBoxRow row, ListBox listBox);

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
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto listBox = getVal!ListBox(_paramVals);
      auto row = getVal!ListBoxRow(&_paramVals[1]);
      _dgClosure.dlg(row, listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("row-activated", closure, after);
  }

  /**
   * Emitted when a new row is selected, or $(LPAREN)with a %NULL row$(RPAREN)
   * when the selection is cleared.
   * When the box is using %GTK_SELECTION_MULTIPLE, this signal will not
   * give you the full picture of selection changes, and you should use
   * the signalGtk.ListBox::selected-rows-changed signal instead.
   * Params
   *   row = the selected row
   *   listBox = the instance the signal is connected to
   */
  alias RowSelectedCallback = void delegate(ListBoxRow row, ListBox listBox);

  /**
   * Connect to RowSelected signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRowSelected(RowSelectedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto listBox = getVal!ListBox(_paramVals);
      auto row = getVal!ListBoxRow(&_paramVals[1]);
      _dgClosure.dlg(row, listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("row-selected", closure, after);
  }

  /**
   * Emitted to select all children of the box, if the selection
   * mode permits it.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.
   *   listBox = the instance the signal is connected to
   */
  alias SelectAllCallback = void delegate(ListBox listBox);

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
      auto listBox = getVal!ListBox(_paramVals);
      _dgClosure.dlg(listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-all", closure, after);
  }

  /**
   * Emitted when the set of selected rows changes.
   *   listBox = the instance the signal is connected to
   */
  alias SelectedRowsChangedCallback = void delegate(ListBox listBox);

  /**
   * Connect to SelectedRowsChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectedRowsChanged(SelectedRowsChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto listBox = getVal!ListBox(_paramVals);
      _dgClosure.dlg(listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("selected-rows-changed", closure, after);
  }

  alias ToggleCursorRowCallback = void delegate(ListBox listBox);

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
      auto listBox = getVal!ListBox(_paramVals);
      _dgClosure.dlg(listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-cursor-row", closure, after);
  }

  /**
   * Emitted to unselect all children of the box, if the selection
   * mode permits it.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is
   * <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
   *   listBox = the instance the signal is connected to
   */
  alias UnselectAllCallback = void delegate(ListBox listBox);

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
      auto listBox = getVal!ListBox(_paramVals);
      _dgClosure.dlg(listBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unselect-all", closure, after);
  }
}

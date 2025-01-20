module Gtk.FlowBox;

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
import Gtk.FlowBoxChild;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkFlowBox` puts child widgets in reflowing grid.
 * For instance, with the horizontal orientation, the widgets will be
 * arranged from left to right, starting a new row under the previous
 * row when necessary. Reducing the width in this case will require more
 * rows, so a larger height will be requested.
 * Likewise, with the vertical orientation, the widgets will be arranged
 * from top to bottom, starting a new column to the right when necessary.
 * Reducing the height will require more columns, so a larger width will
 * be requested.
 * The size request of a `GtkFlowBox` alone may not be what you expect;
 * if you need to be able to shrink it along both axes and dynamically
 * reflow its children, you may have to wrap it in a `GtkScrolledWindow`
 * to enable that.
 * The children of a `GtkFlowBox` can be dynamically sorted and filtered.
 * Although a `GtkFlowBox` must have only `GtkFlowBoxChild` children, you
 * can add any kind of widget to it via [Gtk.FlowBox.insert], and a
 * `GtkFlowBoxChild` widget will automatically be inserted between the box
 * and the widget.
 * Also see [Gtk.ListBox].
 * # CSS nodes
 * ```
 * flowbox
 * ├── flowboxchild
 * │   ╰── <child>
 * ├── flowboxchild
 * │   ╰── <child>
 * ┊
 * ╰── [rubberband]
 * ```
 * `GtkFlowBox` uses a single CSS node with name flowbox. `GtkFlowBoxChild`
 * uses a single CSS node with name flowboxchild. For rubberband selection,
 * a subnode with name rubberband is used.
 * # Accessibility
 * `GtkFlowBox` uses the %GTK_ACCESSIBLE_ROLE_GRID role, and `GtkFlowBoxChild`
 * uses the %GTK_ACCESSIBLE_ROLE_GRID_CELL role.
 */
class FlowBox : Widget, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_flow_box_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!();

  /**
   * Creates a `GtkFlowBox`.
   * Returns: a new `GtkFlowBox`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_flow_box_new();
    this(_cretval, false);
  }

  /**
   * Adds child to the end of self.
   * If a sort function is set, the widget will
   * actually be inserted at the calculated position.
   * See also: [Gtk.FlowBox.insert].
   * Params:
   *   child = the `GtkWidget` to add
   */
  void append(Widget child)
  {
    gtk_flow_box_append(cast(GtkFlowBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Binds model to box.
   * If box was already bound to a model, that previous binding is
   * destroyed.
   * The contents of box are cleared and then filled with widgets that
   * represent items from model. box is updated whenever model changes.
   * If model is %NULL, box is left empty.
   * It is undefined to add or remove widgets directly $(LPAREN)for example, with
   * [Gtk.FlowBox.insert]$(RPAREN) while box is bound to a model.
   * Note that using a model is incompatible with the filtering and sorting
   * functionality in `GtkFlowBox`. When using a model, filtering and sorting
   * should be implemented by the model.
   * Params:
   *   model = the `GListModel` to be bound to box
   *   createWidgetFunc = a function that creates widgets for items
   */
  void bindModel(ListModel model, FlowBoxCreateWidgetFunc createWidgetFunc)
  {
    extern(C) GtkWidget* _createWidgetFuncCallback(ObjectC* item, void* userData)
    {
      Widget _dretval;
      auto _dlg = cast(FlowBoxCreateWidgetFunc*)userData;

      _dretval = (*_dlg)(item ? ObjectG.getDObject!ObjectG(cast(void*)item, false) : null);
      GtkWidget* _retval = cast(GtkWidget*)_dretval.cPtr(true);

      return _retval;
    }

    auto _createWidgetFunc = freezeDelegate(cast(void*)&createWidgetFunc);
    gtk_flow_box_bind_model(cast(GtkFlowBox*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null, &_createWidgetFuncCallback, _createWidgetFunc, &thawDelegate);
  }

  /**
   * Returns whether children activate on single clicks.
   * Returns: %TRUE if children are activated on single click,
   *   %FALSE otherwise
   */
  bool getActivateOnSingleClick()
  {
    bool _retval;
    _retval = gtk_flow_box_get_activate_on_single_click(cast(GtkFlowBox*)cPtr);
    return _retval;
  }

  /**
   * Gets the nth child in the box.
   * Params:
   *   idx = the position of the child
   * Returns: the child widget, which will
   *   always be a `GtkFlowBoxChild` or %NULL in case no child widget
   *   with the given index exists.
   */
  FlowBoxChild getChildAtIndex(int idx)
  {
    GtkFlowBoxChild* _cretval;
    _cretval = gtk_flow_box_get_child_at_index(cast(GtkFlowBox*)cPtr, idx);
    auto _retval = _cretval ? ObjectG.getDObject!FlowBoxChild(cast(GtkFlowBoxChild*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the child in the $(LPAREN)x, y$(RPAREN) position.
   * Both x and y are assumed to be relative to the origin of box.
   * Params:
   *   x = the x coordinate of the child
   *   y = the y coordinate of the child
   * Returns: the child widget, which will
   *   always be a `GtkFlowBoxChild` or %NULL in case no child widget
   *   exists for the given x and y coordinates.
   */
  FlowBoxChild getChildAtPos(int x, int y)
  {
    GtkFlowBoxChild* _cretval;
    _cretval = gtk_flow_box_get_child_at_pos(cast(GtkFlowBox*)cPtr, x, y);
    auto _retval = _cretval ? ObjectG.getDObject!FlowBoxChild(cast(GtkFlowBoxChild*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the horizontal spacing.
   * Returns: the horizontal spacing
   */
  uint getColumnSpacing()
  {
    uint _retval;
    _retval = gtk_flow_box_get_column_spacing(cast(GtkFlowBox*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the box is homogeneous.
   * Returns: %TRUE if the box is homogeneous.
   */
  bool getHomogeneous()
  {
    bool _retval;
    _retval = gtk_flow_box_get_homogeneous(cast(GtkFlowBox*)cPtr);
    return _retval;
  }

  /**
   * Gets the maximum number of children per line.
   * Returns: the maximum number of children per line
   */
  uint getMaxChildrenPerLine()
  {
    uint _retval;
    _retval = gtk_flow_box_get_max_children_per_line(cast(GtkFlowBox*)cPtr);
    return _retval;
  }

  /**
   * Gets the minimum number of children per line.
   * Returns: the minimum number of children per line
   */
  uint getMinChildrenPerLine()
  {
    uint _retval;
    _retval = gtk_flow_box_get_min_children_per_line(cast(GtkFlowBox*)cPtr);
    return _retval;
  }

  /**
   * Gets the vertical spacing.
   * Returns: the vertical spacing
   */
  uint getRowSpacing()
  {
    uint _retval;
    _retval = gtk_flow_box_get_row_spacing(cast(GtkFlowBox*)cPtr);
    return _retval;
  }

  /**
   * Creates a list of all selected children.
   * Returns: A `GList` containing the `GtkWidget` for each selected child.
   *   Free with [GLib.List.free] when done.
   */
  List!(FlowBoxChild, GtkFlowBoxChild) getSelectedChildren()
  {
    GList* _cretval;
    _cretval = gtk_flow_box_get_selected_children(cast(GtkFlowBox*)cPtr);
    List!(FlowBoxChild, GtkFlowBoxChild) _retval = new List!(FlowBoxChild, GtkFlowBoxChild)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Gets the selection mode of box.
   * Returns: the `GtkSelectionMode`
   */
  SelectionMode getSelectionMode()
  {
    GtkSelectionMode _cretval;
    _cretval = gtk_flow_box_get_selection_mode(cast(GtkFlowBox*)cPtr);
    SelectionMode _retval = cast(SelectionMode)_cretval;
    return _retval;
  }

  /**
   * Inserts the widget into box at position.
   * If a sort function is set, the widget will actually be inserted
   * at the calculated position.
   * If position is -1, or larger than the total number of children
   * in the box, then the widget will be appended to the end.
   * Params:
   *   widget = the `GtkWidget` to add
   *   position = the position to insert child in
   */
  void insert(Widget widget, int position)
  {
    gtk_flow_box_insert(cast(GtkFlowBox*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, position);
  }

  /**
   * Updates the filtering for all children.
   * Call this function when the result of the filter
   * function on the box is changed due to an external
   * factor. For instance, this would be used if the
   * filter function just looked for a specific search
   * term, and the entry with the string has changed.
   */
  void invalidateFilter()
  {
    gtk_flow_box_invalidate_filter(cast(GtkFlowBox*)cPtr);
  }

  /**
   * Updates the sorting for all children.
   * Call this when the result of the sort function on
   * box is changed due to an external factor.
   */
  void invalidateSort()
  {
    gtk_flow_box_invalidate_sort(cast(GtkFlowBox*)cPtr);
  }

  /**
   * Adds child to the start of self.
   * If a sort function is set, the widget will
   * actually be inserted at the calculated position.
   * See also: [Gtk.FlowBox.insert].
   * Params:
   *   child = the `GtkWidget` to add
   */
  void prepend(Widget child)
  {
    gtk_flow_box_prepend(cast(GtkFlowBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Removes a child from box.
   * Params:
   *   widget = the child widget to remove
   */
  void remove(Widget widget)
  {
    gtk_flow_box_remove(cast(GtkFlowBox*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Removes all children from box.
   * This function does nothing if box is backed by a model.
   */
  void removeAll()
  {
    gtk_flow_box_remove_all(cast(GtkFlowBox*)cPtr);
  }

  /**
   * Select all children of box, if the selection
   * mode allows it.
   */
  void selectAll()
  {
    gtk_flow_box_select_all(cast(GtkFlowBox*)cPtr);
  }

  /**
   * Selects a single child of box, if the selection
   * mode allows it.
   * Params:
   *   child = a child of box
   */
  void selectChild(FlowBoxChild child)
  {
    gtk_flow_box_select_child(cast(GtkFlowBox*)cPtr, child ? cast(GtkFlowBoxChild*)child.cPtr(false) : null);
  }

  /**
   * Calls a function for each selected child.
   * Note that the selection cannot be modified from within
   * this function.
   * Params:
   *   func = the function to call for each selected child
   */
  void selectedForeach(FlowBoxForeachFunc func)
  {
    static FlowBoxForeachFunc _static_func;

    extern(C) void _funcCallback(GtkFlowBox* box, GtkFlowBoxChild* child, void* userData)
    {
      _static_func(box ? ObjectG.getDObject!FlowBox(cast(void*)box, false) : null, child ? ObjectG.getDObject!FlowBoxChild(cast(void*)child, false) : null);
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    gtk_flow_box_selected_foreach(cast(GtkFlowBox*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * If single is %TRUE, children will be activated when you click
   * on them, otherwise you need to double-click.
   * Params:
   *   single = %TRUE to emit child-activated on a single click
   */
  void setActivateOnSingleClick(bool single)
  {
    gtk_flow_box_set_activate_on_single_click(cast(GtkFlowBox*)cPtr, single);
  }

  /**
   * Sets the horizontal space to add between children.
   * Params:
   *   spacing = the spacing to use
   */
  void setColumnSpacing(uint spacing)
  {
    gtk_flow_box_set_column_spacing(cast(GtkFlowBox*)cPtr, spacing);
  }

  /**
   * By setting a filter function on the box one can decide dynamically
   * which of the children to show.
   * For instance, to implement a search function that only shows the
   * children matching the search terms.
   * The filter_func will be called for each child after the call, and
   * it will continue to be called each time a child changes $(LPAREN)via
   * [Gtk.FlowBoxChild.changed]$(RPAREN) or when
   * [Gtk.FlowBox.invalidateFilter] is called.
   * Note that using a filter function is incompatible with using a model
   * $(LPAREN)see [Gtk.FlowBox.bindModel]$(RPAREN).
   * Params:
   *   filterFunc = callback that
   *     lets you filter which children to show
   */
  void setFilterFunc(FlowBoxFilterFunc filterFunc)
  {
    extern(C) bool _filterFuncCallback(GtkFlowBoxChild* child, void* userData)
    {
      auto _dlg = cast(FlowBoxFilterFunc*)userData;

      bool _retval = (*_dlg)(child ? ObjectG.getDObject!FlowBoxChild(cast(void*)child, false) : null);
      return _retval;
    }

    auto _filterFunc = freezeDelegate(cast(void*)&filterFunc);
    gtk_flow_box_set_filter_func(cast(GtkFlowBox*)cPtr, &_filterFuncCallback, _filterFunc, &thawDelegate);
  }

  /**
   * Hooks up an adjustment to focus handling in box.
   * The adjustment is also used for autoscrolling during
   * rubberband selection. See [Gtk.ScrolledWindow.getHadjustment]
   * for a typical way of obtaining the adjustment, and
   * [Gtk.FlowBox.setVadjustment] for setting the vertical
   * adjustment.
   * The adjustments have to be in pixel units and in the same
   * coordinate system as the allocation for immediate children
   * of the box.
   * Params:
   *   adjustment = an adjustment which should be adjusted
   *     when the focus is moved among the descendents of container
   */
  void setHadjustment(Adjustment adjustment)
  {
    gtk_flow_box_set_hadjustment(cast(GtkFlowBox*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
  }

  /**
   * Sets whether or not all children of box are given
   * equal space in the box.
   * Params:
   *   homogeneous = %TRUE to create equal allotments,
   *     %FALSE for variable allotments
   */
  void setHomogeneous(bool homogeneous)
  {
    gtk_flow_box_set_homogeneous(cast(GtkFlowBox*)cPtr, homogeneous);
  }

  /**
   * Sets the maximum number of children to request and
   * allocate space for in box’s orientation.
   * Setting the maximum number of children per line
   * limits the overall natural size request to be no more
   * than n_children children long in the given orientation.
   * Params:
   *   nChildren = the maximum number of children per line
   */
  void setMaxChildrenPerLine(uint nChildren)
  {
    gtk_flow_box_set_max_children_per_line(cast(GtkFlowBox*)cPtr, nChildren);
  }

  /**
   * Sets the minimum number of children to line up
   * in box’s orientation before flowing.
   * Params:
   *   nChildren = the minimum number of children per line
   */
  void setMinChildrenPerLine(uint nChildren)
  {
    gtk_flow_box_set_min_children_per_line(cast(GtkFlowBox*)cPtr, nChildren);
  }

  /**
   * Sets the vertical space to add between children.
   * Params:
   *   spacing = the spacing to use
   */
  void setRowSpacing(uint spacing)
  {
    gtk_flow_box_set_row_spacing(cast(GtkFlowBox*)cPtr, spacing);
  }

  /**
   * Sets how selection works in box.
   * Params:
   *   mode = the new selection mode
   */
  void setSelectionMode(SelectionMode mode)
  {
    gtk_flow_box_set_selection_mode(cast(GtkFlowBox*)cPtr, mode);
  }

  /**
   * By setting a sort function on the box, one can dynamically
   * reorder the children of the box, based on the contents of
   * the children.
   * The sort_func will be called for each child after the call,
   * and will continue to be called each time a child changes $(LPAREN)via
   * [Gtk.FlowBoxChild.changed]$(RPAREN) and when
   * [Gtk.FlowBox.invalidateSort] is called.
   * Note that using a sort function is incompatible with using a model
   * $(LPAREN)see [Gtk.FlowBox.bindModel]$(RPAREN).
   * Params:
   *   sortFunc = the sort function
   */
  void setSortFunc(FlowBoxSortFunc sortFunc)
  {
    extern(C) int _sortFuncCallback(GtkFlowBoxChild* child1, GtkFlowBoxChild* child2, void* userData)
    {
      auto _dlg = cast(FlowBoxSortFunc*)userData;

      int _retval = (*_dlg)(child1 ? ObjectG.getDObject!FlowBoxChild(cast(void*)child1, false) : null, child2 ? ObjectG.getDObject!FlowBoxChild(cast(void*)child2, false) : null);
      return _retval;
    }

    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    gtk_flow_box_set_sort_func(cast(GtkFlowBox*)cPtr, &_sortFuncCallback, _sortFunc, &thawDelegate);
  }

  /**
   * Hooks up an adjustment to focus handling in box.
   * The adjustment is also used for autoscrolling during
   * rubberband selection. See [Gtk.ScrolledWindow.getVadjustment]
   * for a typical way of obtaining the adjustment, and
   * [Gtk.FlowBox.setHadjustment] for setting the horizontal
   * adjustment.
   * The adjustments have to be in pixel units and in the same
   * coordinate system as the allocation for immediate children
   * of the box.
   * Params:
   *   adjustment = an adjustment which should be adjusted
   *     when the focus is moved among the descendents of container
   */
  void setVadjustment(Adjustment adjustment)
  {
    gtk_flow_box_set_vadjustment(cast(GtkFlowBox*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
  }

  /**
   * Unselect all children of box, if the selection
   * mode allows it.
   */
  void unselectAll()
  {
    gtk_flow_box_unselect_all(cast(GtkFlowBox*)cPtr);
  }

  /**
   * Unselects a single child of box, if the selection
   * mode allows it.
   * Params:
   *   child = a child of box
   */
  void unselectChild(FlowBoxChild child)
  {
    gtk_flow_box_unselect_child(cast(GtkFlowBox*)cPtr, child ? cast(GtkFlowBoxChild*)child.cPtr(false) : null);
  }

  /**
   * Emitted when the user activates the box.
   * This is a [keybinding signal](class.SignalAction.html).
   *   flowBox = the instance the signal is connected to
   */
  alias ActivateCursorChildCallback = void delegate(FlowBox flowBox);

  /**
   * Connect to ActivateCursorChild signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivateCursorChild(ActivateCursorChildCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto flowBox = getVal!FlowBox(_paramVals);
      _dgClosure.dlg(flowBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-cursor-child", closure, after);
  }

  /**
   * Emitted when a child has been activated by the user.
   * Params
   *   child = the child that is activated
   *   flowBox = the instance the signal is connected to
   */
  alias ChildActivatedCallback = void delegate(FlowBoxChild child, FlowBox flowBox);

  /**
   * Connect to ChildActivated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChildActivated(ChildActivatedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto flowBox = getVal!FlowBox(_paramVals);
      auto child = getVal!FlowBoxChild(&_paramVals[1]);
      _dgClosure.dlg(child, flowBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("child-activated", closure, after);
  }

  /**
   * Emitted when the user initiates a cursor movement.
   * This is a [keybinding signal](class.SignalAction.html).
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control the cursor
   * programmatically.
   * The default bindings for this signal come in two variants,
   * the variant with the Shift modifier extends the selection,
   * the variant without the Shift modifier does not.
   * There are too many key combinations to list them all here.
   * - <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
   * move by individual children
   * - <kbd>Home</kbd>, <kbd>End</kbd> move to the ends of the box
   * - <kbd>PgUp</kbd>, <kbd>PgDn</kbd> move vertically by pages
   * Params
   *   step = the granularity of the move, as a `GtkMovementStep`
   *   count = the number of step units to move
   *   extend = whether to extend the selection
   *   modify = whether to modify the selection
   *   flowBox = the instance the signal is connected to
   * Returns: %TRUE to stop other handlers from being invoked for the event.
   *   %FALSE to propagate the event further.
   */
  alias MoveCursorCallback = bool delegate(MovementStep step, int count, bool extend, bool modify, FlowBox flowBox);

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
      auto flowBox = getVal!FlowBox(_paramVals);
      auto step = getVal!MovementStep(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      auto extend = getVal!bool(&_paramVals[3]);
      auto modify = getVal!bool(&_paramVals[4]);
      _retval = _dgClosure.dlg(step, count, extend, modify, flowBox);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-cursor", closure, after);
  }

  /**
   * Emitted to select all children of the box,
   * if the selection mode permits it.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>a</kbd>.
   *   flowBox = the instance the signal is connected to
   */
  alias SelectAllCallback = void delegate(FlowBox flowBox);

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
      auto flowBox = getVal!FlowBox(_paramVals);
      _dgClosure.dlg(flowBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("select-all", closure, after);
  }

  /**
   * Emitted when the set of selected children changes.
   * Use [Gtk.FlowBox.selectedForeach] or
   * [Gtk.FlowBox.getSelectedChildren] to obtain the
   * selected children.
   *   flowBox = the instance the signal is connected to
   */
  alias SelectedChildrenChangedCallback = void delegate(FlowBox flowBox);

  /**
   * Connect to SelectedChildrenChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSelectedChildrenChanged(SelectedChildrenChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto flowBox = getVal!FlowBox(_paramVals);
      _dgClosure.dlg(flowBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("selected-children-changed", closure, after);
  }

  /**
   * Emitted to toggle the selection of the child that has the focus.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>Ctrl</kbd>-<kbd>Space</kbd>.
   *   flowBox = the instance the signal is connected to
   */
  alias ToggleCursorChildCallback = void delegate(FlowBox flowBox);

  /**
   * Connect to ToggleCursorChild signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggleCursorChild(ToggleCursorChildCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto flowBox = getVal!FlowBox(_paramVals);
      _dgClosure.dlg(flowBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-cursor-child", closure, after);
  }

  /**
   * Emitted to unselect all children of the box,
   * if the selection mode permits it.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal is <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>a</kbd>.
   *   flowBox = the instance the signal is connected to
   */
  alias UnselectAllCallback = void delegate(FlowBox flowBox);

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
      auto flowBox = getVal!FlowBox(_paramVals);
      _dgClosure.dlg(flowBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unselect-all", closure, after);
  }
}

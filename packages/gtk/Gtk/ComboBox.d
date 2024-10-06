module Gtk.ComboBox;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gdk.Device;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellEditable;
import Gtk.CellEditableT;
import Gtk.CellLayout;
import Gtk.CellLayoutT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.TreeIter;
import Gtk.TreeModel;
import Gtk.TreeModelT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkComboBox` is a widget that allows the user to choose from a list of
 * valid choices.
 * ![An example GtkComboBox](combo-box.png)
 * The `GtkComboBox` displays the selected choice; when activated, the
 * `GtkComboBox` displays a popup which allows the user to make a new choice.
 * The `GtkComboBox` uses the model-view pattern; the list of valid choices
 * is specified in the form of a tree model, and the display of the choices
 * can be adapted to the data in the model by using cell renderers, as you
 * would in a tree view. This is possible since `GtkComboBox` implements the
 * [Gtk.CellLayout] interface. The tree model holding the valid
 * choices is not restricted to a flat list, it can be a real tree, and the
 * popup will reflect the tree structure.
 * To allow the user to enter values not in the model, the
 * property@Gtk.ComboBox:has-entry property allows the `GtkComboBox` to
 * contain a [Gtk.Entry]. This entry can be accessed by calling
 * [Gtk.ComboBox.getChild] on the combo box.
 * For a simple list of textual choices, the model-view API of `GtkComboBox`
 * can be a bit overwhelming. In this case, [Gtk.ComboBoxText] offers
 * a simple alternative. Both `GtkComboBox` and `GtkComboBoxText` can contain
 * an entry.
 * ## CSS nodes
 * ```
 * combobox
 * ├── box.linked
 * │   ╰── button.combo
 * │       ╰── box
 * │           ├── cellview
 * │           ╰── arrow
 * ╰── window.popup
 * ```
 * A normal combobox contains a box with the .linked class, a button
 * with the .combo class and inside those buttons, there are a cellview and
 * an arrow.
 * ```
 * combobox
 * ├── box.linked
 * │   ├── entry.combo
 * │   ╰── button.combo
 * │       ╰── box
 * │           ╰── arrow
 * ╰── window.popup
 * ```
 * A `GtkComboBox` with an entry has a single CSS node with name combobox.
 * It contains a box with the .linked class. That box contains an entry and
 * a button, both with the .combo class added. The button also contains another
 * node with name arrow.
 * ## Accessibility
 * `GtkComboBox` uses the %GTK_ACCESSIBLE_ROLE_COMBO_BOX role.

 * Deprecated: Use [Gtk.DropDown] instead
 */
class ComboBox : Widget, CellEditable, CellLayout
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_combo_box_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin CellEditableT!GtkComboBox;
  mixin CellLayoutT!GtkComboBox;

  /**
   * Creates a new empty `GtkComboBox`.
   * Returns: A new `GtkComboBox`

   * Deprecated: Use [Gtk.DropDown]
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_new();
    this(_cretval, false);
  }

  /**
   * Creates a new empty `GtkComboBox` with an entry.
   * In order to use a combo box with entry, you need to tell it
   * which column of the model contains the text for the entry
   * by calling [Gtk.ComboBox.setEntryTextColumn].
   * Returns: A new `GtkComboBox`

   * Deprecated: Use [Gtk.DropDown]
   */
  static ComboBox newWithEntry()
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_new_with_entry();
    auto _retval = _cretval ? ObjectG.getDObject!ComboBox(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkComboBox` with a model.
   * Params:
   *   model = a `GtkTreeModel`
   * Returns: A new `GtkComboBox`

   * Deprecated: Use [Gtk.DropDown]
   */
  static ComboBox newWithModel(TreeModel model)
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_new_with_model(model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!ComboBox(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new empty `GtkComboBox` with an entry and a model.
   * See also [Gtk.ComboBox.newWithEntry].
   * Params:
   *   model = A `GtkTreeModel`
   * Returns: A new `GtkComboBox`

   * Deprecated: Use [Gtk.DropDown]
   */
  static ComboBox newWithModelAndEntry(TreeModel model)
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_new_with_model_and_entry(model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!ComboBox(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the index of the currently active item.
   * If the model is a non-flat treemodel, and the active item is not
   * an immediate child of the root of the tree, this function returns
   * `gtk_tree_path_get_indices $(LPAREN)path$(RPAREN)[0]`, where `path` is the
   * [Gtk.TreePath] of the active item.
   * Returns: An integer which is the index of the currently active item,
   *   or -1 if there’s no active item

   * Deprecated: Use [Gtk.DropDown]
   */
  int getActive()
  {
    int _retval;
    _retval = gtk_combo_box_get_active(cast(GtkComboBox*)cPtr);
    return _retval;
  }

  /**
   * Returns the ID of the active row of combo_box.
   * This value is taken from the active row and the column specified
   * by the propertyGtk.ComboBox:id-column property of combo_box
   * $(LPAREN)see [Gtk.ComboBox.setIdColumn]$(RPAREN).
   * The returned value is an interned string which means that you can
   * compare the pointer by value to other interned strings and that you
   * must not free it.
   * If the propertyGtk.ComboBox:id-column property of combo_box is
   * not set, or if no row is active, or if the active row has a %NULL
   * ID value, then %NULL is returned.
   * Returns: the ID of the active row

   * Deprecated: Use [Gtk.DropDown]
   */
  string getActiveId()
  {
    const(char)* _cretval;
    _cretval = gtk_combo_box_get_active_id(cast(GtkComboBox*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Sets iter to point to the currently active item.
   * If no item is active, iter is left unchanged.
   * Params:
   *   iter = A `GtkTreeIter`
   * Returns: %TRUE if iter was set, %FALSE otherwise

   * Deprecated: Use [Gtk.DropDown]
   */
  bool getActiveIter(out TreeIter iter)
  {
    bool _retval;
    GtkTreeIter _iter;
    _retval = gtk_combo_box_get_active_iter(cast(GtkComboBox*)cPtr, &_iter);
    iter = new TreeIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Returns whether the combo box sets the dropdown button
   * sensitive or not when there are no items in the model.
   * Returns: %GTK_SENSITIVITY_ON if the dropdown button
   *   is sensitive when the model is empty, %GTK_SENSITIVITY_OFF
   *   if the button is always insensitive or %GTK_SENSITIVITY_AUTO
   *   if it is only sensitive as long as the model has one item to
   *   be selected.

   * Deprecated: Use [Gtk.DropDown]
   */
  SensitivityType getButtonSensitivity()
  {
    GtkSensitivityType _cretval;
    _cretval = gtk_combo_box_get_button_sensitivity(cast(GtkComboBox*)cPtr);
    SensitivityType _retval = cast(SensitivityType)_cretval;
    return _retval;
  }

  /**
   * Gets the child widget of combo_box.
   * Returns: the child widget of combo_box

   * Deprecated: Use [Gtk.DropDown]
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_combo_box_get_child(cast(GtkComboBox*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the column which combo_box is using to get the strings
   * from to display in the internal entry.
   * Returns: A column in the data source model of combo_box.

   * Deprecated: Use [Gtk.DropDown]
   */
  int getEntryTextColumn()
  {
    int _retval;
    _retval = gtk_combo_box_get_entry_text_column(cast(GtkComboBox*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the combo box has an entry.
   * Returns: whether there is an entry in combo_box.

   * Deprecated: Use [Gtk.DropDown]
   */
  bool getHasEntry()
  {
    bool _retval;
    _retval = gtk_combo_box_get_has_entry(cast(GtkComboBox*)cPtr);
    return _retval;
  }

  /**
   * Returns the column which combo_box is using to get string IDs
   * for values from.
   * Returns: A column in the data source model of combo_box.

   * Deprecated: Use [Gtk.DropDown]
   */
  int getIdColumn()
  {
    int _retval;
    _retval = gtk_combo_box_get_id_column(cast(GtkComboBox*)cPtr);
    return _retval;
  }

  /**
   * Returns the `GtkTreeModel` of combo_box.
   * Returns: A `GtkTreeModel` which was passed
   *   during construction.

   * Deprecated: Use [Gtk.DropDown]
   */
  TreeModel getModel()
  {
    GtkTreeModel* _cretval;
    _cretval = gtk_combo_box_get_model(cast(GtkComboBox*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeModel(cast(GtkTreeModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether the popup uses a fixed width.
   * Returns: %TRUE if the popup uses a fixed width

   * Deprecated: Use [Gtk.DropDown]
   */
  bool getPopupFixedWidth()
  {
    bool _retval;
    _retval = gtk_combo_box_get_popup_fixed_width(cast(GtkComboBox*)cPtr);
    return _retval;
  }

  /**
   * Hides the menu or dropdown list of combo_box.
   * This function is mostly intended for use by accessibility technologies;
   * applications should have little use for it.

   * Deprecated: Use [Gtk.DropDown]
   */
  void popdown()
  {
    gtk_combo_box_popdown(cast(GtkComboBox*)cPtr);
  }

  /**
   * Pops up the menu or dropdown list of combo_box.
   * This function is mostly intended for use by accessibility technologies;
   * applications should have little use for it.
   * Before calling this, combo_box must be mapped, or nothing will happen.

   * Deprecated: Use [Gtk.DropDown]
   */
  void popup()
  {
    gtk_combo_box_popup(cast(GtkComboBox*)cPtr);
  }

  /**
   * Pops up the menu of combo_box.
   * Note that currently this does not do anything with the device, as it was
   * previously only used for list-mode combo boxes, and those were removed
   * in GTK 4. However, it is retained in case similar functionality is added
   * back later.
   * Params:
   *   device = a `GdkDevice`

   * Deprecated: Use [Gtk.DropDown]
   */
  void popupForDevice(Device device)
  {
    gtk_combo_box_popup_for_device(cast(GtkComboBox*)cPtr, device ? cast(GdkDevice*)device.cPtr(false) : null);
  }

  /**
   * Sets the active item of combo_box to be the item at index.
   * Params:
   *   index = An index in the model passed during construction,
   *     or -1 to have no active item

   * Deprecated: Use [Gtk.DropDown]
   */
  void setActive(int index)
  {
    gtk_combo_box_set_active(cast(GtkComboBox*)cPtr, index);
  }

  /**
   * Changes the active row of combo_box to the one that has an ID equal to
   * active_id.
   * If active_id is %NULL, the active row is unset. Rows having
   * a %NULL ID string cannot be made active by this function.
   * If the propertyGtk.ComboBox:id-column property of combo_box is
   * unset or if no row has the given ID then the function does nothing
   * and returns %FALSE.
   * Params:
   *   activeId = the ID of the row to select
   * Returns: %TRUE if a row with a matching ID was found. If a %NULL
   *   active_id was given to unset the active row, the function
   *   always returns %TRUE.

   * Deprecated: Use [Gtk.DropDown]
   */
  bool setActiveId(string activeId)
  {
    bool _retval;
    const(char)* _activeId = activeId.toCString(false);
    _retval = gtk_combo_box_set_active_id(cast(GtkComboBox*)cPtr, _activeId);
    return _retval;
  }

  /**
   * Sets the current active item to be the one referenced by iter.
   * If iter is %NULL, the active item is unset.
   * Params:
   *   iter = The `GtkTreeIter`

   * Deprecated: Use [Gtk.DropDown]
   */
  void setActiveIter(TreeIter iter)
  {
    gtk_combo_box_set_active_iter(cast(GtkComboBox*)cPtr, iter ? cast(GtkTreeIter*)iter.cPtr(false) : null);
  }

  /**
   * Sets whether the dropdown button of the combo box should update
   * its sensitivity depending on the model contents.
   * Params:
   *   sensitivity = specify the sensitivity of the dropdown button

   * Deprecated: Use [Gtk.DropDown]
   */
  void setButtonSensitivity(SensitivityType sensitivity)
  {
    gtk_combo_box_set_button_sensitivity(cast(GtkComboBox*)cPtr, sensitivity);
  }

  /**
   * Sets the child widget of combo_box.
   * Params:
   *   child = the child widget

   * Deprecated: Use [Gtk.DropDown]
   */
  void setChild(Widget child)
  {
    gtk_combo_box_set_child(cast(GtkComboBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the model column which combo_box should use to get strings
   * from to be text_column.
   * For this column no separate
   * [Gtk.CellRenderer] is needed.
   * The column text_column in the model of combo_box must be of
   * type %G_TYPE_STRING.
   * This is only relevant if combo_box has been created with
   * propertyGtk.ComboBox:has-entry as %TRUE.
   * Params:
   *   textColumn = A column in model to get the strings from for
   *     the internal entry

   * Deprecated: Use [Gtk.DropDown]
   */
  void setEntryTextColumn(int textColumn)
  {
    gtk_combo_box_set_entry_text_column(cast(GtkComboBox*)cPtr, textColumn);
  }

  /**
   * Sets the model column which combo_box should use to get string IDs
   * for values from.
   * The column id_column in the model of combo_box must be of type
   * %G_TYPE_STRING.
   * Params:
   *   idColumn = A column in model to get string IDs for values from

   * Deprecated: Use [Gtk.DropDown]
   */
  void setIdColumn(int idColumn)
  {
    gtk_combo_box_set_id_column(cast(GtkComboBox*)cPtr, idColumn);
  }

  /**
   * Sets the model used by combo_box to be model.
   * Will unset a previously set model $(LPAREN)if applicable$(RPAREN). If model is %NULL,
   * then it will unset the model.
   * Note that this function does not clear the cell renderers, you have to
   * call [Gtk.CellLayout.clear] yourself if you need to set up different
   * cell renderers for the new model.
   * Params:
   *   model = A `GtkTreeModel`

   * Deprecated: Use [Gtk.DropDown]
   */
  void setModel(TreeModel model)
  {
    gtk_combo_box_set_model(cast(GtkComboBox*)cPtr, model ? cast(GtkTreeModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Specifies whether the popup’s width should be a fixed width.
   * If fixed is %TRUE, the popup's width is set to match the
   * allocated width of the combo box.
   * Params:
   *   fixed = whether to use a fixed popup width

   * Deprecated: Use [Gtk.DropDown]
   */
  void setPopupFixedWidth(bool fixed)
  {
    gtk_combo_box_set_popup_fixed_width(cast(GtkComboBox*)cPtr, fixed);
  }

  /**
   * Sets the row separator function, which is used to determine
   * whether a row should be drawn as a separator.
   * If the row separator function is %NULL, no separators are drawn.
   * This is the default value.
   * Params:
   *   func = a `GtkTreeViewRowSeparatorFunc`

   * Deprecated: Use [Gtk.DropDown]
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
    gtk_combo_box_set_row_separator_func(cast(GtkComboBox*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Emitted to when the combo box is activated.
   * The `::activate` signal on `GtkComboBox` is an action signal and
   * emitting it causes the combo box to pop up its dropdown.
   *   comboBox = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(ComboBox comboBox);

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
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto comboBox = getVal!ComboBox(_paramVals);
      _dgClosure.dlg(comboBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the active item is changed.
   * The can be due to the user selecting a different item from the list,
   * or due to a call to [Gtk.ComboBox.setActiveIter]. It will
   * also be emitted while typing into the entry of a combo box with an entry.
   *   comboBox = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(ComboBox comboBox);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto comboBox = getVal!ComboBox(_paramVals);
      _dgClosure.dlg(comboBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to allow changing how the text in a combo box's entry is displayed.
   * See propertyGtk.ComboBox:has-entry.
   * Connect a signal handler which returns an allocated string representing
   * path. That string will then be used to set the text in the combo box's
   * entry. The default signal handler uses the text from the
   * propertyGtk.ComboBox:entry-text-column model column.
   * Here's an example signal handler which fetches data from the model and
   * displays it in the entry.
   * ```c
   * static char *
   * format_entry_text_callback $(LPAREN)GtkComboBox *combo,
   * const char *path,
   * gpointer     user_data$(RPAREN)
   * {
   * GtkTreeIter iter;
   * GtkTreeModel model;
   * double       value;
   * model \= gtk_combo_box_get_model $(LPAREN)combo$(RPAREN);
   * gtk_tree_model_get_iter_from_string $(LPAREN)model, &iter, path$(RPAREN);
   * gtk_tree_model_get $(LPAREN)model, &iter,
   * THE_DOUBLE_VALUE_COLUMN, &value,
   * -1$(RPAREN);
   * return g_strdup_printf $(LPAREN)"%g", value$(RPAREN);
   * }
   * ```
   * Params
   *   path = the [Gtk.TreePath] string from the combo box's current model
   *     to format text for
   *   comboBox = the instance the signal is connected to
   * Returns: a newly allocated string representing path
   *   for the current `GtkComboBox` model.
   */
  alias FormatEntryTextCallback = string delegate(string path, ComboBox comboBox);

  /**
   * Connect to FormatEntryText signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectFormatEntryText(FormatEntryTextCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto comboBox = getVal!ComboBox(_paramVals);
      auto path = getVal!string(&_paramVals[1]);
      auto _retval = _dgClosure.dlg(path, comboBox);
      setVal!string(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("format-entry-text", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to move the active selection.
   * This is an [keybinding signal](class.SignalAction.html).
   * Params
   *   scrollType = a `GtkScrollType`
   *   comboBox = the instance the signal is connected to
   */
  alias MoveActiveCallback = void delegate(ScrollType scrollType, ComboBox comboBox);

  /**
   * Connect to MoveActive signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectMoveActive(MoveActiveCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto comboBox = getVal!ComboBox(_paramVals);
      auto scrollType = getVal!ScrollType(&_paramVals[1]);
      _dgClosure.dlg(scrollType, comboBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-active", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to popdown the combo box list.
   * This is an [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are Alt+Up and Escape.
   *   comboBox = the instance the signal is connected to
   * Returns:
   */
  alias PopdownCallback = bool delegate(ComboBox comboBox);

  /**
   * Connect to Popdown signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPopdown(PopdownCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto comboBox = getVal!ComboBox(_paramVals);
      _retval = _dgClosure.dlg(comboBox);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("popdown", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to popup the combo box list.
   * This is an [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is Alt+Down.
   *   comboBox = the instance the signal is connected to
   */
  alias PopupCallback = void delegate(ComboBox comboBox);

  /**
   * Connect to Popup signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPopup(PopupCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto comboBox = getVal!ComboBox(_paramVals);
      _dgClosure.dlg(comboBox);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("popup", closure, (flags & ConnectFlags.After) != 0);
  }
}

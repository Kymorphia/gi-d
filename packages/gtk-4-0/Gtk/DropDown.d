module Gtk.DropDown;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Expression;
import Gtk.ListItemFactory;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkDropDown` is a widget that allows the user to choose an item
 * from a list of options.
 * ![An example GtkDropDown](drop-down.png)
 * The `GtkDropDown` displays the [selected][Gtk.DropDown.selected]
 * choice.
 * The options are given to `GtkDropDown` in the form of `GListModel`
 * and how the individual options are represented is determined by
 * a [Gtk.ListItemFactory]. The default factory displays simple strings,
 * and adds a checkmark to the selected item in the popup.
 * To set your own factory, use [Gtk.DropDown.setFactory]. It is
 * possible to use a separate factory for the items in the popup, with
 * [Gtk.DropDown.setListFactory].
 * `GtkDropDown` knows how to obtain strings from the items in a
 * [Gtk.StringList]; for other models, you have to provide an expression
 * to find the strings via [Gtk.DropDown.setExpression].
 * `GtkDropDown` can optionally allow search in the popup, which is
 * useful if the list of options is long. To enable the search entry,
 * use [Gtk.DropDown.setEnableSearch].
 * Here is a UI definition example for `GtkDropDown` with a simple model:
 * ```xml
 * <object class\="GtkDropDown">
 * <property name\="model">
 * <object class\="GtkStringList">
 * <items>
 * <item translatable\="yes">Factory</item>
 * <item translatable\="yes">Home</item>
 * <item translatable\="yes">Subway</item>
 * </items>
 * </object>
 * </property>
 * </object>
 * ```
 * If a `GtkDropDown` is created in this manner, or with
 * [Gtk.DropDown.newFromStrings], for instance, the object returned from
 * [Gtk.DropDown.getSelectedItem] will be a [Gtk.StringObject].
 * To learn more about the list widget framework, see the
 * [overview](section-list-widget.html).
 * ## CSS nodes
 * `GtkDropDown` has a single CSS node with name dropdown,
 * with the button and popover nodes as children.
 * ## Accessibility
 * `GtkDropDown` uses the %GTK_ACCESSIBLE_ROLE_COMBO_BOX role.
 */
class DropDown : Widget
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
    return gtk_drop_down_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkDropDown`.
   * You may want to call [Gtk.DropDown.setFactory]
   * to set up a way to map its items to widgets.
   * Params:
   *   model = the model to use
   *   expression = the expression to use
   * Returns: a new `GtkDropDown`
   */
  this(ListModel model, Expression expression)
  {
    GtkWidget* _cretval;
    _cretval = gtk_drop_down_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(true) : null, expression ? cast(GtkExpression*)expression.cPtr(true) : null);
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkDropDown` that is populated with
   * the strings.
   * Params:
   *   strings = The strings to put in the dropdown
   * Returns: a new `GtkDropDown`
   */
  static DropDown newFromStrings(string[] strings)
  {
    GtkWidget* _cretval;
    char*[] _tmpstrings;
    foreach (s; strings)
      _tmpstrings ~= s.toCString(false);
    _tmpstrings ~= null;
    const(char*)* _strings = _tmpstrings.ptr;
    _cretval = gtk_drop_down_new_from_strings(_strings);
    auto _retval = _cretval ? ObjectG.getDObject!DropDown(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether search is enabled.
   * Returns: %TRUE if the popup includes a search entry
   */
  bool getEnableSearch()
  {
    bool _retval;
    _retval = gtk_drop_down_get_enable_search(cast(GtkDropDown*)cPtr);
    return _retval;
  }

  /**
   * Gets the expression set that is used to obtain strings from items.
   * See [Gtk.DropDown.setExpression].
   * Returns: a `GtkExpression`
   */
  Expression getExpression()
  {
    GtkExpression* _cretval;
    _cretval = gtk_drop_down_get_expression(cast(GtkDropDown*)cPtr);
    auto _retval = _cretval ? new Expression(cast(GtkExpression*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the factory that's currently used to populate list items.
   * The factory returned by this function is always used for the
   * item in the button. It is also used for items in the popup
   * if propertyGtk.DropDown:list-factory is not set.
   * Returns: The factory in use
   */
  ListItemFactory getFactory()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_drop_down_get_factory(cast(GtkDropDown*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListItemFactory(cast(GtkListItemFactory*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the factory that's currently used to create header widgets for the popup.
   * Returns: The factory in use
   */
  ListItemFactory getHeaderFactory()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_drop_down_get_header_factory(cast(GtkDropDown*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListItemFactory(cast(GtkListItemFactory*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the factory that's currently used to populate list items in the popup.
   * Returns: The factory in use
   */
  ListItemFactory getListFactory()
  {
    GtkListItemFactory* _cretval;
    _cretval = gtk_drop_down_get_list_factory(cast(GtkDropDown*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListItemFactory(cast(GtkListItemFactory*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the model that provides the displayed items.
   * Returns: The model in use
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_drop_down_get_model(cast(GtkDropDown*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the match mode that the search filter is using.
   * Returns: the match mode of the search filter
   */
  StringFilterMatchMode getSearchMatchMode()
  {
    GtkStringFilterMatchMode _cretval;
    _cretval = gtk_drop_down_get_search_match_mode(cast(GtkDropDown*)cPtr);
    StringFilterMatchMode _retval = cast(StringFilterMatchMode)_cretval;
    return _retval;
  }

  /**
   * Gets the position of the selected item.
   * Returns: the position of the selected item, or %GTK_INVALID_LIST_POSITION
   *   if not item is selected
   */
  uint getSelected()
  {
    uint _retval;
    _retval = gtk_drop_down_get_selected(cast(GtkDropDown*)cPtr);
    return _retval;
  }

  /**
   * Gets the selected item. If no item is selected, %NULL is returned.
   * Returns: The selected item
   */
  ObjectG getSelectedItem()
  {
    ObjectC* _cretval;
    _cretval = gtk_drop_down_get_selected_item(cast(GtkDropDown*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether to show an arrow within the widget.
   * Returns: %TRUE if an arrow will be shown.
   */
  bool getShowArrow()
  {
    bool _retval;
    _retval = gtk_drop_down_get_show_arrow(cast(GtkDropDown*)cPtr);
    return _retval;
  }

  /**
   * Sets whether a search entry will be shown in the popup that
   * allows to search for items in the list.
   * Note that [Gtk.DropDown.expression] must be set for
   * search to work.
   * Params:
   *   enableSearch = whether to enable search
   */
  void setEnableSearch(bool enableSearch)
  {
    gtk_drop_down_set_enable_search(cast(GtkDropDown*)cPtr, enableSearch);
  }

  /**
   * Sets the expression that gets evaluated to obtain strings from items.
   * This is used for search in the popup. The expression must have
   * a value type of %G_TYPE_STRING.
   * Params:
   *   expression = a `GtkExpression`
   */
  void setExpression(Expression expression)
  {
    gtk_drop_down_set_expression(cast(GtkDropDown*)cPtr, expression ? cast(GtkExpression*)expression.cPtr(false) : null);
  }

  /**
   * Sets the `GtkListItemFactory` to use for populating list items.
   * Params:
   *   factory = the factory to use
   */
  void setFactory(ListItemFactory factory)
  {
    gtk_drop_down_set_factory(cast(GtkDropDown*)cPtr, factory ? cast(GtkListItemFactory*)factory.cPtr(false) : null);
  }

  /**
   * Sets the `GtkListItemFactory` to use for creating header widgets for the popup.
   * Params:
   *   factory = the factory to use
   */
  void setHeaderFactory(ListItemFactory factory)
  {
    gtk_drop_down_set_header_factory(cast(GtkDropDown*)cPtr, factory ? cast(GtkListItemFactory*)factory.cPtr(false) : null);
  }

  /**
   * Sets the `GtkListItemFactory` to use for populating list items in the popup.
   * Params:
   *   factory = the factory to use
   */
  void setListFactory(ListItemFactory factory)
  {
    gtk_drop_down_set_list_factory(cast(GtkDropDown*)cPtr, factory ? cast(GtkListItemFactory*)factory.cPtr(false) : null);
  }

  /**
   * Sets the `GListModel` to use.
   * Params:
   *   model = the model to use
   */
  void setModel(ListModel model)
  {
    gtk_drop_down_set_model(cast(GtkDropDown*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Sets the match mode for the search filter.
   * Params:
   *   searchMatchMode = the new match mode
   */
  void setSearchMatchMode(StringFilterMatchMode searchMatchMode)
  {
    gtk_drop_down_set_search_match_mode(cast(GtkDropDown*)cPtr, searchMatchMode);
  }

  /**
   * Selects the item at the given position.
   * Params:
   *   position = the position of the item to select, or %GTK_INVALID_LIST_POSITION
   */
  void setSelected(uint position)
  {
    gtk_drop_down_set_selected(cast(GtkDropDown*)cPtr, position);
  }

  /**
   * Sets whether an arrow will be displayed within the widget.
   * Params:
   *   showArrow = whether to show an arrow within the widget
   */
  void setShowArrow(bool showArrow)
  {
    gtk_drop_down_set_show_arrow(cast(GtkDropDown*)cPtr, showArrow);
  }

  /**
   * Emitted to when the drop down is activated.
   * The `::activate` signal on `GtkDropDown` is an action signal and
   * emitting it causes the drop down to pop up its dropdown.
   *   dropDown = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(DropDown dropDown);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dropDown = getVal!DropDown(_paramVals);
      _dgClosure.dlg(dropDown);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }
}

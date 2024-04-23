module Gio.MenuModel;

import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.MenuAttributeIter;
import Gio.MenuLinkIter;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMenuModel represents the contents of a menu -- an ordered list of
 * menu items. The items are associated with actions, which can be
 * activated through them. Items can be grouped in sections, and may
 * have submenus associated with them. Both items and sections usually
 * have some representation data, such as labels or icons. The type of
 * the associated action (ie whether it is stateful, and what kind of
 * state it has) can influence the representation of the item.
 *
 * The conceptual model of menus in #GMenuModel is hierarchical:
 * sections and submenus are again represented by #GMenuModels.
 * Menus themselves do not define their own roles. Rather, the role
 * of a particular #GMenuModel is defined by the item that references
 * it (or, in the case of the 'root' menu, is defined by the context
 * in which it is used).
 *
 * As an example, consider the visible portions of this menu:
 *
 * ## An example menu # {#menu-example}
 *
 * ![](menu-example.png)
 *
 * There are 8 "menus" visible in the screenshot: one menubar, two
 * submenus and 5 sections:
 *
 * - the toplevel menubar (containing 4 items)
 * - the View submenu (containing 3 sections)
 * - the first section of the View submenu (containing 2 items)
 * - the second section of the View submenu (containing 1 item)
 * - the final section of the View submenu (containing 1 item)
 * - the Highlight Mode submenu (containing 2 sections)
 * - the Sources section (containing 2 items)
 * - the Markup section (containing 2 items)
 *
 * The [example][menu-model] illustrates the conceptual connection between
 * these 8 menus. Each large block in the figure represents a menu and the
 * smaller blocks within the large block represent items in that menu. Some
 * items contain references to other menus.
 *
 * ## A menu example # {#menu-model}
 *
 * ![](menu-model.png)
 *
 * Notice that the separators visible in the [example][menu-example]
 * appear nowhere in the [menu model][menu-model]. This is because
 * separators are not explicitly represented in the menu model. Instead,
 * a separator is inserted between any two non-empty sections of a menu.
 * Section items can have labels just like any other item. In that case,
 * a display system may show a section header instead of a separator.
 *
 * The motivation for this abstract model of application controls is
 * that modern user interfaces tend to make these controls available
 * outside the application. Examples include global menus, jumplists,
 * dash boards, etc. To support such uses, it is necessary to 'export'
 * information about actions and their representation in menus, which
 * is exactly what the [GActionGroup exporter][gio-GActionGroup-exporter]
 * and the [GMenuModel exporter][gio-GMenuModel-exporter] do for
 * #GActionGroup and #GMenuModel. The client-side counterparts to
 * make use of the exported information are #GDBusActionGroup and
 * #GDBusMenuModel.
 *
 * The API of #GMenuModel is very generic, with iterators for the
 * attributes and links of an item, see g_menu_model_iterate_item_attributes()
 * and g_menu_model_iterate_item_links(). The 'standard' attributes and
 * link types have predefined names: %G_MENU_ATTRIBUTE_LABEL,
 * %G_MENU_ATTRIBUTE_ACTION, %G_MENU_ATTRIBUTE_TARGET, %G_MENU_LINK_SECTION
 * and %G_MENU_LINK_SUBMENU.
 *
 * Items in a #GMenuModel represent active controls if they refer to
 * an action that can get activated when the user interacts with the
 * menu item. The reference to the action is encoded by the string id
 * in the %G_MENU_ATTRIBUTE_ACTION attribute. An action id uniquely
 * identifies an action in an action group. Which action group(s) provide
 * actions depends on the context in which the menu model is used.
 * E.g. when the model is exported as the application menu of a
 * #GtkApplication, actions can be application-wide or window-specific
 * (and thus come from two different action groups). By convention, the
 * application-wide actions have names that start with "app.", while the
 * names of window-specific actions start with "win.".
 *
 * While a wide variety of stateful actions is possible, the following
 * is the minimum that is expected to be supported by all users of exported
 * menu information:
 * - an action with no parameter type and no state
 * - an action with no parameter type and boolean state
 * - an action with string parameter type and string state
 *
 * ## Stateless
 *
 * A stateless action typically corresponds to an ordinary menu item.
 *
 * Selecting such a menu item will activate the action (with no parameter).
 *
 * ## Boolean State
 *
 * An action with a boolean state will most typically be used with a "toggle"
 * or "switch" menu item. The state can be set directly, but activating the
 * action (with no parameter) results in the state being toggled.
 *
 * Selecting a toggle menu item will activate the action. The menu item should
 * be rendered as "checked" when the state is true.
 *
 * ## String Parameter and State
 *
 * Actions with string parameters and state will most typically be used to
 * represent an enumerated choice over the items available for a group of
 * radio menu items. Activating the action with a string parameter is
 * equivalent to setting that parameter as the state.
 *
 * Radio menu items, in addition to being associated with the action, will
 * have a target value. Selecting that menu item will result in activation
 * of the action with the target value as the parameter. The menu item should
 * be rendered as "selected" when the state of the action is equal to the
 * target value of the menu item.
 */
class MenuModel : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_menu_model_get_type();
  }

  /**
   * the value of the attribute
   */
  Variant getItemAttributeValue(int itemIndex, string attribute, VariantType expectedType)
  {
    GVariant* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_menu_model_get_item_attribute_value(cPtr!GMenuModel, itemIndex, _attribute, expectedType ? expectedType.cPtr!GVariantType : null);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the linked #GMenuModel, or %NULL
   */
  MenuModel getItemLink(int itemIndex, string link)
  {
    GMenuModel* _cretval;
    const(char)* _link = link.toCString(false);
    _cretval = g_menu_model_get_item_link(cPtr!GMenuModel, itemIndex, _link);
    MenuModel _retval = ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, true);
    return _retval;
  }

  /**
   * the number of items
   */
  int getNItems()
  {
    int _retval;
    _retval = g_menu_model_get_n_items(cPtr!GMenuModel);
    return _retval;
  }

  /**
   * %TRUE if the model is mutable (ie: "items-changed" may be
   * emitted).
   */
  bool isMutable()
  {
    bool _retval;
    _retval = g_menu_model_is_mutable(cPtr!GMenuModel);
    return _retval;
  }

  /**
   * Requests emission of the #GMenuModel::items-changed signal on @model.
   *
   * This function should never be called except by #GMenuModel
   * subclasses.  Any other calls to this function will very likely lead
   * to a violation of the interface of the model.
   *
   * The implementation should update its internal representation of the
   * menu before emitting the signal.  The implementation should further
   * expect to receive queries about the new state of the menu (and
   * particularly added menu items) while signal handlers are running.
   *
   * The implementation must dispatch this call directly from a mainloop
   * entry and not in response to calls -- particularly those from the
   * #GMenuModel API.  Said another way: the menu must not change while
   * user code is running without returning to the mainloop.
   */
  void itemsChanged(int position, int removed, int added)
  {
    g_menu_model_items_changed(cPtr!GMenuModel, position, removed, added);
  }

  /**
   * a new #GMenuAttributeIter
   */
  MenuAttributeIter iterateItemAttributes(int itemIndex)
  {
    GMenuAttributeIter* _cretval;
    _cretval = g_menu_model_iterate_item_attributes(cPtr!GMenuModel, itemIndex);
    MenuAttributeIter _retval = ObjectG.getDObject!MenuAttributeIter(cast(GMenuAttributeIter*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GMenuLinkIter
   */
  MenuLinkIter iterateItemLinks(int itemIndex)
  {
    GMenuLinkIter* _cretval;
    _cretval = g_menu_model_iterate_item_links(cPtr!GMenuModel, itemIndex);
    MenuLinkIter _retval = ObjectG.getDObject!MenuLinkIter(cast(GMenuLinkIter*)_cretval, true);
    return _retval;
  }

  /**
   * Emitted when a change has occurred to the menu.
   *
   * The only changes that can occur to a menu is that items are removed
   * or added.  Items may not change (except by being removed and added
   * back in the same location).  This signal is capable of describing
   * both of those changes (at the same time).
   *
   * The signal means that starting at the index @position, @removed
   * items were removed and @added items were added in their place.  If
   * @removed is zero then only items were added.  If @added is zero
   * then only items were removed.
   *
   * As an example, if the menu contains items a, b, c, d (in that
   * order) and the signal (2, 1, 3) occurs then the new composition of
   * the menu will be a, b, _, _, _, d (with each _ representing some
   * new item).
   *
   * Signal handlers may query the model (particularly the added items)
   * and expect to see the results of the modification that is being
   * reported.  The signal is emitted after the modification.
   */
  ulong connectItemsChanged(void delegate(int position, int removed, int added, MenuModel menuModel) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto menuModel = getVal!MenuModel(_paramVals);
      auto position = getVal!int(&_paramVals[1]);
      auto removed = getVal!int(&_paramVals[2]);
      auto added = getVal!int(&_paramVals[3]);
      _dgClosure.dlg(position, removed, added, menuModel);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("items-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

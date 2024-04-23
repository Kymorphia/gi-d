module Gio.MenuItem;

import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Icon;
import Gio.MenuModel;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMenuItem is an opaque structure type.  You must access it using the
 * functions below.
 */
class MenuItem : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_menu_item_get_type();
  }

  /**
   * a new #GMenuItem
   */
  this(string label, string detailedAction)
  {
    GMenuItem* _cretval;
    const(char)* _label = label.toCString(false);
    const(char)* _detailedAction = detailedAction.toCString(false);
    _cretval = g_menu_item_new(_label, _detailedAction);
    this(_cretval, true);
  }

  /**
   * a new #GMenuItem.
   */
  static MenuItem newFromModel(MenuModel model, int itemIndex)
  {
    GMenuItem* _cretval;
    _cretval = g_menu_item_new_from_model(model ? model.cPtr!GMenuModel : null, itemIndex);
    MenuItem _retval = ObjectG.getDObject!MenuItem(cast(GMenuItem*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GMenuItem
   */
  static MenuItem newSection(string label, MenuModel section)
  {
    GMenuItem* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = g_menu_item_new_section(_label, section ? section.cPtr!GMenuModel : null);
    MenuItem _retval = ObjectG.getDObject!MenuItem(cast(GMenuItem*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GMenuItem
   */
  static MenuItem newSubmenu(string label, MenuModel submenu)
  {
    GMenuItem* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = g_menu_item_new_submenu(_label, submenu ? submenu.cPtr!GMenuModel : null);
    MenuItem _retval = ObjectG.getDObject!MenuItem(cast(GMenuItem*)_cretval, true);
    return _retval;
  }

  /**
   * the attribute value, or %NULL
   */
  Variant getAttributeValue(string attribute, VariantType expectedType)
  {
    GVariant* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_menu_item_get_attribute_value(cPtr!GMenuItem, _attribute, expectedType ? expectedType.cPtr!GVariantType : null);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the link, or %NULL
   */
  MenuModel getLink(string link)
  {
    GMenuModel* _cretval;
    const(char)* _link = link.toCString(false);
    _cretval = g_menu_item_get_link(cPtr!GMenuItem, _link);
    MenuModel _retval = ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, true);
    return _retval;
  }

  /**
   * Sets or unsets the "action" and "target" attributes of @menu_item.
   *
   * If @action is %NULL then both the "action" and "target" attributes
   * are unset (and @target_value is ignored).
   *
   * If @action is non-%NULL then the "action" attribute is set.  The
   * "target" attribute is then set to the value of @target_value if it is
   * non-%NULL or unset otherwise.
   *
   * Normal menu items (ie: not submenu, section or other custom item
   * types) are expected to have the "action" attribute set to identify
   * the action that they are associated with.  The state type of the
   * action help to determine the disposition of the menu item.  See
   * #GAction and #GActionGroup for an overview of actions.
   *
   * In general, clicking on the menu item will result in activation of
   * the named action with the "target" attribute given as the parameter
   * to the action invocation.  If the "target" attribute is not set then
   * the action is invoked with no parameter.
   *
   * If the action has no state then the menu item is usually drawn as a
   * plain menu item (ie: with no additional decoration).
   *
   * If the action has a boolean state then the menu item is usually drawn
   * as a toggle menu item (ie: with a checkmark or equivalent
   * indication).  The item should be marked as 'toggled' or 'checked'
   * when the boolean state is %TRUE.
   *
   * If the action has a string state then the menu item is usually drawn
   * as a radio menu item (ie: with a radio bullet or equivalent
   * indication).  The item should be marked as 'selected' when the string
   * state is equal to the value of the @target property.
   *
   * See g_menu_item_set_action_and_target() or
   * g_menu_item_set_detailed_action() for two equivalent calls that are
   * probably more convenient for most uses.
   */
  void setActionAndTargetValue(string action, Variant targetValue)
  {
    const(char)* _action = action.toCString(false);
    g_menu_item_set_action_and_target_value(cPtr!GMenuItem, _action, targetValue ? targetValue.cPtr!GVariant : null);
  }

  /**
   * Sets or unsets an attribute on @menu_item.
   *
   * The attribute to set or unset is specified by @attribute. This
   * can be one of the standard attribute names %G_MENU_ATTRIBUTE_LABEL,
   * %G_MENU_ATTRIBUTE_ACTION, %G_MENU_ATTRIBUTE_TARGET, or a custom
   * attribute name.
   * Attribute names are restricted to lowercase characters, numbers
   * and '-'. Furthermore, the names must begin with a lowercase character,
   * must not end with a '-', and must not contain consecutive dashes.
   *
   * must consist only of lowercase
   * ASCII characters, digits and '-'.
   *
   * If @value is non-%NULL then it is used as the new value for the
   * attribute.  If @value is %NULL then the attribute is unset. If
   * the @value #GVariant is floating, it is consumed.
   *
   * See also g_menu_item_set_attribute() for a more convenient way to do
   * the same.
   */
  void setAttributeValue(string attribute, Variant value)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_menu_item_set_attribute_value(cPtr!GMenuItem, _attribute, value ? value.cPtr!GVariant : null);
  }

  /**
   * Sets the "action" and possibly the "target" attribute of @menu_item.
   *
   * The format of @detailed_action is the same format parsed by
   * g_action_parse_detailed_name().
   *
   * See g_menu_item_set_action_and_target() or
   * g_menu_item_set_action_and_target_value() for more flexible (but
   * slightly less convenient) alternatives.
   *
   * See also g_menu_item_set_action_and_target_value() for a description of
   * the semantics of the action and target attributes.
   */
  void setDetailedAction(string detailedAction)
  {
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_menu_item_set_detailed_action(cPtr!GMenuItem, _detailedAction);
  }

  /**
   * Sets (or unsets) the icon on @menu_item.
   *
   * This call is the same as calling g_icon_serialize() and using the
   * result as the value to g_menu_item_set_attribute_value() for
   * %G_MENU_ATTRIBUTE_ICON.
   *
   * This API is only intended for use with "noun" menu items; things like
   * bookmarks or applications in an "Open With" menu.  Don't use it on
   * menu items corresponding to verbs (eg: stock icons for 'Save' or
   * 'Quit').
   *
   * If @icon is %NULL then the icon is unset.
   */
  void setIcon(Icon icon)
  {
    g_menu_item_set_icon(cPtr!GMenuItem, icon ? (cast(ObjectG)icon).cPtr!GIcon : null);
  }

  /**
   * Sets or unsets the "label" attribute of @menu_item.
   *
   * If @label is non-%NULL it is used as the label for the menu item.  If
   * it is %NULL then the label attribute is unset.
   */
  void setLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    g_menu_item_set_label(cPtr!GMenuItem, _label);
  }

  /**
   * Creates a link from @menu_item to @model if non-%NULL, or unsets it.
   *
   * Links are used to establish a relationship between a particular menu
   * item and another menu.  For example, %G_MENU_LINK_SUBMENU is used to
   * associate a submenu with a particular menu item, and %G_MENU_LINK_SECTION
   * is used to create a section. Other types of link can be used, but there
   * is no guarantee that clients will be able to make sense of them.
   * Link types are restricted to lowercase characters, numbers
   * and '-'. Furthermore, the names must begin with a lowercase character,
   * must not end with a '-', and must not contain consecutive dashes.
   */
  void setLink(string link, MenuModel model)
  {
    const(char)* _link = link.toCString(false);
    g_menu_item_set_link(cPtr!GMenuItem, _link, model ? model.cPtr!GMenuModel : null);
  }

  /**
   * Sets or unsets the "section" link of @menu_item to @section.
   *
   * The effect of having one menu appear as a section of another is
   * exactly as it sounds: the items from @section become a direct part of
   * the menu that @menu_item is added to.  See g_menu_item_new_section()
   * for more information about what it means for a menu item to be a
   * section.
   */
  void setSection(MenuModel section)
  {
    g_menu_item_set_section(cPtr!GMenuItem, section ? section.cPtr!GMenuModel : null);
  }

  /**
   * Sets or unsets the "submenu" link of @menu_item to @submenu.
   *
   * If @submenu is non-%NULL, it is linked to.  If it is %NULL then the
   * link is unset.
   *
   * The effect of having one menu appear as a submenu of another is
   * exactly as it sounds.
   */
  void setSubmenu(MenuModel submenu)
  {
    g_menu_item_set_submenu(cPtr!GMenuItem, submenu ? submenu.cPtr!GMenuModel : null);
  }
}

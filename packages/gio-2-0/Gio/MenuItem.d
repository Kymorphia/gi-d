module Gio.MenuItem;

import GLib.VariantG;
import GLib.VariantType;
import GObject.ObjectG;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
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

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_menu_item_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GMenuItem.
   * If label is non-%NULL it is used to set the "label" attribute of the
   * new item.
   * If detailed_action is non-%NULL it is used to set the "action" and
   * possibly the "target" attribute of the new item.  See
   * [Gio.MenuItem.setDetailedAction] for more information.
   * Params:
   *   label = the section label, or %NULL
   *   detailedAction = the detailed action string, or %NULL
   * Returns: a new #GMenuItem
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
   * Creates a #GMenuItem as an exact copy of an existing menu item in a
   * #GMenuModel.
   * item_index must be valid $(LPAREN)ie: be sure to call
   * [Gio.MenuModel.getNItems] first$(RPAREN).
   * Params:
   *   model = a #GMenuModel
   *   itemIndex = the index of an item in model
   * Returns: a new #GMenuItem.
   */
  static MenuItem newFromModel(MenuModel model, int itemIndex)
  {
    GMenuItem* _cretval;
    _cretval = g_menu_item_new_from_model(model ? cast(GMenuModel*)model.cPtr(false) : null, itemIndex);
    auto _retval = _cretval ? ObjectG.getDObject!MenuItem(cast(GMenuItem*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GMenuItem representing a section.
   * This is a convenience API around [Gio.MenuItem.new_] and
   * [Gio.MenuItem.setSection].
   * The effect of having one menu appear as a section of another is
   * exactly as it sounds: the items from section become a direct part of
   * the menu that menu_item is added to.
   * Visual separation is typically displayed between two non-empty
   * sections.  If label is non-%NULL then it will be encorporated into
   * this visual indication.  This allows for labeled subsections of a
   * menu.
   * As a simple example, consider a typical "Edit" menu from a simple
   * program.  It probably contains an "Undo" and "Redo" item, followed by
   * a separator, followed by "Cut", "Copy" and "Paste".
   * This would be accomplished by creating three #GMenu instances.  The
   * first would be populated with the "Undo" and "Redo" items, and the
   * second with the "Cut", "Copy" and "Paste" items.  The first and
   * second menus would then be added as submenus of the third.  In XML
   * format, this would look something like the following:
   * |[
   * <menu id\='edit-menu'>
   * <section>
   * <item label\='Undo'/>
   * <item label\='Redo'/>
   * </section>
   * <section>
   * <item label\='Cut'/>
   * <item label\='Copy'/>
   * <item label\='Paste'/>
   * </section>
   * </menu>
   * ]|
   * The following example is exactly equivalent.  It is more illustrative
   * of the exact relationship between the menus and items $(LPAREN)keeping in
   * mind that the 'link' element defines a new menu that is linked to the
   * containing one$(RPAREN).  The style of the second example is more verbose and
   * difficult to read $(LPAREN)and therefore not recommended except for the
   * purpose of understanding what is really going on$(RPAREN).
   * |[
   * <menu id\='edit-menu'>
   * <item>
   * <link name\='section'>
   * <item label\='Undo'/>
   * <item label\='Redo'/>
   * </link>
   * </item>
   * <item>
   * <link name\='section'>
   * <item label\='Cut'/>
   * <item label\='Copy'/>
   * <item label\='Paste'/>
   * </link>
   * </item>
   * </menu>
   * ]|
   * Params:
   *   label = the section label, or %NULL
   *   section = a #GMenuModel with the items of the section
   * Returns: a new #GMenuItem
   */
  static MenuItem newSection(string label, MenuModel section)
  {
    GMenuItem* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = g_menu_item_new_section(_label, section ? cast(GMenuModel*)section.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!MenuItem(cast(GMenuItem*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GMenuItem representing a submenu.
   * This is a convenience API around [Gio.MenuItem.new_] and
   * [Gio.MenuItem.setSubmenu].
   * Params:
   *   label = the section label, or %NULL
   *   submenu = a #GMenuModel with the items of the submenu
   * Returns: a new #GMenuItem
   */
  static MenuItem newSubmenu(string label, MenuModel submenu)
  {
    GMenuItem* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = g_menu_item_new_submenu(_label, submenu ? cast(GMenuModel*)submenu.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!MenuItem(cast(GMenuItem*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Queries the named attribute on menu_item.
   * If expected_type is specified and the attribute does not have this
   * type, %NULL is returned.  %NULL is also returned if the attribute
   * simply does not exist.
   * Params:
   *   attribute = the attribute name to query
   *   expectedType = the expected type of the attribute
   * Returns: the attribute value, or %NULL
   */
  VariantG getAttributeValue(string attribute, VariantType expectedType)
  {
    VariantC* _cretval;
    const(char)* _attribute = attribute.toCString(false);
    _cretval = g_menu_item_get_attribute_value(cast(GMenuItem*)cPtr, _attribute, expectedType ? cast(GVariantType*)expectedType.cPtr(false) : null);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Queries the named link on menu_item.
   * Params:
   *   link = the link name to query
   * Returns: the link, or %NULL
   */
  MenuModel getLink(string link)
  {
    GMenuModel* _cretval;
    const(char)* _link = link.toCString(false);
    _cretval = g_menu_item_get_link(cast(GMenuItem*)cPtr, _link);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets or unsets the "action" and "target" attributes of menu_item.
   * If action is %NULL then both the "action" and "target" attributes
   * are unset $(LPAREN)and target_value is ignored$(RPAREN).
   * If action is non-%NULL then the "action" attribute is set.  The
   * "target" attribute is then set to the value of target_value if it is
   * non-%NULL or unset otherwise.
   * Normal menu items $(LPAREN)ie: not submenu, section or other custom item
   * types$(RPAREN) are expected to have the "action" attribute set to identify
   * the action that they are associated with.  The state type of the
   * action help to determine the disposition of the menu item.  See
   * #GAction and #GActionGroup for an overview of actions.
   * In general, clicking on the menu item will result in activation of
   * the named action with the "target" attribute given as the parameter
   * to the action invocation.  If the "target" attribute is not set then
   * the action is invoked with no parameter.
   * If the action has no state then the menu item is usually drawn as a
   * plain menu item $(LPAREN)ie: with no additional decoration$(RPAREN).
   * If the action has a boolean state then the menu item is usually drawn
   * as a toggle menu item $(LPAREN)ie: with a checkmark or equivalent
   * indication$(RPAREN).  The item should be marked as 'toggled' or 'checked'
   * when the boolean state is %TRUE.
   * If the action has a string state then the menu item is usually drawn
   * as a radio menu item $(LPAREN)ie: with a radio bullet or equivalent
   * indication$(RPAREN).  The item should be marked as 'selected' when the string
   * state is equal to the value of the target property.
   * See [Gio.MenuItem.setActionAndTarget] or
   * [Gio.MenuItem.setDetailedAction] for two equivalent calls that are
   * probably more convenient for most uses.
   * Params:
   *   action = the name of the action for this item
   *   targetValue = a #GVariant to use as the action target
   */
  void setActionAndTargetValue(string action, VariantG targetValue)
  {
    const(char)* _action = action.toCString(false);
    g_menu_item_set_action_and_target_value(cast(GMenuItem*)cPtr, _action, targetValue ? cast(VariantC*)targetValue.cPtr(false) : null);
  }

  /**
   * Sets or unsets an attribute on menu_item.
   * The attribute to set or unset is specified by attribute. This
   * can be one of the standard attribute names %G_MENU_ATTRIBUTE_LABEL,
   * %G_MENU_ATTRIBUTE_ACTION, %G_MENU_ATTRIBUTE_TARGET, or a custom
   * attribute name.
   * Attribute names are restricted to lowercase characters, numbers
   * and '-'. Furthermore, the names must begin with a lowercase character,
   * must not end with a '-', and must not contain consecutive dashes.
   * must consist only of lowercase
   * ASCII characters, digits and '-'.
   * If value is non-%NULL then it is used as the new value for the
   * attribute.  If value is %NULL then the attribute is unset. If
   * the value #GVariant is floating, it is consumed.
   * See also [Gio.MenuItem.setAttribute] for a more convenient way to do
   * the same.
   * Params:
   *   attribute = the attribute to set
   *   value = a #GVariant to use as the value, or %NULL
   */
  void setAttributeValue(string attribute, VariantG value)
  {
    const(char)* _attribute = attribute.toCString(false);
    g_menu_item_set_attribute_value(cast(GMenuItem*)cPtr, _attribute, value ? cast(VariantC*)value.cPtr(false) : null);
  }

  /**
   * Sets the "action" and possibly the "target" attribute of menu_item.
   * The format of detailed_action is the same format parsed by
   * [Gio.Action.parseDetailedName].
   * See [Gio.MenuItem.setActionAndTarget] or
   * [Gio.MenuItem.setActionAndTargetValue] for more flexible $(LPAREN)but
   * slightly less convenient$(RPAREN) alternatives.
   * See also [Gio.MenuItem.setActionAndTargetValue] for a description of
   * the semantics of the action and target attributes.
   * Params:
   *   detailedAction = the "detailed" action string
   */
  void setDetailedAction(string detailedAction)
  {
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_menu_item_set_detailed_action(cast(GMenuItem*)cPtr, _detailedAction);
  }

  /**
   * Sets $(LPAREN)or unsets$(RPAREN) the icon on menu_item.
   * This call is the same as calling [Gio.Icon.serialize] and using the
   * result as the value to [Gio.MenuItem.setAttributeValue] for
   * %G_MENU_ATTRIBUTE_ICON.
   * This API is only intended for use with "noun" menu items; things like
   * bookmarks or applications in an "Open With" menu.  Don't use it on
   * menu items corresponding to verbs $(LPAREN)eg: stock icons for 'Save' or
   * 'Quit'$(RPAREN).
   * If icon is %NULL then the icon is unset.
   * Params:
   *   icon = a #GIcon, or %NULL
   */
  void setIcon(Icon icon)
  {
    g_menu_item_set_icon(cast(GMenuItem*)cPtr, icon ? cast(GIcon*)(cast(ObjectG)icon).cPtr(false) : null);
  }

  /**
   * Sets or unsets the "label" attribute of menu_item.
   * If label is non-%NULL it is used as the label for the menu item.  If
   * it is %NULL then the label attribute is unset.
   * Params:
   *   label = the label to set, or %NULL to unset
   */
  void setLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    g_menu_item_set_label(cast(GMenuItem*)cPtr, _label);
  }

  /**
   * Creates a link from menu_item to model if non-%NULL, or unsets it.
   * Links are used to establish a relationship between a particular menu
   * item and another menu.  For example, %G_MENU_LINK_SUBMENU is used to
   * associate a submenu with a particular menu item, and %G_MENU_LINK_SECTION
   * is used to create a section. Other types of link can be used, but there
   * is no guarantee that clients will be able to make sense of them.
   * Link types are restricted to lowercase characters, numbers
   * and '-'. Furthermore, the names must begin with a lowercase character,
   * must not end with a '-', and must not contain consecutive dashes.
   * Params:
   *   link = type of link to establish or unset
   *   model = the #GMenuModel to link to $(LPAREN)or %NULL to unset$(RPAREN)
   */
  void setLink(string link, MenuModel model)
  {
    const(char)* _link = link.toCString(false);
    g_menu_item_set_link(cast(GMenuItem*)cPtr, _link, model ? cast(GMenuModel*)model.cPtr(false) : null);
  }

  /**
   * Sets or unsets the "section" link of menu_item to section.
   * The effect of having one menu appear as a section of another is
   * exactly as it sounds: the items from section become a direct part of
   * the menu that menu_item is added to.  See [Gio.MenuItem.newSection]
   * for more information about what it means for a menu item to be a
   * section.
   * Params:
   *   section = a #GMenuModel, or %NULL
   */
  void setSection(MenuModel section)
  {
    g_menu_item_set_section(cast(GMenuItem*)cPtr, section ? cast(GMenuModel*)section.cPtr(false) : null);
  }

  /**
   * Sets or unsets the "submenu" link of menu_item to submenu.
   * If submenu is non-%NULL, it is linked to.  If it is %NULL then the
   * link is unset.
   * The effect of having one menu appear as a submenu of another is
   * exactly as it sounds.
   * Params:
   *   submenu = a #GMenuModel, or %NULL
   */
  void setSubmenu(MenuModel submenu)
  {
    g_menu_item_set_submenu(cast(GMenuItem*)cPtr, submenu ? cast(GMenuModel*)submenu.cPtr(false) : null);
  }
}

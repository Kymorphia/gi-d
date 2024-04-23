module Gio.Menu;

import GObject.ObjectG;
import Gid.Gid;
import Gio.MenuItem;
import Gio.MenuModel;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMenu is a simple implementation of #GMenuModel.
 * You populate a #GMenu by adding #GMenuItem instances to it.
 *
 * There are some convenience functions to allow you to directly
 * add items (avoiding #GMenuItem) for the common cases. To add
 * a regular item, use g_menu_insert(). To add a section, use
 * g_menu_insert_section(). To add a submenu, use
 * g_menu_insert_submenu().
 */
class Menu : MenuModel
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_menu_get_type();
  }

  /**
   * a new #GMenu
   */
  this()
  {
    GMenu* _cretval;
    _cretval = g_menu_new();
    this(_cretval, true);
  }

  /**
   * Convenience function for appending a normal menu item to the end of
   * @menu.  Combine g_menu_item_new() and g_menu_insert_item() for a more
   * flexible alternative.
   */
  void append(string label, string detailedAction)
  {
    const(char)* _label = label.toCString(false);
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_menu_append(cPtr!GMenu, _label, _detailedAction);
  }

  /**
   * Appends @item to the end of @menu.
   *
   * See g_menu_insert_item() for more information.
   */
  void appendItem(MenuItem item)
  {
    g_menu_append_item(cPtr!GMenu, item ? item.cPtr!GMenuItem : null);
  }

  /**
   * Convenience function for appending a section menu item to the end of
   * @menu.  Combine g_menu_item_new_section() and g_menu_insert_item() for a
   * more flexible alternative.
   */
  void appendSection(string label, MenuModel section)
  {
    const(char)* _label = label.toCString(false);
    g_menu_append_section(cPtr!GMenu, _label, section ? section.cPtr!GMenuModel : null);
  }

  /**
   * Convenience function for appending a submenu menu item to the end of
   * @menu.  Combine g_menu_item_new_submenu() and g_menu_insert_item() for a
   * more flexible alternative.
   */
  void appendSubmenu(string label, MenuModel submenu)
  {
    const(char)* _label = label.toCString(false);
    g_menu_append_submenu(cPtr!GMenu, _label, submenu ? submenu.cPtr!GMenuModel : null);
  }

  /**
   * Marks @menu as frozen.
   *
   * After the menu is frozen, it is an error to attempt to make any
   * changes to it.  In effect this means that the #GMenu API must no
   * longer be used.
   *
   * This function causes g_menu_model_is_mutable() to begin returning
   * %FALSE, which has some positive performance implications.
   */
  void freeze()
  {
    g_menu_freeze(cPtr!GMenu);
  }

  /**
   * Convenience function for inserting a normal menu item into @menu.
   * Combine g_menu_item_new() and g_menu_insert_item() for a more flexible
   * alternative.
   */
  void insert(int position, string label, string detailedAction)
  {
    const(char)* _label = label.toCString(false);
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_menu_insert(cPtr!GMenu, position, _label, _detailedAction);
  }

  /**
   * Inserts @item into @menu.
   *
   * The "insertion" is actually done by copying all of the attribute and
   * link values of @item and using them to form a new item within @menu.
   * As such, @item itself is not really inserted, but rather, a menu item
   * that is exactly the same as the one presently described by @item.
   *
   * This means that @item is essentially useless after the insertion
   * occurs.  Any changes you make to it are ignored unless it is inserted
   * again (at which point its updated values will be copied).
   *
   * You should probably just free @item once you're done.
   *
   * There are many convenience functions to take care of common cases.
   * See g_menu_insert(), g_menu_insert_section() and
   * g_menu_insert_submenu() as well as "prepend" and "append" variants of
   * each of these functions.
   */
  void insertItem(int position, MenuItem item)
  {
    g_menu_insert_item(cPtr!GMenu, position, item ? item.cPtr!GMenuItem : null);
  }

  /**
   * Convenience function for inserting a section menu item into @menu.
   * Combine g_menu_item_new_section() and g_menu_insert_item() for a more
   * flexible alternative.
   */
  void insertSection(int position, string label, MenuModel section)
  {
    const(char)* _label = label.toCString(false);
    g_menu_insert_section(cPtr!GMenu, position, _label, section ? section.cPtr!GMenuModel : null);
  }

  /**
   * Convenience function for inserting a submenu menu item into @menu.
   * Combine g_menu_item_new_submenu() and g_menu_insert_item() for a more
   * flexible alternative.
   */
  void insertSubmenu(int position, string label, MenuModel submenu)
  {
    const(char)* _label = label.toCString(false);
    g_menu_insert_submenu(cPtr!GMenu, position, _label, submenu ? submenu.cPtr!GMenuModel : null);
  }

  /**
   * Convenience function for prepending a normal menu item to the start
   * of @menu.  Combine g_menu_item_new() and g_menu_insert_item() for a more
   * flexible alternative.
   */
  void prepend(string label, string detailedAction)
  {
    const(char)* _label = label.toCString(false);
    const(char)* _detailedAction = detailedAction.toCString(false);
    g_menu_prepend(cPtr!GMenu, _label, _detailedAction);
  }

  /**
   * Prepends @item to the start of @menu.
   *
   * See g_menu_insert_item() for more information.
   */
  void prependItem(MenuItem item)
  {
    g_menu_prepend_item(cPtr!GMenu, item ? item.cPtr!GMenuItem : null);
  }

  /**
   * Convenience function for prepending a section menu item to the start
   * of @menu.  Combine g_menu_item_new_section() and g_menu_insert_item() for
   * a more flexible alternative.
   */
  void prependSection(string label, MenuModel section)
  {
    const(char)* _label = label.toCString(false);
    g_menu_prepend_section(cPtr!GMenu, _label, section ? section.cPtr!GMenuModel : null);
  }

  /**
   * Convenience function for prepending a submenu menu item to the start
   * of @menu.  Combine g_menu_item_new_submenu() and g_menu_insert_item() for
   * a more flexible alternative.
   */
  void prependSubmenu(string label, MenuModel submenu)
  {
    const(char)* _label = label.toCString(false);
    g_menu_prepend_submenu(cPtr!GMenu, _label, submenu ? submenu.cPtr!GMenuModel : null);
  }

  /**
   * Removes an item from the menu.
   *
   * @position gives the index of the item to remove.
   *
   * It is an error if position is not in range the range from 0 to one
   * less than the number of items in the menu.
   *
   * It is not possible to remove items by identity since items are added
   * to the menu simply by copying their links and attributes (ie:
   * identity of the item itself is not preserved).
   */
  void remove(int position)
  {
    g_menu_remove(cPtr!GMenu, position);
  }

  /**
   * Removes all items in the menu.
   */
  void removeAll()
  {
    g_menu_remove_all(cPtr!GMenu);
  }
}

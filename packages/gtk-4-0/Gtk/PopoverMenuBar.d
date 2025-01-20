module Gtk.PopoverMenuBar;

import GObject.ObjectG;
import Gid.gid;
import Gio.MenuModel;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkPopoverMenuBar` presents a horizontal bar of items that pop
 * up popover menus when clicked.
 * ![An example GtkPopoverMenuBar](menubar.png)
 * The only way to create instances of `GtkPopoverMenuBar` is
 * from a `GMenuModel`.
 * # CSS nodes
 * ```
 * menubar
 * ├── item[.active]
 * ┊   ╰── popover
 * ╰── item
 * ╰── popover
 * ```
 * `GtkPopoverMenuBar` has a single CSS node with name menubar, below which
 * each item has its CSS node, and below that the corresponding popover.
 * The item whose popover is currently open gets the .active
 * style class.
 * # Accessibility
 * `GtkPopoverMenuBar` uses the %GTK_ACCESSIBLE_ROLE_MENU_BAR role,
 * the menu items use the %GTK_ACCESSIBLE_ROLE_MENU_ITEM role and
 * the menus use the %GTK_ACCESSIBLE_ROLE_MENU role.
 */
class PopoverMenuBar : Widget
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
    return gtk_popover_menu_bar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkPopoverMenuBar` from a `GMenuModel`.
   * Params:
   *   model = a `GMenuModel`
   * Returns: a new `GtkPopoverMenuBar`
   */
  static PopoverMenuBar newFromModel(MenuModel model)
  {
    GtkWidget* _cretval;
    _cretval = gtk_popover_menu_bar_new_from_model(model ? cast(GMenuModel*)model.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!PopoverMenuBar(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a custom widget to a generated menubar.
   * For this to work, the menu model of bar must have an
   * item with a `custom` attribute that matches id.
   * Params:
   *   child = the `GtkWidget` to add
   *   id = the ID to insert child at
   * Returns: %TRUE if id was found and the widget added
   */
  bool addChild(Widget child, string id)
  {
    bool _retval;
    const(char)* _id = id.toCString(false);
    _retval = gtk_popover_menu_bar_add_child(cast(GtkPopoverMenuBar*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, _id);
    return _retval;
  }

  /**
   * Returns the model from which the contents of bar are taken.
   * Returns: a `GMenuModel`
   */
  MenuModel getMenuModel()
  {
    GMenuModel* _cretval;
    _cretval = gtk_popover_menu_bar_get_menu_model(cast(GtkPopoverMenuBar*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Removes a widget that has previously been added with
   * [Gtk.PopoverMenuBar.addChild].
   * Params:
   *   child = the `GtkWidget` to remove
   * Returns: %TRUE if the widget was removed
   */
  bool removeChild(Widget child)
  {
    bool _retval;
    _retval = gtk_popover_menu_bar_remove_child(cast(GtkPopoverMenuBar*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    return _retval;
  }

  /**
   * Sets a menu model from which bar should take
   * its contents.
   * Params:
   *   model = a `GMenuModel`
   */
  void setMenuModel(MenuModel model)
  {
    gtk_popover_menu_bar_set_menu_model(cast(GtkPopoverMenuBar*)cPtr, model ? cast(GMenuModel*)model.cPtr(false) : null);
  }
}

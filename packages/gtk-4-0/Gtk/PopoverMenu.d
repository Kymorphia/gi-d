module Gtk.PopoverMenu;

import GObject.ObjectG;
import Gid.gid;
import Gio.MenuModel;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Popover;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkPopoverMenu` is a subclass of `GtkPopover` that implements menu
 * behavior.
 * ![An example GtkPopoverMenu](menu.png)
 * `GtkPopoverMenu` treats its children like menus and allows switching
 * between them. It can open submenus as traditional, nested submenus,
 * or in a more touch-friendly sliding fashion.
 * The property [Gtk.PopoverMenu.flags] controls this appearance.
 * `GtkPopoverMenu` is meant to be used primarily with menu models,
 * using [Gtk.PopoverMenu.newFromModel]. If you need to put
 * other widgets such as a `GtkSpinButton` or a `GtkSwitch` into a popover,
 * you can use [Gtk.PopoverMenu.addChild].
 * For more dialog-like behavior, use a plain `GtkPopover`.
 * ## Menu models
 * The XML format understood by `GtkBuilder` for `GMenuModel` consists
 * of a toplevel `<menu>` element, which contains one or more `<item>`
 * elements. Each `<item>` element contains `<attribute>` and `<link>`
 * elements with a mandatory name attribute. `<link>` elements have the
 * same content model as `<menu>`. Instead of `<link name\="submenu">`
 * or `<link name\="section">`, you can use `<submenu>` or `<section>`
 * elements.
 * ```xml
 * <menu id\='app-menu'>
 * <section>
 * <item>
 * <attribute name\='label' translatable\='yes'>_New Window</attribute>
 * <attribute name\='action'>app.new</attribute>
 * </item>
 * <item>
 * <attribute name\='label' translatable\='yes'>_About Sunny</attribute>
 * <attribute name\='action'>app.about</attribute>
 * </item>
 * <item>
 * <attribute name\='label' translatable\='yes'>_Quit</attribute>
 * <attribute name\='action'>app.quit</attribute>
 * </item>
 * </section>
 * </menu>
 * ```
 * Attribute values can be translated using gettext, like other `GtkBuilder`
 * content. `<attribute>` elements can be marked for translation with a
 * `translatable\="yes"` attribute. It is also possible to specify message
 * context and translator comments, using the context and comments attributes.
 * To make use of this, the `GtkBuilder` must have been given the gettext
 * domain to use.
 * The following attributes are used when constructing menu items:
 * - "label": a user-visible string to display
 * - "use-markup": whether the text in the menu item includes [Pango markup](https://docs.gtk.org/Pango/pango_markup.html)
 * - "action": the prefixed name of the action to trigger
 * - "target": the parameter to use when activating the action
 * - "icon" and "verb-icon": names of icons that may be displayed
 * - "submenu-action": name of an action that may be used to track
 * whether a submenu is open
 * - "hidden-when": a string used to determine when the item will be hidden.
 * Possible values include "action-disabled", "action-missing", "macos-menubar".
 * This is mainly useful for exported menus, see [Gtk.Application.setMenubar].
 * - "custom": a string used to match against the ID of a custom child added with
 * [Gtk.PopoverMenu.addChild], [Gtk.PopoverMenuBar.addChild],
 * or in the ui file with `<child type\="ID">`.
 * The following attributes are used when constructing sections:
 * - "label": a user-visible string to use as section heading
 * - "display-hint": a string used to determine special formatting for the section.
 * Possible values include "horizontal-buttons", "circular-buttons" and
 * "inline-buttons". They all indicate that section should be
 * displayed as a horizontal row of buttons.
 * - "text-direction": a string used to determine the `GtkTextDirection` to use
 * when "display-hint" is set to "horizontal-buttons". Possible values
 * include "rtl", "ltr", and "none".
 * The following attributes are used when constructing submenus:
 * - "label": a user-visible string to display
 * - "icon": icon name to display
 * Menu items will also show accelerators, which are usually associated
 * with actions via [Gtk.Application.setAccelsForAction],
 * [Gtk.WidgetClass.addBindingAction] or
 * [Gtk.ShortcutController.addShortcut].
 * # CSS Nodes
 * `GtkPopoverMenu` is just a subclass of `GtkPopover` that adds custom content
 * to it, therefore it has the same CSS nodes. It is one of the cases that add
 * a `.menu` style class to the main `popover` node.
 * Menu items have nodes with name `button` and class `.model`. If a section
 * display-hint is set, the section gets a node `box` with class `horizontal`
 * plus a class with the same text as the display hint. Note that said box may
 * not be the direct ancestor of the item `button`s. Thus, for example, to style
 * items in an `inline-buttons` section, select `.inline-buttons button.model`.
 * Other things that may be of interest to style in menus include `label` nodes.
 * # Accessibility
 * `GtkPopoverMenu` uses the %GTK_ACCESSIBLE_ROLE_MENU role, and its
 * items use the %GTK_ACCESSIBLE_ROLE_MENU_ITEM,
 * %GTK_ACCESSIBLE_ROLE_MENU_ITEM_CHECKBOX or
 * %GTK_ACCESSIBLE_ROLE_MENU_ITEM_RADIO roles, depending on the
 * action they are connected to.
 */
class PopoverMenu : Popover
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
    return gtk_popover_menu_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkPopoverMenu` and populates it according to model.
   * The created buttons are connected to actions found in the
   * `GtkApplicationWindow` to which the popover belongs - typically
   * by means of being attached to a widget that is contained within
   * the `GtkApplicationWindow`s widget hierarchy.
   * Actions can also be added using [Gtk.Widget.insertActionGroup]
   * on the menus attach widget or on any of its parent widgets.
   * This function creates menus with sliding submenus.
   * See [Gtk.PopoverMenu.newFromModelFull] for a way
   * to control this.
   * Params:
   *   model = a `GMenuModel`
   * Returns: the new `GtkPopoverMenu`
   */
  static PopoverMenu newFromModel(MenuModel model)
  {
    GtkWidget* _cretval;
    _cretval = gtk_popover_menu_new_from_model(model ? cast(GMenuModel*)model.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!PopoverMenu(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a `GtkPopoverMenu` and populates it according to model.
   * The created buttons are connected to actions found in the
   * action groups that are accessible from the parent widget.
   * This includes the `GtkApplicationWindow` to which the popover
   * belongs. Actions can also be added using [Gtk.Widget.insertActionGroup]
   * on the parent widget or on any of its parent widgets.
   * Params:
   *   model = a `GMenuModel`
   *   flags = flags that affect how the menu is created
   * Returns: the new `GtkPopoverMenu`
   */
  static PopoverMenu newFromModelFull(MenuModel model, PopoverMenuFlags flags)
  {
    GtkWidget* _cretval;
    _cretval = gtk_popover_menu_new_from_model_full(model ? cast(GMenuModel*)model.cPtr(false) : null, flags);
    auto _retval = _cretval ? ObjectG.getDObject!PopoverMenu(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a custom widget to a generated menu.
   * For this to work, the menu model of popover must have
   * an item with a `custom` attribute that matches id.
   * Params:
   *   child = the `GtkWidget` to add
   *   id = the ID to insert child at
   * Returns: %TRUE if id was found and the widget added
   */
  bool addChild(Widget child, string id)
  {
    bool _retval;
    const(char)* _id = id.toCString(false);
    _retval = gtk_popover_menu_add_child(cast(GtkPopoverMenu*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, _id);
    return _retval;
  }

  /**
   * Returns the flags that popover uses to create/display a menu from its model.
   * Returns: the `GtkPopoverMenuFlags`
   */
  PopoverMenuFlags getFlags()
  {
    GtkPopoverMenuFlags _cretval;
    _cretval = gtk_popover_menu_get_flags(cast(GtkPopoverMenu*)cPtr);
    PopoverMenuFlags _retval = cast(PopoverMenuFlags)_cretval;
    return _retval;
  }

  /**
   * Returns the menu model used to populate the popover.
   * Returns: the menu model of popover
   */
  MenuModel getMenuModel()
  {
    GMenuModel* _cretval;
    _cretval = gtk_popover_menu_get_menu_model(cast(GtkPopoverMenu*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Removes a widget that has previously been added with
   * [Gtk.PopoverMenu.addChild]
   * Params:
   *   child = the `GtkWidget` to remove
   * Returns: %TRUE if the widget was removed
   */
  bool removeChild(Widget child)
  {
    bool _retval;
    _retval = gtk_popover_menu_remove_child(cast(GtkPopoverMenu*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
    return _retval;
  }

  /**
   * Sets the flags that popover uses to create/display a menu from its model.
   * If a model is set and the flags change, contents are rebuilt, so if setting
   * properties individually, set flags before model to avoid a redundant rebuild.
   * Params:
   *   flags = a set of `GtkPopoverMenuFlags`
   */
  void setFlags(PopoverMenuFlags flags)
  {
    gtk_popover_menu_set_flags(cast(GtkPopoverMenu*)cPtr, flags);
  }

  /**
   * Sets a new menu model on popover.
   * The existing contents of popover are removed, and
   * the popover is populated with new contents according
   * to model.
   * Params:
   *   model = a `GMenuModel`
   */
  void setMenuModel(MenuModel model)
  {
    gtk_popover_menu_set_menu_model(cast(GtkPopoverMenu*)cPtr, model ? cast(GMenuModel*)model.cPtr(false) : null);
  }
}

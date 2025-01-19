module Gtk.MenuButton;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.MenuModel;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Popover;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkMenuButton` widget is used to display a popup when clicked.
 * ![An example GtkMenuButton](menu-button.png)
 * This popup can be provided either as a `GtkPopover` or as an abstract
 * `GMenuModel`.
 * The `GtkMenuButton` widget can show either an icon $(LPAREN)set with the
 * property@Gtk.MenuButton:icon-name property$(RPAREN) or a label $(LPAREN)set with the
 * [Gtk.MenuButton.label] property$(RPAREN). If neither is explicitly set,
 * a [Gtk.Image] is automatically created, using an arrow image oriented
 * according to [Gtk.MenuButton.direction] or the generic
 * “open-menu-symbolic” icon if the direction is not set.
 * The positioning of the popup is determined by the
 * [Gtk.MenuButton.direction] property of the menu button.
 * For menus, the [Gtk.Widget.halign] and [Gtk.Widget.valign]
 * properties of the menu are also taken into account. For example, when the
 * direction is %GTK_ARROW_DOWN and the horizontal alignment is %GTK_ALIGN_START,
 * the menu will be positioned below the button, with the starting edge
 * $(LPAREN)depending on the text direction$(RPAREN) of the menu aligned with the starting
 * edge of the button. If there is not enough space below the button, the
 * menu is popped up above the button instead. If the alignment would move
 * part of the menu offscreen, it is “pushed in”.
 * |           | start                | center                | end                |
 * | -         | ---                  | ---                   | ---                |
 * | **down**  | ![](down-start.png)  | ![](down-center.png)  | ![](down-end.png)  |
 * | **up**    | ![](up-start.png)    | ![](up-center.png)    | ![](up-end.png)    |
 * | **left**  | ![](left-start.png)  | ![](left-center.png)  | ![](left-end.png)  |
 * | **right** | ![](right-start.png) | ![](right-center.png) | ![](right-end.png) |
 * # CSS nodes
 * ```
 * menubutton
 * ╰── button.toggle
 * ╰── <content>
 * ╰── [arrow]
 * ```
 * `GtkMenuButton` has a single CSS node with name `menubutton`
 * which contains a `button` node with a `.toggle` style class.
 * If the button contains an icon, it will have the `.image-button` style class,
 * if it contains text, it will have `.text-button` style class. If an arrow is
 * visible in addition to an icon, text or a custom child, it will also have
 * `.arrow-button` style class.
 * Inside the toggle button content, there is an `arrow` node for
 * the indicator, which will carry one of the `.none`, `.up`, `.down`,
 * `.left` or `.right` style classes to indicate the direction that
 * the menu will appear in. The CSS is expected to provide a suitable
 * image for each of these cases using the `-gtk-icon-source` property.
 * Optionally, the `menubutton` node can carry the `.circular` style class
 * to request a round appearance.
 * # Accessibility
 * `GtkMenuButton` uses the %GTK_ACCESSIBLE_ROLE_BUTTON role.
 */
class MenuButton : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_menu_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
  // Add base class alias for getDirection since it is used in GtkWidget and defined in MenuButton class
  alias getDirection = Widget.getDirection;


  /**
   * Creates a new `GtkMenuButton` widget with downwards-pointing
   * arrow as the only child.
   * You can replace the child widget with another `GtkWidget`
   * should you wish to.
   * Returns: The newly created `GtkMenuButton`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_menu_button_new();
    this(_cretval, false);
  }

  /**
   * Returns whether the menu button is active.
   * Returns: TRUE if the button is active
   */
  bool getActive()
  {
    bool _retval;
    _retval = gtk_menu_button_get_active(cast(GtkMenuButton*)cPtr);
    return _retval;
  }

  /**
   * Gets whether to show a dropdown arrow even when using an icon or a custom
   * child.
   * Returns: whether to show a dropdown arrow even when using an icon or a custom
   *   child.
   */
  bool getAlwaysShowArrow()
  {
    bool _retval;
    _retval = gtk_menu_button_get_always_show_arrow(cast(GtkMenuButton*)cPtr);
    return _retval;
  }

  /**
   * Retrieves whether the button can be smaller than the natural
   * size of its contents.
   * Returns: true if the button can shrink, and false otherwise
   */
  bool getCanShrink()
  {
    bool _retval;
    _retval = gtk_menu_button_get_can_shrink(cast(GtkMenuButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the child widget of menu_button.
   * Returns: the child widget of menu_button
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_menu_button_get_child(cast(GtkMenuButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the direction the popup will be pointing at when popped up.
   * Returns: a `GtkArrowType` value
   */
  ArrowType getDirection()
  {
    GtkArrowType _cretval;
    _cretval = gtk_menu_button_get_direction(cast(GtkMenuButton*)cPtr);
    ArrowType _retval = cast(ArrowType)_cretval;
    return _retval;
  }

  /**
   * Returns whether the button has a frame.
   * Returns: %TRUE if the button has a frame
   */
  bool getHasFrame()
  {
    bool _retval;
    _retval = gtk_menu_button_get_has_frame(cast(GtkMenuButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the name of the icon shown in the button.
   * Returns: the name of the icon shown in the button
   */
  string getIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_menu_button_get_icon_name(cast(GtkMenuButton*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the label shown in the button
   * Returns: the label shown in the button
   */
  string getLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_menu_button_get_label(cast(GtkMenuButton*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the `GMenuModel` used to generate the popup.
   * Returns: a `GMenuModel`
   */
  MenuModel getMenuModel()
  {
    GMenuModel* _cretval;
    _cretval = gtk_menu_button_get_menu_model(cast(GtkMenuButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `GtkPopover` that pops out of the button.
   * If the button is not using a `GtkPopover`, this function
   * returns %NULL.
   * Returns: a `GtkPopover` or %NULL
   */
  Popover getPopover()
  {
    GtkPopover* _cretval;
    _cretval = gtk_menu_button_get_popover(cast(GtkMenuButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Popover(cast(GtkPopover*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the menu button acts as a primary menu.
   * Returns: %TRUE if the button is a primary menu
   */
  bool getPrimary()
  {
    bool _retval;
    _retval = gtk_menu_button_get_primary(cast(GtkMenuButton*)cPtr);
    return _retval;
  }

  /**
   * Returns whether an embedded underline in the text indicates a
   * mnemonic.
   * Returns: %TRUE whether an embedded underline in the text indicates
   *   the mnemonic accelerator keys.
   */
  bool getUseUnderline()
  {
    bool _retval;
    _retval = gtk_menu_button_get_use_underline(cast(GtkMenuButton*)cPtr);
    return _retval;
  }

  /**
   * Dismiss the menu.
   */
  void popdown()
  {
    gtk_menu_button_popdown(cast(GtkMenuButton*)cPtr);
  }

  /**
   * Pop up the menu.
   */
  void popup()
  {
    gtk_menu_button_popup(cast(GtkMenuButton*)cPtr);
  }

  /**
   * Sets whether the menu button is active.
   * Params:
   *   active = whether the menu button is active
   */
  void setActive(bool active)
  {
    gtk_menu_button_set_active(cast(GtkMenuButton*)cPtr, active);
  }

  /**
   * Sets whether to show a dropdown arrow even when using an icon or a custom
   * child.
   * Params:
   *   alwaysShowArrow = whether to show a dropdown arrow even when using an icon
   *     or a custom child
   */
  void setAlwaysShowArrow(bool alwaysShowArrow)
  {
    gtk_menu_button_set_always_show_arrow(cast(GtkMenuButton*)cPtr, alwaysShowArrow);
  }

  /**
   * Sets whether the button size can be smaller than the natural size of
   * its contents.
   * For text buttons, setting can_shrink to true will ellipsize the label.
   * For icon buttons, this function has no effect.
   * Params:
   *   canShrink = whether the button can shrink
   */
  void setCanShrink(bool canShrink)
  {
    gtk_menu_button_set_can_shrink(cast(GtkMenuButton*)cPtr, canShrink);
  }

  /**
   * Sets the child widget of menu_button.
   * Setting a child resets [Gtk.MenuButton.label] and
   * propertyGtk.MenuButton:icon-name.
   * If propertyGtk.MenuButton:always-show-arrow is set to `TRUE` and
   * [Gtk.MenuButton.direction] is not `GTK_ARROW_NONE`, a dropdown arrow
   * will be shown next to the child.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_menu_button_set_child(cast(GtkMenuButton*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets func to be called when a popup is about to be shown.
   * func should use one of
   * - [Gtk.MenuButton.setPopover]
   * - [Gtk.MenuButton.setMenuModel]
   * to set a popup for menu_button.
   * If func is non-%NULL, menu_button will always be sensitive.
   * Using this function will not reset the menu widget attached to
   * menu_button. Instead, this can be done manually in func.
   * Params:
   *   func = function to call when a popup is about to
   *     be shown, but none has been provided via other means, or %NULL
   *     to reset to default behavior.
   */
  void setCreatePopupFunc(MenuButtonCreatePopupFunc func)
  {
    extern(C) void _funcCallback(GtkMenuButton* menuButton, void* userData)
    {
      auto _dlg = cast(MenuButtonCreatePopupFunc*)userData;

      (*_dlg)(menuButton ? ObjectG.getDObject!MenuButton(cast(void*)menuButton, false) : null);
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_menu_button_set_create_popup_func(cast(GtkMenuButton*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Sets the direction in which the popup will be popped up.
   * If the button is automatically populated with an arrow icon,
   * its direction will be changed to match.
   * If the does not fit in the available space in the given direction,
   * GTK will its best to keep it inside the screen and fully visible.
   * If you pass %GTK_ARROW_NONE for a direction, the popup will behave
   * as if you passed %GTK_ARROW_DOWN $(LPAREN)although you won’t see any arrows$(RPAREN).
   * Params:
   *   direction = a `GtkArrowType`
   */
  void setDirection(ArrowType direction)
  {
    gtk_menu_button_set_direction(cast(GtkMenuButton*)cPtr, direction);
  }

  /**
   * Sets the style of the button.
   * Params:
   *   hasFrame = whether the button should have a visible frame
   */
  void setHasFrame(bool hasFrame)
  {
    gtk_menu_button_set_has_frame(cast(GtkMenuButton*)cPtr, hasFrame);
  }

  /**
   * Sets the name of an icon to show inside the menu button.
   * Setting icon name resets [Gtk.MenuButton.label] and
   * [Gtk.MenuButton.child].
   * If propertyGtk.MenuButton:always-show-arrow is set to `TRUE` and
   * [Gtk.MenuButton.direction] is not `GTK_ARROW_NONE`, a dropdown arrow
   * will be shown next to the icon.
   * Params:
   *   iconName = the icon name
   */
  void setIconName(string iconName)
  {
    const(char)* _iconName = iconName.toCString(false);
    gtk_menu_button_set_icon_name(cast(GtkMenuButton*)cPtr, _iconName);
  }

  /**
   * Sets the label to show inside the menu button.
   * Setting a label resets propertyGtk.MenuButton:icon-name and
   * [Gtk.MenuButton.child].
   * If [Gtk.MenuButton.direction] is not `GTK_ARROW_NONE`, a dropdown
   * arrow will be shown next to the label.
   * Params:
   *   label = the label
   */
  void setLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    gtk_menu_button_set_label(cast(GtkMenuButton*)cPtr, _label);
  }

  /**
   * Sets the `GMenuModel` from which the popup will be constructed.
   * If menu_model is %NULL, the button is disabled.
   * A [Gtk.Popover] will be created from the menu model with
   * [Gtk.PopoverMenu.newFromModel]. Actions will be connected
   * as documented for this function.
   * If [Gtk.MenuButton.popover] is already set, it will be
   * dissociated from the menu_button, and the property is set to %NULL.
   * Params:
   *   menuModel = a `GMenuModel`, or %NULL to unset and disable the
   *     button
   */
  void setMenuModel(MenuModel menuModel)
  {
    gtk_menu_button_set_menu_model(cast(GtkMenuButton*)cPtr, menuModel ? cast(GMenuModel*)menuModel.cPtr(false) : null);
  }

  /**
   * Sets the `GtkPopover` that will be popped up when the menu_button is clicked.
   * If popover is %NULL, the button is disabled.
   * If propertyGtk.MenuButton:menu-model is set, the menu model is dissociated
   * from the menu_button, and the property is set to %NULL.
   * Params:
   *   popover = a `GtkPopover`, or %NULL to unset and disable the button
   */
  void setPopover(Widget popover)
  {
    gtk_menu_button_set_popover(cast(GtkMenuButton*)cPtr, popover ? cast(GtkWidget*)popover.cPtr(false) : null);
  }

  /**
   * Sets whether menu button acts as a primary menu.
   * Primary menus can be opened with the <kbd>F10</kbd> key.
   * Params:
   *   primary = whether the menubutton should act as a primary menu
   */
  void setPrimary(bool primary)
  {
    gtk_menu_button_set_primary(cast(GtkMenuButton*)cPtr, primary);
  }

  /**
   * If true, an underline in the text indicates a mnemonic.
   * Params:
   *   useUnderline = %TRUE if underlines in the text indicate mnemonics
   */
  void setUseUnderline(bool useUnderline)
  {
    gtk_menu_button_set_use_underline(cast(GtkMenuButton*)cPtr, useUnderline);
  }

  /**
   * Emitted to when the menu button is activated.
   * The `::activate` signal on `GtkMenuButton` is an action signal and
   * emitting it causes the button to pop up its menu.
   *   menuButton = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(MenuButton menuButton);

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
      auto menuButton = getVal!MenuButton(_paramVals);
      _dgClosure.dlg(menuButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }
}

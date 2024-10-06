module Gtk.ApplicationWindow;

import GObject.ObjectG;
import Gid.gid;
import Gio.ActionGroup;
import Gio.ActionGroupT;
import Gio.ActionMap;
import Gio.ActionMapT;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Application;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Root;
import Gtk.RootT;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.ShortcutsWindow;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkApplicationWindow` is a `GtkWindow` subclass that integrates with
 * `GtkApplication`.
 * Notably, `GtkApplicationWindow` can handle an application menubar.
 * This class implements the `GActionGroup` and `GActionMap` interfaces,
 * to let you add window-specific actions that will be exported by the
 * associated [Gtk.Application], together with its application-wide
 * actions. Window-specific actions are prefixed with the “win.”
 * prefix and application-wide actions are prefixed with the “app.”
 * prefix. Actions must be addressed with the prefixed name when
 * referring to them from a `GMenuModel`.
 * Note that widgets that are placed inside a `GtkApplicationWindow`
 * can also activate these actions, if they implement the
 * [Gtk.Actionable] interface.
 * The settings property@Gtk.Settings:gtk-shell-shows-app-menu and
 * property@Gtk.Settings:gtk-shell-shows-menubar tell GTK whether the
 * desktop environment is showing the application menu and menubar
 * models outside the application as part of the desktop shell.
 * For instance, on OS X, both menus will be displayed remotely;
 * on Windows neither will be.
 * If the desktop environment does not display the menubar, then
 * `GtkApplicationWindow` will automatically show a menubar for it.
 * This behaviour can be overridden with the
 * property@Gtk.ApplicationWindow:show-menubar property. If the
 * desktop environment does not display the application menu, then
 * it will automatically be included in the menubar or in the windows
 * client-side decorations.
 * See [Gtk.PopoverMenu] for information about the XML language
 * used by `GtkBuilder` for menu models.
 * See also: [Gtk.Application.setMenubar].
 * ## A GtkApplicationWindow with a menubar
 * The code sample below shows how to set up a `GtkApplicationWindow`
 * with a menu bar defined on the [Gtk.Application]:
 * ```c
 * GtkApplication *app \= gtk_application_new $(LPAREN)"org.gtk.test", 0$(RPAREN);
 * GtkBuilder *builder \= gtk_builder_new_from_string $(LPAREN)
 * "<interface>"
 * "  <menu id\='menubar'>"
 * "    <submenu>"
 * "      <attribute name\='label' translatable\='yes'>_Edit</attribute>"
 * "      <item>"
 * "        <attribute name\='label' translatable\='yes'>_Copy</attribute>"
 * "        <attribute name\='action'>win.copy</attribute>"
 * "      </item>"
 * "      <item>"
 * "        <attribute name\='label' translatable\='yes'>_Paste</attribute>"
 * "        <attribute name\='action'>win.paste</attribute>"
 * "      </item>"
 * "    </submenu>"
 * "  </menu>"
 * "</interface>",
 * -1$(RPAREN);
 * GMenuModel *menubar \= G_MENU_MODEL $(LPAREN)gtk_builder_get_object $(LPAREN)builder, "menubar"$(RPAREN)$(RPAREN);
 * gtk_application_set_menubar $(LPAREN)GTK_APPLICATION $(LPAREN)app$(RPAREN), menubar$(RPAREN);
 * g_object_unref $(LPAREN)builder$(RPAREN);
 * // ...
 * GtkWidget *window \= gtk_application_window_new $(LPAREN)app$(RPAREN);
 * ```
 */
class ApplicationWindow : Window, ActionGroup, ActionMap
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
    return gtk_application_window_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionGroupT!GtkApplicationWindow;
  mixin ActionMapT!GtkApplicationWindow;
  // Add base class alias for activateAction since it is used in GtkWidget and Gio.ActionGroup interface
  alias activateAction = Widget.activateAction;


  /**
   * Creates a new `GtkApplicationWindow`.
   * Params:
   *   application = a `GtkApplication`
   * Returns: a newly created `GtkApplicationWindow`
   */
  this(Application application)
  {
    GtkWidget* _cretval;
    _cretval = gtk_application_window_new(application ? cast(GtkApplication*)application.cPtr(false) : null);
    this(_cretval, false);
  }

  /**
   * Gets the `GtkShortcutsWindow` that is associated with window.
   * See [Gtk.ApplicationWindow.setHelpOverlay].
   * Returns: the help overlay associated
   *   with window
   */
  ShortcutsWindow getHelpOverlay()
  {
    GtkShortcutsWindow* _cretval;
    _cretval = gtk_application_window_get_help_overlay(cast(GtkApplicationWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutsWindow(cast(GtkShortcutsWindow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the unique ID of the window.
   * If the window has not yet been added to a `GtkApplication`, returns `0`.
   * Returns: the unique ID for window, or `0` if the window
   *   has not yet been added to a `GtkApplication`
   */
  uint getId()
  {
    uint _retval;
    _retval = gtk_application_window_get_id(cast(GtkApplicationWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the window will display a menubar for the app menu
   * and menubar as needed.
   * Returns: %TRUE if window will display a menubar when needed
   */
  bool getShowMenubar()
  {
    bool _retval;
    _retval = gtk_application_window_get_show_menubar(cast(GtkApplicationWindow*)cPtr);
    return _retval;
  }

  /**
   * Associates a shortcuts window with the application window.
   * Additionally, sets up an action with the name
   * `win.show-help-overlay` to present it.
   * window takes responsibility for destroying help_overlay.
   * Params:
   *   helpOverlay = a `GtkShortcutsWindow`
   */
  void setHelpOverlay(ShortcutsWindow helpOverlay)
  {
    gtk_application_window_set_help_overlay(cast(GtkApplicationWindow*)cPtr, helpOverlay ? cast(GtkShortcutsWindow*)helpOverlay.cPtr(false) : null);
  }

  /**
   * Sets whether the window will display a menubar for the app menu
   * and menubar as needed.
   * Params:
   *   showMenubar = whether to show a menubar when needed
   */
  void setShowMenubar(bool showMenubar)
  {
    gtk_application_window_set_show_menubar(cast(GtkApplicationWindow*)cPtr, showMenubar);
  }
}

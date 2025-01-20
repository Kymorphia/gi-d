module Gtk.Window;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gdk.Display;
import Gdk.MonitorG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
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
import Gtk.Types;
import Gtk.Widget;
import Gtk.WindowGroup;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkWindow` is a toplevel window which can contain other widgets.
 * ![An example GtkWindow](window.png)
 * Windows normally have decorations that are under the control
 * of the windowing system and allow the user to manipulate the window
 * $(LPAREN)resize it, move it, close it,...$(RPAREN).
 * # GtkWindow as GtkBuildable
 * The `GtkWindow` implementation of the [Gtk.Buildable] interface supports
 * setting a child as the titlebar by specifying “titlebar” as the “type”
 * attribute of a `<child>` element.
 * # CSS nodes
 * ```
 * window.background [.csd / .solid-csd / .ssd] [.maximized / .fullscreen / .tiled]
 * ├── <child>
 * ╰── <titlebar child>.titlebar [.default-decoration]
 * ```
 * `GtkWindow` has a main CSS node with name window and style class .background.
 * Style classes that are typically used with the main CSS node are .csd $(LPAREN)when
 * client-side decorations are in use$(RPAREN), .solid-csd $(LPAREN)for client-side decorations
 * without invisible borders$(RPAREN), .ssd $(LPAREN)used by mutter when rendering server-side
 * decorations$(RPAREN). GtkWindow also represents window states with the following
 * style classes on the main node: .maximized, .fullscreen, .tiled $(LPAREN)when supported,
 * also .tiled-top, .tiled-left, .tiled-right, .tiled-bottom$(RPAREN).
 * `GtkWindow` subclasses often add their own discriminating style classes,
 * such as .dialog, .popup or .tooltip.
 * Generally, some CSS properties don't make sense on the toplevel window node,
 * such as margins or padding. When client-side decorations without invisible
 * borders are in use $(LPAREN)i.e. the .solid-csd style class is added to the
 * main window node$(RPAREN), the CSS border of the toplevel window is used for
 * resize drags. In the .csd case, the shadow area outside of the window
 * can be used to resize it.
 * `GtkWindow` adds the .titlebar and .default-decoration style classes to the
 * widget that is added as a titlebar child.
 * # Accessibility
 * Until GTK 4.10, `GtkWindow` used the `GTK_ACCESSIBLE_ROLE_WINDOW` role.
 * Since GTK 4.12, `GtkWindow` uses the `GTK_ACCESSIBLE_ROLE_APPLICATION` role.
 * # Actions
 * `GtkWindow` defines a set of built-in actions:
 * - `default.activate`: Activate the default widget.
 * - `window.minimize`: Minimize the window.
 * - `window.toggle-maximized`: Maximize or restore the window.
 * - `window.close`: Close the window.
 */
class Window : Widget, Native, Root, ShortcutManager
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_window_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin NativeT!();
  mixin RootT!();
  mixin ShortcutManagerT!();

  /**
   * Creates a new `GtkWindow`.
   * To get an undecorated window $(LPAREN)no window borders$(RPAREN), use
   * [Gtk.Window.setDecorated].
   * All top-level windows created by [Gtk.Window.new_] are stored
   * in an internal top-level window list. This list can be obtained
   * from [Gtk.Window.listToplevels]. Due to GTK keeping a
   * reference to the window internally, [Gtk.Window.new_] does not
   * return a reference to the caller.
   * To delete a `GtkWindow`, call [Gtk.Window.destroy].
   * Returns: a new `GtkWindow`.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_window_new();
    this(_cretval, false);
  }

  /**
   * Returns the fallback icon name for windows.
   * The returned string is owned by GTK and should not
   * be modified. It is only valid until the next call to
   * [Gtk.Window.setDefaultIconName].
   * Returns: the fallback icon name for windows
   */
  static string getDefaultIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_window_get_default_icon_name();
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns a list of all existing toplevel windows.
   * If you want to iterate through the list and perform actions involving
   * callbacks that might destroy the widgets or add new ones, be aware that
   * the list of toplevels will change and emit the "items-changed" signal.
   * Returns: the list
   *   of toplevel widgets
   */
  static ListModel getToplevels()
  {
    GListModel* _cretval;
    _cretval = gtk_window_get_toplevels();
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns a list of all existing toplevel windows.
   * The widgets in the list are not individually referenced.
   * If you want to iterate through the list and perform actions
   * involving callbacks that might destroy the widgets, you must
   * call `g_list_foreach $(LPAREN)result, $(LPAREN)GFunc$(RPAREN)g_object_ref, NULL$(RPAREN)` first,
   * and then unref all the widgets afterwards.
   * Returns: list of
   *   toplevel widgets
   */
  static List!(Widget) listToplevels()
  {
    GList* _cretval;
    _cretval = gtk_window_list_toplevels();
    List!(Widget) _retval = new List!(Widget)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Sets whether the window should request startup notification.
   * By default, after showing the first `GtkWindow`, GTK calls
   * [Gdk.Toplevel.setStartupId]. Call this function
   * to disable the automatic startup notification. You might do this
   * if your first window is a splash screen, and you want to delay
   * notification until after your real main window has been shown,
   * for example.
   * In that example, you would disable startup notification
   * temporarily, show your splash screen, then re-enable it so that
   * showing the main window would automatically result in notification.
   * Params:
   *   setting = %TRUE to automatically do startup notification
   */
  static void setAutoStartupNotification(bool setting)
  {
    gtk_window_set_auto_startup_notification(setting);
  }

  /**
   * Sets an icon to be used as fallback.
   * The fallback icon is used for windows that
   * haven't had [Gtk.Window.setIconName]
   * called on them.
   * Params:
   *   name = the name of the themed icon
   */
  static void setDefaultIconName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_window_set_default_icon_name(_name);
  }

  /**
   * Opens or closes the [interactive debugger](running.html#interactive-debugging).
   * The debugger offers access to the widget hierarchy of the application
   * and to useful debugging tools.
   * Params:
   *   enable = %TRUE to enable interactive debugging
   */
  static void setInteractiveDebugging(bool enable)
  {
    gtk_window_set_interactive_debugging(enable);
  }

  /**
   * Requests that the window is closed.
   * This is similar to what happens when a window manager
   * close button is clicked.
   * This function can be used with close buttons in custom
   * titlebars.
   */
  void close()
  {
    gtk_window_close(cast(GtkWindow*)cPtr);
  }

  /**
   * Drop the internal reference GTK holds on toplevel windows.
   */
  void destroy()
  {
    gtk_window_destroy(cast(GtkWindow*)cPtr);
  }

  /**
   * Asks to place window in the fullscreen state.
   * Note that you shouldn’t assume the window is definitely fullscreen
   * afterward, because other entities $(LPAREN)e.g. the user or window manager$(RPAREN)
   * unfullscreen it again, and not all window managers honor requests
   * to fullscreen windows.
   * You can track the result of this operation via the
   * [Gdk.Toplevel.state] property, or by listening to
   * notifications of the [Gtk.Window.fullscreened] property.
   */
  void fullscreen()
  {
    gtk_window_fullscreen(cast(GtkWindow*)cPtr);
  }

  /**
   * Asks to place window in the fullscreen state on the given monitor.
   * Note that you shouldn't assume the window is definitely fullscreen
   * afterward, or that the windowing system allows fullscreen windows on
   * any given monitor.
   * You can track the result of this operation via the
   * [Gdk.Toplevel.state] property, or by listening to
   * notifications of the [Gtk.Window.fullscreened] property.
   * Params:
   *   monitor = which monitor to go fullscreen on
   */
  void fullscreenOnMonitor(MonitorG monitor)
  {
    gtk_window_fullscreen_on_monitor(cast(GtkWindow*)cPtr, monitor ? cast(GdkMonitor*)monitor.cPtr(false) : null);
  }

  /**
   * Gets the `GtkApplication` associated with the window.
   * Returns: a `GtkApplication`
   */
  Application getApplication()
  {
    GtkApplication* _cretval;
    _cretval = gtk_window_get_application(cast(GtkWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Application(cast(GtkApplication*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the child widget of window.
   * Returns: the child widget of window
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_window_get_child(cast(GtkWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the window has been set to have decorations.
   * Returns: %TRUE if the window has been set to have decorations
   */
  bool getDecorated()
  {
    bool _retval;
    _retval = gtk_window_get_decorated(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Gets the default size of the window.
   * A value of 0 for the width or height indicates that a default
   * size has not been explicitly set for that dimension, so the
   * “natural” size of the window will be used.
   * This function is the recommended way for [saving window state
   * across restarts of applications]$(LPAREN)https://developer.gnome.org/documentation/tutorials/save-state.html$(RPAREN).
   * Params:
   *   width = location to store the default width
   *   height = location to store the default height
   */
  void getDefaultSize(out int width, out int height)
  {
    gtk_window_get_default_size(cast(GtkWindow*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Returns the default widget for window.
   * Returns: the default widget
   */
  Widget getDefaultWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_window_get_default_widget(cast(GtkWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the window has been set to have a close button.
   * Returns: %TRUE if the window has been set to have a close button
   */
  bool getDeletable()
  {
    bool _retval;
    _retval = gtk_window_get_deletable(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the window will be destroyed with its transient parent.
   * Returns: %TRUE if the window will be destroyed with its transient parent.
   */
  bool getDestroyWithParent()
  {
    bool _retval;
    _retval = gtk_window_get_destroy_with_parent(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the current focused widget within the window.
   * Note that this is the widget that would have the focus
   * if the toplevel window focused; if the toplevel window
   * is not focused then `gtk_widget_has_focus $(LPAREN)widget$(RPAREN)` will
   * not be %TRUE for the widget.
   * Returns: the currently focused widget
   */
  Widget getFocus()
  {
    GtkWidget* _cretval;
    _cretval = gtk_window_get_focus(cast(GtkWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether “focus rectangles” are supposed to be visible.
   * Returns: %TRUE if “focus rectangles” are supposed to be visible
   *   in this window.
   */
  bool getFocusVisible()
  {
    bool _retval;
    _retval = gtk_window_get_focus_visible(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns the group for window.
   * If the window has no group, then the default group is returned.
   * Returns: the `GtkWindowGroup` for a window
   *   or the default group
   */
  WindowGroup getGroup()
  {
    GtkWindowGroup* _cretval;
    _cretval = gtk_window_get_group(cast(GtkWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!WindowGroup(cast(GtkWindowGroup*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether this window reacts to F10 key presses by
   * activating a menubar it contains.
   * Returns: %TRUE if the window handles F10
   */
  bool getHandleMenubarAccel()
  {
    bool _retval;
    _retval = gtk_window_get_handle_menubar_accel(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the window will be hidden when the close button is clicked.
   * Returns: %TRUE if the window will be hidden
   */
  bool getHideOnClose()
  {
    bool _retval;
    _retval = gtk_window_get_hide_on_close(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns the name of the themed icon for the window.
   * Returns: the icon name
   */
  string getIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_window_get_icon_name(cast(GtkWindow*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets whether mnemonics are supposed to be visible.
   * Returns: %TRUE if mnemonics are supposed to be visible
   *   in this window.
   */
  bool getMnemonicsVisible()
  {
    bool _retval;
    _retval = gtk_window_get_mnemonics_visible(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the window is modal.
   * Returns: %TRUE if the window is set to be modal and
   *   establishes a grab when shown
   */
  bool getModal()
  {
    bool _retval;
    _retval = gtk_window_get_modal(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Gets the value set by [Gtk.Window.setResizable].
   * Returns: %TRUE if the user can resize the window
   */
  bool getResizable()
  {
    bool _retval;
    _retval = gtk_window_get_resizable(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the title of the window.
   * Returns: the title of the window
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_window_get_title(cast(GtkWindow*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the custom titlebar that has been set with
   * [Gtk.Window.setTitlebar].
   * Returns: the custom titlebar
   */
  Widget getTitlebar()
  {
    GtkWidget* _cretval;
    _cretval = gtk_window_get_titlebar(cast(GtkWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Fetches the transient parent for this window.
   * Returns: the transient parent for this window
   */
  Window getTransientFor()
  {
    GtkWindow* _cretval;
    _cretval = gtk_window_get_transient_for(cast(GtkWindow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Window(cast(GtkWindow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether window has an explicit window group.
   * Returns: %TRUE if window has an explicit window group.
   */
  bool hasGroup()
  {
    bool _retval;
    _retval = gtk_window_has_group(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the window is part of the current active toplevel.
   * The active toplevel is the window receiving keystrokes.
   * The return value is %TRUE if the window is active toplevel itself.
   * You might use this function if you wanted to draw a widget
   * differently in an active window from a widget in an inactive window.
   * Returns: %TRUE if the window part of the current active window.
   */
  bool isActive()
  {
    bool _retval;
    _retval = gtk_window_is_active(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the current fullscreen state of window.
   * Note that since fullscreening is ultimately handled by the window
   * manager and happens asynchronously to an application request, you
   * shouldn’t assume the return value of this function changing
   * immediately $(LPAREN)or at all$(RPAREN), as an effect of calling
   * [Gtk.Window.fullscreen] or [Gtk.Window.unfullscreen].
   * If the window isn't yet mapped, the value returned will whether the
   * initial requested state is fullscreen.
   * Returns: whether the window has a fullscreen state.
   */
  bool isFullscreen()
  {
    bool _retval;
    _retval = gtk_window_is_fullscreen(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the current maximized state of window.
   * Note that since maximization is ultimately handled by the window
   * manager and happens asynchronously to an application request, you
   * shouldn’t assume the return value of this function changing
   * immediately $(LPAREN)or at all$(RPAREN), as an effect of calling
   * [Gtk.Window.maximize] or [Gtk.Window.unmaximize].
   * If the window isn't yet mapped, the value returned will whether the
   * initial requested state is maximized.
   * Returns: whether the window has a maximized state.
   */
  bool isMaximized()
  {
    bool _retval;
    _retval = gtk_window_is_maximized(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the current suspended state of window.
   * A window being suspended means it's currently not visible to the user, for
   * example by being on a inactive workspace, minimized, obstructed.
   * Returns: whether the window is suspended.
   */
  bool isSuspended()
  {
    bool _retval;
    _retval = gtk_window_is_suspended(cast(GtkWindow*)cPtr);
    return _retval;
  }

  /**
   * Asks to maximize window, so that it fills the screen.
   * Note that you shouldn’t assume the window is definitely maximized
   * afterward, because other entities $(LPAREN)e.g. the user or window manager$(RPAREN)
   * could unmaximize it again, and not all window managers support
   * maximization.
   * It’s permitted to call this function before showing a window,
   * in which case the window will be maximized when it appears onscreen
   * initially.
   * You can track the result of this operation via the
   * [Gdk.Toplevel.state] property, or by listening to
   * notifications on the [Gtk.Window.maximized]
   * property.
   */
  void maximize()
  {
    gtk_window_maximize(cast(GtkWindow*)cPtr);
  }

  /**
   * Asks to minimize the specified window.
   * Note that you shouldn’t assume the window is definitely minimized
   * afterward, because the windowing system might not support this
   * functionality; other entities $(LPAREN)e.g. the user or the window manager$(RPAREN)
   * could unminimize it again, or there may not be a window manager in
   * which case minimization isn’t possible, etc.
   * It’s permitted to call this function before showing a window,
   * in which case the window will be minimized before it ever appears
   * onscreen.
   * You can track result of this operation via the
   * [Gdk.Toplevel.state] property.
   */
  void minimize()
  {
    gtk_window_minimize(cast(GtkWindow*)cPtr);
  }

  /**
   * Presents a window to the user.
   * This may mean raising the window in the stacking order,
   * unminimizing it, moving it to the current desktop and/or
   * giving it the keyboard focus $(LPAREN)possibly dependent on the user’s
   * platform, window manager and preferences$(RPAREN).
   * If window is hidden, this function also makes it visible.
   */
  void present()
  {
    gtk_window_present(cast(GtkWindow*)cPtr);
  }

  /**
   * Presents a window to the user in response to an user interaction.
   * See [Gtk.Window.present] for more details.
   * The timestamp should be gathered when the window was requested
   * to be shown $(LPAREN)when clicking a link for example$(RPAREN), rather than once
   * the window is ready to be shown.
   * Params:
   *   timestamp = the timestamp of the user interaction $(LPAREN)typically a
   *     button or key press event$(RPAREN) which triggered this call

   * Deprecated: Use [Gtk.Window.present]
   */
  void presentWithTime(uint timestamp)
  {
    gtk_window_present_with_time(cast(GtkWindow*)cPtr, timestamp);
  }

  /**
   * Sets or unsets the `GtkApplication` associated with the window.
   * The application will be kept alive for at least as long as it has
   * any windows associated with it $(LPAREN)see [Gio.DGioApplication.hold] for a way
   * to keep it alive without windows$(RPAREN).
   * Normally, the connection between the application and the window will
   * remain until the window is destroyed, but you can explicitly remove
   * it by setting the application to %NULL.
   * This is equivalent to calling [Gtk.Application.removeWindow]
   * and/or [Gtk.Application.addWindow] on the old/new applications
   * as relevant.
   * Params:
   *   application = a `GtkApplication`, or %NULL to unset
   */
  void setApplication(Application application)
  {
    gtk_window_set_application(cast(GtkWindow*)cPtr, application ? cast(GtkApplication*)application.cPtr(false) : null);
  }

  /**
   * Sets the child widget of window.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_window_set_child(cast(GtkWindow*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether the window should be decorated.
   * By default, windows are decorated with a title bar, resize
   * controls, etc. Some window managers allow GTK to disable these
   * decorations, creating a borderless window. If you set the decorated
   * property to %FALSE using this function, GTK will do its best to
   * convince the window manager not to decorate the window. Depending on
   * the system, this function may not have any effect when called on a
   * window that is already visible, so you should call it before calling
   * [Gtk.Widget.show].
   * On Windows, this function always works, since there’s no window manager
   * policy involved.
   * Params:
   *   setting = %TRUE to decorate the window
   */
  void setDecorated(bool setting)
  {
    gtk_window_set_decorated(cast(GtkWindow*)cPtr, setting);
  }

  /**
   * Sets the default size of a window.
   * The default size of a window is the size that will be used if no other constraints apply.
   * The default size will be updated whenever the window is resized
   * to reflect the new size, unless the window is forced to a size,
   * like when it is maximized or fullscreened.
   * If the window’s minimum size request is larger than
   * the default, the default will be ignored.
   * Setting the default size to a value <\= 0 will cause it to be
   * ignored and the natural size request will be used instead. It
   * is possible to do this while the window is showing to "reset"
   * it to its initial size.
   * Unlike [Gtk.Widget.setSizeRequest], which sets a size
   * request for a widget and thus would keep users from shrinking
   * the window, this function only sets the initial size, just as
   * if the user had resized the window themselves. Users can still
   * shrink the window again as they normally would. Setting a default
   * size of -1 means to use the “natural” default size $(LPAREN)the size request
   * of the window$(RPAREN).
   * If you use this function to reestablish a previously saved window size,
   * note that the appropriate size to save is the one returned by
   * [Gtk.Window.getDefaultSize]. Using the window allocation
   * directly will not work in all circumstances and can lead to growing
   * or shrinking windows.
   * Params:
   *   width = width in pixels, or -1 to unset the default width
   *   height = height in pixels, or -1 to unset the default height
   */
  void setDefaultSize(int width, int height)
  {
    gtk_window_set_default_size(cast(GtkWindow*)cPtr, width, height);
  }

  /**
   * Sets the default widget.
   * The default widget is the widget that is activated when the user
   * presses Enter in a dialog $(LPAREN)for example$(RPAREN).
   * Params:
   *   defaultWidget = widget to be the default
   *     to unset the default widget for the toplevel
   */
  void setDefaultWidget(Widget defaultWidget)
  {
    gtk_window_set_default_widget(cast(GtkWindow*)cPtr, defaultWidget ? cast(GtkWidget*)defaultWidget.cPtr(false) : null);
  }

  /**
   * Sets whether the window should be deletable.
   * By default, windows have a close button in the window frame.
   * Some  window managers allow GTK to disable this button. If you
   * set the deletable property to %FALSE using this function, GTK
   * will do its best to convince the window manager not to show a
   * close button. Depending on the system, this function may not
   * have any effect when called on a window that is already visible,
   * so you should call it before calling [Gtk.Widget.show].
   * On Windows, this function always works, since there’s no window
   * manager policy involved.
   * Params:
   *   setting = %TRUE to decorate the window as deletable
   */
  void setDeletable(bool setting)
  {
    gtk_window_set_deletable(cast(GtkWindow*)cPtr, setting);
  }

  /**
   * If setting is %TRUE, then destroying the transient parent of window
   * will also destroy window itself.
   * This is useful for dialogs that shouldn’t persist beyond the lifetime
   * of the main window they are associated with, for example.
   * Params:
   *   setting = whether to destroy window with its transient parent
   */
  void setDestroyWithParent(bool setting)
  {
    gtk_window_set_destroy_with_parent(cast(GtkWindow*)cPtr, setting);
  }

  /**
   * Sets the `GdkDisplay` where the window is displayed.
   * If the window is already mapped, it will be unmapped,
   * and then remapped on the new display.
   * Params:
   *   display = a `GdkDisplay`
   */
  void setDisplay(Display display)
  {
    gtk_window_set_display(cast(GtkWindow*)cPtr, display ? cast(GdkDisplay*)display.cPtr(false) : null);
  }

  /**
   * Sets the focus widget.
   * If focus is not the current focus widget, and is focusable,
   * sets it as the focus widget for the window. If focus is %NULL,
   * unsets the focus widget for this window. To set the focus to a
   * particular widget in the toplevel, it is usually more convenient
   * to use [Gtk.Widget.grabFocus] instead of this function.
   * Params:
   *   focus = widget to be the new focus widget, or %NULL to unset
   *     any focus widget for the toplevel window.
   */
  void setFocus(Widget focus)
  {
    gtk_window_set_focus(cast(GtkWindow*)cPtr, focus ? cast(GtkWidget*)focus.cPtr(false) : null);
  }

  /**
   * Sets whether “focus rectangles” are supposed to be visible.
   * This property is maintained by GTK based on user input,
   * and should not be set by applications.
   * Params:
   *   setting = the new value
   */
  void setFocusVisible(bool setting)
  {
    gtk_window_set_focus_visible(cast(GtkWindow*)cPtr, setting);
  }

  /**
   * Sets whether this window should react to F10 key presses
   * by activating a menubar it contains.
   * Params:
   *   handleMenubarAccel = %TRUE to make window handle F10
   */
  void setHandleMenubarAccel(bool handleMenubarAccel)
  {
    gtk_window_set_handle_menubar_accel(cast(GtkWindow*)cPtr, handleMenubarAccel);
  }

  /**
   * If setting is %TRUE, then clicking the close button on the window
   * will not destroy it, but only hide it.
   * Params:
   *   setting = whether to hide the window when it is closed
   */
  void setHideOnClose(bool setting)
  {
    gtk_window_set_hide_on_close(cast(GtkWindow*)cPtr, setting);
  }

  /**
   * Sets the icon for the window from a named themed icon.
   * See the docs for [Gtk.IconTheme] for more details.
   * On some platforms, the window icon is not used at all.
   * Note that this has nothing to do with the WM_ICON_NAME
   * property which is mentioned in the ICCCM.
   * Params:
   *   name = the name of the themed icon
   */
  void setIconName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_window_set_icon_name(cast(GtkWindow*)cPtr, _name);
  }

  /**
   * Sets whether mnemonics are supposed to be visible.
   * This property is maintained by GTK based on user input,
   * and should not be set by applications.
   * Params:
   *   setting = the new value
   */
  void setMnemonicsVisible(bool setting)
  {
    gtk_window_set_mnemonics_visible(cast(GtkWindow*)cPtr, setting);
  }

  /**
   * Sets a window modal or non-modal.
   * Modal windows prevent interaction with other windows in the same
   * application. To keep modal dialogs on top of main application windows,
   * use [Gtk.Window.setTransientFor] to make the dialog transient
   * for the parent; most window managers will then disallow lowering the
   * dialog below the parent.
   * Params:
   *   modal = whether the window is modal
   */
  void setModal(bool modal)
  {
    gtk_window_set_modal(cast(GtkWindow*)cPtr, modal);
  }

  /**
   * Sets whether the user can resize a window.
   * Windows are user resizable by default.
   * Params:
   *   resizable = %TRUE if the user can resize this window
   */
  void setResizable(bool resizable)
  {
    gtk_window_set_resizable(cast(GtkWindow*)cPtr, resizable);
  }

  /**
   * Sets the startup notification ID.
   * Startup notification identifiers are used by desktop environment
   * to track application startup, to provide user feedback and other
   * features. This function changes the corresponding property on the
   * underlying `GdkSurface`.
   * Normally, startup identifier is managed automatically and you should
   * only use this function in special cases like transferring focus from
   * other processes. You should use this function before calling
   * [Gtk.Window.present] or any equivalent function generating
   * a window map event.
   * This function is only useful on X11, not with other GTK targets.
   * Params:
   *   startupId = a string with startup-notification identifier
   */
  void setStartupId(string startupId)
  {
    const(char)* _startupId = startupId.toCString(false);
    gtk_window_set_startup_id(cast(GtkWindow*)cPtr, _startupId);
  }

  /**
   * Sets the title of the `GtkWindow`.
   * The title of a window will be displayed in its title bar; on the
   * X Window System, the title bar is rendered by the window manager
   * so exactly how the title appears to users may vary according to a
   * user’s exact configuration. The title should help a user distinguish
   * this window from other windows they may have open. A good title might
   * include the application name and current document filename, for example.
   * Passing %NULL does the same as setting the title to an empty string.
   * Params:
   *   title = title of the window
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    gtk_window_set_title(cast(GtkWindow*)cPtr, _title);
  }

  /**
   * Sets a custom titlebar for window.
   * A typical widget used here is [Gtk.HeaderBar], as it
   * provides various features expected of a titlebar while allowing
   * the addition of child widgets to it.
   * If you set a custom titlebar, GTK will do its best to convince
   * the window manager not to put its own titlebar on the window.
   * Depending on the system, this function may not work for a window
   * that is already visible, so you set the titlebar before calling
   * [Gtk.Widget.show].
   * Params:
   *   titlebar = the widget to use as titlebar
   */
  void setTitlebar(Widget titlebar)
  {
    gtk_window_set_titlebar(cast(GtkWindow*)cPtr, titlebar ? cast(GtkWidget*)titlebar.cPtr(false) : null);
  }

  /**
   * Dialog windows should be set transient for the main application
   * window they were spawned from. This allows window managers to e.g.
   * keep the dialog on top of the main window, or center the dialog
   * over the main window. [Gtk.Dialog.newWithButtons] and other
   * convenience functions in GTK will sometimes call
   * [Gtk.Window.setTransientFor] on your behalf.
   * Passing %NULL for parent unsets the current transient window.
   * On Windows, this function puts the child window on top of the parent,
   * much as the window manager would have done on X.
   * Params:
   *   parent = parent window
   */
  void setTransientFor(Window parent)
  {
    gtk_window_set_transient_for(cast(GtkWindow*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null);
  }

  /**
   * Asks to remove the fullscreen state for window, and return to
   * its previous state.
   * Note that you shouldn’t assume the window is definitely not
   * fullscreen afterward, because other entities $(LPAREN)e.g. the user or
   * window manager$(RPAREN) could fullscreen it again, and not all window
   * managers honor requests to unfullscreen windows; normally the
   * window will end up restored to its normal state. Just don’t
   * write code that crashes if not.
   * You can track the result of this operation via the
   * [Gdk.Toplevel.state] property, or by listening to
   * notifications of the [Gtk.Window.fullscreened] property.
   */
  void unfullscreen()
  {
    gtk_window_unfullscreen(cast(GtkWindow*)cPtr);
  }

  /**
   * Asks to unmaximize window.
   * Note that you shouldn’t assume the window is definitely unmaximized
   * afterward, because other entities $(LPAREN)e.g. the user or window manager$(RPAREN)
   * maximize it again, and not all window managers honor requests to
   * unmaximize.
   * You can track the result of this operation via the
   * [Gdk.Toplevel.state] property, or by listening to
   * notifications on the [Gtk.Window.maximized] property.
   */
  void unmaximize()
  {
    gtk_window_unmaximize(cast(GtkWindow*)cPtr);
  }

  /**
   * Asks to unminimize the specified window.
   * Note that you shouldn’t assume the window is definitely unminimized
   * afterward, because the windowing system might not support this
   * functionality; other entities $(LPAREN)e.g. the user or the window manager$(RPAREN)
   * could minimize it again, or there may not be a window manager in
   * which case minimization isn’t possible, etc.
   * You can track result of this operation via the
   * [Gdk.Toplevel.state] property.
   */
  void unminimize()
  {
    gtk_window_unminimize(cast(GtkWindow*)cPtr);
  }

  /**
   * Emitted when the user activates the default widget
   * of window.
   * This is a [keybinding signal](class.SignalAction.html).
   *   window = the instance the signal is connected to
   */
  alias ActivateDefaultCallback = void delegate(Window window);

  /**
   * Connect to ActivateDefault signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivateDefault(ActivateDefaultCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto window = getVal!Window(_paramVals);
      _dgClosure.dlg(window);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-default", closure, after);
  }

  /**
   * Emitted when the user activates the currently focused
   * widget of window.
   * This is a [keybinding signal](class.SignalAction.html).
   *   window = the instance the signal is connected to
   */
  alias ActivateFocusCallback = void delegate(Window window);

  /**
   * Connect to ActivateFocus signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivateFocus(ActivateFocusCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto window = getVal!Window(_paramVals);
      _dgClosure.dlg(window);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate-focus", closure, after);
  }

  /**
   * Emitted when the user clicks on the close button of the window.
   *   window = the instance the signal is connected to
   * Returns: %TRUE to stop other handlers from being invoked for the signal
   */
  alias CloseRequestCallback = bool delegate(Window window);

  /**
   * Connect to CloseRequest signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCloseRequest(CloseRequestCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto window = getVal!Window(_paramVals);
      _retval = _dgClosure.dlg(window);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("close-request", closure, after);
  }

  /**
   * Emitted when the user enables or disables interactive debugging.
   * When toggle is %TRUE, interactive debugging is toggled on or off,
   * when it is %FALSE, the debugger will be pointed at the widget
   * under the pointer.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are Ctrl-Shift-I
   * and Ctrl-Shift-D.
   * Params
   *   toggle = toggle the debugger
   *   window = the instance the signal is connected to
   * Returns: %TRUE if the key binding was handled
   */
  alias EnableDebuggingCallback = bool delegate(bool toggle, Window window);

  /**
   * Connect to EnableDebugging signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEnableDebugging(EnableDebuggingCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto window = getVal!Window(_paramVals);
      auto toggle = getVal!bool(&_paramVals[1]);
      _retval = _dgClosure.dlg(toggle, window);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("enable-debugging", closure, after);
  }

  /**
   * emitted when the set of accelerators or mnemonics that
   * are associated with window changes.
   *   window = the instance the signal is connected to

   * Deprecated: Use [Gtk.Shortcut] and [Gtk.EventController]
   *   to implement keyboard shortcuts
   */
  alias KeysChangedCallback = void delegate(Window window);

  /**
   * Connect to KeysChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectKeysChanged(KeysChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto window = getVal!Window(_paramVals);
      _dgClosure.dlg(window);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("keys-changed", closure, after);
  }
}

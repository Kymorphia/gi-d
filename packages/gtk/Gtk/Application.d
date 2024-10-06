module Gtk.Application;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.ActionGroup;
import Gio.ActionGroupT;
import Gio.ActionMap;
import Gio.ActionMapT;
import Gio.Application : DGioApplication = Application;
import Gio.Menu;
import Gio.MenuModel;
import Gio.Types;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkApplication` is a high-level API for writing applications.
 * It supports many aspects of writing a GTK application in a convenient
 * fashion, without enforcing a one-size-fits-all model.
 * Currently, `GtkApplication` handles GTK initialization, application
 * uniqueness, session management, provides some basic scriptability and
 * desktop shell integration by exporting actions and menus and manages a
 * list of toplevel windows whose life-cycle is automatically tied to the
 * life-cycle of your application.
 * While `GtkApplication` works fine with plain [Gtk.Window]s, it is
 * recommended to use it together with [Gtk.ApplicationWindow].
 * ## Automatic resources
 * `GtkApplication` will automatically load menus from the `GtkBuilder`
 * resource located at "gtk/menus.ui", relative to the application's
 * resource base path $(LPAREN)see [Gio.DGioApplication.setResourceBasePath]$(RPAREN).
 * The menu with the ID "menubar" is taken as the application's
 * menubar. Additional menus $(LPAREN)most interesting submenus$(RPAREN) can be named
 * and accessed via [Gtk.Application.getMenuById] which allows for
 * dynamic population of a part of the menu structure.
 * Note that automatic resource loading uses the resource base path
 * that is set at construction time and will not work if the resource
 * base path is changed at a later time.
 * It is also possible to provide the menubar manually using
 * [Gtk.Application.setMenubar].
 * `GtkApplication` will also automatically setup an icon search path for
 * the default icon theme by appending "icons" to the resource base
 * path. This allows your application to easily store its icons as
 * resources. See [Gtk.IconTheme.addResourcePath] for more
 * information.
 * If there is a resource located at `gtk/help-overlay.ui` which
 * defines a [Gtk.ShortcutsWindow] with ID `help_overlay` then
 * `GtkApplication` associates an instance of this shortcuts window with
 * each [Gtk.ApplicationWindow] and sets up the keyboard accelerator
 * <kbd>Control</kbd>+<kbd>?</kbd> to open it. To create a menu item that
 * displays the shortcuts window, associate the item with the action
 * `win.show-help-overlay`.
 * ## A simple application
 * [A simple example](https://gitlab.gnome.org/GNOME/gtk/tree/main/examples/bp/bloatpad.c)
 * is available in the GTK source code repository
 * `GtkApplication` optionally registers with a session manager of the
 * users session $(LPAREN)if you set the property@Gtk.Application:register-session
 * property$(RPAREN) and offers various functionality related to the session
 * life-cycle.
 * An application can block various ways to end the session with
 * the [Gtk.Application.inhibit] function. Typical use cases for
 * this kind of inhibiting are long-running, uninterruptible operations,
 * such as burning a CD or performing a disk backup. The session
 * manager may not honor the inhibitor, but it can be expected to
 * inform the user about the negative consequences of ending the
 * session while inhibitors are present.
 * ## See Also
 * [HowDoI: Using GtkApplication](https://wiki.gnome.org/HowDoI/GtkApplication),
 * [Getting Started with GTK: Basics](getting_started.html#basics)
 */
class Application : DGioApplication
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
    return gtk_application_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkApplication` instance.
   * When using `GtkApplication`, it is not necessary to call funcGtk.init
   * manually. It is called as soon as the application gets registered as
   * the primary instance.
   * Concretely, funcGtk.init is called in the default handler for the
   * `GApplication::startup` signal. Therefore, `GtkApplication` subclasses should
   * always chain up in their `GApplication::startup` handler before using any GTK
   * API.
   * Note that commandline arguments are not passed to funcGtk.init.
   * If `application_id` is not %NULL, then it must be valid. See
   * `[Gio.DGioApplication.idIsValid]`.
   * If no application ID is given then some features $(LPAREN)most notably application
   * uniqueness$(RPAREN) will be disabled.
   * Params:
   *   applicationId = The application ID
   *   flags = the application flags
   * Returns: a new `GtkApplication` instance
   */
  this(string applicationId, ApplicationFlags flags)
  {
    GtkApplication* _cretval;
    const(char)* _applicationId = applicationId.toCString(false);
    _cretval = gtk_application_new(_applicationId, flags);
    this(_cretval, true);
  }

  /**
   * Adds a window to `application`.
   * This call can only happen after the `application` has started;
   * typically, you should add new application windows in response
   * to the emission of the `GApplication::activate` signal.
   * This call is equivalent to setting the [Gtk.Window.application]
   * property of `window` to `application`.
   * Normally, the connection between the application and the window
   * will remain until the window is destroyed, but you can explicitly
   * remove it with [Gtk.Application.removeWindow].
   * GTK will keep the `application` running as long as it has
   * any windows.
   * Params:
   *   window = a `GtkWindow`
   */
  void addWindow(Window window)
  {
    gtk_application_add_window(cast(GtkApplication*)cPtr, window ? cast(GtkWindow*)window.cPtr(false) : null);
  }

  /**
   * Gets the “active” window for the application.
   * The active window is the one that was most recently focused $(LPAREN)within
   * the application$(RPAREN).  This window may not have the focus at the moment
   * if another application has it — this is just the most
   * recently-focused window within this application.
   * Returns: the active window
   */
  Window getActiveWindow()
  {
    GtkWindow* _cretval;
    _cretval = gtk_application_get_active_window(cast(GtkApplication*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Window(cast(GtkWindow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets a menu from automatically loaded resources.
   * See [the section on Automatic resources](class.Application.html#automatic-resources)
   * for more information.
   * Params:
   *   id = the id of the menu to look up
   * Returns: Gets the menu with the
   *   given id from the automatically loaded resources
   */
  Menu getMenuById(string id)
  {
    GMenu* _cretval;
    const(char)* _id = id.toCString(false);
    _cretval = gtk_application_get_menu_by_id(cast(GtkApplication*)cPtr, _id);
    auto _retval = _cretval ? ObjectG.getDObject!Menu(cast(GMenu*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the menu model that has been set with
   * [Gtk.Application.setMenubar].
   * Returns: the menubar for windows of `application`
   */
  MenuModel getMenubar()
  {
    GMenuModel* _cretval;
    _cretval = gtk_application_get_menubar(cast(GtkApplication*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the [Gtk.ApplicationWindow] with the given ID.
   * The ID of a `GtkApplicationWindow` can be retrieved with
   * [Gtk.ApplicationWindow.getId].
   * Params:
   *   id = an identifier number
   * Returns: the window for the given `id`
   */
  Window getWindowById(uint id)
  {
    GtkWindow* _cretval;
    _cretval = gtk_application_get_window_by_id(cast(GtkApplication*)cPtr, id);
    auto _retval = _cretval ? ObjectG.getDObject!Window(cast(GtkWindow*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets a list of the [Gtk.Window] instances associated with `application`.
   * The list is sorted by most recently focused window, such that the first
   * element is the currently focused window. $(LPAREN)Useful for choosing a parent
   * for a transient window.$(RPAREN)
   * The list that is returned should not be modified in any way. It will
   * only remain valid until the next focus change or window creation or
   * deletion.
   * Returns: a `GList` of `GtkWindow`
   *   instances
   */
  List!(Window, GtkWindow) getWindows()
  {
    GList* _cretval;
    _cretval = gtk_application_get_windows(cast(GtkApplication*)cPtr);
    List!(Window, GtkWindow) _retval = new List!(Window, GtkWindow)(cast(GList*)_cretval, GidOwnership.None);
    return _retval;
  }

  /**
   * Inform the session manager that certain types of actions should be
   * inhibited.
   * This is not guaranteed to work on all platforms and for all types of
   * actions.
   * Applications should invoke this method when they begin an operation
   * that should not be interrupted, such as creating a CD or DVD. The
   * types of actions that may be blocked are specified by the `flags`
   * parameter. When the application completes the operation it should
   * call [Gtk.Application.uninhibit] to remove the inhibitor. Note
   * that an application can have multiple inhibitors, and all of them must
   * be individually removed. Inhibitors are also cleared when the
   * application exits.
   * Applications should not expect that they will always be able to block
   * the action. In most cases, users will be given the option to force
   * the action to take place.
   * The `reason` message should be short and to the point.
   * If `window` is given, the session manager may point the user to
   * this window to find out more about why the action is inhibited.
   * Params:
   *   window = a `GtkWindow`
   *   flags = what types of actions should be inhibited
   *   reason = a short, human-readable string that explains
   *     why these operations are inhibited
   * Returns: A non-zero cookie that is used to uniquely identify this
   *   request. It should be used as an argument to [Gtk.Application.uninhibit]
   *   in order to remove the request. If the platform does not support
   *   inhibiting or the request failed for some reason, 0 is returned.
   */
  uint inhibit(Window window, ApplicationInhibitFlags flags, string reason)
  {
    uint _retval;
    const(char)* _reason = reason.toCString(false);
    _retval = gtk_application_inhibit(cast(GtkApplication*)cPtr, window ? cast(GtkWindow*)window.cPtr(false) : null, flags, _reason);
    return _retval;
  }

  /**
   * Remove a window from `application`.
   * If `window` belongs to `application` then this call is equivalent to
   * setting the [Gtk.Window.application] property of `window` to
   * `NULL`.
   * The application may stop running as a result of a call to this
   * function, if `window` was the last window of the `application`.
   * Params:
   *   window = a `GtkWindow`
   */
  void removeWindow(Window window)
  {
    gtk_application_remove_window(cast(GtkApplication*)cPtr, window ? cast(GtkWindow*)window.cPtr(false) : null);
  }

  /**
   * Sets zero or more keyboard accelerators that will trigger the
   * given action.
   * The first item in `accels` will be the primary accelerator, which may be
   * displayed in the UI.
   * To remove all accelerators for an action, use an empty, zero-terminated
   * array for `accels`.
   * For the `detailed_action_name`, see `[Gio.Action.parseDetailedName]` and
   * `[Gio.Action.printDetailedName]`.
   * Params:
   *   detailedActionName = a detailed action name, specifying an action
   *     and target to associate accelerators with
   *   accels = a list of accelerators in the format
   *     understood by funcGtk.accelerator_parse
   */
  void setAccelsForAction(string detailedActionName, string[] accels)
  {
    const(char)* _detailedActionName = detailedActionName.toCString(false);
    char*[] _tmpaccels;
    foreach (s; accels)
      _tmpaccels ~= s.toCString(false);
    _tmpaccels ~= null;
    const(char*)* _accels = _tmpaccels.ptr;
    gtk_application_set_accels_for_action(cast(GtkApplication*)cPtr, _detailedActionName, _accels);
  }

  /**
   * Sets or unsets the menubar for windows of `application`.
   * This is a menubar in the traditional sense.
   * This can only be done in the primary instance of the application,
   * after it has been registered. `GApplication::startup` is a good place
   * to call this.
   * Depending on the desktop environment, this may appear at the top of
   * each window, or at the top of the screen.  In some environments, if
   * both the application menu and the menubar are set, the application
   * menu will be presented as if it were the first item of the menubar.
   * Other environments treat the two as completely separate — for example,
   * the application menu may be rendered by the desktop shell while the
   * menubar $(LPAREN)if set$(RPAREN) remains in each individual window.
   * Use the base `GActionMap` interface to add actions, to respond to the
   * user selecting these menu items.
   * Params:
   *   menubar = a `GMenuModel`
   */
  void setMenubar(MenuModel menubar)
  {
    gtk_application_set_menubar(cast(GtkApplication*)cPtr, menubar ? cast(GMenuModel*)menubar.cPtr(false) : null);
  }

  /**
   * Removes an inhibitor that has been previously established.
   * See [Gtk.Application.inhibit].
   * Inhibitors are also cleared when the application exits.
   * Params:
   *   cookie = a cookie that was returned by [Gtk.Application.inhibit]
   */
  void uninhibit(uint cookie)
  {
    gtk_application_uninhibit(cast(GtkApplication*)cPtr, cookie);
  }

  /**
   * Emitted when the session manager is about to end the session.
   * This signal is only emitted if propertyGtk.Application:register-session
   * is `TRUE`. Applications can connect to this signal and call
   * [Gtk.Application.inhibit] with `GTK_APPLICATION_INHIBIT_LOGOUT`
   * to delay the end of the session until state has been saved.
   *   application = the instance the signal is connected to
   */
  alias QueryEndCallback = void delegate(Application application);

  /**
   * Connect to QueryEnd signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectQueryEnd(QueryEndCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      _dgClosure.dlg(application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("query-end", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a [Gtk.Window] is added to `application` through
   * [Gtk.Application.addWindow].
   * Params
   *   window = the newly-added [Gtk.Window]
   *   application = the instance the signal is connected to
   */
  alias WindowAddedCallback = void delegate(Window window, Application application);

  /**
   * Connect to WindowAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectWindowAdded(WindowAddedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      auto window = getVal!Window(&_paramVals[1]);
      _dgClosure.dlg(window, application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("window-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a [Gtk.Window] is removed from `application`.
   * This can happen as a side-effect of the window being destroyed
   * or explicitly through [Gtk.Application.removeWindow].
   * Params
   *   window = the [Gtk.Window] that is being removed
   *   application = the instance the signal is connected to
   */
  alias WindowRemovedCallback = void delegate(Window window, Application application);

  /**
   * Connect to WindowRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectWindowRemoved(WindowRemovedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto application = getVal!Application(_paramVals);
      auto window = getVal!Window(&_paramVals[1]);
      _dgClosure.dlg(window, application);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("window-removed", closure, (flags & ConnectFlags.After) != 0);
  }
}

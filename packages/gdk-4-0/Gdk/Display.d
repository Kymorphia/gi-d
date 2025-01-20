module Gdk.Display;

import GLib.ErrorG;
import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Value;
import Gdk.AppLaunchContext;
import Gdk.Clipboard;
import Gdk.Device;
import Gdk.DmabufFormats;
import Gdk.Event;
import Gdk.GLContext;
import Gdk.MonitorG;
import Gdk.Seat;
import Gdk.Surface;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;

/**
 * `GdkDisplay` objects are the GDK representation of a workstation.
 * Their purpose are two-fold:
 * - To manage and provide information about input devices $(LPAREN)pointers, keyboards, etc$(RPAREN)
 * - To manage and provide information about output devices $(LPAREN)monitors, projectors, etc$(RPAREN)
 * Most of the input device handling has been factored out into separate
 * [Gdk.Seat] objects. Every display has a one or more seats, which
 * can be accessed with [Gdk.Display.getDefaultSeat] and
 * [Gdk.Display.listSeats].
 * Output devices are represented by [Gdk.MonitorG] objects, which can
 * be accessed with [Gdk.Display.getMonitorAtSurface] and similar APIs.
 */
class Display : ObjectG
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
    return gdk_display_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the default `GdkDisplay`.
   * This is a convenience function for:
   * gdk_display_manager_get_default_display $(LPAREN)gdk_display_manager_get $(LPAREN)$(RPAREN)$(RPAREN)
   * Returns: a `GdkDisplay`, or %NULL if
   *   there is no default display
   */
  static Display getDefault()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_display_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Opens a display.
   * If opening the display fails, `NULL` is returned.
   * Params:
   *   displayName = the name of the display to open
   * Returns: a `GdkDisplay`
   */
  static Display open(string displayName)
  {
    GdkDisplay* _cretval;
    const(char)* _displayName = displayName.toCString(false);
    _cretval = gdk_display_open(_displayName);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Emits a short beep on display
   */
  void beep()
  {
    gdk_display_beep(cast(GdkDisplay*)cPtr);
  }

  /**
   * Closes the connection to the windowing system for the given display.
   * This cleans up associated resources.
   */
  void close()
  {
    gdk_display_close(cast(GdkDisplay*)cPtr);
  }

  /**
   * Creates a new `GdkGLContext` for the `GdkDisplay`.
   * The context is disconnected from any particular surface or surface
   * and cannot be used to draw to any surface. It can only be used to
   * draw to non-surface framebuffers like textures.
   * If the creation of the `GdkGLContext` failed, error will be set.
   * Before using the returned `GdkGLContext`, you will need to
   * call [Gdk.GLContext.makeCurrent] or [Gdk.GLContext.realize].
   * Returns: the newly created `GdkGLContext`
   */
  GLContext createGlContext()
  {
    GdkGLContext* _cretval;
    GError *_err;
    _cretval = gdk_display_create_gl_context(cast(GdkDisplay*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!GLContext(cast(GdkGLContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if there is an ongoing grab on device for display.
   * Params:
   *   device = a `GdkDevice`
   * Returns: %TRUE if there is a grab in effect for device.
   */
  bool deviceIsGrabbed(Device device)
  {
    bool _retval;
    _retval = gdk_display_device_is_grabbed(cast(GdkDisplay*)cPtr, device ? cast(GdkDevice*)device.cPtr(false) : null);
    return _retval;
  }

  /**
   * Flushes any requests queued for the windowing system.
   * This happens automatically when the main loop blocks waiting for new events,
   * but if your application is drawing without returning control to the main loop,
   * you may need to call this function explicitly. A common case where this function
   * needs to be called is when an application is executing drawing commands
   * from a thread other than the thread where the main loop is running.
   * This is most useful for X11. On windowing systems where requests are
   * handled synchronously, this function will do nothing.
   */
  void flush()
  {
    gdk_display_flush(cast(GdkDisplay*)cPtr);
  }

  /**
   * Returns a `GdkAppLaunchContext` suitable for launching
   * applications on the given display.
   * Returns: a new `GdkAppLaunchContext` for display
   */
  AppLaunchContext getAppLaunchContext()
  {
    GdkAppLaunchContext* _cretval;
    _cretval = gdk_display_get_app_launch_context(cast(GdkDisplay*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!AppLaunchContext(cast(GdkAppLaunchContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the clipboard used for copy/paste operations.
   * Returns: the display's clipboard
   */
  Clipboard getClipboard()
  {
    GdkClipboard* _cretval;
    _cretval = gdk_display_get_clipboard(cast(GdkDisplay*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Clipboard(cast(GdkClipboard*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the default `GdkSeat` for this display.
   * Note that a display may not have a seat. In this case,
   * this function will return %NULL.
   * Returns: the default seat.
   */
  Seat getDefaultSeat()
  {
    GdkSeat* _cretval;
    _cretval = gdk_display_get_default_seat(cast(GdkDisplay*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Seat(cast(GdkSeat*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the dma-buf formats that are supported on this display.
   * GTK may use OpenGL or Vulkan to support some formats.
   * Calling this function will then initialize them if they aren't yet.
   * The formats returned by this function can be used for negotiating
   * buffer formats with producers such as v4l, pipewire or GStreamer.
   * To learn more about dma-bufs, see [Gdk.DmabufTextureBuilder].
   * Returns: a `GdkDmabufFormats` object
   */
  DmabufFormats getDmabufFormats()
  {
    GdkDmabufFormats* _cretval;
    _cretval = gdk_display_get_dmabuf_formats(cast(GdkDisplay*)cPtr);
    auto _retval = _cretval ? new DmabufFormats(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the monitor in which the largest area of surface
   * resides.
   * Params:
   *   surface = a `GdkSurface`
   * Returns: the monitor with the largest
   *   overlap with surface
   */
  MonitorG getMonitorAtSurface(Surface surface)
  {
    GdkMonitor* _cretval;
    _cretval = gdk_display_get_monitor_at_surface(cast(GdkDisplay*)cPtr, surface ? cast(GdkSurface*)surface.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!MonitorG(cast(GdkMonitor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the list of monitors associated with this display.
   * Subsequent calls to this function will always return the
   * same list for the same display.
   * You can listen to the GListModel::items-changed signal on
   * this list to monitor changes to the monitor of this display.
   * Returns: a `GListModel` of `GdkMonitor`
   */
  ListModel getMonitors()
  {
    GListModel* _cretval;
    _cretval = gdk_display_get_monitors(cast(GdkDisplay*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the name of the display.
   * Returns: a string representing the display name. This string is owned
   *   by GDK and should not be modified or freed.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gdk_display_get_name(cast(GdkDisplay*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the clipboard used for the primary selection.
   * On backends where the primary clipboard is not supported natively,
   * GDK emulates this clipboard locally.
   * Returns: the primary clipboard
   */
  Clipboard getPrimaryClipboard()
  {
    GdkClipboard* _cretval;
    _cretval = gdk_display_get_primary_clipboard(cast(GdkDisplay*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Clipboard(cast(GdkClipboard*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves a desktop-wide setting such as double-click time
   * for the display.
   * Params:
   *   name = the name of the setting
   *   value = location to store the value of the setting
   * Returns: %TRUE if the setting existed and a value was stored
   *   in value, %FALSE otherwise
   */
  bool getSetting(string name, Value value)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = gdk_display_get_setting(cast(GdkDisplay*)cPtr, _name, value ? cast(GValue*)value.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets the startup notification ID for a Wayland display, or %NULL
   * if no ID has been defined.
   * Returns: the startup notification ID for display
   */
  string getStartupNotificationId()
  {
    const(char)* _cretval;
    _cretval = gdk_display_get_startup_notification_id(cast(GdkDisplay*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Finds out if the display has been closed.
   * Returns: %TRUE if the display is closed.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = gdk_display_is_closed(cast(GdkDisplay*)cPtr);
    return _retval;
  }

  /**
   * Returns whether surfaces can reasonably be expected to have
   * their alpha channel drawn correctly on the screen.
   * Check [Gdk.Display.isRgba] for whether the display
   * supports an alpha channel.
   * On X11 this function returns whether a compositing manager is
   * compositing on display.
   * On modern displays, this value is always %TRUE.
   * Returns: Whether surfaces with RGBA visuals can reasonably
   *   be expected to have their alpha channels drawn correctly
   *   on the screen.
   */
  bool isComposited()
  {
    bool _retval;
    _retval = gdk_display_is_composited(cast(GdkDisplay*)cPtr);
    return _retval;
  }

  /**
   * Returns whether surfaces on this display are created with an
   * alpha channel.
   * Even if a %TRUE is returned, it is possible that the
   * surface’s alpha channel won’t be honored when displaying the
   * surface on the screen: in particular, for X an appropriate
   * windowing manager and compositing manager must be running to
   * provide appropriate display. Use [Gdk.Display.isComposited]
   * to check if that is the case.
   * On modern displays, this value is always %TRUE.
   * Returns: %TRUE if surfaces are created with an alpha channel or
   *   %FALSE if the display does not support this functionality.
   */
  bool isRgba()
  {
    bool _retval;
    _retval = gdk_display_is_rgba(cast(GdkDisplay*)cPtr);
    return _retval;
  }

  /**
   * Returns the list of seats known to display.
   * Returns: the
   *   list of seats known to the `GdkDisplay`
   */
  List!(Seat) listSeats()
  {
    GList* _cretval;
    _cretval = gdk_display_list_seats(cast(GdkDisplay*)cPtr);
    List!(Seat) _retval = new List!(Seat)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Returns the keyvals bound to keycode.
   * The Nth `GdkKeymapKey` in keys is bound to the Nth keyval in keyvals.
   * When a keycode is pressed by the user, the keyval from
   * this list of entries is selected by considering the effective
   * keyboard group and level.
   * Free the returned arrays with [GLib.Global.gfree].
   * Params:
   *   keycode = a keycode
   *   keys = return
   *     location for array of `GdkKeymapKey`
   *   keyvals = return
   *     location for array of keyvals
   * Returns: %TRUE if there were any entries
   */
  bool mapKeycode(uint keycode, out KeymapKey[] keys, out uint[] keyvals)
  {
    bool _retval;
    int _nEntries;
    GdkKeymapKey* _keys;
    uint* _keyvals;
    _retval = gdk_display_map_keycode(cast(GdkDisplay*)cPtr, keycode, &_keys, &_keyvals, &_nEntries);
    keys = _keys[0 .. _nEntries];
    safeFree(cast(void*)_keys);
    keyvals = _keyvals[0 .. _nEntries];
    safeFree(cast(void*)_keyvals);
    return _retval;
  }

  /**
   * Obtains a list of keycode/group/level combinations that will
   * generate keyval.
   * Groups and levels are two kinds of keyboard mode; in general, the level
   * determines whether the top or bottom symbol on a key is used, and the
   * group determines whether the left or right symbol is used.
   * On US keyboards, the shift key changes the keyboard level, and there
   * are no groups. A group switch key might convert a keyboard between
   * Hebrew to English modes, for example.
   * `GdkEventKey` contains a %group field that indicates the active
   * keyboard group. The level is computed from the modifier mask.
   * The returned array should be freed with [GLib.Global.gfree].
   * Params:
   *   keyval = a keyval, such as %GDK_KEY_a, %GDK_KEY_Up, %GDK_KEY_Return, etc.
   *   keys = return location
   *     for an array of `GdkKeymapKey`
   * Returns: %TRUE if keys were found and returned
   */
  bool mapKeyval(uint keyval, out KeymapKey[] keys)
  {
    bool _retval;
    int _nKeys;
    GdkKeymapKey* _keys;
    _retval = gdk_display_map_keyval(cast(GdkDisplay*)cPtr, keyval, &_keys, &_nKeys);
    keys = _keys[0 .. _nKeys];
    safeFree(cast(void*)_keys);
    return _retval;
  }

  /**
   * Indicates to the GUI environment that the application has
   * finished loading, using a given identifier.
   * GTK will call this function automatically for [GtkWindow](../gtk4/class.Window.html)
   * with custom startup-notification identifier unless
   * [[Gtk.Window.setAutoStartupNotification]](../gtk4/method.Window.set_auto_startup_notification.html)
   * is called to disable that feature.
   * Params:
   *   startupId = a startup-notification identifier, for which
   *     notification process should be completed

   * Deprecated: Using [Gdk.Toplevel.setStartupId] is sufficient
   */
  void notifyStartupComplete(string startupId)
  {
    const(char)* _startupId = startupId.toCString(false);
    gdk_display_notify_startup_complete(cast(GdkDisplay*)cPtr, _startupId);
  }

  /**
   * Checks that OpenGL is available for self and ensures that it is
   * properly initialized.
   * When this fails, an error will be set describing the error and this
   * function returns %FALSE.
   * Note that even if this function succeeds, creating a `GdkGLContext`
   * may still fail.
   * This function is idempotent. Calling it multiple times will just
   * return the same value or error.
   * You never need to call this function, GDK will call it automatically
   * as needed. But you can use it as a check when setting up code that
   * might make use of OpenGL.
   * Returns: %TRUE if the display supports OpenGL
   */
  bool prepareGl()
  {
    bool _retval;
    GError *_err;
    _retval = gdk_display_prepare_gl(cast(GdkDisplay*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Adds the given event to the event queue for display.
   * Params:
   *   event = a `GdkEvent`

   * Deprecated: This function is only useful in very
   *   special situations and should not be used by applications.
   */
  void putEvent(Event event)
  {
    gdk_display_put_event(cast(GdkDisplay*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null);
  }

  /**
   * Returns %TRUE if the display supports input shapes.
   * This means that [Gdk.Surface.setInputRegion] can
   * be used to modify the input shape of surfaces on display.
   * On modern displays, this value is always %TRUE.
   * Returns: %TRUE if surfaces with modified input shape are supported
   */
  bool supportsInputShapes()
  {
    bool _retval;
    _retval = gdk_display_supports_input_shapes(cast(GdkDisplay*)cPtr);
    return _retval;
  }

  /**
   * Returns whether it's possible for a surface to draw outside of the window area.
   * If %TRUE is returned the application decides if it wants to draw shadows.
   * If %FALSE is returned, the compositor decides if it wants to draw shadows.
   * Returns: %TRUE if surfaces can draw shadows or
   *   %FALSE if the display does not support this functionality.
   */
  bool supportsShadowWidth()
  {
    bool _retval;
    _retval = gdk_display_supports_shadow_width(cast(GdkDisplay*)cPtr);
    return _retval;
  }

  /**
   * Flushes any requests queued for the windowing system and waits until all
   * requests have been handled.
   * This is often used for making sure that the display is synchronized
   * with the current state of the program. Calling [Gdk.Display.sync]
   * before methodGdkX11.Display.error_trap_pop makes sure that any errors
   * generated from earlier requests are handled before the error trap is removed.
   * This is most useful for X11. On windowing systems where requests are
   * handled synchronously, this function will do nothing.
   */
  void sync()
  {
    gdk_display_sync(cast(GdkDisplay*)cPtr);
  }

  /**
   * Translates the contents of a `GdkEventKey` into a keyval, effective group,
   * and level.
   * Modifiers that affected the translation and are thus unavailable for
   * application use are returned in consumed_modifiers.
   * The effective_group is the group that was actually used for the
   * translation; some keys such as Enter are not affected by the active
   * keyboard group. The level is derived from state.
   * consumed_modifiers gives modifiers that should be masked out
   * from state when comparing this key press to a keyboard shortcut.
   * For instance, on a US keyboard, the `plus` symbol is shifted, so
   * when comparing a key press to a `<Control>plus` accelerator `<Shift>`
   * should be masked out.
   * This function should rarely be needed, since `GdkEventKey` already
   * contains the translated keyval. It is exported for the benefit of
   * virtualized test environments.
   * Params:
   *   keycode = a keycode
   *   state = a modifier state
   *   group = active keyboard group
   *   keyval = return location for keyval
   *   effectiveGroup = return location for effective group
   *   level = return location for level
   *   consumed = return location for modifiers that were used
   *     to determine the group or level
   * Returns: %TRUE if there was a keyval bound to keycode/state/group.
   */
  bool translateKey(uint keycode, ModifierType state, int group, out uint keyval, out int effectiveGroup, out int level, out ModifierType consumed)
  {
    bool _retval;
    _retval = gdk_display_translate_key(cast(GdkDisplay*)cPtr, keycode, state, group, cast(uint*)&keyval, cast(int*)&effectiveGroup, cast(int*)&level, &consumed);
    return _retval;
  }

  /**
   * Emitted when the connection to the windowing system for display is closed.
   * Params
   *   isError = %TRUE if the display was closed due to an error
   *   display = the instance the signal is connected to
   */
  alias ClosedCallback = void delegate(bool isError, Display display);

  /**
   * Connect to Closed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectClosed(ClosedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto display = getVal!Display(_paramVals);
      auto isError = getVal!bool(&_paramVals[1]);
      _dgClosure.dlg(isError, display);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("closed", closure, after);
  }

  /**
   * Emitted when the connection to the windowing system for display is opened.
   *   display = the instance the signal is connected to
   */
  alias OpenedCallback = void delegate(Display display);

  /**
   * Connect to Opened signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectOpened(OpenedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto display = getVal!Display(_paramVals);
      _dgClosure.dlg(display);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("opened", closure, after);
  }

  /**
   * Emitted whenever a new seat is made known to the windowing system.
   * Params
   *   seat = the seat that was just added
   *   display = the instance the signal is connected to
   */
  alias SeatAddedCallback = void delegate(Seat seat, Display display);

  /**
   * Connect to SeatAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSeatAdded(SeatAddedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto display = getVal!Display(_paramVals);
      auto seat = getVal!Seat(&_paramVals[1]);
      _dgClosure.dlg(seat, display);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("seat-added", closure, after);
  }

  /**
   * Emitted whenever a seat is removed by the windowing system.
   * Params
   *   seat = the seat that was just removed
   *   display = the instance the signal is connected to
   */
  alias SeatRemovedCallback = void delegate(Seat seat, Display display);

  /**
   * Connect to SeatRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSeatRemoved(SeatRemovedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto display = getVal!Display(_paramVals);
      auto seat = getVal!Seat(&_paramVals[1]);
      _dgClosure.dlg(seat, display);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("seat-removed", closure, after);
  }

  /**
   * Emitted whenever a setting changes its value.
   * Params
   *   setting = the name of the setting that changed
   *   display = the instance the signal is connected to
   */
  alias SettingChangedCallback = void delegate(string setting, Display display);

  /**
   * Connect to SettingChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSettingChanged(SettingChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto display = getVal!Display(_paramVals);
      auto setting = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(setting, display);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("setting-changed", closure, after);
  }
}

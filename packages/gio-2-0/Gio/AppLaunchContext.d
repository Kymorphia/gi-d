module Gio.AppLaunchContext;

import GLib.VariantG;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.AppInfo;
import Gio.AppInfoT;
import Gio.File;
import Gio.FileT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Integrating the launch with the launching application. This is used to
 * handle for instance startup notification and launching the new application
 * on the same screen as the launching window.
 */
class AppLaunchContext : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_app_launch_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new application launch context. This is not normally used,
   * instead you instantiate a subclass of this, such as #GdkAppLaunchContext.
   * Returns: a #GAppLaunchContext.
   */
  this()
  {
    GAppLaunchContext* _cretval;
    _cretval = g_app_launch_context_new();
    this(_cretval, true);
  }

  /**
   * Gets the display string for the context. This is used to ensure new
   * applications are started on the same display as the launching
   * application, by setting the `DISPLAY` environment variable.
   * Params:
   *   info = a #GAppInfo
   *   files = a #GList of #GFile objects
   * Returns: a display string for the display.
   */
  string getDisplay(AppInfo info, File[] files)
  {
    char* _cretval;
    auto _files = gListFromD!(File)(files);
    scope(exit) containerFree!(GList*, File, GidOwnership.None)(_files);
    _cretval = g_app_launch_context_get_display(cast(GAppLaunchContext*)cPtr, info ? cast(GAppInfo*)(cast(ObjectG)info).cPtr(false) : null, _files);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the complete environment variable list to be passed to
   * the child process when context is used to launch an application.
   * This is a %NULL-terminated array of strings, where each string has
   * the form `KEY\=VALUE`.
   * Returns: the child's environment
   */
  string[] getEnvironment()
  {
    char** _cretval;
    _cretval = g_app_launch_context_get_environment(cast(GAppLaunchContext*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Initiates startup notification for the application and returns the
   * `XDG_ACTIVATION_TOKEN` or `DESKTOP_STARTUP_ID` for the launched operation,
   * if supported.
   * The returned token may be referred to equivalently as an ‘activation token’
   * $(LPAREN)using Wayland terminology$(RPAREN) or a ‘startup sequence ID’ $(LPAREN)using X11 terminology$(RPAREN).
   * The two [are interoperable](https://gitlab.freedesktop.org/wayland/wayland-protocols/-/blob/main/staging/xdg-activation/x11-interoperation.rst).
   * Activation tokens are defined in the [XDG Activation Protocol](https://wayland.app/protocols/xdg-activation-v1),
   * and startup notification IDs are defined in the
   * [freedesktop.org Startup Notification Protocol](http://standards.freedesktop.org/startup-notification-spec/startup-notification-latest.txt).
   * Support for the XDG Activation Protocol was added in GLib 2.76.
   * Params:
   *   info = a #GAppInfo
   *   files = a #GList of #GFile objects
   * Returns: a startup notification ID for the application, or %NULL if
   *   not supported.
   */
  string getStartupNotifyId(AppInfo info, File[] files)
  {
    char* _cretval;
    auto _files = gListFromD!(File)(files);
    scope(exit) containerFree!(GList*, File, GidOwnership.None)(_files);
    _cretval = g_app_launch_context_get_startup_notify_id(cast(GAppLaunchContext*)cPtr, info ? cast(GAppInfo*)(cast(ObjectG)info).cPtr(false) : null, _files);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Called when an application has failed to launch, so that it can cancel
   * the application startup notification started in [Gio.AppLaunchContext.getStartupNotifyId].
   * Params:
   *   startupNotifyId = the startup notification id that was returned by [Gio.AppLaunchContext.getStartupNotifyId].
   */
  void launchFailed(string startupNotifyId)
  {
    const(char)* _startupNotifyId = startupNotifyId.toCString(false);
    g_app_launch_context_launch_failed(cast(GAppLaunchContext*)cPtr, _startupNotifyId);
  }

  /**
   * Arranges for variable to be set to value in the child's
   * environment when context is used to launch an application.
   * Params:
   *   variable = the environment variable to set
   *   value = the value for to set the variable to.
   */
  void setenv(string variable, string value)
  {
    const(char)* _variable = variable.toCString(false);
    const(char)* _value = value.toCString(false);
    g_app_launch_context_setenv(cast(GAppLaunchContext*)cPtr, _variable, _value);
  }

  /**
   * Arranges for variable to be unset in the child's environment
   * when context is used to launch an application.
   * Params:
   *   variable = the environment variable to remove
   */
  void unsetenv(string variable)
  {
    const(char)* _variable = variable.toCString(false);
    g_app_launch_context_unsetenv(cast(GAppLaunchContext*)cPtr, _variable);
  }

  /**
   * The #GAppLaunchContext::launch-failed signal is emitted when a #GAppInfo launch
   * fails. The startup notification id is provided, so that the launcher
   * can cancel the startup notification.
   * Because a launch operation may involve spawning multiple instances of the
   * target application, you should expect this signal to be emitted multiple
   * times, one for each spawned instance.
   * Params
   *   startupNotifyId = the startup notification id for the failed launch
   *   appLaunchContext = the instance the signal is connected to
   */
  alias LaunchFailedCallback = void delegate(string startupNotifyId, AppLaunchContext appLaunchContext);

  /**
   * Connect to LaunchFailed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLaunchFailed(LaunchFailedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appLaunchContext = getVal!AppLaunchContext(_paramVals);
      auto startupNotifyId = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(startupNotifyId, appLaunchContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("launch-failed", closure, after);
  }

  /**
   * The #GAppLaunchContext::launch-started signal is emitted when a #GAppInfo is
   * about to be launched. If non-null the platform_data is an
   * GVariant dictionary mapping strings to variants $(LPAREN)ie `a{sv}`$(RPAREN), which
   * contains additional, platform-specific data about this launch. On
   * UNIX, at least the `startup-notification-id` keys will be
   * present.
   * The value of the `startup-notification-id` key $(LPAREN)type `s`$(RPAREN) is a startup
   * notification ID corresponding to the format from the [startup-notification
   * specification]$(LPAREN)https://specifications.freedesktop.org/startup-notification-spec/startup-notification-0.1.txt$(RPAREN).
   * It allows tracking the progress of the launchee through startup.
   * It is guaranteed that this signal is followed by either a #GAppLaunchContext::launched or
   * #GAppLaunchContext::launch-failed signal.
   * Because a launch operation may involve spawning multiple instances of the
   * target application, you should expect this signal to be emitted multiple
   * times, one for each spawned instance.
   * Params
   *   info = the #GAppInfo that is about to be launched
   *   platformData = additional platform-specific data for this launch
   *   appLaunchContext = the instance the signal is connected to
   */
  alias LaunchStartedCallback = void delegate(AppInfo info, VariantG platformData, AppLaunchContext appLaunchContext);

  /**
   * Connect to LaunchStarted signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLaunchStarted(LaunchStartedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appLaunchContext = getVal!AppLaunchContext(_paramVals);
      auto info = getVal!AppInfo(&_paramVals[1]);
      auto platformData = getVal!VariantG(&_paramVals[2]);
      _dgClosure.dlg(info, platformData, appLaunchContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("launch-started", closure, after);
  }

  /**
   * The #GAppLaunchContext::launched signal is emitted when a #GAppInfo is successfully
   * launched.
   * Because a launch operation may involve spawning multiple instances of the
   * target application, you should expect this signal to be emitted multiple
   * times, one time for each spawned instance.
   * The platform_data is an GVariant dictionary mapping
   * strings to variants $(LPAREN)ie `a{sv}`$(RPAREN), which contains additional,
   * platform-specific data about this launch. On UNIX, at least the
   * `pid` and `startup-notification-id` keys will be present.
   * Since 2.72 the `pid` may be 0 if the process id wasn't known $(LPAREN)for
   * example if the process was launched via D-Bus$(RPAREN). The `pid` may not be
   * set at all in subsequent releases.
   * On Windows, `pid` is guaranteed to be valid only for the duration of the
   * #GAppLaunchContext::launched signal emission; after the signal is emitted,
   * GLib will call [GLib.Global.spawnClosePid]. If you need to keep the #GPid after the
   * signal has been emitted, then you can duplicate `pid` using `DuplicateHandle$(LPAREN)$(RPAREN)`.
   * Params
   *   info = the #GAppInfo that was just launched
   *   platformData = additional platform-specific data for this launch
   *   appLaunchContext = the instance the signal is connected to
   */
  alias LaunchedCallback = void delegate(AppInfo info, VariantG platformData, AppLaunchContext appLaunchContext);

  /**
   * Connect to Launched signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLaunched(LaunchedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appLaunchContext = getVal!AppLaunchContext(_paramVals);
      auto info = getVal!AppInfo(&_paramVals[1]);
      auto platformData = getVal!VariantG(&_paramVals[2]);
      _dgClosure.dlg(info, platformData, appLaunchContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("launched", closure, after);
  }
}

module Gio.AppLaunchContext;

import GLib.List;
import GLib.Types;
import GLib.Variant;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AppInfo;
import Gio.File;
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

  /**
   * a #GAppLaunchContext.
   */
  this()
  {
    GAppLaunchContext* _cretval;
    _cretval = g_app_launch_context_new();
    this(_cretval, true);
  }

  /**
   * a display string for the display.
   */
  string getDisplay(AppInfo info, List!(File, GFile*) files)
  {
    char* _cretval;
    _cretval = g_app_launch_context_get_display(cPtr!GAppLaunchContext, info ? (cast(ObjectG)info).cPtr!GAppInfo : null, files.cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the child's environment
   */
  string[] getEnvironment()
  {
    char** _cretval;
    _cretval = g_app_launch_context_get_environment(cPtr!GAppLaunchContext);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * a startup notification ID for the application, or %NULL if
   * not supported.
   */
  string getStartupNotifyId(AppInfo info, List!(File, GFile*) files)
  {
    char* _cretval;
    _cretval = g_app_launch_context_get_startup_notify_id(cPtr!GAppLaunchContext, info ? (cast(ObjectG)info).cPtr!GAppInfo : null, files.cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Called when an application has failed to launch, so that it can cancel
   * the application startup notification started in g_app_launch_context_get_startup_notify_id().
   */
  void launchFailed(string startupNotifyId)
  {
    const(char)* _startupNotifyId = startupNotifyId.toCString(false);
    g_app_launch_context_launch_failed(cPtr!GAppLaunchContext, _startupNotifyId);
  }

  /**
   * Arranges for @variable to be set to @value in the child's
   * environment when @context is used to launch an application.
   */
  void setenv(string variable, string value)
  {
    const(char)* _variable = variable.toCString(false);
    const(char)* _value = value.toCString(false);
    g_app_launch_context_setenv(cPtr!GAppLaunchContext, _variable, _value);
  }

  /**
   * Arranges for @variable to be unset in the child's environment
   * when @context is used to launch an application.
   */
  void unsetenv(string variable)
  {
    const(char)* _variable = variable.toCString(false);
    g_app_launch_context_unsetenv(cPtr!GAppLaunchContext, _variable);
  }

  /**
   * The #GAppLaunchContext::launch-failed signal is emitted when a #GAppInfo launch
   * fails. The startup notification id is provided, so that the launcher
   * can cancel the startup notification.
   *
   * Because a launch operation may involve spawning multiple instances of the
   * target application, you should expect this signal to be emitted multiple
   * times, one for each spawned instance.
   */
  ulong connectLaunchFailed(void delegate(string startupNotifyId, AppLaunchContext appLaunchContext) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appLaunchContext = getVal!AppLaunchContext(_paramVals);
      auto startupNotifyId = getVal!string(&_paramVals[1]);
      char* _startupNotifyId = startupNotifyId.toCString(false);
      _dgClosure.dlg(startupNotifyId, appLaunchContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("launch-failed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The #GAppLaunchContext::launch-started signal is emitted when a #GAppInfo is
   * about to be launched. If non-null the @platform_data is an
   * GVariant dictionary mapping strings to variants (ie `a{sv}`), which
   * contains additional, platform-specific data about this launch. On
   * UNIX, at least the `startup-notification-id` keys will be
   * present.
   *
   * The value of the `startup-notification-id` key (type `s`) is a startup
   * notification ID corresponding to the format from the [startup-notification
   * specification](https://specifications.freedesktop.org/startup-notification-spec/startup-notification-0.1.txt).
   * It allows tracking the progress of the launchee through startup.
   *
   * It is guaranteed that this signal is followed by either a #GAppLaunchContext::launched or
   * #GAppLaunchContext::launch-failed signal.
   *
   * Because a launch operation may involve spawning multiple instances of the
   * target application, you should expect this signal to be emitted multiple
   * times, one for each spawned instance.
   */
  ulong connectLaunchStarted(void delegate(AppInfo info, Variant platformData, AppLaunchContext appLaunchContext) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appLaunchContext = getVal!AppLaunchContext(_paramVals);
      auto info = getVal!AppInfo(&_paramVals[1]);
      auto platformData = getVal!Variant(&_paramVals[2]);
      _dgClosure.dlg(info, platformData, appLaunchContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("launch-started", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The #GAppLaunchContext::launched signal is emitted when a #GAppInfo is successfully
   * launched.
   *
   * Because a launch operation may involve spawning multiple instances of the
   * target application, you should expect this signal to be emitted multiple
   * times, one time for each spawned instance.
   *
   * The @platform_data is an GVariant dictionary mapping
   * strings to variants (ie `a{sv}`), which contains additional,
   * platform-specific data about this launch. On UNIX, at least the
   * `pid` and `startup-notification-id` keys will be present.
   *
   * Since 2.72 the `pid` may be 0 if the process id wasn't known (for
   * example if the process was launched via D-Bus). The `pid` may not be
   * set at all in subsequent releases.
   *
   * On Windows, `pid` is guaranteed to be valid only for the duration of the
   * #GAppLaunchContext::launched signal emission; after the signal is emitted,
   * GLib will call g_spawn_close_pid(). If you need to keep the #GPid after the
   * signal has been emitted, then you can duplicate `pid` using `DuplicateHandle()`.
   */
  ulong connectLaunched(void delegate(AppInfo info, Variant platformData, AppLaunchContext appLaunchContext) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appLaunchContext = getVal!AppLaunchContext(_paramVals);
      auto info = getVal!AppInfo(&_paramVals[1]);
      auto platformData = getVal!Variant(&_paramVals[2]);
      _dgClosure.dlg(info, platformData, appLaunchContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("launched", closure, (flags & ConnectFlags.After) != 0);
  }
}

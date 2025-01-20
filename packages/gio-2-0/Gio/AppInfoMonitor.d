module Gio.AppInfoMonitor;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GAppInfoMonitor` monitors application information for changes.
 * `GAppInfoMonitor` is a very simple object used for monitoring the app
 * info database for changes $(LPAREN)newly installed or removed applications$(RPAREN).
 * Call [Gio.AppInfoMonitor.get] to get a `GAppInfoMonitor` and connect
 * to the [Gio.AppInfoMonitor.changed] signal. The signal will be emitted once when
 * the app info database changes, and will not be emitted again until after the
 * next call to [Gio.AppInfo.getAll] or another `g_app_info_*()` function.
 * This is because monitoring the app info database for changes is expensive.
 * The following functions will re-arm the [Gio.AppInfoMonitor.changed]
 * signal so it can be emitted again:
 * - [Gio.AppInfo.getAll]
 * - [Gio.AppInfo.getAllForType]
 * - [Gio.AppInfo.getDefaultForType]
 * - [Gio.AppInfo.getFallbackForType]
 * - [Gio.AppInfo.getRecommendedForType]
 * - [`[Gio.DesktopAppInfo.getImplementations]`](../gio-unix/type_func.DesktopAppInfo.get_implementation.html)
 * - [`[Gio.DesktopAppInfo.new_]`](../gio-unix/ctor.DesktopAppInfo.new.html)
 * - [`[Gio.DesktopAppInfo.newFromFilename]`](../gio-unix/ctor.DesktopAppInfo.new_from_filename.html)
 * - [`[Gio.DesktopAppInfo.newFromKeyfile]`](../gio-unix/ctor.DesktopAppInfo.new_from_keyfile.html)
 * - [`[Gio.DesktopAppInfo.search]`](../gio-unix/type_func.DesktopAppInfo.search.html)
 * The latter functions are available if using
 * [`GDesktopAppInfo`](../gio-unix/class.DesktopAppInfo.html) from
 * `gio-unix-2.0.pc` $(LPAREN)GIR namespace `GioUnix-2.0`$(RPAREN).
 * In the usual case, applications should try to make note of the change
 * $(LPAREN)doing things like invalidating caches$(RPAREN) but not act on it. In
 * particular, applications should avoid making calls to `GAppInfo` APIs
 * in response to the change signal, deferring these until the time that
 * the updated data is actually required. The exception to this case is when
 * application information is actually being displayed on the screen
 * $(LPAREN)for example, during a search or when the list of all applications is shown$(RPAREN).
 * The reason for this is that changes to the list of installed applications
 * often come in groups $(LPAREN)like during system updates$(RPAREN) and rescanning the list
 * on every change is pointless and expensive.
 */
class AppInfoMonitor : ObjectG
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
    return g_app_info_monitor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the #GAppInfoMonitor for the current thread-default main
   * context.
   * The #GAppInfoMonitor will emit a "changed" signal in the
   * thread-default main context whenever the list of installed
   * applications $(LPAREN)as reported by [Gio.AppInfo.getAll]$(RPAREN) may have changed.
   * The #GAppInfoMonitor::changed signal will only be emitted once until
   * [Gio.AppInfo.getAll] $(LPAREN)$(RPAREN)(or another `g_app_info_*` function) is called. Doing
   * so will re-arm the signal ready to notify about the next change.
   * You must only call [GObject.ObjectG.unref] on the return value from under
   * the same main context as you created it.
   * Returns: a reference to a #GAppInfoMonitor
   */
  static AppInfoMonitor get()
  {
    GAppInfoMonitor* _cretval;
    _cretval = g_app_info_monitor_get();
    auto _retval = _cretval ? ObjectG.getDObject!AppInfoMonitor(cast(GAppInfoMonitor*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Signal emitted when the app info database changes, when applications are
   * installed or removed.
   *   appInfoMonitor = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(AppInfoMonitor appInfoMonitor);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto appInfoMonitor = getVal!AppInfoMonitor(_paramVals);
      _dgClosure.dlg(appInfoMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }
}

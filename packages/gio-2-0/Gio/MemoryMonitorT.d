module Gio.MemoryMonitorT;

public import Gio.MemoryMonitorIfaceProxy;
public import GObject.DClosure;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GMemoryMonitor` will monitor system memory and suggest to the application
 * when to free memory so as to leave more room for other applications.
 * It is implemented on Linux using the
 * [Low Memory Monitor](https://gitlab.freedesktop.org/hadess/low-memory-monitor/)
 * $(LPAREN)[API documentation](https://hadess.pages.freedesktop.org/low-memory-monitor/)$(RPAREN).
 * There is also an implementation for use inside Flatpak sandboxes.
 * Possible actions to take when the signal is received are:
 * - Free caches
 * - Save files that haven’t been looked at in a while to disk, ready to be reopened when needed
 * - Run a garbage collection cycle
 * - Try and compress fragmented allocations
 * - Exit on idle if the process has no reason to stay around
 * - Call [`malloc_trim$(LPAREN)3$(RPAREN)`]$(LPAREN)$(RPAREN)(man:malloc_trim3) to return cached heap pages to
 * the kernel $(LPAREN)if supported by your libc$(RPAREN)
 * Note that some actions may not always improve system performance, and so
 * should be profiled for your application. `malloc_trim$(LPAREN)$(RPAREN)`, for example, may
 * make future heap allocations slower $(LPAREN)due to releasing cached heap pages back
 * to the kernel$(RPAREN).
 * See [Gio] for details on the various warning
 * levels.
 * ```c
 * static void
 * warning_cb $(LPAREN)GMemoryMonitor *m, GMemoryMonitorWarningLevel level$(RPAREN)
 * {
 * g_debug $(LPAREN)"Warning level: %d", level$(RPAREN);
 * if $(LPAREN)warning_level > G_MEMORY_MONITOR_WARNING_LEVEL_LOW$(RPAREN)
 * drop_caches $(LPAREN)$(RPAREN);
 * }
 * static GMemoryMonitor *
 * monitor_low_memory $(LPAREN)void$(RPAREN)
 * {
 * GMemoryMonitor *m;
 * m \= g_memory_monitor_dup_default $(LPAREN)$(RPAREN);
 * g_signal_connect $(LPAREN)G_OBJECT $(LPAREN)m$(RPAREN), "low-memory-warning",
 * G_CALLBACK $(LPAREN)warning_cb$(RPAREN), NULL$(RPAREN);
 * return m;
 * }
 * ```
 * Don’t forget to disconnect the signal@Gio.MemoryMonitor::low-memory-warning
 * signal, and unref the `GMemoryMonitor` itself when exiting.
 */
template MemoryMonitorT()
{


  /**
   * Emitted when the system is running low on free memory. The signal
   * handler should then take the appropriate action depending on the
   * warning level. See the #GMemoryMonitorWarningLevel documentation for
   * details.
   * Params
   *   level = the #GMemoryMonitorWarningLevel warning level
   *   memoryMonitor = the instance the signal is connected to
   */
  alias LowMemoryWarningCallback = void delegate(MemoryMonitorWarningLevel level, MemoryMonitor memoryMonitor);

  /**
   * Connect to LowMemoryWarning signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLowMemoryWarning(LowMemoryWarningCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto memoryMonitor = getVal!MemoryMonitor(_paramVals);
      auto level = getVal!MemoryMonitorWarningLevel(&_paramVals[1]);
      _dgClosure.dlg(level, memoryMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("low-memory-warning", closure, after);
  }
}

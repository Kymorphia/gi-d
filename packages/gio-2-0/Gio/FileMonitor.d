module Gio.FileMonitor;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Monitors a file or directory for changes.
 * To obtain a `GFileMonitor` for a file or directory, use
 * [Gio.File.monitor], [Gio.File.monitorFile], or
 * [Gio.File.monitorDirectory].
 * To get informed about changes to the file or directory you are
 * monitoring, connect to the [Gio.FileMonitor.changed] signal. The
 * signal will be emitted in the thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) of the thread that the monitor
 * was created in $(LPAREN)though if the global default main context is blocked, this
 * may cause notifications to be blocked even if the thread-default
 * context is still running$(RPAREN).
 */
class FileMonitor : ObjectG
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
    return g_file_monitor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Cancels a file monitor.
   * Returns: always %TRUE
   */
  bool cancel()
  {
    bool _retval;
    _retval = g_file_monitor_cancel(cast(GFileMonitor*)cPtr);
    return _retval;
  }

  /**
   * Emits the #GFileMonitor::changed signal if a change
   * has taken place. Should be called from file monitor
   * implementations only.
   * Implementations are responsible to call this method from the
   * [thread-default main context][g-main-context-push-thread-default] of the
   * thread that the monitor was created in.
   * Params:
   *   child = a #GFile.
   *   otherFile = a #GFile.
   *   eventType = a set of #GFileMonitorEvent flags.
   */
  void emitEvent(File child, File otherFile, FileMonitorEvent eventType)
  {
    g_file_monitor_emit_event(cast(GFileMonitor*)cPtr, child ? cast(GFile*)(cast(ObjectG)child).cPtr(false) : null, otherFile ? cast(GFile*)(cast(ObjectG)otherFile).cPtr(false) : null, eventType);
  }

  /**
   * Returns whether the monitor is canceled.
   * Returns: %TRUE if monitor is canceled. %FALSE otherwise.
   */
  bool isCancelled()
  {
    bool _retval;
    _retval = g_file_monitor_is_cancelled(cast(GFileMonitor*)cPtr);
    return _retval;
  }

  /**
   * Sets the rate limit to which the monitor will report
   * consecutive change events to the same file.
   * Params:
   *   limitMsecs = a non-negative integer with the limit in milliseconds
   *     to poll for changes
   */
  void setRateLimit(int limitMsecs)
  {
    g_file_monitor_set_rate_limit(cast(GFileMonitor*)cPtr, limitMsecs);
  }

  /**
   * Emitted when file has been changed.
   * If using %G_FILE_MONITOR_WATCH_MOVES on a directory monitor, and
   * the information is available $(LPAREN)and if supported by the backend$(RPAREN),
   * event_type may be %G_FILE_MONITOR_EVENT_RENAMED,
   * %G_FILE_MONITOR_EVENT_MOVED_IN or %G_FILE_MONITOR_EVENT_MOVED_OUT.
   * In all cases file will be a child of the monitored directory.  For
   * renames, file will be the old name and other_file is the new
   * name.  For "moved in" events, file is the name of the file that
   * appeared and other_file is the old name that it was moved from $(LPAREN)in
   * another directory$(RPAREN).  For "moved out" events, file is the name of
   * the file that used to be in this directory and other_file is the
   * name of the file at its new location.
   * It makes sense to treat %G_FILE_MONITOR_EVENT_MOVED_IN as
   * equivalent to %G_FILE_MONITOR_EVENT_CREATED and
   * %G_FILE_MONITOR_EVENT_MOVED_OUT as equivalent to
   * %G_FILE_MONITOR_EVENT_DELETED, with extra information.
   * %G_FILE_MONITOR_EVENT_RENAMED is equivalent to a delete/create
   * pair.  This is exactly how the events will be reported in the case
   * that the %G_FILE_MONITOR_WATCH_MOVES flag is not in use.
   * If using the deprecated flag %G_FILE_MONITOR_SEND_MOVED flag and event_type is
   * %G_FILE_MONITOR_EVENT_MOVED, file will be set to a #GFile containing the
   * old path, and other_file will be set to a #GFile containing the new path.
   * In all the other cases, other_file will be set to #NULL.
   * Params
   *   file = a #GFile.
   *   otherFile = a #GFile or #NULL.
   *   eventType = a #GFileMonitorEvent.
   *   fileMonitor = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(File file, File otherFile, FileMonitorEvent eventType, FileMonitor fileMonitor);

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
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto fileMonitor = getVal!FileMonitor(_paramVals);
      auto file = getVal!File(&_paramVals[1]);
      auto otherFile = getVal!File(&_paramVals[2]);
      auto eventType = getVal!FileMonitorEvent(&_paramVals[3]);
      _dgClosure.dlg(file, otherFile, eventType, fileMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }
}

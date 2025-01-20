module Gio.UnixMountMonitor;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Watches #GUnixMounts for changes.
 */
class UnixMountMonitor : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_unix_mount_monitor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Deprecated alias for [Gio.UnixMountMonitor.get].
   * This function was never a true constructor, which is why it was
   * renamed.
   * Returns: a #GUnixMountMonitor.

   * Deprecated: Use [Gio.UnixMountMonitor.get] instead.
   */
  this()
  {
    GUnixMountMonitor* _cretval;
    _cretval = g_unix_mount_monitor_new();
    this(_cretval, true);
  }

  /**
   * Gets the #GUnixMountMonitor for the current thread-default main
   * context.
   * The mount monitor can be used to monitor for changes to the list of
   * mounted filesystems as well as the list of mount points $(LPAREN)ie: fstab
   * entries$(RPAREN).
   * You must only call [GObject.ObjectG.unref] on the return value from under
   * the same main context as you called this function.
   * Returns: the #GUnixMountMonitor.
   */
  static UnixMountMonitor get()
  {
    GUnixMountMonitor* _cretval;
    _cretval = g_unix_mount_monitor_get();
    auto _retval = _cretval ? ObjectG.getDObject!UnixMountMonitor(cast(GUnixMountMonitor*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function does nothing.
   * Before 2.44, this was a partially-effective way of controlling the
   * rate at which events would be reported under some uncommon
   * circumstances.  Since mount_monitor is a singleton, it also meant
   * that calling this function would have side effects for other users of
   * the monitor.
   * Params:
   *   limitMsec = a integer with the limit in milliseconds to
   *     poll for changes.

   * Deprecated: This function does nothing.  Don't call it.
   */
  void setRateLimit(int limitMsec)
  {
    g_unix_mount_monitor_set_rate_limit(cast(GUnixMountMonitor*)cPtr, limitMsec);
  }

  /**
   * Emitted when the unix mount points have changed.
   *   unixMountMonitor = the instance the signal is connected to
   */
  alias MountpointsChangedCallback = void delegate(UnixMountMonitor unixMountMonitor);

  /**
   * Connect to MountpointsChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountpointsChanged(MountpointsChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto unixMountMonitor = getVal!UnixMountMonitor(_paramVals);
      _dgClosure.dlg(unixMountMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mountpoints-changed", closure, after);
  }

  /**
   * Emitted when the unix mounts have changed.
   *   unixMountMonitor = the instance the signal is connected to
   */
  alias MountsChangedCallback = void delegate(UnixMountMonitor unixMountMonitor);

  /**
   * Connect to MountsChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountsChanged(MountsChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto unixMountMonitor = getVal!UnixMountMonitor(_paramVals);
      _dgClosure.dlg(unixMountMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mounts-changed", closure, after);
  }
}

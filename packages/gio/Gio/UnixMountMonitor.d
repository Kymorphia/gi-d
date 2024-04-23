module Gio.UnixMountMonitor;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
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

  /**
   * a #GUnixMountMonitor.
   */
  this()
  {
    GUnixMountMonitor* _cretval;
    _cretval = g_unix_mount_monitor_new();
    this(_cretval, true);
  }

  /**
   * the #GUnixMountMonitor.
   */
  static UnixMountMonitor get()
  {
    GUnixMountMonitor* _cretval;
    _cretval = g_unix_mount_monitor_get();
    UnixMountMonitor _retval = ObjectG.getDObject!UnixMountMonitor(cast(GUnixMountMonitor*)_cretval, true);
    return _retval;
  }

  /**
   * This function does nothing.
   *
   * Before 2.44, this was a partially-effective way of controlling the
   * rate at which events would be reported under some uncommon
   * circumstances.  Since @mount_monitor is a singleton, it also meant
   * that calling this function would have side effects for other users of
   * the monitor.
   */
  void setRateLimit(int limitMsec)
  {
    g_unix_mount_monitor_set_rate_limit(cPtr!GUnixMountMonitor, limitMsec);
  }

  /**
   * Emitted when the unix mount points have changed.
   */
  ulong connectMountpointsChanged(void delegate(UnixMountMonitor unixMountMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto unixMountMonitor = getVal!UnixMountMonitor(_paramVals);
      _dgClosure.dlg(unixMountMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mountpoints-changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the unix mounts have changed.
   */
  ulong connectMountsChanged(void delegate(UnixMountMonitor unixMountMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto unixMountMonitor = getVal!UnixMountMonitor(_paramVals);
      _dgClosure.dlg(unixMountMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mounts-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

module Gio.NetworkMonitorT;

public import GLib.ErrorG;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.SocketConnectable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GNetworkMonitor provides an easy-to-use cross-platform API
 * for monitoring network connectivity. On Linux, the available
 * implementations are based on the kernel's netlink interface and
 * on NetworkManager.
 *
 * There is also an implementation for use inside Flatpak sandboxes.
 */
template NetworkMonitorT(TStruct)
{

  /**
   * a #GNetworkMonitor, which will be
   * a dummy object if no network monitor is available
   */
  static NetworkMonitor getDefault()
  {
    GNetworkMonitor* _cretval;
    _cretval = g_network_monitor_get_default();
    NetworkMonitor _retval = ObjectG.getDObject!NetworkMonitor(cast(GNetworkMonitor*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if @connectable is reachable, %FALSE if not.
   */
  override bool canReach(SocketConnectable connectable, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_network_monitor_can_reach(cPtr!GNetworkMonitor, connectable ? (cast(ObjectG)connectable).cPtr!GSocketConnectable : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously attempts to determine whether or not the host
   * pointed to by @connectable can be reached, without actually
   * trying to connect to it.
   *
   * For more details, see g_network_monitor_can_reach().
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_network_monitor_can_reach_finish()
   * to get the result of the operation.
   */
  override void canReachAsync(SocketConnectable connectable, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_network_monitor_can_reach_async(cPtr!GNetworkMonitor, connectable ? (cast(ObjectG)connectable).cPtr!GSocketConnectable : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if network is reachable, %FALSE if not.
   */
  override bool canReachFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_network_monitor_can_reach_finish(cPtr!GNetworkMonitor, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the network connectivity state
   */
  override NetworkConnectivity getConnectivity()
  {
    GNetworkConnectivity _cretval;
    _cretval = g_network_monitor_get_connectivity(cPtr!GNetworkMonitor);
    NetworkConnectivity _retval = cast(NetworkConnectivity)_cretval;
    return _retval;
  }

  /**
   * whether the network is available
   */
  override bool getNetworkAvailable()
  {
    bool _retval;
    _retval = g_network_monitor_get_network_available(cPtr!GNetworkMonitor);
    return _retval;
  }

  /**
   * whether the connection is metered
   */
  override bool getNetworkMetered()
  {
    bool _retval;
    _retval = g_network_monitor_get_network_metered(cPtr!GNetworkMonitor);
    return _retval;
  }

  /**
   * Emitted when the network configuration changes.
   */
  ulong connectNetworkChanged(void delegate(bool networkAvailable, NetworkMonitor networkMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto networkMonitor = getVal!NetworkMonitor(_paramVals);
      auto networkAvailable = getVal!bool(&_paramVals[1]);
      _dgClosure.dlg(networkAvailable, networkMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("network-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

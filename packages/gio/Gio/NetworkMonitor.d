module Gio.NetworkMonitor;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.SocketConnectable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GNetworkMonitor provides an easy-to-use cross-platform API
 * for monitoring network connectivity. On Linux, the available
 * implementations are based on the kernel's netlink interface and
 * on NetworkManager.
 *
 * There is also an implementation for use inside Flatpak sandboxes.
 */
interface NetworkMonitor
{

  static GType getType()
  {
    return g_network_monitor_get_type();
  }

  /**
   * a #GNetworkMonitor, which will be
   * a dummy object if no network monitor is available
   */
  static NetworkMonitor getDefault();

  /**
   * %TRUE if @connectable is reachable, %FALSE if not.
   */
  bool canReach(SocketConnectable connectable, Cancellable cancellable);

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
  void canReachAsync(SocketConnectable connectable, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if network is reachable, %FALSE if not.
   */
  bool canReachFinish(AsyncResult result);

  /**
   * the network connectivity state
   */
  NetworkConnectivity getConnectivity();

  /**
   * whether the network is available
   */
  bool getNetworkAvailable();

  /**
   * whether the connection is metered
   */
  bool getNetworkMetered();

  /**
   * Emitted when the network configuration changes.
   */
  ulong connectNetworkChanged(void delegate(bool networkAvailable, NetworkMonitor networkMonitor) dlg, ConnectFlags flags = ConnectFlags.Default);
}

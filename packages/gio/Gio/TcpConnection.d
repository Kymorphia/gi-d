module Gio.TcpConnection;

import Gid.Gid;
import Gio.SocketConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This is the subclass of #GSocketConnection that is created
 * for TCP/IP sockets.
 */
class TcpConnection : SocketConnection
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tcp_connection_get_type();
  }

  /**
   * %TRUE if graceful disconnect is used on close, %FALSE otherwise
   */
  bool getGracefulDisconnect()
  {
    bool _retval;
    _retval = g_tcp_connection_get_graceful_disconnect(cPtr!GTcpConnection);
    return _retval;
  }

  /**
   * This enables graceful disconnects on close. A graceful disconnect
   * means that we signal the receiving end that the connection is terminated
   * and wait for it to close the connection before closing the connection.
   *
   * A graceful disconnect means that we can be sure that we successfully sent
   * all the outstanding data to the other end, or get an error reported.
   * However, it also means we have to wait for all the data to reach the
   * other side and for it to acknowledge this by closing the socket, which may
   * take a while. For this reason it is disabled by default.
   */
  void setGracefulDisconnect(bool gracefulDisconnect)
  {
    g_tcp_connection_set_graceful_disconnect(cPtr!GTcpConnection, gracefulDisconnect);
  }
}

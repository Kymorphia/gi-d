module Gio.SocketConnectableT;

public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.SocketAddressEnumerator;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * Objects that describe one or more potential socket endpoints
 * implement #GSocketConnectable. Callers can then use
 * g_socket_connectable_enumerate() to get a #GSocketAddressEnumerator
 * to try out each socket address in turn until one succeeds, as shown
 * in the sample code below.
 *
 * |[<!-- language="C" -->
 * MyConnectionType *
 * connect_to_host (const char    *hostname,
 * guint16        port,
 * GCancellable  *cancellable,
 * GError       **error)
 * {
 * MyConnection *conn = NULL;
 * GSocketConnectable *addr;
 * GSocketAddressEnumerator *enumerator;
 * GSocketAddress *sockaddr;
 * GError *conn_error = NULL;
 *
 * addr = g_network_address_new (hostname, port);
 * enumerator = g_socket_connectable_enumerate (addr);
 * g_object_unref (addr);
 *
 * // Try each sockaddr until we succeed. Record the first connection error,
 * // but not any further ones (since they'll probably be basically the same
 * // as the first).
 * while (!conn && (sockaddr = g_socket_address_enumerator_next (enumerator, cancellable, error))
 * {
 * conn = connect_to_sockaddr (sockaddr, conn_error ? NULL : &conn_error);
 * g_object_unref (sockaddr);
 * }
 * g_object_unref (enumerator);
 *
 * if (conn)
 * {
 * if (conn_error)
 * {
 * // We couldn't connect to the first address, but we succeeded
 * // in connecting to a later address.
 * g_error_free (conn_error);
 * }
 * return conn;
 * }
 * else if (error)
 * {
 * /// Either initial lookup failed, or else the caller cancelled us.
 * if (conn_error)
 * g_error_free (conn_error);
 * return NULL;
 * }
 * else
 * {
 * g_error_propagate (error, conn_error);
 * return NULL;
 * }
 * }
 * ]|
 */
template SocketConnectableT(TStruct)
{

  /**
   * a new #GSocketAddressEnumerator.
   */
  override SocketAddressEnumerator enumerate()
  {
    GSocketAddressEnumerator* _cretval;
    _cretval = g_socket_connectable_enumerate(cPtr!GSocketConnectable);
    SocketAddressEnumerator _retval = ObjectG.getDObject!SocketAddressEnumerator(cast(GSocketAddressEnumerator*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GSocketAddressEnumerator.
   */
  override SocketAddressEnumerator proxyEnumerate()
  {
    GSocketAddressEnumerator* _cretval;
    _cretval = g_socket_connectable_proxy_enumerate(cPtr!GSocketConnectable);
    SocketAddressEnumerator _retval = ObjectG.getDObject!SocketAddressEnumerator(cast(GSocketAddressEnumerator*)_cretval, true);
    return _retval;
  }

  /**
   * the formatted string
   */
  override string toString_()
  {
    char* _cretval;
    _cretval = g_socket_connectable_to_string(cPtr!GSocketConnectable);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

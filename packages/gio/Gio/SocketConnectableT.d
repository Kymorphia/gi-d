module Gio.SocketConnectableT;

public import Gio.SocketConnectableIfaceProxy;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.SocketAddressEnumerator;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * Objects that describe one or more potential socket endpoints
 * implement `GSocketConnectable`. Callers can then use
 * [Gio.SocketConnectable.enumerate] to get a
 * [Gio.SocketAddressEnumerator] to try out each socket address in turn
 * until one succeeds, as shown in the sample code below.
 * ```c
 * MyConnectionType *
 * connect_to_host $(LPAREN)const char    *hostname,
 * guint16        port,
 * GCancellable  *cancellable,
 * GError       **error$(RPAREN)
 * {
 * MyConnection *conn \= NULL;
 * GSocketConnectable *addr;
 * GSocketAddressEnumerator *enumerator;
 * GSocketAddress *sockaddr;
 * GError *conn_error \= NULL;
 * addr \= g_network_address_new $(LPAREN)hostname, port$(RPAREN);
 * enumerator \= g_socket_connectable_enumerate $(LPAREN)addr$(RPAREN);
 * g_object_unref $(LPAREN)addr$(RPAREN);
 * // Try each sockaddr until we succeed. Record the first connection error,
 * // but not any further ones $(LPAREN)since they'll probably be basically the same
 * // as the first$(RPAREN).
 * while $(LPAREN)!conn && $(LPAREN)sockaddr \= g_socket_address_enumerator_next $(LPAREN)enumerator, cancellable, error$(RPAREN)$(RPAREN)
 * {
 * conn \= connect_to_sockaddr $(LPAREN)sockaddr, conn_error ? NULL : &conn_error$(RPAREN);
 * g_object_unref $(LPAREN)sockaddr$(RPAREN);
 * }
 * g_object_unref $(LPAREN)enumerator$(RPAREN);
 * if $(LPAREN)conn$(RPAREN)
 * {
 * if $(LPAREN)conn_error$(RPAREN)
 * {
 * // We couldn't connect to the first address, but we succeeded
 * // in connecting to a later address.
 * g_error_free $(LPAREN)conn_error$(RPAREN);
 * }
 * return conn;
 * }
 * else if $(LPAREN)error$(RPAREN)
 * {
 * /// Either initial lookup failed, or else the caller cancelled us.
 * if $(LPAREN)conn_error$(RPAREN)
 * g_error_free $(LPAREN)conn_error$(RPAREN);
 * return NULL;
 * }
 * else
 * {
 * g_error_propagate $(LPAREN)error, conn_error$(RPAREN);
 * return NULL;
 * }
 * }
 * ```
 */
template SocketConnectableT()
{

  /**
   * Creates a #GSocketAddressEnumerator for connectable.
   * Returns: a new #GSocketAddressEnumerator.
   */
  override SocketAddressEnumerator enumerate()
  {
    GSocketAddressEnumerator* _cretval;
    _cretval = g_socket_connectable_enumerate(cast(GSocketConnectable*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!SocketAddressEnumerator(cast(GSocketAddressEnumerator*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GSocketAddressEnumerator for connectable that will
   * return a #GProxyAddress for each of its addresses that you must connect
   * to via a proxy.
   * If connectable does not implement
   * [Gio.SocketConnectable.proxyEnumerate], this will fall back to
   * calling [Gio.SocketConnectable.enumerate].
   * Returns: a new #GSocketAddressEnumerator.
   */
  override SocketAddressEnumerator proxyEnumerate()
  {
    GSocketAddressEnumerator* _cretval;
    _cretval = g_socket_connectable_proxy_enumerate(cast(GSocketConnectable*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!SocketAddressEnumerator(cast(GSocketAddressEnumerator*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Format a #GSocketConnectable as a string. This is a human-readable format for
   * use in debugging output, and is not a stable serialization format. It is not
   * suitable for use in user interfaces as it exposes too much information for a
   * user.
   * If the #GSocketConnectable implementation does not support string formatting,
   * the implementation’s type name will be returned as a fallback.
   * Returns: the formatted string
   */
  override string toString_()
  {
    char* _cretval;
    _cretval = g_socket_connectable_to_string(cast(GSocketConnectable*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

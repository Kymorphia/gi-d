module Gio.InetSocketAddress;

import GObject.ObjectG;
import Gid.gid;
import Gio.InetAddress;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * An IPv4 or IPv6 socket address. That is, the combination of a
 * [Gio.InetAddress] and a port number.
 * In UNIX terms, `GInetSocketAddress` corresponds to a
 * [`struct sockaddr_in` or `struct sockaddr_in6`]$(LPAREN)$(RPAREN)(man:sockaddr3type).
 */
class InetSocketAddress : SocketAddress
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
    return g_inet_socket_address_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GInetSocketAddress for address and port.
   * Params:
   *   address = a #GInetAddress
   *   port = a port number
   * Returns: a new #GInetSocketAddress
   */
  this(InetAddress address, ushort port)
  {
    GSocketAddress* _cretval;
    _cretval = g_inet_socket_address_new(address ? cast(GInetAddress*)address.cPtr(false) : null, port);
    this(_cretval, true);
  }

  /**
   * Creates a new #GInetSocketAddress for address and port.
   * If address is an IPv6 address, it can also contain a scope ID
   * $(LPAREN)separated from the address by a `%`$(RPAREN).
   * Params:
   *   address = the string form of an IP address
   *   port = a port number
   * Returns: a new #GInetSocketAddress,
   *   or %NULL if address cannot be parsed.
   */
  static InetSocketAddress newFromString(string address, uint port)
  {
    GSocketAddress* _cretval;
    const(char)* _address = address.toCString(false);
    _cretval = g_inet_socket_address_new_from_string(_address, port);
    auto _retval = _cretval ? ObjectG.getDObject!InetSocketAddress(cast(GSocketAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets address's #GInetAddress.
   * Returns: the #GInetAddress for address, which must be
   *   [GObject.ObjectG.ref_]'d if it will be stored
   */
  InetAddress getAddress()
  {
    GInetAddress* _cretval;
    _cretval = g_inet_socket_address_get_address(cast(GInetSocketAddress*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `sin6_flowinfo` field from address,
   * which must be an IPv6 address.
   * Returns: the flowinfo field
   */
  uint getFlowinfo()
  {
    uint _retval;
    _retval = g_inet_socket_address_get_flowinfo(cast(GInetSocketAddress*)cPtr);
    return _retval;
  }

  /**
   * Gets address's port.
   * Returns: the port for address
   */
  ushort getPort()
  {
    ushort _retval;
    _retval = g_inet_socket_address_get_port(cast(GInetSocketAddress*)cPtr);
    return _retval;
  }

  /**
   * Gets the `sin6_scope_id` field from address,
   * which must be an IPv6 address.
   * Returns: the scope id field
   */
  uint getScopeId()
  {
    uint _retval;
    _retval = g_inet_socket_address_get_scope_id(cast(GInetSocketAddress*)cPtr);
    return _retval;
  }
}

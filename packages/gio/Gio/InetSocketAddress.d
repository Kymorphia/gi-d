module Gio.InetSocketAddress;

import GObject.ObjectG;
import Gid.Gid;
import Gio.InetAddress;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * An IPv4 or IPv6 socket address; that is, the combination of a
 * #GInetAddress and a port number.
 */
class InetSocketAddress : SocketAddress, SocketConnectable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_inet_socket_address_get_type();
  }

  mixin SocketConnectableT!GInetSocketAddress;

  /**
   * a new #GInetSocketAddress
   */
  this(InetAddress address, ushort port)
  {
    GSocketAddress* _cretval;
    _cretval = g_inet_socket_address_new(address ? address.cPtr!GInetAddress : null, port);
    this(_cretval, true);
  }

  /**
   * a new #GInetSocketAddress,
   * or %NULL if @address cannot be parsed.
   */
  static SocketAddress newFromString(string address, uint port)
  {
    GSocketAddress* _cretval;
    const(char)* _address = address.toCString(false);
    _cretval = g_inet_socket_address_new_from_string(_address, port);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * the #GInetAddress for @address, which must be
   * g_object_ref()'d if it will be stored
   */
  InetAddress getAddress()
  {
    GInetAddress* _cretval;
    _cretval = g_inet_socket_address_get_address(cPtr!GInetSocketAddress);
    InetAddress _retval = ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, false);
    return _retval;
  }

  /**
   * the flowinfo field
   */
  uint getFlowinfo()
  {
    uint _retval;
    _retval = g_inet_socket_address_get_flowinfo(cPtr!GInetSocketAddress);
    return _retval;
  }

  /**
   * the port for @address
   */
  ushort getPort()
  {
    ushort _retval;
    _retval = g_inet_socket_address_get_port(cPtr!GInetSocketAddress);
    return _retval;
  }

  /**
   * the scope id field
   */
  uint getScopeId()
  {
    uint _retval;
    _retval = g_inet_socket_address_get_scope_id(cPtr!GInetSocketAddress);
    return _retval;
  }
}

module Gio.ProxyAddress;

import GObject.ObjectG;
import Gid.Gid;
import Gio.InetAddress;
import Gio.InetSocketAddress;
import Gio.SocketAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Support for proxied #GInetSocketAddress.
 */
class ProxyAddress : InetSocketAddress
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_proxy_address_get_type();
  }

  /**
   * a new #GProxyAddress
   */
  this(InetAddress inetaddr, ushort port, string protocol, string destHostname, ushort destPort, string username, string password)
  {
    GSocketAddress* _cretval;
    const(char)* _protocol = protocol.toCString(false);
    const(char)* _destHostname = destHostname.toCString(false);
    const(char)* _username = username.toCString(false);
    const(char)* _password = password.toCString(false);
    _cretval = g_proxy_address_new(inetaddr ? inetaddr.cPtr!GInetAddress : null, port, _protocol, _destHostname, destPort, _username, _password);
    this(_cretval, true);
  }

  /**
   * the @proxy's destination hostname
   */
  string getDestinationHostname()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_destination_hostname(cPtr!GProxyAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the @proxy's destination port
   */
  ushort getDestinationPort()
  {
    ushort _retval;
    _retval = g_proxy_address_get_destination_port(cPtr!GProxyAddress);
    return _retval;
  }

  /**
   * the @proxy's destination protocol
   */
  string getDestinationProtocol()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_destination_protocol(cPtr!GProxyAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the @proxy's password
   */
  string getPassword()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_password(cPtr!GProxyAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the @proxy's protocol
   */
  string getProtocol()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_protocol(cPtr!GProxyAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the @proxy's URI, or %NULL if unknown
   */
  string getUri()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_uri(cPtr!GProxyAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the @proxy's username
   */
  string getUsername()
  {
    const(char)* _cretval;
    _cretval = g_proxy_address_get_username(cPtr!GProxyAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}

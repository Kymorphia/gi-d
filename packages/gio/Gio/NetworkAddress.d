module Gio.NetworkAddress;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GNetworkAddress provides an easy way to resolve a hostname and
 * then attempt to connect to that host, handling the possibility of
 * multiple IP addresses and multiple address families.
 *
 * The enumeration results of resolved addresses *may* be cached as long
 * as this object is kept alive which may have unexpected results if
 * alive for too long.
 *
 * See #GSocketConnectable for an example of using the connectable
 * interface.
 */
class NetworkAddress : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_network_address_get_type();
  }

  /**
   * the new #GNetworkAddress
   */
  this(string hostname, ushort port)
  {
    GSocketConnectable* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    _cretval = g_network_address_new(_hostname, port);
    this(_cretval, true);
  }

  /**
   * the new #GNetworkAddress
   */
  static NetworkAddress newLoopback(ushort port)
  {
    GSocketConnectable* _cretval;
    _cretval = g_network_address_new_loopback(port);
    NetworkAddress _retval = ObjectG.getDObject!NetworkAddress(cast(GSocketConnectable*)_cretval, true);
    return _retval;
  }

  /**
   * the new
   * #GNetworkAddress, or %NULL on error
   */
  static NetworkAddress parse(string hostAndPort, ushort defaultPort)
  {
    GSocketConnectable* _cretval;
    const(char)* _hostAndPort = hostAndPort.toCString(false);
    GError *_err;
    _cretval = g_network_address_parse(_hostAndPort, defaultPort, &_err);
    if (_err)
      throw new ErrorG(_err);
    NetworkAddress _retval = ObjectG.getDObject!NetworkAddress(cast(GSocketConnectable*)_cretval, true);
    return _retval;
  }

  /**
   * the new
   * #GNetworkAddress, or %NULL on error
   */
  static NetworkAddress parseUri(string uri, ushort defaultPort)
  {
    GSocketConnectable* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_network_address_parse_uri(_uri, defaultPort, &_err);
    if (_err)
      throw new ErrorG(_err);
    NetworkAddress _retval = ObjectG.getDObject!NetworkAddress(cast(GSocketConnectable*)_cretval, true);
    return _retval;
  }

  /**
   * @addr's hostname
   */
  string getHostname()
  {
    const(char)* _cretval;
    _cretval = g_network_address_get_hostname(cPtr!GNetworkAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @addr's port (which may be 0)
   */
  ushort getPort()
  {
    ushort _retval;
    _retval = g_network_address_get_port(cPtr!GNetworkAddress);
    return _retval;
  }

  /**
   * @addr's scheme (%NULL if not built from URI)
   */
  string getScheme()
  {
    const(char)* _cretval;
    _cretval = g_network_address_get_scheme(cPtr!GNetworkAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}

module Gio.NetworkAddress;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GNetworkAddress` provides an easy way to resolve a hostname and
 * then attempt to connect to that host, handling the possibility of
 * multiple IP addresses and multiple address families.
 * The enumeration results of resolved addresses *may* be cached as long
 * as this object is kept alive which may have unexpected results if
 * alive for too long.
 * See [Gio.SocketConnectable] for an example of using the connectable
 * interface.
 */
class NetworkAddress : ObjectG, SocketConnectable
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
    return g_network_address_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SocketConnectableT!GNetworkAddress;

  /**
   * Creates a new #GSocketConnectable for connecting to the given
   * hostname and port.
   * Note that depending on the configuration of the machine, a
   * hostname of `localhost` may refer to the IPv4 loopback address
   * only, or to both IPv4 and IPv6; use
   * [Gio.NetworkAddress.newLoopback] to create a #GNetworkAddress that
   * is guaranteed to resolve to both addresses.
   * Params:
   *   hostname = the hostname
   *   port = the port
   * Returns: the new #GNetworkAddress
   */
  this(string hostname, ushort port)
  {
    GSocketConnectable* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    _cretval = g_network_address_new(_hostname, port);
    this(_cretval, true);
  }

  /**
   * Creates a new #GSocketConnectable for connecting to the local host
   * over a loopback connection to the given port. This is intended for
   * use in connecting to local services which may be running on IPv4 or
   * IPv6.
   * The connectable will return IPv4 and IPv6 loopback addresses,
   * regardless of how the host resolves `localhost`. By contrast,
   * [Gio.NetworkAddress.new_] will often only return an IPv4 address when
   * resolving `localhost`, and an IPv6 address for `localhost6`.
   * [Gio.NetworkAddress.getHostname] will always return `localhost` for
   * a #GNetworkAddress created with this constructor.
   * Params:
   *   port = the port
   * Returns: the new #GNetworkAddress
   */
  static NetworkAddress newLoopback(ushort port)
  {
    GSocketConnectable* _cretval;
    _cretval = g_network_address_new_loopback(port);
    auto _retval = _cretval ? ObjectG.getDObject!NetworkAddress(cast(GSocketConnectable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GSocketConnectable for connecting to the given
   * hostname and port. May fail and return %NULL in case
   * parsing host_and_port fails.
   * host_and_port may be in any of a number of recognised formats; an IPv6
   * address, an IPv4 address, or a domain name $(LPAREN)in which case a DNS
   * lookup is performed$(RPAREN). Quoting with [] is supported for all address
   * types. A port override may be specified in the usual way with a
   * colon.
   * If no port is specified in host_and_port then default_port will be
   * used as the port number to connect to.
   * In general, host_and_port is expected to be provided by the user
   * $(LPAREN)allowing them to give the hostname, and a port override if necessary$(RPAREN)
   * and default_port is expected to be provided by the application.
   * $(LPAREN)The port component of host_and_port can also be specified as a
   * service name rather than as a numeric port, but this functionality
   * is deprecated, because it depends on the contents of /etc/services,
   * which is generally quite sparse on platforms other than Linux.$(RPAREN)
   * Params:
   *   hostAndPort = the hostname and optionally a port
   *   defaultPort = the default port if not in host_and_port
   * Returns: the new
   *   #GNetworkAddress, or %NULL on error
   */
  static NetworkAddress parse(string hostAndPort, ushort defaultPort)
  {
    GSocketConnectable* _cretval;
    const(char)* _hostAndPort = hostAndPort.toCString(false);
    GError *_err;
    _cretval = g_network_address_parse(_hostAndPort, defaultPort, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!NetworkAddress(cast(GSocketConnectable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GSocketConnectable for connecting to the given
   * uri. May fail and return %NULL in case parsing uri fails.
   * Using this rather than [Gio.NetworkAddress.new_] or
   * [Gio.NetworkAddress.parse] allows #GSocketClient to determine
   * when to use application-specific proxy protocols.
   * Params:
   *   uri = the hostname and optionally a port
   *   defaultPort = The default port if none is found in the URI
   * Returns: the new
   *   #GNetworkAddress, or %NULL on error
   */
  static NetworkAddress parseUri(string uri, ushort defaultPort)
  {
    GSocketConnectable* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_network_address_parse_uri(_uri, defaultPort, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!NetworkAddress(cast(GSocketConnectable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets addr's hostname. This might be either UTF-8 or ASCII-encoded,
   * depending on what addr was created with.
   * Returns: addr's hostname
   */
  string getHostname()
  {
    const(char)* _cretval;
    _cretval = g_network_address_get_hostname(cast(GNetworkAddress*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets addr's port number
   * Returns: addr's port $(LPAREN)which may be 0$(RPAREN)
   */
  ushort getPort()
  {
    ushort _retval;
    _retval = g_network_address_get_port(cast(GNetworkAddress*)cPtr);
    return _retval;
  }

  /**
   * Gets addr's scheme
   * Returns: addr's scheme $(LPAREN)%NULL if not built from URI$(RPAREN)
   */
  string getScheme()
  {
    const(char)* _cretval;
    _cretval = g_network_address_get_scheme(cast(GNetworkAddress*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}

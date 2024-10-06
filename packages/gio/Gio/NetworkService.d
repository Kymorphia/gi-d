module Gio.NetworkService;

import GObject.ObjectG;
import Gid.gid;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Like [Gio.NetworkAddress] does with hostnames, `GNetworkService`
 * provides an easy way to resolve a SRV record, and then attempt to
 * connect to one of the hosts that implements that service, handling
 * service priority/weighting, multiple IP addresses, and multiple
 * address families.
 * See [Gio.SrvTarget] for more information about SRV records, and see
 * [Gio.SocketConnectable] for an example of using the connectable
 * interface.
 */
class NetworkService : ObjectG, SocketConnectable
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
    return g_network_service_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SocketConnectableT!GNetworkService;

  /**
   * Creates a new #GNetworkService representing the given service,
   * protocol, and domain. This will initially be unresolved; use the
   * #GSocketConnectable interface to resolve it.
   * Params:
   *   service = the service type to look up $(LPAREN)eg, "ldap"$(RPAREN)
   *   protocol = the networking protocol to use for service $(LPAREN)eg, "tcp"$(RPAREN)
   *   domain = the DNS domain to look up the service in
   * Returns: a new #GNetworkService
   */
  this(string service, string protocol, string domain)
  {
    GSocketConnectable* _cretval;
    const(char)* _service = service.toCString(false);
    const(char)* _protocol = protocol.toCString(false);
    const(char)* _domain = domain.toCString(false);
    _cretval = g_network_service_new(_service, _protocol, _domain);
    this(_cretval, true);
  }

  /**
   * Gets the domain that srv serves. This might be either UTF-8 or
   * ASCII-encoded, depending on what srv was created with.
   * Returns: srv's domain name
   */
  string getDomain()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_domain(cast(GNetworkService*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets srv's protocol name $(LPAREN)eg, "tcp"$(RPAREN).
   * Returns: srv's protocol name
   */
  string getProtocol()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_protocol(cast(GNetworkService*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the URI scheme used to resolve proxies. By default, the service name
   * is used as scheme.
   * Returns: srv's scheme name
   */
  string getScheme()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_scheme(cast(GNetworkService*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets srv's service name $(LPAREN)eg, "ldap"$(RPAREN).
   * Returns: srv's service name
   */
  string getService()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_service(cast(GNetworkService*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Set's the URI scheme used to resolve proxies. By default, the service name
   * is used as scheme.
   * Params:
   *   scheme = a URI scheme
   */
  void setScheme(string scheme)
  {
    const(char)* _scheme = scheme.toCString(false);
    g_network_service_set_scheme(cast(GNetworkService*)cPtr, _scheme);
  }
}

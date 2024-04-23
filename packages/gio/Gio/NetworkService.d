module Gio.NetworkService;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Like #GNetworkAddress does with hostnames, #GNetworkService
 * provides an easy way to resolve a SRV record, and then attempt to
 * connect to one of the hosts that implements that service, handling
 * service priority/weighting, multiple IP addresses, and multiple
 * address families.
 *
 * See #GSrvTarget for more information about SRV records, and see
 * #GSocketConnectable for an example of using the connectable
 * interface.
 */
class NetworkService : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_network_service_get_type();
  }

  /**
   * a new #GNetworkService
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
   * @srv's domain name
   */
  string getDomain()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_domain(cPtr!GNetworkService);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @srv's protocol name
   */
  string getProtocol()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_protocol(cPtr!GNetworkService);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @srv's scheme name
   */
  string getScheme()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_scheme(cPtr!GNetworkService);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @srv's service name
   */
  string getService()
  {
    const(char)* _cretval;
    _cretval = g_network_service_get_service(cPtr!GNetworkService);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Set's the URI scheme used to resolve proxies. By default, the service name
   * is used as scheme.
   */
  void setScheme(string scheme)
  {
    const(char)* _scheme = scheme.toCString(false);
    g_network_service_set_scheme(cPtr!GNetworkService, _scheme);
  }
}

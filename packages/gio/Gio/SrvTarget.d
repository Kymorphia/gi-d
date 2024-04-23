module Gio.SrvTarget;

import GLib.Boxed;
import GLib.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * SRV (service) records are used by some network protocols to provide
 * service-specific aliasing and load-balancing. For example, XMPP
 * (Jabber) uses SRV records to locate the XMPP server for a domain;
 * rather than connecting directly to "example.com" or assuming a
 * specific server hostname like "xmpp.example.com", an XMPP client
 * would look up the "xmpp-client" SRV record for "example.com", and
 * then connect to whatever host was pointed to by that record.
 *
 * You can use g_resolver_lookup_service() or
 * g_resolver_lookup_service_async() to find the #GSrvTargets
 * for a given service. However, if you are simply planning to connect
 * to the remote service, you can use #GNetworkService's
 * #GSocketConnectable interface and not need to worry about
 * #GSrvTarget at all.
 */
class SrvTarget : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GSrvTarget))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_srv_target_get_type();
  }

  /**
   * a new #GSrvTarget.
   */
  this(string hostname, ushort port, ushort priority, ushort weight)
  {
    GSrvTarget* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    _cretval = g_srv_target_new(_hostname, port, priority, weight);
    this(_cretval, true);
  }

  /**
   * a copy of @target
   */
  SrvTarget copy()
  {
    GSrvTarget* _cretval;
    _cretval = g_srv_target_copy(cPtr!GSrvTarget);
    SrvTarget _retval = new SrvTarget(cast(GSrvTarget*)_cretval, true);
    return _retval;
  }

  /**
   * @target's hostname
   */
  string getHostname()
  {
    const(char)* _cretval;
    _cretval = g_srv_target_get_hostname(cPtr!GSrvTarget);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @target's port
   */
  ushort getPort()
  {
    ushort _retval;
    _retval = g_srv_target_get_port(cPtr!GSrvTarget);
    return _retval;
  }

  /**
   * @target's priority
   */
  ushort getPriority()
  {
    ushort _retval;
    _retval = g_srv_target_get_priority(cPtr!GSrvTarget);
    return _retval;
  }

  /**
   * @target's weight
   */
  ushort getWeight()
  {
    ushort _retval;
    _retval = g_srv_target_get_weight(cPtr!GSrvTarget);
    return _retval;
  }
}

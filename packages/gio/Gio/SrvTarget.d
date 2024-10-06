module Gio.SrvTarget;

import GLib.Boxed;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A single target host/port that a network service is running on.
 * SRV $(LPAREN)service$(RPAREN) records are used by some network protocols to provide
 * service-specific aliasing and load-balancing. For example, XMPP
 * $(LPAREN)Jabber$(RPAREN) uses SRV records to locate the XMPP server for a domain;
 * rather than connecting directly to ‘example.com’ or assuming a
 * specific server hostname like ‘xmpp.example.com’, an XMPP client
 * would look up the `xmpp-client` SRV record for ‘example.com’, and
 * then connect to whatever host was pointed to by that record.
 * You can use [Gio.Resolver.lookupService] or
 * [Gio.Resolver.lookupServiceAsync] to find the `GSrvTarget`s
 * for a given service. However, if you are simply planning to connect
 * to the remote service, you can use [Gio.NetworkService]’s
 * [Gio.SocketConnectable] interface and not need to worry about
 * `GSrvTarget` at all.
 */
class SrvTarget : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_srv_target_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GSrvTarget with the given parameters.
   * You should not need to use this; normally #GSrvTargets are
   * created by #GResolver.
   * Params:
   *   hostname = the host that the service is running on
   *   port = the port that the service is running on
   *   priority = the target's priority
   *   weight = the target's weight
   * Returns: a new #GSrvTarget.
   */
  this(string hostname, ushort port, ushort priority, ushort weight)
  {
    GSrvTarget* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    _cretval = g_srv_target_new(_hostname, port, priority, weight);
    this(_cretval, true);
  }

  /**
   * Copies target
   * Returns: a copy of target
   */
  SrvTarget copy()
  {
    GSrvTarget* _cretval;
    _cretval = g_srv_target_copy(cast(GSrvTarget*)cPtr);
    auto _retval = _cretval ? new SrvTarget(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets target's hostname $(LPAREN)in ASCII form; if you are going to present
   * this to the user, you should use [GLib.Global.hostnameIsAsciiEncoded] to
   * check if it contains encoded Unicode segments, and use
   * [GLib.Global.hostnameToUnicode] to convert it if it does.$(RPAREN)
   * Returns: target's hostname
   */
  string getHostname()
  {
    const(char)* _cretval;
    _cretval = g_srv_target_get_hostname(cast(GSrvTarget*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets target's port
   * Returns: target's port
   */
  ushort getPort()
  {
    ushort _retval;
    _retval = g_srv_target_get_port(cast(GSrvTarget*)cPtr);
    return _retval;
  }

  /**
   * Gets target's priority. You should not need to look at this;
   * #GResolver already sorts the targets according to the algorithm in
   * RFC 2782.
   * Returns: target's priority
   */
  ushort getPriority()
  {
    ushort _retval;
    _retval = g_srv_target_get_priority(cast(GSrvTarget*)cPtr);
    return _retval;
  }

  /**
   * Gets target's weight. You should not need to look at this;
   * #GResolver already sorts the targets according to the algorithm in
   * RFC 2782.
   * Returns: target's weight
   */
  ushort getWeight()
  {
    ushort _retval;
    _retval = g_srv_target_get_weight(cast(GSrvTarget*)cPtr);
    return _retval;
  }
}

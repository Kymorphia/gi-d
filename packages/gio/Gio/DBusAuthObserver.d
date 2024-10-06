module Gio.DBusAuthObserver;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.Credentials;
import Gio.IOStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GDBusAuthObserver` provides a mechanism for participating
 * in how a [Gio.DBusServer] [](or a Gio.DBusConnection)
 * authenticates remote peers.
 * Simply instantiate a `GDBusAuthObserver` and connect to the
 * signals you are interested in. Note that new signals may be added
 * in the future.
 * ## Controlling Authentication Mechanisms
 * By default, a `GDBusServer` or server-side `GDBusConnection` will allow
 * any authentication mechanism to be used. If you only want to allow D-Bus
 * connections with the `EXTERNAL` mechanism, which makes use of credentials
 * passing and is the recommended mechanism for modern Unix platforms such
 * as Linux and the BSD family, you would use a signal handler like this:
 * ```c
 * static gboolean
 * on_allow_mechanism $(LPAREN)GDBusAuthObserver *observer,
 * const gchar       *mechanism,
 * gpointer           user_data$(RPAREN)
 * {
 * if $(LPAREN)g_strcmp0 $(LPAREN)mechanism, "EXTERNAL"$(RPAREN) \=\= 0$(RPAREN)
 * {
 * return TRUE;
 * }
 * return FALSE;
 * }
 * ```
 * ## Controlling Authorization
 * By default, a `GDBusServer` or server-side `GDBusConnection` will accept
 * connections from any successfully authenticated user $(LPAREN)but not from
 * anonymous connections using the `ANONYMOUS` mechanism$(RPAREN). If you only
 * want to allow D-Bus connections from processes owned by the same uid
 * as the server, since GLib 2.68, you should use the
 * `G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER` flag. It’s equivalent
 * to the following signal handler:
 * ```c
 * static gboolean
 * on_authorize_authenticated_peer $(LPAREN)GDBusAuthObserver *observer,
 * GIOStream         *stream,
 * GCredentials      *credentials,
 * gpointer           user_data$(RPAREN)
 * {
 * gboolean authorized;
 * authorized \= FALSE;
 * if $(LPAREN)credentials !\= NULL$(RPAREN)
 * {
 * GCredentials *own_credentials;
 * own_credentials \= g_credentials_new $(LPAREN)$(RPAREN);
 * if $(LPAREN)g_credentials_is_same_user $(LPAREN)credentials, own_credentials, NULL$(RPAREN)$(RPAREN)
 * authorized \= TRUE;
 * g_object_unref $(LPAREN)own_credentials$(RPAREN);
 * }
 * return authorized;
 * }
 * ```
 */
class DBusAuthObserver : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_auth_observer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GDBusAuthObserver object.
   * Returns: A #GDBusAuthObserver. Free with [GObject.ObjectG.unref].
   */
  this()
  {
    GDBusAuthObserver* _cretval;
    _cretval = g_dbus_auth_observer_new();
    this(_cretval, true);
  }

  /**
   * Emits the #GDBusAuthObserver::allow-mechanism signal on observer.
   * Params:
   *   mechanism = The name of the mechanism, e.g. `DBUS_COOKIE_SHA1`.
   * Returns: %TRUE if mechanism can be used to authenticate the other peer, %FALSE if not.
   */
  bool allowMechanism(string mechanism)
  {
    bool _retval;
    const(char)* _mechanism = mechanism.toCString(false);
    _retval = g_dbus_auth_observer_allow_mechanism(cast(GDBusAuthObserver*)cPtr, _mechanism);
    return _retval;
  }

  /**
   * Emits the #GDBusAuthObserver::authorize-authenticated-peer signal on observer.
   * Params:
   *   stream = A #GIOStream for the #GDBusConnection.
   *   credentials = Credentials received from the peer or %NULL.
   * Returns: %TRUE if the peer is authorized, %FALSE if not.
   */
  bool authorizeAuthenticatedPeer(IOStream stream, Credentials credentials)
  {
    bool _retval;
    _retval = g_dbus_auth_observer_authorize_authenticated_peer(cast(GDBusAuthObserver*)cPtr, stream ? cast(GIOStream*)stream.cPtr(false) : null, credentials ? cast(GCredentials*)credentials.cPtr(false) : null);
    return _retval;
  }

  /**
   * Emitted to check if mechanism is allowed to be used.
   * Params
   *   mechanism = The name of the mechanism, e.g. `DBUS_COOKIE_SHA1`.
   *   dBusAuthObserver = the instance the signal is connected to
   * Returns: %TRUE if mechanism can be used to authenticate the other peer, %FALSE if not.
   */
  alias AllowMechanismCallback = bool delegate(string mechanism, DBusAuthObserver dBusAuthObserver);

  /**
   * Connect to AllowMechanism signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAllowMechanism(AllowMechanismCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dBusAuthObserver = getVal!DBusAuthObserver(_paramVals);
      auto mechanism = getVal!string(&_paramVals[1]);
      _retval = _dgClosure.dlg(mechanism, dBusAuthObserver);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("allow-mechanism", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to check if a peer that is successfully authenticated
   * is authorized.
   * Params
   *   stream = A #GIOStream for the #GDBusConnection.
   *   credentials = Credentials received from the peer or %NULL.
   *   dBusAuthObserver = the instance the signal is connected to
   * Returns: %TRUE if the peer is authorized, %FALSE if not.
   */
  alias AuthorizeAuthenticatedPeerCallback = bool delegate(IOStream stream, Credentials credentials, DBusAuthObserver dBusAuthObserver);

  /**
   * Connect to AuthorizeAuthenticatedPeer signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAuthorizeAuthenticatedPeer(AuthorizeAuthenticatedPeerCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dBusAuthObserver = getVal!DBusAuthObserver(_paramVals);
      auto stream = getVal!IOStream(&_paramVals[1]);
      auto credentials = getVal!Credentials(&_paramVals[2]);
      _retval = _dgClosure.dlg(stream, credentials, dBusAuthObserver);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("authorize-authenticated-peer", closure, (flags & ConnectFlags.After) != 0);
  }
}

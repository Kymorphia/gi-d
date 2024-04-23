module Gio.DBusAuthObserver;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Credentials;
import Gio.IOStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GDBusAuthObserver type provides a mechanism for participating
 * in how a #GDBusServer (or a #GDBusConnection) authenticates remote
 * peers. Simply instantiate a #GDBusAuthObserver and connect to the
 * signals you are interested in. Note that new signals may be added
 * in the future
 *
 * ## Controlling Authentication Mechanisms
 *
 * By default, a #GDBusServer or server-side #GDBusConnection will allow
 * any authentication mechanism to be used. If you only
 * want to allow D-Bus connections with the `EXTERNAL` mechanism,
 * which makes use of credentials passing and is the recommended
 * mechanism for modern Unix platforms such as Linux and the BSD family,
 * you would use a signal handler like this:
 *
 * |[<!-- language="C" -->
 * static gboolean
 * on_allow_mechanism (GDBusAuthObserver *observer,
 * const gchar       *mechanism,
 * gpointer           user_data)
 * {
 * if (g_strcmp0 (mechanism, "EXTERNAL") == 0)
 * {
 * return TRUE;
 * }
 *
 * return FALSE;
 * }
 * ]|
 *
 * ## Controlling Authorization # {#auth-observer}
 *
 * By default, a #GDBusServer or server-side #GDBusConnection will accept
 * connections from any successfully authenticated user (but not from
 * anonymous connections using the `ANONYMOUS` mechanism). If you only
 * want to allow D-Bus connections from processes owned by the same uid
 * as the server, since GLib 2.68, you should use the
 * %G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER flag. It’s equivalent
 * to the following signal handler:
 *
 * |[<!-- language="C" -->
 * static gboolean
 * on_authorize_authenticated_peer (GDBusAuthObserver *observer,
 * GIOStream         *stream,
 * GCredentials      *credentials,
 * gpointer           user_data)
 * {
 * gboolean authorized;
 *
 * authorized = FALSE;
 * if (credentials != NULL)
 * {
 * GCredentials *own_credentials;
 * own_credentials = g_credentials_new ();
 * if (g_credentials_is_same_user (credentials, own_credentials, NULL))
 * authorized = TRUE;
 * g_object_unref (own_credentials);
 * }
 *
 * return authorized;
 * }
 * ]|
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

  /**
   * A #GDBusAuthObserver. Free with g_object_unref().
   */
  this()
  {
    GDBusAuthObserver* _cretval;
    _cretval = g_dbus_auth_observer_new();
    this(_cretval, true);
  }

  /**
   * %TRUE if @mechanism can be used to authenticate the other peer, %FALSE if not.
   */
  bool allowMechanism(string mechanism)
  {
    bool _retval;
    const(char)* _mechanism = mechanism.toCString(false);
    _retval = g_dbus_auth_observer_allow_mechanism(cPtr!GDBusAuthObserver, _mechanism);
    return _retval;
  }

  /**
   * %TRUE if the peer is authorized, %FALSE if not.
   */
  bool authorizeAuthenticatedPeer(IOStream stream, Credentials credentials)
  {
    bool _retval;
    _retval = g_dbus_auth_observer_authorize_authenticated_peer(cPtr!GDBusAuthObserver, stream ? stream.cPtr!GIOStream : null, credentials ? credentials.cPtr!GCredentials : null);
    return _retval;
  }

  /**
   * %TRUE if @mechanism can be used to authenticate the other peer, %FALSE if not.
   */
  ulong connectAllowMechanism(bool delegate(string mechanism, DBusAuthObserver dBusAuthObserver) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dBusAuthObserver = getVal!DBusAuthObserver(_paramVals);
      auto mechanism = getVal!string(&_paramVals[1]);
      char* _mechanism = mechanism.toCString(false);
      _retval = _dgClosure.dlg(mechanism, dBusAuthObserver);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("allow-mechanism", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * %TRUE if the peer is authorized, %FALSE if not.
   */
  ulong connectAuthorizeAuthenticatedPeer(bool delegate(IOStream stream, Credentials credentials, DBusAuthObserver dBusAuthObserver) dlg, ConnectFlags flags = ConnectFlags.Default)
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

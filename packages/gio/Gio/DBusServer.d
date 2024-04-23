module Gio.DBusServer;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.DBusAuthObserver;
import Gio.DBusConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDBusServer is a helper for listening to and accepting D-Bus
 * connections. This can be used to create a new D-Bus server, allowing two
 * peers to use the D-Bus protocol for their own specialized communication.
 * A server instance provided in this way will not perform message routing or
 * implement the org.freedesktop.DBus interface.
 *
 * To just export an object on a well-known name on a message bus, such as the
 * session or system bus, you should instead use g_bus_own_name().
 *
 * An example of peer-to-peer communication with GDBus can be found
 * in [gdbus-example-peer.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-peer.c).
 *
 * Note that a minimal #GDBusServer will accept connections from any
 * peer. In many use-cases it will be necessary to add a #GDBusAuthObserver
 * that only accepts connections that have successfully authenticated
 * as the same user that is running the #GDBusServer. Since GLib 2.68 this can
 * be achieved more simply by passing the
 * %G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER flag to the server.
 */
class DBusServer : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_server_get_type();
  }

  /**
   * A #GDBusServer or %NULL if @error is set. Free with
   * g_object_unref().
   */
  static DBusServer newSync(string address, DBusServerFlags flags, string guid, DBusAuthObserver observer, Cancellable cancellable)
  {
    GDBusServer* _cretval;
    const(char)* _address = address.toCString(false);
    const(char)* _guid = guid.toCString(false);
    GError *_err;
    _cretval = g_dbus_server_new_sync(_address, flags, _guid, observer ? observer.cPtr!GDBusAuthObserver : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusServer _retval = ObjectG.getDObject!DBusServer(cast(GDBusServer*)_cretval, true);
    return _retval;
  }

  /**
   * A D-Bus address string. Do not free, the string is owned
   * by @server.
   */
  string getClientAddress()
  {
    const(char)* _cretval;
    _cretval = g_dbus_server_get_client_address(cPtr!GDBusServer);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A set of flags from the #GDBusServerFlags enumeration.
   */
  DBusServerFlags getFlags()
  {
    GDBusServerFlags _cretval;
    _cretval = g_dbus_server_get_flags(cPtr!GDBusServer);
    DBusServerFlags _retval = cast(DBusServerFlags)_cretval;
    return _retval;
  }

  /**
   * A D-Bus GUID. Do not free this string, it is owned by @server.
   */
  string getGuid()
  {
    const(char)* _cretval;
    _cretval = g_dbus_server_get_guid(cPtr!GDBusServer);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if server is active, %FALSE otherwise.
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_dbus_server_is_active(cPtr!GDBusServer);
    return _retval;
  }

  /**
   * Starts @server.
   */
  void start()
  {
    g_dbus_server_start(cPtr!GDBusServer);
  }

  /**
   * Stops @server.
   */
  void stop()
  {
    g_dbus_server_stop(cPtr!GDBusServer);
  }

  /**
   * %TRUE to claim @connection, %FALSE to let other handlers
   * run.
   */
  ulong connectNewConnection(bool delegate(DBusConnection connection, DBusServer dBusServer) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dBusServer = getVal!DBusServer(_paramVals);
      auto connection = getVal!DBusConnection(&_paramVals[1]);
      _retval = _dgClosure.dlg(connection, dBusServer);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("new-connection", closure, (flags & ConnectFlags.After) != 0);
  }
}

module Gio.DBusServer;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Cancellable;
import Gio.DBusAuthObserver;
import Gio.DBusConnection;
import Gio.Initable;
import Gio.InitableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GDBusServer` is a helper for listening to and accepting D-Bus
 * connections. This can be used to create a new D-Bus server, allowing two
 * peers to use the D-Bus protocol for their own specialized communication.
 * A server instance provided in this way will not perform message routing or
 * implement the
 * [`org.freedesktop.DBus` interface](https://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-messages).
 * To just export an object on a well-known name on a message bus, such as the
 * session or system bus, you should instead use func@Gio.bus_own_name.
 * An example of peer-to-peer communication with GDBus can be found
 * in [gdbus-example-peer.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-peer.c).
 * Note that a minimal `GDBusServer` will accept connections from any
 * peer. In many use-cases it will be necessary to add a
 * [Gio.DBusAuthObserver] that only accepts connections that have
 * successfully authenticated as the same user that is running the
 * `GDBusServer`. Since GLib 2.68 this can be achieved more simply by passing
 * the `G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER` flag to the
 * server.
 */
class DBusServer : ObjectG, Initable
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
    return g_dbus_server_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin InitableT!();

  /**
   * Creates a new D-Bus server that listens on the first address in
   * address that works.
   * Once constructed, you can use [Gio.DBusServer.getClientAddress] to
   * get a D-Bus address string that clients can use to connect.
   * To have control over the available authentication mechanisms and
   * the users that are authorized to connect, it is strongly recommended
   * to provide a non-%NULL #GDBusAuthObserver.
   * Connect to the #GDBusServer::new-connection signal to handle
   * incoming connections.
   * The returned #GDBusServer isn't active - you have to start it with
   * [Gio.DBusServer.start].
   * #GDBusServer is used in this [example][gdbus-peer-to-peer].
   * This is a synchronous failable constructor. There is currently no
   * asynchronous version.
   * Params:
   *   address = A D-Bus address.
   *   flags = Flags from the #GDBusServerFlags enumeration.
   *   guid = A D-Bus GUID.
   *   observer = A #GDBusAuthObserver or %NULL.
   *   cancellable = A #GCancellable or %NULL.
   * Returns: A #GDBusServer or %NULL if error is set. Free with
   *   [GObject.ObjectG.unref].
   */
  static DBusServer newSync(string address, DBusServerFlags flags, string guid, DBusAuthObserver observer, Cancellable cancellable)
  {
    GDBusServer* _cretval;
    const(char)* _address = address.toCString(false);
    const(char)* _guid = guid.toCString(false);
    GError *_err;
    _cretval = g_dbus_server_new_sync(_address, flags, _guid, observer ? cast(GDBusAuthObserver*)observer.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!DBusServer(cast(GDBusServer*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a
   * [D-Bus address](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses)
   * string that can be used by clients to connect to server.
   * This is valid and non-empty if initializing the #GDBusServer succeeded.
   * Returns: A D-Bus address string. Do not free, the string is owned
   *   by server.
   */
  string getClientAddress()
  {
    const(char)* _cretval;
    _cretval = g_dbus_server_get_client_address(cast(GDBusServer*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the flags for server.
   * Returns: A set of flags from the #GDBusServerFlags enumeration.
   */
  DBusServerFlags getFlags()
  {
    GDBusServerFlags _cretval;
    _cretval = g_dbus_server_get_flags(cast(GDBusServer*)cPtr);
    DBusServerFlags _retval = cast(DBusServerFlags)_cretval;
    return _retval;
  }

  /**
   * Gets the GUID for server, as provided to [Gio.DBusServer.newSync].
   * Returns: A D-Bus GUID. Do not free this string, it is owned by server.
   */
  string getGuid()
  {
    const(char)* _cretval;
    _cretval = g_dbus_server_get_guid(cast(GDBusServer*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets whether server is active.
   * Returns: %TRUE if server is active, %FALSE otherwise.
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_dbus_server_is_active(cast(GDBusServer*)cPtr);
    return _retval;
  }

  /**
   * Starts server.
   */
  void start()
  {
    g_dbus_server_start(cast(GDBusServer*)cPtr);
  }

  /**
   * Stops server.
   */
  void stop()
  {
    g_dbus_server_stop(cast(GDBusServer*)cPtr);
  }

  /**
   * Emitted when a new authenticated connection has been made. Use
   * [Gio.DBusConnection.getPeerCredentials] to figure out what
   * identity $(LPAREN)if any$(RPAREN), was authenticated.
   * If you want to accept the connection, take a reference to the
   * connection object and return %TRUE. When you are done with the
   * connection call [Gio.DBusConnection.close] and give up your
   * reference. Note that the other peer may disconnect at any time -
   * a typical thing to do when accepting a connection is to listen to
   * the #GDBusConnection::closed signal.
   * If #GDBusServer:flags contains %G_DBUS_SERVER_FLAGS_RUN_IN_THREAD
   * then the signal is emitted in a new thread dedicated to the
   * connection. Otherwise the signal is emitted in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread that server was constructed in.
   * You are guaranteed that signal handlers for this signal runs
   * before incoming messages on connection are processed. This means
   * that it's suitable to call [Gio.DBusConnection.registerObject] or
   * similar from the signal handler.
   * Params
   *   connection = A #GDBusConnection for the new connection.
   *   dBusServer = the instance the signal is connected to
   * Returns: %TRUE to claim connection, %FALSE to let other handlers
   *   run.
   */
  alias NewConnectionCallback = bool delegate(DBusConnection connection, DBusServer dBusServer);

  /**
   * Connect to NewConnection signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectNewConnection(NewConnectionCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("new-connection", closure, after);
  }
}

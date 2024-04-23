module Gio.DBusObjectManagerClient;

import GLib.ErrorG;
import GLib.Types;
import GLib.Variant;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncInitable;
import Gio.AsyncInitableT;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.DBusConnection;
import Gio.DBusObjectManager;
import Gio.DBusObjectManagerT;
import Gio.DBusObjectProxy;
import Gio.DBusProxy;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDBusObjectManagerClient is used to create, monitor and delete object
 * proxies for remote objects exported by a #GDBusObjectManagerServer (or any
 * code implementing the
 * [org.freedesktop.DBus.ObjectManager](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface).
 *
 * Once an instance of this type has been created, you can connect to
 * the #GDBusObjectManager::object-added and
 * #GDBusObjectManager::object-removed signals and inspect the
 * #GDBusObjectProxy objects returned by
 * g_dbus_object_manager_get_objects().
 *
 * If the name for a #GDBusObjectManagerClient is not owned by anyone at
 * object construction time, the default behavior is to request the
 * message bus to launch an owner for the name. This behavior can be
 * disabled using the %G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_DO_NOT_AUTO_START
 * flag. It's also worth noting that this only works if the name of
 * interest is activatable in the first place. E.g. in some cases it
 * is not possible to launch an owner for the requested name. In this
 * case, #GDBusObjectManagerClient object construction still succeeds but
 * there will be no object proxies
 * (e.g. g_dbus_object_manager_get_objects() returns the empty list) and
 * the #GDBusObjectManagerClient:name-owner property is %NULL.
 *
 * The owner of the requested name can come and go (for example
 * consider a system service being restarted) – #GDBusObjectManagerClient
 * handles this case too; simply connect to the #GObject::notify
 * signal to watch for changes on the #GDBusObjectManagerClient:name-owner
 * property. When the name owner vanishes, the behavior is that
 * #GDBusObjectManagerClient:name-owner is set to %NULL (this includes
 * emission of the #GObject::notify signal) and then
 * #GDBusObjectManager::object-removed signals are synthesized
 * for all currently existing object proxies. Since
 * #GDBusObjectManagerClient:name-owner is %NULL when this happens, you can
 * use this information to disambiguate a synthesized signal from a
 * genuine signal caused by object removal on the remote
 * #GDBusObjectManager. Similarly, when a new name owner appears,
 * #GDBusObjectManager::object-added signals are synthesized
 * while #GDBusObjectManagerClient:name-owner is still %NULL. Only when all
 * object proxies have been added, the #GDBusObjectManagerClient:name-owner
 * is set to the new name owner (this includes emission of the
 * #GObject::notify signal).  Furthermore, you are guaranteed that
 * #GDBusObjectManagerClient:name-owner will alternate between a name owner
 * (e.g. `:1.42`) and %NULL even in the case where
 * the name of interest is atomically replaced
 *
 * Ultimately, #GDBusObjectManagerClient is used to obtain #GDBusProxy
 * instances. All signals (including the
 * org.freedesktop.DBus.Properties::PropertiesChanged signal)
 * delivered to #GDBusProxy instances are guaranteed to originate
 * from the name owner. This guarantee along with the behavior
 * described above, means that certain race conditions including the
 * "half the proxy is from the old owner and the other half is from
 * the new owner" problem cannot happen.
 *
 * To avoid having the application connect to signals on the returned
 * #GDBusObjectProxy and #GDBusProxy objects, the
 * #GDBusObject::interface-added,
 * #GDBusObject::interface-removed,
 * #GDBusProxy::g-properties-changed and
 * #GDBusProxy::g-signal signals
 * are also emitted on the #GDBusObjectManagerClient instance managing these
 * objects. The signals emitted are
 * #GDBusObjectManager::interface-added,
 * #GDBusObjectManager::interface-removed,
 * #GDBusObjectManagerClient::interface-proxy-properties-changed and
 * #GDBusObjectManagerClient::interface-proxy-signal.
 *
 * Note that all callbacks and signals are emitted in the
 * [thread-default main context][g-main-context-push-thread-default]
 * that the #GDBusObjectManagerClient object was constructed
 * in. Additionally, the #GDBusObjectProxy and #GDBusProxy objects
 * originating from the #GDBusObjectManagerClient object will be created in
 * the same context and, consequently, will deliver signals in the
 * same main loop.
 */
class DBusObjectManagerClient : ObjectG, AsyncInitable, DBusObjectManager
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_object_manager_client_get_type();
  }

  mixin AsyncInitableT!GDBusObjectManagerClient;
  mixin DBusObjectManagerT!GDBusObjectManagerClient;

  /**
   * A
   * #GDBusObjectManagerClient object or %NULL if @error is set. Free
   * with g_object_unref().
   */
  static DBusObjectManagerClient newFinish(AsyncResult res)
  {
    GDBusObjectManager* _cretval;
    GError *_err;
    _cretval = g_dbus_object_manager_client_new_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusObjectManagerClient _retval = ObjectG.getDObject!DBusObjectManagerClient(cast(GDBusObjectManager*)_cretval, true);
    return _retval;
  }

  /**
   * A
   * #GDBusObjectManagerClient object or %NULL if @error is set. Free
   * with g_object_unref().
   */
  static DBusObjectManagerClient newForBusFinish(AsyncResult res)
  {
    GDBusObjectManager* _cretval;
    GError *_err;
    _cretval = g_dbus_object_manager_client_new_for_bus_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusObjectManagerClient _retval = ObjectG.getDObject!DBusObjectManagerClient(cast(GDBusObjectManager*)_cretval, true);
    return _retval;
  }

  /**
   * A
   * #GDBusObjectManagerClient object or %NULL if @error is set. Free
   * with g_object_unref().
   */
  static DBusObjectManagerClient newForBusSync(BusType busType, DBusObjectManagerClientFlags flags, string name, string objectPath, DBusProxyTypeFunc getProxyTypeFunc, Cancellable cancellable)
  {
    extern(C) GType _getProxyTypeFuncCallback(GDBusObjectManagerClient* manager, const(char)* objectPath, const(char)* interfaceName, void* data)
    {
      string _objectPath = objectPath.fromCString(false);
      string _interfaceName = interfaceName.fromCString(false);

      GType _retval = (*(cast(DBusProxyTypeFunc*)data))(manager ? ObjectG.getDObject!DBusObjectManagerClient(manager, false) : null, _objectPath, _interfaceName);
      return _retval;
    }

    GDBusObjectManager* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    ptrFreezeGC(cast(void*)&getProxyTypeFunc);
    GError *_err;
    _cretval = g_dbus_object_manager_client_new_for_bus_sync(busType, flags, _name, _objectPath, &_getProxyTypeFuncCallback, cast(void*)&getProxyTypeFunc, &ptrThawDestroyNotify, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusObjectManagerClient _retval = ObjectG.getDObject!DBusObjectManagerClient(cast(GDBusObjectManager*)_cretval, true);
    return _retval;
  }

  /**
   * A
   * #GDBusObjectManagerClient object or %NULL if @error is set. Free
   * with g_object_unref().
   */
  static DBusObjectManagerClient newSync(DBusConnection connection, DBusObjectManagerClientFlags flags, string name, string objectPath, DBusProxyTypeFunc getProxyTypeFunc, Cancellable cancellable)
  {
    extern(C) GType _getProxyTypeFuncCallback(GDBusObjectManagerClient* manager, const(char)* objectPath, const(char)* interfaceName, void* data)
    {
      string _objectPath = objectPath.fromCString(false);
      string _interfaceName = interfaceName.fromCString(false);

      GType _retval = (*(cast(DBusProxyTypeFunc*)data))(manager ? ObjectG.getDObject!DBusObjectManagerClient(manager, false) : null, _objectPath, _interfaceName);
      return _retval;
    }

    GDBusObjectManager* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    ptrFreezeGC(cast(void*)&getProxyTypeFunc);
    GError *_err;
    _cretval = g_dbus_object_manager_client_new_sync(connection ? connection.cPtr!GDBusConnection : null, flags, _name, _objectPath, &_getProxyTypeFuncCallback, cast(void*)&getProxyTypeFunc, &ptrThawDestroyNotify, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusObjectManagerClient _retval = ObjectG.getDObject!DBusObjectManagerClient(cast(GDBusObjectManager*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusConnection object. Do not free,
   * the object belongs to @manager.
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_object_manager_client_get_connection(cPtr!GDBusObjectManagerClient);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false);
    return _retval;
  }

  /**
   * Zero of more flags from the #GDBusObjectManagerClientFlags
   * enumeration.
   */
  DBusObjectManagerClientFlags getFlags()
  {
    GDBusObjectManagerClientFlags _cretval;
    _cretval = g_dbus_object_manager_client_get_flags(cPtr!GDBusObjectManagerClient);
    DBusObjectManagerClientFlags _retval = cast(DBusObjectManagerClientFlags)_cretval;
    return _retval;
  }

  /**
   * A unique or well-known name. Do not free, the string
   * belongs to @manager.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_object_manager_client_get_name(cPtr!GDBusObjectManagerClient);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The name owner or %NULL if no name owner
   * exists. Free with g_free().
   */
  string getNameOwner()
  {
    char* _cretval;
    _cretval = g_dbus_object_manager_client_get_name_owner(cPtr!GDBusObjectManagerClient);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Emitted when a D-Bus signal is received on @interface_proxy.
   *
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all interface proxies managed by @manager.
   *
   * This signal is emitted in the
   * [thread-default main context][g-main-context-push-thread-default]
   * that @manager was constructed in.
   */
  ulong connectInterfaceProxySignal(void delegate(DBusObjectProxy objectProxy, DBusProxy interfaceProxy, string senderName, string signalName, Variant parameters, DBusObjectManagerClient dBusObjectManagerClient) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 6, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusObjectManagerClient = getVal!DBusObjectManagerClient(_paramVals);
      auto objectProxy = getVal!DBusObjectProxy(&_paramVals[1]);
      auto interfaceProxy = getVal!DBusProxy(&_paramVals[2]);
      auto senderName = getVal!string(&_paramVals[3]);
      char* _senderName = senderName.toCString(false);
      auto signalName = getVal!string(&_paramVals[4]);
      char* _signalName = signalName.toCString(false);
      auto parameters = getVal!Variant(&_paramVals[5]);
      _dgClosure.dlg(objectProxy, interfaceProxy, senderName, signalName, parameters, dBusObjectManagerClient);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("interface-proxy-signal", closure, (flags & ConnectFlags.After) != 0);
  }
}

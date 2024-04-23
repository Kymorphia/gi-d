module Gio.DBusProxy;

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
import Gio.DBusInterface;
import Gio.DBusInterfaceInfo;
import Gio.DBusInterfaceT;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDBusProxy is a base class used for proxies to access a D-Bus
 * interface on a remote object. A #GDBusProxy can be constructed for
 * both well-known and unique names.
 *
 * By default, #GDBusProxy will cache all properties (and listen to
 * changes) of the remote object, and proxy all signals that get
 * emitted. This behaviour can be changed by passing suitable
 * #GDBusProxyFlags when the proxy is created. If the proxy is for a
 * well-known name, the property cache is flushed when the name owner
 * vanishes and reloaded when a name owner appears.
 *
 * The unique name owner of the proxy's name is tracked and can be read from
 * #GDBusProxy:g-name-owner. Connect to the #GObject::notify signal to
 * get notified of changes. Additionally, only signals and property
 * changes emitted from the current name owner are considered and
 * calls are always sent to the current name owner. This avoids a
 * number of race conditions when the name is lost by one owner and
 * claimed by another. However, if no name owner currently exists,
 * then calls will be sent to the well-known name which may result in
 * the message bus launching an owner (unless
 * %G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START is set).
 *
 * If the proxy is for a stateless D-Bus service, where the name owner may
 * be started and stopped between calls, the #GDBusProxy:g-name-owner tracking
 * of #GDBusProxy will cause the proxy to drop signal and property changes from
 * the service after it has restarted for the first time. When interacting
 * with a stateless D-Bus service, do not use #GDBusProxy — use direct D-Bus
 * method calls and signal connections.
 *
 * The generic #GDBusProxy::g-properties-changed and
 * #GDBusProxy::g-signal signals are not very convenient to work with.
 * Therefore, the recommended way of working with proxies is to subclass
 * #GDBusProxy, and have more natural properties and signals in your derived
 * class. This [example][gdbus-example-gdbus-codegen] shows how this can
 * easily be done using the [gdbus-codegen][gdbus-codegen] tool.
 *
 * A #GDBusProxy instance can be used from multiple threads but note
 * that all signals (e.g. #GDBusProxy::g-signal, #GDBusProxy::g-properties-changed
 * and #GObject::notify) are emitted in the
 * [thread-default main context][g-main-context-push-thread-default]
 * of the thread where the instance was constructed.
 *
 * An example using a proxy for a well-known name can be found in
 * [gdbus-example-watch-proxy.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-watch-proxy.c)
 */
class DBusProxy : ObjectG, AsyncInitable, DBusInterface
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_proxy_get_type();
  }

  mixin AsyncInitableT!GDBusProxy;
  mixin DBusInterfaceT!GDBusProxy;

  /**
   * A #GDBusProxy or %NULL if @error is set.
   * Free with g_object_unref().
   */
  static DBusProxy newFinish(AsyncResult res)
  {
    GDBusProxy* _cretval;
    GError *_err;
    _cretval = g_dbus_proxy_new_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusProxy _retval = ObjectG.getDObject!DBusProxy(cast(GDBusProxy*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusProxy or %NULL if @error is set.
   * Free with g_object_unref().
   */
  static DBusProxy newForBusFinish(AsyncResult res)
  {
    GDBusProxy* _cretval;
    GError *_err;
    _cretval = g_dbus_proxy_new_for_bus_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusProxy _retval = ObjectG.getDObject!DBusProxy(cast(GDBusProxy*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusProxy or %NULL if error is set.
   * Free with g_object_unref().
   */
  static DBusProxy newForBusSync(BusType busType, DBusProxyFlags flags, DBusInterfaceInfo info, string name, string objectPath, string interfaceName, Cancellable cancellable)
  {
    GDBusProxy* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    GError *_err;
    _cretval = g_dbus_proxy_new_for_bus_sync(busType, flags, info ? info.cPtr!GDBusInterfaceInfo : null, _name, _objectPath, _interfaceName, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusProxy _retval = ObjectG.getDObject!DBusProxy(cast(GDBusProxy*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusProxy or %NULL if error is set.
   * Free with g_object_unref().
   */
  static DBusProxy newSync(DBusConnection connection, DBusProxyFlags flags, DBusInterfaceInfo info, string name, string objectPath, string interfaceName, Cancellable cancellable)
  {
    GDBusProxy* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    GError *_err;
    _cretval = g_dbus_proxy_new_sync(connection ? connection.cPtr!GDBusConnection : null, flags, info ? info.cPtr!GDBusInterfaceInfo : null, _name, _objectPath, _interfaceName, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusProxy _retval = ObjectG.getDObject!DBusProxy(cast(GDBusProxy*)_cretval, true);
    return _retval;
  }

  /**
   * Creates a proxy for accessing @interface_name on the remote object
   * at @object_path owned by @name at @connection and asynchronously
   * loads D-Bus properties unless the
   * %G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES flag is used. Connect to
   * the #GDBusProxy::g-properties-changed signal to get notified about
   * property changes.
   *
   * If the %G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS flag is not set, also sets up
   * match rules for signals. Connect to the #GDBusProxy::g-signal signal
   * to handle signals from the remote object.
   *
   * If both %G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES and
   * %G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS are set, this constructor is
   * guaranteed to complete immediately without blocking.
   *
   * If @name is a well-known name and the
   * %G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START and %G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START_AT_CONSTRUCTION
   * flags aren't set and no name owner currently exists, the message bus
   * will be requested to launch a name owner for the name.
   *
   * This is a failable asynchronous constructor - when the proxy is
   * ready, @callback will be invoked and you can use
   * g_dbus_proxy_new_finish() to get the result.
   *
   * See g_dbus_proxy_new_sync() and for a synchronous version of this constructor.
   *
   * #GDBusProxy is used in this [example][gdbus-wellknown-proxy].
   */
  static void new_(DBusConnection connection, DBusProxyFlags flags, DBusInterfaceInfo info, string name, string objectPath, string interfaceName, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _name = name.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_proxy_new(connection ? connection.cPtr!GDBusConnection : null, flags, info ? info.cPtr!GDBusInterfaceInfo : null, _name, _objectPath, _interfaceName, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Like g_dbus_proxy_new() but takes a #GBusType instead of a #GDBusConnection.
   *
   * #GDBusProxy is used in this [example][gdbus-wellknown-proxy].
   */
  static void newForBus(BusType busType, DBusProxyFlags flags, DBusInterfaceInfo info, string name, string objectPath, string interfaceName, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _name = name.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_proxy_new_for_bus(busType, flags, info ? info.cPtr!GDBusInterfaceInfo : null, _name, _objectPath, _interfaceName, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Asynchronously invokes the @method_name method on @proxy.
   *
   * If @method_name contains any dots, then @name is split into interface and
   * method name parts. This allows using @proxy for invoking methods on
   * other interfaces.
   *
   * If the #GDBusConnection associated with @proxy is closed then
   * the operation will fail with %G_IO_ERROR_CLOSED. If
   * @cancellable is canceled, the operation will fail with
   * %G_IO_ERROR_CANCELLED. If @parameters contains a value not
   * compatible with the D-Bus protocol, the operation fails with
   * %G_IO_ERROR_INVALID_ARGUMENT.
   *
   * If the @parameters #GVariant is floating, it is consumed. This allows
   * convenient 'inline' use of g_variant_new(), e.g.:
   * |[<!-- language="C" -->
   * g_dbus_proxy_call (proxy,
   * "TwoStrings",
   * g_variant_new ("(ss)",
   * "Thing One",
   * "Thing Two"),
   * G_DBUS_CALL_FLAGS_NONE,
   * -1,
   * NULL,
   * (GAsyncReadyCallback) two_strings_done,
   * &data);
   * ]|
   *
   * If @proxy has an expected interface (see
   * #GDBusProxy:g-interface-info) and @method_name is referenced by it,
   * then the return value is checked against the return type.
   *
   * This is an asynchronous method. When the operation is finished,
   * @callback will be invoked in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread you are calling this method from.
   * You can then call g_dbus_proxy_call_finish() to get the result of
   * the operation. See g_dbus_proxy_call_sync() for the synchronous
   * version of this method.
   *
   * If @callback is %NULL then the D-Bus method call message will be sent with
   * the %G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED flag set.
   */
  void call(string methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _methodName = methodName.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_proxy_call(cPtr!GDBusProxy, _methodName, parameters ? parameters.cPtr!GVariant : null, flags, timeoutMsec, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %NULL if @error is set. Otherwise a #GVariant tuple with
   * return values. Free with g_variant_unref().
   */
  Variant callFinish(AsyncResult res)
  {
    GVariant* _cretval;
    GError *_err;
    _cretval = g_dbus_proxy_call_finish(cPtr!GDBusProxy, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %NULL if @error is set. Otherwise a #GVariant tuple with
   * return values. Free with g_variant_unref().
   */
  Variant callSync(string methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable)
  {
    GVariant* _cretval;
    const(char)* _methodName = methodName.toCString(false);
    GError *_err;
    _cretval = g_dbus_proxy_call_sync(cPtr!GDBusProxy, _methodName, parameters ? parameters.cPtr!GVariant : null, flags, timeoutMsec, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * Like g_dbus_proxy_call() but also takes a #GUnixFDList object.
   *
   * This method is only available on UNIX.
   */
  void callWithUnixFdList(string methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _methodName = methodName.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_proxy_call_with_unix_fd_list(cPtr!GDBusProxy, _methodName, parameters ? parameters.cPtr!GVariant : null, flags, timeoutMsec, fdList ? fdList.cPtr!GUnixFDList : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %NULL if @error is set. Otherwise a #GVariant tuple with
   * return values. Free with g_variant_unref().
   */
  Variant callWithUnixFdListFinish(out UnixFDList outFdList, AsyncResult res)
  {
    GVariant* _cretval;
    GUnixFDList* _outFdList;
    GError *_err;
    _cretval = g_dbus_proxy_call_with_unix_fd_list_finish(cPtr!GDBusProxy, &_outFdList, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    outFdList = new UnixFDList(cast(void*)_outFdList, true);
    return _retval;
  }

  /**
   * %NULL if @error is set. Otherwise a #GVariant tuple with
   * return values. Free with g_variant_unref().
   */
  Variant callWithUnixFdListSync(string methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, out UnixFDList outFdList, Cancellable cancellable)
  {
    GVariant* _cretval;
    const(char)* _methodName = methodName.toCString(false);
    GUnixFDList* _outFdList;
    GError *_err;
    _cretval = g_dbus_proxy_call_with_unix_fd_list_sync(cPtr!GDBusProxy, _methodName, parameters ? parameters.cPtr!GVariant : null, flags, timeoutMsec, fdList ? fdList.cPtr!GUnixFDList : null, &_outFdList, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    outFdList = new UnixFDList(cast(void*)_outFdList, true);
    return _retval;
  }

  /**
   * A reference to the #GVariant instance
   * that holds the value for @property_name or %NULL if the value is not in
   * the cache. The returned reference must be freed with g_variant_unref().
   */
  Variant getCachedProperty(string propertyName)
  {
    GVariant* _cretval;
    const(char)* _propertyName = propertyName.toCString(false);
    _cretval = g_dbus_proxy_get_cached_property(cPtr!GDBusProxy, _propertyName);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * A
   * %NULL-terminated array of strings or %NULL if
   * @proxy has no cached properties. Free the returned array with
   * g_strfreev().
   */
  string[] getCachedPropertyNames()
  {
    char** _cretval;
    _cretval = g_dbus_proxy_get_cached_property_names(cPtr!GDBusProxy);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * A #GDBusConnection owned by @proxy. Do not free.
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_proxy_get_connection(cPtr!GDBusProxy);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false);
    return _retval;
  }

  /**
   * Timeout to use for @proxy.
   */
  int getDefaultTimeout()
  {
    int _retval;
    _retval = g_dbus_proxy_get_default_timeout(cPtr!GDBusProxy);
    return _retval;
  }

  /**
   * Flags from the #GDBusProxyFlags enumeration.
   */
  DBusProxyFlags getFlags()
  {
    GDBusProxyFlags _cretval;
    _cretval = g_dbus_proxy_get_flags(cPtr!GDBusProxy);
    DBusProxyFlags _retval = cast(DBusProxyFlags)_cretval;
    return _retval;
  }

  /**
   * A #GDBusInterfaceInfo or %NULL.
   * Do not unref the returned object, it is owned by @proxy.
   */
  DBusInterfaceInfo getInterfaceInfo()
  {
    GDBusInterfaceInfo* _cretval;
    _cretval = g_dbus_proxy_get_interface_info(cPtr!GDBusProxy);
    DBusInterfaceInfo _retval = new DBusInterfaceInfo(cast(GDBusInterfaceInfo*)_cretval, false);
    return _retval;
  }

  /**
   * A string owned by @proxy. Do not free.
   */
  string getInterfaceName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_proxy_get_interface_name(cPtr!GDBusProxy);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A string owned by @proxy. Do not free.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_proxy_get_name(cPtr!GDBusProxy);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The name owner or %NULL if no name
   * owner exists. Free with g_free().
   */
  string getNameOwner()
  {
    char* _cretval;
    _cretval = g_dbus_proxy_get_name_owner(cPtr!GDBusProxy);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * A string owned by @proxy. Do not free.
   */
  string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_proxy_get_object_path(cPtr!GDBusProxy);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * If @value is not %NULL, sets the cached value for the property with
   * name @property_name to the value in @value.
   *
   * If @value is %NULL, then the cached value is removed from the
   * property cache.
   *
   * If @proxy has an expected interface (see
   * #GDBusProxy:g-interface-info) and @property_name is referenced by
   * it, then @value is checked against the type of the property.
   *
   * If the @value #GVariant is floating, it is consumed. This allows
   * convenient 'inline' use of g_variant_new(), e.g.
   * |[<!-- language="C" -->
   * g_dbus_proxy_set_cached_property (proxy,
   * "SomeProperty",
   * g_variant_new ("(si)",
   * "A String",
   * 42));
   * ]|
   *
   * Normally you will not need to use this method since @proxy
   * is tracking changes using the
   * `org.freedesktop.DBus.Properties.PropertiesChanged`
   * D-Bus signal. However, for performance reasons an object may
   * decide to not use this signal for some properties and instead
   * use a proprietary out-of-band mechanism to transmit changes.
   *
   * As a concrete example, consider an object with a property
   * `ChatroomParticipants` which is an array of strings. Instead of
   * transmitting the same (long) array every time the property changes,
   * it is more efficient to only transmit the delta using e.g. signals
   * `ChatroomParticipantJoined(String name)` and
   * `ChatroomParticipantParted(String name)`.
   */
  void setCachedProperty(string propertyName, Variant value)
  {
    const(char)* _propertyName = propertyName.toCString(false);
    g_dbus_proxy_set_cached_property(cPtr!GDBusProxy, _propertyName, value ? value.cPtr!GVariant : null);
  }

  /**
   * Sets the timeout to use if -1 (specifying default timeout) is
   * passed as @timeout_msec in the g_dbus_proxy_call() and
   * g_dbus_proxy_call_sync() functions.
   *
   * See the #GDBusProxy:g-default-timeout property for more details.
   */
  void setDefaultTimeout(int timeoutMsec)
  {
    g_dbus_proxy_set_default_timeout(cPtr!GDBusProxy, timeoutMsec);
  }

  /**
   * Ensure that interactions with @proxy conform to the given
   * interface. See the #GDBusProxy:g-interface-info property for more
   * details.
   */
  void setInterfaceInfo(DBusInterfaceInfo info)
  {
    g_dbus_proxy_set_interface_info(cPtr!GDBusProxy, info ? info.cPtr!GDBusInterfaceInfo : null);
  }

  /**
   * Emitted when a signal from the remote object and interface that @proxy is for, has been received.
   *
   * Since 2.72 this signal supports detailed connections. You can connect to
   * the detailed signal `g-signal::x` in order to receive callbacks only when
   * signal `x` is received from the remote object.
   */
  ulong connectGSignal(void delegate(string senderName, string signalName, Variant parameters, DBusProxy dBusProxy) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusProxy = getVal!DBusProxy(_paramVals);
      auto senderName = getVal!string(&_paramVals[1]);
      char* _senderName = senderName.toCString(false);
      auto signalName = getVal!string(&_paramVals[2]);
      char* _signalName = signalName.toCString(false);
      auto parameters = getVal!Variant(&_paramVals[3]);
      _dgClosure.dlg(senderName, signalName, parameters, dBusProxy);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("g-signal", closure, (flags & ConnectFlags.After) != 0);
  }
}

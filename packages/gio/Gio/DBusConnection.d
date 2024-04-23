module Gio.DBusConnection;

import GLib.ErrorG;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GObject.Closure;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.ActionGroup;
import Gio.AsyncInitable;
import Gio.AsyncInitableT;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Credentials;
import Gio.DBusAuthObserver;
import Gio.DBusInterfaceInfo;
import Gio.DBusMessage;
import Gio.DBusSubtreeVTable;
import Gio.IOStream;
import Gio.MenuModel;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GDBusConnection type is used for D-Bus connections to remote
 * peers such as a message buses. It is a low-level API that offers a
 * lot of flexibility. For instance, it lets you establish a connection
 * over any transport that can by represented as a #GIOStream.
 *
 * This class is rarely used directly in D-Bus clients. If you are writing
 * a D-Bus client, it is often easier to use the g_bus_own_name(),
 * g_bus_watch_name() or g_dbus_proxy_new_for_bus() APIs.
 *
 * As an exception to the usual GLib rule that a particular object must not
 * be used by two threads at the same time, #GDBusConnection's methods may be
 * called from any thread. This is so that g_bus_get() and g_bus_get_sync()
 * can safely return the same #GDBusConnection when called from any thread.
 *
 * Most of the ways to obtain a #GDBusConnection automatically initialize it
 * (i.e. connect to D-Bus): for instance, g_dbus_connection_new() and
 * g_bus_get(), and the synchronous versions of those methods, give you an
 * initialized connection. Language bindings for GIO should use
 * g_initable_new() or g_async_initable_new_async(), which also initialize the
 * connection.
 *
 * If you construct an uninitialized #GDBusConnection, such as via
 * g_object_new(), you must initialize it via g_initable_init() or
 * g_async_initable_init_async() before using its methods or properties.
 * Calling methods or accessing properties on a #GDBusConnection that has not
 * completed initialization successfully is considered to be invalid, and leads
 * to undefined behaviour. In particular, if initialization fails with a
 * #GError, the only valid thing you can do with that #GDBusConnection is to
 * free it with g_object_unref().
 *
 * ## An example D-Bus server # {#gdbus-server}
 *
 * Here is an example for a D-Bus server:
 * [gdbus-example-server.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-server.c)
 *
 * ## An example for exporting a subtree # {#gdbus-subtree-server}
 *
 * Here is an example for exporting a subtree:
 * [gdbus-example-subtree.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-subtree.c)
 *
 * ## An example for file descriptor passing # {#gdbus-unix-fd-client}
 *
 * Here is an example for passing UNIX file descriptors:
 * [gdbus-unix-fd-client.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-unix-fd-client.c)
 *
 * ## An example for exporting a GObject # {#gdbus-export}
 *
 * Here is an example for exporting a #GObject:
 * [gdbus-example-export.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-export.c)
 */
class DBusConnection : ObjectG, AsyncInitable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_connection_get_type();
  }

  mixin AsyncInitableT!GDBusConnection;

  /**
   * a #GDBusConnection or %NULL if @error is set. Free
   * with g_object_unref().
   */
  static DBusConnection newFinish(AsyncResult res)
  {
    GDBusConnection* _cretval;
    GError *_err;
    _cretval = g_dbus_connection_new_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDBusConnection or %NULL if @error is set.
   * Free with g_object_unref().
   */
  static DBusConnection newForAddressFinish(AsyncResult res)
  {
    GDBusConnection* _cretval;
    GError *_err;
    _cretval = g_dbus_connection_new_for_address_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDBusConnection or %NULL if @error is set.
   * Free with g_object_unref().
   */
  static DBusConnection newForAddressSync(string address, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable)
  {
    GDBusConnection* _cretval;
    const(char)* _address = address.toCString(false);
    GError *_err;
    _cretval = g_dbus_connection_new_for_address_sync(_address, flags, observer ? observer.cPtr!GDBusAuthObserver : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDBusConnection or %NULL if @error is set.
   * Free with g_object_unref().
   */
  static DBusConnection newSync(IOStream stream, string guid, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable)
  {
    GDBusConnection* _cretval;
    const(char)* _guid = guid.toCString(false);
    GError *_err;
    _cretval = g_dbus_connection_new_sync(stream ? stream.cPtr!GIOStream : null, _guid, flags, observer ? observer.cPtr!GDBusAuthObserver : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously sets up a D-Bus connection for exchanging D-Bus messages
   * with the end represented by @stream.
   *
   * If @stream is a #GSocketConnection, then the corresponding #GSocket
   * will be put into non-blocking mode.
   *
   * The D-Bus connection will interact with @stream from a worker thread.
   * As a result, the caller should not interact with @stream after this
   * method has been called, except by calling g_object_unref() on it.
   *
   * If @observer is not %NULL it may be used to control the
   * authentication process.
   *
   * When the operation is finished, @callback will be invoked. You can
   * then call g_dbus_connection_new_finish() to get the result of the
   * operation.
   *
   * This is an asynchronous failable constructor. See
   * g_dbus_connection_new_sync() for the synchronous
   * version.
   */
  static void new_(IOStream stream, string guid, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _guid = guid.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_connection_new(stream ? stream.cPtr!GIOStream : null, _guid, flags, observer ? observer.cPtr!GDBusAuthObserver : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Asynchronously connects and sets up a D-Bus client connection for
   * exchanging D-Bus messages with an endpoint specified by @address
   * which must be in the
   * [D-Bus address format](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
   *
   * This constructor can only be used to initiate client-side
   * connections - use g_dbus_connection_new() if you need to act as the
   * server. In particular, @flags cannot contain the
   * %G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER,
   * %G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS or
   * %G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER flags.
   *
   * When the operation is finished, @callback will be invoked. You can
   * then call g_dbus_connection_new_for_address_finish() to get the result of
   * the operation.
   *
   * If @observer is not %NULL it may be used to control the
   * authentication process.
   *
   * This is an asynchronous failable constructor. See
   * g_dbus_connection_new_for_address_sync() for the synchronous
   * version.
   */
  static void newForAddress(string address, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _address = address.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_connection_new_for_address(_address, flags, observer ? observer.cPtr!GDBusAuthObserver : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a filter identifier that can be used with
   * g_dbus_connection_remove_filter()
   */
  uint addFilter(DBusMessageFilterFunction filterFunction)
  {
    extern(C) GDBusMessage* _filterFunctionCallback(GDBusConnection* connection, GDBusMessage* message, bool incoming, void* userData)
    {
      DBusMessage _dretval;

      _dretval = (*(cast(DBusMessageFilterFunction*)userData))(connection ? ObjectG.getDObject!DBusConnection(connection, false) : null, message ? ObjectG.getDObject!DBusMessage(message, true) : null, incoming);
      GDBusMessage* _retval = _dretval.cPtr!GDBusMessage(true);

      return _retval;
    }

    uint _retval;
    ptrFreezeGC(cast(void*)&filterFunction);
    _retval = g_dbus_connection_add_filter(cPtr!GDBusConnection, &_filterFunctionCallback, cast(void*)&filterFunction, &ptrThawDestroyNotify);
    return _retval;
  }

  /**
   * Asynchronously invokes the @method_name method on the
   * @interface_name D-Bus interface on the remote object at
   * @object_path owned by @bus_name.
   *
   * If @connection is closed then the operation will fail with
   * %G_IO_ERROR_CLOSED. If @cancellable is canceled, the operation will
   * fail with %G_IO_ERROR_CANCELLED. If @parameters contains a value
   * not compatible with the D-Bus protocol, the operation fails with
   * %G_IO_ERROR_INVALID_ARGUMENT.
   *
   * If @reply_type is non-%NULL then the reply will be checked for having this type and an
   * error will be raised if it does not match.  Said another way, if you give a @reply_type
   * then any non-%NULL return value will be of this type. Unless it’s
   * %G_VARIANT_TYPE_UNIT, the @reply_type will be a tuple containing one or more
   * values.
   *
   * If the @parameters #GVariant is floating, it is consumed. This allows
   * convenient 'inline' use of g_variant_new(), e.g.:
   * |[<!-- language="C" -->
   * g_dbus_connection_call (connection,
   * "org.freedesktop.StringThings",
   * "/org/freedesktop/StringThings",
   * "org.freedesktop.StringThings",
   * "TwoStrings",
   * g_variant_new ("(ss)",
   * "Thing One",
   * "Thing Two"),
   * NULL,
   * G_DBUS_CALL_FLAGS_NONE,
   * -1,
   * NULL,
   * (GAsyncReadyCallback) two_strings_done,
   * NULL);
   * ]|
   *
   * This is an asynchronous method. When the operation is finished,
   * @callback will be invoked in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread you are calling this method from. You can then call
   * g_dbus_connection_call_finish() to get the result of the operation.
   * See g_dbus_connection_call_sync() for the synchronous version of this
   * function.
   *
   * If @callback is %NULL then the D-Bus method call message will be sent with
   * the %G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED flag set.
   */
  void call(string busName, string objectPath, string interfaceName, string methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _busName = busName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    const(char)* _methodName = methodName.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_connection_call(cPtr!GDBusConnection, _busName, _objectPath, _interfaceName, _methodName, parameters ? parameters.cPtr!GVariant : null, replyType ? replyType.cPtr!GVariantType : null, flags, timeoutMsec, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %NULL if @error is set. Otherwise a non-floating
   * #GVariant tuple with return values. Free with g_variant_unref().
   */
  Variant callFinish(AsyncResult res)
  {
    GVariant* _cretval;
    GError *_err;
    _cretval = g_dbus_connection_call_finish(cPtr!GDBusConnection, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %NULL if @error is set. Otherwise a non-floating
   * #GVariant tuple with return values. Free with g_variant_unref().
   */
  Variant callSync(string busName, string objectPath, string interfaceName, string methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable)
  {
    GVariant* _cretval;
    const(char)* _busName = busName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    const(char)* _methodName = methodName.toCString(false);
    GError *_err;
    _cretval = g_dbus_connection_call_sync(cPtr!GDBusConnection, _busName, _objectPath, _interfaceName, _methodName, parameters ? parameters.cPtr!GVariant : null, replyType ? replyType.cPtr!GVariantType : null, flags, timeoutMsec, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * Like g_dbus_connection_call() but also takes a #GUnixFDList object.
   *
   * The file descriptors normally correspond to %G_VARIANT_TYPE_HANDLE
   * values in the body of the message. For example, if a message contains
   * two file descriptors, @fd_list would have length 2, and
   * `g_variant_new_handle (0)` and `g_variant_new_handle (1)` would appear
   * somewhere in the body of the message (not necessarily in that order!)
   * to represent the file descriptors at indexes 0 and 1 respectively.
   *
   * When designing D-Bus APIs that are intended to be interoperable,
   * please note that non-GDBus implementations of D-Bus can usually only
   * access file descriptors if they are referenced in this way by a
   * value of type %G_VARIANT_TYPE_HANDLE in the body of the message.
   *
   * This method is only available on UNIX.
   */
  void callWithUnixFdList(string busName, string objectPath, string interfaceName, string methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _busName = busName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    const(char)* _methodName = methodName.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_dbus_connection_call_with_unix_fd_list(cPtr!GDBusConnection, _busName, _objectPath, _interfaceName, _methodName, parameters ? parameters.cPtr!GVariant : null, replyType ? replyType.cPtr!GVariantType : null, flags, timeoutMsec, fdList ? fdList.cPtr!GUnixFDList : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %NULL if @error is set. Otherwise a non-floating
   * #GVariant tuple with return values. Free with g_variant_unref().
   */
  Variant callWithUnixFdListFinish(out UnixFDList outFdList, AsyncResult res)
  {
    GVariant* _cretval;
    GUnixFDList* _outFdList;
    GError *_err;
    _cretval = g_dbus_connection_call_with_unix_fd_list_finish(cPtr!GDBusConnection, &_outFdList, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    outFdList = new UnixFDList(cast(void*)_outFdList, true);
    return _retval;
  }

  /**
   * %NULL if @error is set. Otherwise a non-floating
   * #GVariant tuple with return values. Free with g_variant_unref().
   */
  Variant callWithUnixFdListSync(string busName, string objectPath, string interfaceName, string methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, out UnixFDList outFdList, Cancellable cancellable)
  {
    GVariant* _cretval;
    const(char)* _busName = busName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    const(char)* _methodName = methodName.toCString(false);
    GUnixFDList* _outFdList;
    GError *_err;
    _cretval = g_dbus_connection_call_with_unix_fd_list_sync(cPtr!GDBusConnection, _busName, _objectPath, _interfaceName, _methodName, parameters ? parameters.cPtr!GVariant : null, replyType ? replyType.cPtr!GVariantType : null, flags, timeoutMsec, fdList ? fdList.cPtr!GUnixFDList : null, &_outFdList, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    outFdList = new UnixFDList(cast(void*)_outFdList, true);
    return _retval;
  }

  /**
   * Closes @connection. Note that this never causes the process to
   * exit (this might only happen if the other end of a shared message
   * bus connection disconnects, see #GDBusConnection:exit-on-close).
   *
   * Once the connection is closed, operations such as sending a message
   * will return with the error %G_IO_ERROR_CLOSED. Closing a connection
   * will not automatically flush the connection so queued messages may
   * be lost. Use g_dbus_connection_flush() if you need such guarantees.
   *
   * If @connection is already closed, this method fails with
   * %G_IO_ERROR_CLOSED.
   *
   * When @connection has been closed, the #GDBusConnection::closed
   * signal is emitted in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread that @connection was constructed in.
   *
   * This is an asynchronous method. When the operation is finished,
   * @callback will be invoked in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread you are calling this method from. You can
   * then call g_dbus_connection_close_finish() to get the result of the
   * operation. See g_dbus_connection_close_sync() for the synchronous
   * version.
   */
  void close(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_dbus_connection_close(cPtr!GDBusConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation succeeded, %FALSE if @error is set
   */
  bool closeFinish(AsyncResult res)
  {
    bool _retval;
    GError *_err;
    _retval = g_dbus_connection_close_finish(cPtr!GDBusConnection, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the operation succeeded, %FALSE if @error is set
   */
  bool closeSync(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_dbus_connection_close_sync(cPtr!GDBusConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE unless @error is set
   */
  bool emitSignal(string destinationBusName, string objectPath, string interfaceName, string signalName, Variant parameters)
  {
    bool _retval;
    const(char)* _destinationBusName = destinationBusName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    const(char)* _signalName = signalName.toCString(false);
    GError *_err;
    _retval = g_dbus_connection_emit_signal(cPtr!GDBusConnection, _destinationBusName, _objectPath, _interfaceName, _signalName, parameters ? parameters.cPtr!GVariant : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the ID of the export (never zero), or 0 in case of failure
   */
  uint exportActionGroup(string objectPath, ActionGroup actionGroup)
  {
    uint _retval;
    const(char)* _objectPath = objectPath.toCString(false);
    GError *_err;
    _retval = g_dbus_connection_export_action_group(cPtr!GDBusConnection, _objectPath, actionGroup ? (cast(ObjectG)actionGroup).cPtr!GActionGroup : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the ID of the export (never zero), or 0 in case of failure
   */
  uint exportMenuModel(string objectPath, MenuModel menu)
  {
    uint _retval;
    const(char)* _objectPath = objectPath.toCString(false);
    GError *_err;
    _retval = g_dbus_connection_export_menu_model(cPtr!GDBusConnection, _objectPath, menu ? menu.cPtr!GMenuModel : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously flushes @connection, that is, writes all queued
   * outgoing message to the transport and then flushes the transport
   * (using g_output_stream_flush_async()). This is useful in programs
   * that wants to emit a D-Bus signal and then exit immediately. Without
   * flushing the connection, there is no guaranteed that the message has
   * been sent to the networking buffers in the OS kernel.
   *
   * This is an asynchronous method. When the operation is finished,
   * @callback will be invoked in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread you are calling this method from. You can
   * then call g_dbus_connection_flush_finish() to get the result of the
   * operation. See g_dbus_connection_flush_sync() for the synchronous
   * version.
   */
  void flush(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_dbus_connection_flush(cPtr!GDBusConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation succeeded, %FALSE if @error is set
   */
  bool flushFinish(AsyncResult res)
  {
    bool _retval;
    GError *_err;
    _retval = g_dbus_connection_flush_finish(cPtr!GDBusConnection, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the operation succeeded, %FALSE if @error is set
   */
  bool flushSync(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_dbus_connection_flush_sync(cPtr!GDBusConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * zero or more flags from the #GDBusCapabilityFlags enumeration
   */
  DBusCapabilityFlags getCapabilities()
  {
    GDBusCapabilityFlags _cretval;
    _cretval = g_dbus_connection_get_capabilities(cPtr!GDBusConnection);
    DBusCapabilityFlags _retval = cast(DBusCapabilityFlags)_cretval;
    return _retval;
  }

  /**
   * whether the process is terminated when @connection is
   * closed by the remote peer
   */
  bool getExitOnClose()
  {
    bool _retval;
    _retval = g_dbus_connection_get_exit_on_close(cPtr!GDBusConnection);
    return _retval;
  }

  /**
   * zero or more flags from the #GDBusConnectionFlags enumeration
   */
  DBusConnectionFlags getFlags()
  {
    GDBusConnectionFlags _cretval;
    _cretval = g_dbus_connection_get_flags(cPtr!GDBusConnection);
    DBusConnectionFlags _retval = cast(DBusConnectionFlags)_cretval;
    return _retval;
  }

  /**
   * The GUID. Do not free this string, it is owned by
   * @connection.
   */
  string getGuid()
  {
    const(char)* _cretval;
    _cretval = g_dbus_connection_get_guid(cPtr!GDBusConnection);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the last used serial or zero when no message has been sent
   * within the current thread
   */
  uint getLastSerial()
  {
    uint _retval;
    _retval = g_dbus_connection_get_last_serial(cPtr!GDBusConnection);
    return _retval;
  }

  /**
   * a #GCredentials or %NULL if not
   * available. Do not free this object, it is owned by @connection.
   */
  Credentials getPeerCredentials()
  {
    GCredentials* _cretval;
    _cretval = g_dbus_connection_get_peer_credentials(cPtr!GDBusConnection);
    Credentials _retval = ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, false);
    return _retval;
  }

  /**
   * the stream used for IO
   */
  IOStream getStream()
  {
    GIOStream* _cretval;
    _cretval = g_dbus_connection_get_stream(cPtr!GDBusConnection);
    IOStream _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, false);
    return _retval;
  }

  /**
   * the unique name or %NULL if @connection is not a message
   * bus connection. Do not free this string, it is owned by
   * @connection.
   */
  string getUniqueName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_connection_get_unique_name(cPtr!GDBusConnection);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if the connection is closed, %FALSE otherwise
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_dbus_connection_is_closed(cPtr!GDBusConnection);
    return _retval;
  }

  /**
   * 0 if @error is set, otherwise a registration ID (never 0)
   * that can be used with g_dbus_connection_unregister_object() .
   */
  uint registerObject(string objectPath, DBusInterfaceInfo interfaceInfo, Closure methodCallClosure, Closure getPropertyClosure, Closure setPropertyClosure)
  {
    uint _retval;
    const(char)* _objectPath = objectPath.toCString(false);
    GError *_err;
    _retval = g_dbus_connection_register_object_with_closures(cPtr!GDBusConnection, _objectPath, interfaceInfo ? interfaceInfo.cPtr!GDBusInterfaceInfo : null, methodCallClosure ? methodCallClosure.cPtr!GClosure : null, getPropertyClosure ? getPropertyClosure.cPtr!GClosure : null, setPropertyClosure ? setPropertyClosure.cPtr!GClosure : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * 0 if @error is set, otherwise a subtree registration ID (never 0)
   * that can be used with g_dbus_connection_unregister_subtree()
   */
  uint registerSubtree(string objectPath, DBusSubtreeVTable vtable, DBusSubtreeFlags flags, void* userData, DestroyNotify userDataFreeFunc)
  {
    extern(C) void _userDataFreeFuncCallback(void* data)
    {
      ptrThawGC(data);

      (*(cast(DestroyNotify*)data))();
    }

    uint _retval;
    const(char)* _objectPath = objectPath.toCString(false);
    GError *_err;
    _retval = g_dbus_connection_register_subtree(cPtr!GDBusConnection, _objectPath, vtable ? vtable.cPtr!GDBusSubtreeVTable : null, flags, userData, &_userDataFreeFuncCallback, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes a filter.
   *
   * Note that since filters run in a different thread, there is a race
   * condition where it is possible that the filter will be running even
   * after calling g_dbus_connection_remove_filter(), so you cannot just
   * free data that the filter might be using. Instead, you should pass
   * a #GDestroyNotify to g_dbus_connection_add_filter(), which will be
   * called when it is guaranteed that the data is no longer needed.
   */
  void removeFilter(uint filterId)
  {
    g_dbus_connection_remove_filter(cPtr!GDBusConnection, filterId);
  }

  /**
   * %TRUE if the message was well-formed and queued for
   * transmission, %FALSE if @error is set
   */
  bool sendMessage(DBusMessage message, DBusSendMessageFlags flags, out uint outSerial)
  {
    bool _retval;
    GError *_err;
    _retval = g_dbus_connection_send_message(cPtr!GDBusConnection, message ? message.cPtr!GDBusMessage : null, flags, cast(uint*)&outSerial, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously sends @message to the peer represented by @connection.
   *
   * Unless @flags contain the
   * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag, the serial number
   * will be assigned by @connection and set on @message via
   * g_dbus_message_set_serial(). If @out_serial is not %NULL, then the
   * serial number used will be written to this location prior to
   * submitting the message to the underlying transport. While it has a `volatile`
   * qualifier, this is a historical artifact and the argument passed to it should
   * not be `volatile`.
   *
   * If @connection is closed then the operation will fail with
   * %G_IO_ERROR_CLOSED. If @cancellable is canceled, the operation will
   * fail with %G_IO_ERROR_CANCELLED. If @message is not well-formed,
   * the operation fails with %G_IO_ERROR_INVALID_ARGUMENT.
   *
   * This is an asynchronous method. When the operation is finished, @callback
   * will be invoked in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread you are calling this method from. You can then call
   * g_dbus_connection_send_message_with_reply_finish() to get the result of the operation.
   * See g_dbus_connection_send_message_with_reply_sync() for the synchronous version.
   *
   * Note that @message must be unlocked, unless @flags contain the
   * %G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL flag.
   *
   * See this [server][gdbus-server] and [client][gdbus-unix-fd-client]
   * for an example of how to use this low-level API to send and receive
   * UNIX file descriptors.
   */
  void sendMessageWithReply(DBusMessage message, DBusSendMessageFlags flags, int timeoutMsec, out uint outSerial, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_dbus_connection_send_message_with_reply(cPtr!GDBusConnection, message ? message.cPtr!GDBusMessage : null, flags, timeoutMsec, cast(uint*)&outSerial, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a locked #GDBusMessage or %NULL if @error is set
   */
  DBusMessage sendMessageWithReplyFinish(AsyncResult res)
  {
    GDBusMessage* _cretval;
    GError *_err;
    _cretval = g_dbus_connection_send_message_with_reply_finish(cPtr!GDBusConnection, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * a locked #GDBusMessage that is the reply
   * to @message or %NULL if @error is set
   */
  DBusMessage sendMessageWithReplySync(DBusMessage message, DBusSendMessageFlags flags, int timeoutMsec, out uint outSerial, Cancellable cancellable)
  {
    GDBusMessage* _cretval;
    GError *_err;
    _cretval = g_dbus_connection_send_message_with_reply_sync(cPtr!GDBusConnection, message ? message.cPtr!GDBusMessage : null, flags, timeoutMsec, cast(uint*)&outSerial, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * Sets whether the process should be terminated when @connection is
   * closed by the remote peer. See #GDBusConnection:exit-on-close for
   * more details.
   *
   * Note that this function should be used with care. Most modern UNIX
   * desktops tie the notion of a user session with the session bus, and expect
   * all of a user's applications to quit when their bus connection goes away.
   * If you are setting @exit_on_close to %FALSE for the shared session
   * bus connection, you should make sure that your application exits
   * when the user session ends.
   */
  void setExitOnClose(bool exitOnClose)
  {
    g_dbus_connection_set_exit_on_close(cPtr!GDBusConnection, exitOnClose);
  }

  /**
   * a subscription identifier that can be used with g_dbus_connection_signal_unsubscribe()
   */
  uint signalSubscribe(string sender, string interfaceName, string member, string objectPath, string arg0, DBusSignalFlags flags, DBusSignalCallback callback)
  {
    extern(C) void _callbackCallback(GDBusConnection* connection, const(char)* senderName, const(char)* objectPath, const(char)* interfaceName, const(char)* signalName, GVariant* parameters, void* userData)
    {
      string _senderName = senderName.fromCString(false);
      string _objectPath = objectPath.fromCString(false);
      string _interfaceName = interfaceName.fromCString(false);
      string _signalName = signalName.fromCString(false);

      (*(cast(DBusSignalCallback*)userData))(connection ? ObjectG.getDObject!DBusConnection(connection, false) : null, _senderName, _objectPath, _interfaceName, _signalName, parameters ? new Variant(parameters, false) : null);
    }

    uint _retval;
    const(char)* _sender = sender.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    const(char)* _member = member.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _arg0 = arg0.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    _retval = g_dbus_connection_signal_subscribe(cPtr!GDBusConnection, _sender, _interfaceName, _member, _objectPath, _arg0, flags, &_callbackCallback, cast(void*)&callback, &ptrThawDestroyNotify);
    return _retval;
  }

  /**
   * Unsubscribes from signals.
   *
   * Note that there may still be D-Bus traffic to process (relating to this
   * signal subscription) in the current thread-default #GMainContext after this
   * function has returned. You should continue to iterate the #GMainContext
   * until the #GDestroyNotify function passed to
   * g_dbus_connection_signal_subscribe() is called, in order to avoid memory
   * leaks through callbacks queued on the #GMainContext after it’s stopped being
   * iterated.
   * Alternatively, any idle source with a priority lower than %G_PRIORITY_DEFAULT
   * that was scheduled after unsubscription, also indicates that all resources
   * of this subscription are released.
   */
  void signalUnsubscribe(uint subscriptionId)
  {
    g_dbus_connection_signal_unsubscribe(cPtr!GDBusConnection, subscriptionId);
  }

  /**
   * If @connection was created with
   * %G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING, this method
   * starts processing messages. Does nothing on if @connection wasn't
   * created with this flag or if the method has already been called.
   */
  void startMessageProcessing()
  {
    g_dbus_connection_start_message_processing(cPtr!GDBusConnection);
  }

  /**
   * Reverses the effect of a previous call to
   * g_dbus_connection_export_action_group().
   *
   * It is an error to call this function with an ID that wasn't returned
   * from g_dbus_connection_export_action_group() or to call it with the
   * same ID more than once.
   */
  void unexportActionGroup(uint exportId)
  {
    g_dbus_connection_unexport_action_group(cPtr!GDBusConnection, exportId);
  }

  /**
   * Reverses the effect of a previous call to
   * g_dbus_connection_export_menu_model().
   *
   * It is an error to call this function with an ID that wasn't returned
   * from g_dbus_connection_export_menu_model() or to call it with the
   * same ID more than once.
   */
  void unexportMenuModel(uint exportId)
  {
    g_dbus_connection_unexport_menu_model(cPtr!GDBusConnection, exportId);
  }

  /**
   * %TRUE if the object was unregistered, %FALSE otherwise
   */
  bool unregisterObject(uint registrationId)
  {
    bool _retval;
    _retval = g_dbus_connection_unregister_object(cPtr!GDBusConnection, registrationId);
    return _retval;
  }

  /**
   * %TRUE if the subtree was unregistered, %FALSE otherwise
   */
  bool unregisterSubtree(uint registrationId)
  {
    bool _retval;
    _retval = g_dbus_connection_unregister_subtree(cPtr!GDBusConnection, registrationId);
    return _retval;
  }

  /**
   * Emitted when the connection is closed.
   *
   * The cause of this event can be
   *
   * - If g_dbus_connection_close() is called. In this case
   * @remote_peer_vanished is set to %FALSE and @error is %NULL.
   *
   * - If the remote peer closes the connection. In this case
   * @remote_peer_vanished is set to %TRUE and @error is set.
   *
   * - If the remote peer sends invalid or malformed data. In this
   * case @remote_peer_vanished is set to %FALSE and @error is set.
   *
   * Upon receiving this signal, you should give up your reference to
   * @connection. You are guaranteed that this signal is emitted only
   * once.
   */
  ulong connectClosed(void delegate(bool remotePeerVanished, ErrorG error, DBusConnection dBusConnection) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusConnection = getVal!DBusConnection(_paramVals);
      auto remotePeerVanished = getVal!bool(&_paramVals[1]);
      auto error = getVal!ErrorG(&_paramVals[2]);
      _dgClosure.dlg(remotePeerVanished, error, dBusConnection);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("closed", closure, (flags & ConnectFlags.After) != 0);
  }
}

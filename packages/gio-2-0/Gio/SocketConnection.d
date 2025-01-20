module Gio.SocketConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.Socket;
import Gio.SocketAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GSocketConnection` is a [Gio.IOStream] for a connected socket. They
 * can be created either by [Gio.SocketClient] when connecting to a host,
 * or by [Gio.SocketListener] when accepting a new client.
 * The type of the `GSocketConnection` object returned from these calls
 * depends on the type of the underlying socket that is in use. For
 * instance, for a TCP/IP connection it will be a [Gio.TcpConnection].
 * Choosing what type of object to construct is done with the socket
 * connection factory, and it is possible for third parties to register
 * custom socket connection types for specific combination of socket
 * family/type/protocol using [Gio.SocketConnection.factoryRegisterType].
 * To close a `GSocketConnection`, use [Gio.IOStream.close]. Closing both
 * substreams of the [Gio.IOStream] separately will not close the
 * underlying [Gio.Socket].
 */
class SocketConnection : IOStream
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
    return g_socket_connection_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Looks up the #GType to be used when creating socket connections on
   * sockets with the specified family, type and protocol_id.
   * If no type is registered, the #GSocketConnection base type is returned.
   * Params:
   *   family = a #GSocketFamily
   *   type = a #GSocketType
   *   protocolId = a protocol id
   * Returns: a #GType
   */
  static GType factoryLookupType(SocketFamily family, SocketType type, int protocolId)
  {
    GType _retval;
    _retval = g_socket_connection_factory_lookup_type(family, type, protocolId);
    return _retval;
  }

  /**
   * Looks up the #GType to be used when creating socket connections on
   * sockets with the specified family, type and protocol.
   * If no type is registered, the #GSocketConnection base type is returned.
   * Params:
   *   gType = a #GType, inheriting from %G_TYPE_SOCKET_CONNECTION
   *   family = a #GSocketFamily
   *   type = a #GSocketType
   *   protocol = a protocol id
   */
  static void factoryRegisterType(GType gType, SocketFamily family, SocketType type, int protocol)
  {
    g_socket_connection_factory_register_type(gType, family, type, protocol);
  }

  /**
   * Connect connection to the specified remote address.
   * Params:
   *   address = a #GSocketAddress specifying the remote address.
   *   cancellable = a %GCancellable or %NULL
   * Returns: %TRUE if the connection succeeded, %FALSE on error
   */
  bool connect(SocketAddress address, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_connection_connect(cast(GSocketConnection*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously connect connection to the specified remote address.
   * This clears the #GSocket:blocking flag on connection's underlying
   * socket if it is currently set.
   * If #GSocket:timeout is set, the operation will time out and return
   * %G_IO_ERROR_TIMED_OUT after that period. Otherwise, it will continue
   * indefinitely until operating system timeouts $(LPAREN)if any$(RPAREN) are hit.
   * Use [Gio.SocketConnection.connectFinish] to retrieve the result.
   * Params:
   *   address = a #GSocketAddress specifying the remote address.
   *   cancellable = a %GCancellable or %NULL
   *   callback = a #GAsyncReadyCallback
   */
  void connectAsync(SocketAddress address, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_socket_connection_connect_async(cast(GSocketConnection*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Gets the result of a [Gio.SocketConnection.connectAsync] call.
   * Params:
   *   result = the #GAsyncResult
   * Returns: %TRUE if the connection succeeded, %FALSE on error
   */
  bool connectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_connection_connect_finish(cast(GSocketConnection*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Try to get the local address of a socket connection.
   * Returns: a #GSocketAddress or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  SocketAddress getLocalAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_connection_get_local_address(cast(GSocketConnection*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Try to get the remote address of a socket connection.
   * Since GLib 2.40, when used with [Gio.SocketClient.connect] or
   * [Gio.SocketClient.connectAsync], during emission of
   * %G_SOCKET_CLIENT_CONNECTING, this function will return the remote
   * address that will be used for the connection.  This allows
   * applications to print e.g. "Connecting to example.com
   * $(LPAREN)10.42.77.3$(RPAREN)...".
   * Returns: a #GSocketAddress or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  SocketAddress getRemoteAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_connection_get_remote_address(cast(GSocketConnection*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the underlying #GSocket object of the connection.
   * This can be useful if you want to do something unusual on it
   * not supported by the #GSocketConnection APIs.
   * Returns: a #GSocket or %NULL on error.
   */
  Socket getSocket()
  {
    GSocket* _cretval;
    _cretval = g_socket_connection_get_socket(cast(GSocketConnection*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Socket(cast(GSocket*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if connection is connected. This is equivalent to calling
   * [Gio.Socket.isConnected] on connection's underlying #GSocket.
   * Returns: whether connection is connected
   */
  bool isConnected()
  {
    bool _retval;
    _retval = g_socket_connection_is_connected(cast(GSocketConnection*)cPtr);
    return _retval;
  }
}

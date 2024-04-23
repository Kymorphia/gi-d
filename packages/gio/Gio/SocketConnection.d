module Gio.SocketConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.Socket;
import Gio.SocketAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSocketConnection is a #GIOStream for a connected socket. They
 * can be created either by #GSocketClient when connecting to a host,
 * or by #GSocketListener when accepting a new client.
 *
 * The type of the #GSocketConnection object returned from these calls
 * depends on the type of the underlying socket that is in use. For
 * instance, for a TCP/IP connection it will be a #GTcpConnection.
 *
 * Choosing what type of object to construct is done with the socket
 * connection factory, and it is possible for 3rd parties to register
 * custom socket connection types for specific combination of socket
 * family/type/protocol using g_socket_connection_factory_register_type().
 *
 * To close a #GSocketConnection, use g_io_stream_close(). Closing both
 * substreams of the #GIOStream separately will not close the underlying
 * #GSocket.
 */
class SocketConnection : IOStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_connection_get_type();
  }

  /**
   * a #GType
   */
  static GType factoryLookupType(SocketFamily family, SocketType type, int protocolId)
  {
    GType _retval;
    _retval = g_socket_connection_factory_lookup_type(family, type, protocolId);
    return _retval;
  }

  /**
   * Looks up the #GType to be used when creating socket connections on
   * sockets with the specified @family, @type and @protocol.
   *
   * If no type is registered, the #GSocketConnection base type is returned.
   */
  static void factoryRegisterType(GType gType, SocketFamily family, SocketType type, int protocol)
  {
    g_socket_connection_factory_register_type(gType, family, type, protocol);
  }

  /**
   * %TRUE if the connection succeeded, %FALSE on error
   */
  bool connect(SocketAddress address, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_connection_connect(cPtr!GSocketConnection, address ? address.cPtr!GSocketAddress : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously connect @connection to the specified remote address.
   *
   * This clears the #GSocket:blocking flag on @connection's underlying
   * socket if it is currently set.
   *
   * Use g_socket_connection_connect_finish() to retrieve the result.
   */
  void connectAsync(SocketAddress address, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_socket_connection_connect_async(cPtr!GSocketConnection, address ? address.cPtr!GSocketAddress : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the connection succeeded, %FALSE on error
   */
  bool connectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_connection_connect_finish(cPtr!GSocketConnection, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GSocketAddress or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  SocketAddress getLocalAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_connection_get_local_address(cPtr!GSocketConnection, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocketAddress or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  SocketAddress getRemoteAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_connection_get_remote_address(cPtr!GSocketConnection, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocket or %NULL on error.
   */
  Socket getSocket()
  {
    GSocket* _cretval;
    _cretval = g_socket_connection_get_socket(cPtr!GSocketConnection);
    Socket _retval = ObjectG.getDObject!Socket(cast(GSocket*)_cretval, false);
    return _retval;
  }

  /**
   * whether @connection is connected
   */
  bool isConnected()
  {
    bool _retval;
    _retval = g_socket_connection_is_connected(cPtr!GSocketConnection);
    return _retval;
  }
}

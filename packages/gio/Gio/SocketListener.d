module Gio.SocketListener;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Socket;
import Gio.SocketAddress;
import Gio.SocketConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GSocketListener is an object that keeps track of a set
 * of server sockets and helps you accept sockets from any of the
 * socket, either sync or async.
 *
 * Add addresses and ports to listen on using g_socket_listener_add_address()
 * and g_socket_listener_add_inet_port(). These will be listened on until
 * g_socket_listener_close() is called. Dropping your final reference to the
 * #GSocketListener will not cause g_socket_listener_close() to be called
 * implicitly, as some references to the #GSocketListener may be held
 * internally.
 *
 * If you want to implement a network server, also look at #GSocketService
 * and #GThreadedSocketService which are subclasses of #GSocketListener
 * that make this even easier.
 */
class SocketListener : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_listener_get_type();
  }

  /**
   * a new #GSocketListener.
   */
  this()
  {
    GSocketListener* _cretval;
    _cretval = g_socket_listener_new();
    this(_cretval, true);
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection accept(out ObjectG sourceObject, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept(cPtr!GSocketListener, &_sourceObject, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * This is the asynchronous version of g_socket_listener_accept().
   *
   * When the operation is finished @callback will be
   * called. You can then call g_socket_listener_accept_finish()
   * to get the result of the operation.
   */
  void acceptAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_socket_listener_accept_async(cPtr!GSocketListener, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection acceptFinish(AsyncResult result, out ObjectG sourceObject)
  {
    GSocketConnection* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept_finish(cPtr!GSocketListener, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_sourceObject, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * a #GSocket on success, %NULL on error.
   */
  Socket acceptSocket(out ObjectG sourceObject, Cancellable cancellable)
  {
    GSocket* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept_socket(cPtr!GSocketListener, &_sourceObject, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Socket _retval = ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true);
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * This is the asynchronous version of g_socket_listener_accept_socket().
   *
   * When the operation is finished @callback will be
   * called. You can then call g_socket_listener_accept_socket_finish()
   * to get the result of the operation.
   */
  void acceptSocketAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_socket_listener_accept_socket_async(cPtr!GSocketListener, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GSocket on success, %NULL on error.
   */
  Socket acceptSocketFinish(AsyncResult result, out ObjectG sourceObject)
  {
    GSocket* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept_socket_finish(cPtr!GSocketListener, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_sourceObject, &_err);
    if (_err)
      throw new ErrorG(_err);
    Socket _retval = ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true);
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool addAddress(SocketAddress address, SocketType type, SocketProtocol protocol, ObjectG sourceObject, out SocketAddress effectiveAddress)
  {
    bool _retval;
    GSocketAddress* _effectiveAddress;
    GError *_err;
    _retval = g_socket_listener_add_address(cPtr!GSocketListener, address ? address.cPtr!GSocketAddress : null, type, protocol, sourceObject ? sourceObject.cPtr!ObjectC : null, &_effectiveAddress, &_err);
    if (_err)
      throw new ErrorG(_err);
    effectiveAddress = new SocketAddress(cast(void*)_effectiveAddress, true);
    return _retval;
  }

  /**
   * the port number, or 0 in case of failure.
   */
  ushort addAnyInetPort(ObjectG sourceObject)
  {
    ushort _retval;
    GError *_err;
    _retval = g_socket_listener_add_any_inet_port(cPtr!GSocketListener, sourceObject ? sourceObject.cPtr!ObjectC : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool addInetPort(ushort port, ObjectG sourceObject)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_listener_add_inet_port(cPtr!GSocketListener, port, sourceObject ? sourceObject.cPtr!ObjectC : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool addSocket(Socket socket, ObjectG sourceObject)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_listener_add_socket(cPtr!GSocketListener, socket ? socket.cPtr!GSocket : null, sourceObject ? sourceObject.cPtr!ObjectC : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Closes all the sockets in the listener.
   */
  void close()
  {
    g_socket_listener_close(cPtr!GSocketListener);
  }

  /**
   * Sets the listen backlog on the sockets in the listener. This must be called
   * before adding any sockets, addresses or ports to the #GSocketListener (for
   * example, by calling g_socket_listener_add_inet_port()) to be effective.
   *
   * See g_socket_set_listen_backlog() for details
   */
  void setBacklog(int listenBacklog)
  {
    g_socket_listener_set_backlog(cPtr!GSocketListener, listenBacklog);
  }

  /**
   * Emitted when @listener's activity on @socket changes state.
   * Note that when @listener is used to listen on both IPv4 and
   * IPv6, a separate set of signals will be emitted for each, and
   * the order they happen in is undefined.
   */
  ulong connectEvent(void delegate(SocketListenerEvent event, Socket socket, SocketListener socketListener) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto socketListener = getVal!SocketListener(_paramVals);
      auto event = getVal!SocketListenerEvent(&_paramVals[1]);
      auto socket = getVal!Socket(&_paramVals[2]);
      _dgClosure.dlg(event, socket, socketListener);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("event", closure, (flags & ConnectFlags.After) != 0);
  }
}

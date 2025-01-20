module Gio.SocketListener;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Socket;
import Gio.SocketAddress;
import Gio.SocketConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GSocketListener` is an object that keeps track of a set
 * of server sockets and helps you accept sockets from any of the
 * socket, either sync or async.
 * Add addresses and ports to listen on using
 * [Gio.SocketListener.addAddress] and
 * [Gio.SocketListener.addInetPort]. These will be listened on until
 * [Gio.SocketListener.close] is called. Dropping your final reference to
 * the `GSocketListener` will not cause [Gio.SocketListener.close] to be
 * called implicitly, as some references to the `GSocketListener` may be held
 * internally.
 * If you want to implement a network server, also look at
 * [Gio.SocketService] and [Gio.ThreadedSocketService] which are
 * subclasses of `GSocketListener` that make this even easier.
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

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GSocketListener with no sockets to listen for.
   * New listeners can be added with e.g. [Gio.SocketListener.addAddress]
   * or [Gio.SocketListener.addInetPort].
   * Returns: a new #GSocketListener.
   */
  this()
  {
    GSocketListener* _cretval;
    _cretval = g_socket_listener_new();
    this(_cretval, true);
  }

  /**
   * Blocks waiting for a client to connect to any of the sockets added
   * to the listener. Returns a #GSocketConnection for the socket that was
   * accepted.
   * If source_object is not %NULL it will be filled out with the source
   * object specified when the corresponding socket or address was added
   * to the listener.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   sourceObject = location where #GObject pointer will be stored, or %NULL
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection accept(out ObjectG sourceObject, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept(cast(GSocketListener*)cPtr, &_sourceObject, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * This is the asynchronous version of [Gio.SocketListener.accept].
   * When the operation is finished callback will be
   * called. You can then call [Gio.SocketListener.acceptFinish]
   * to get the result of the operation.
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback
   */
  void acceptAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_socket_listener_accept_async(cast(GSocketListener*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an async accept operation. See [Gio.SocketListener.acceptAsync]
   * Params:
   *   result = a #GAsyncResult.
   *   sourceObject = Optional #GObject identifying this source
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection acceptFinish(AsyncResult result, out ObjectG sourceObject)
  {
    GSocketConnection* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept_finish(cast(GSocketListener*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_sourceObject, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * Blocks waiting for a client to connect to any of the sockets added
   * to the listener. Returns the #GSocket that was accepted.
   * If you want to accept the high-level #GSocketConnection, not a #GSocket,
   * which is often the case, then you should use [Gio.SocketListener.accept]
   * instead.
   * If source_object is not %NULL it will be filled out with the source
   * object specified when the corresponding socket or address was added
   * to the listener.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   sourceObject = location where #GObject pointer will be stored, or %NULL.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a #GSocket on success, %NULL on error.
   */
  Socket acceptSocket(out ObjectG sourceObject, Cancellable cancellable)
  {
    GSocket* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept_socket(cast(GSocketListener*)cPtr, &_sourceObject, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true) : null;
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * This is the asynchronous version of [Gio.SocketListener.acceptSocket].
   * When the operation is finished callback will be
   * called. You can then call [Gio.SocketListener.acceptSocketFinish]
   * to get the result of the operation.
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback
   */
  void acceptSocketAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_socket_listener_accept_socket_async(cast(GSocketListener*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an async accept operation. See [Gio.SocketListener.acceptSocketAsync]
   * Params:
   *   result = a #GAsyncResult.
   *   sourceObject = Optional #GObject identifying this source
   * Returns: a #GSocket on success, %NULL on error.
   */
  Socket acceptSocketFinish(AsyncResult result, out ObjectG sourceObject)
  {
    GSocket* _cretval;
    ObjectC* _sourceObject;
    GError *_err;
    _cretval = g_socket_listener_accept_socket_finish(cast(GSocketListener*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_sourceObject, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true) : null;
    sourceObject = new ObjectG(cast(void*)_sourceObject, false);
    return _retval;
  }

  /**
   * Creates a socket of type type and protocol protocol, binds
   * it to address and adds it to the set of sockets we're accepting
   * sockets from.
   * Note that adding an IPv6 address, depending on the platform,
   * may or may not result in a listener that also accepts IPv4
   * connections.  For more deterministic behavior, see
   * [Gio.SocketListener.addInetPort].
   * source_object will be passed out in the various calls
   * to accept to identify this particular source, which is
   * useful if you're listening on multiple addresses and do
   * different things depending on what address is connected to.
   * If successful and effective_address is non-%NULL then it will
   * be set to the address that the binding actually occurred at.  This
   * is helpful for determining the port number that was used for when
   * requesting a binding to port 0 $(LPAREN)ie: "any port"$(RPAREN).  This address, if
   * requested, belongs to the caller and must be freed.
   * Call [Gio.SocketListener.close] to stop listening on address; this will not
   * be done automatically when you drop your final reference to listener, as
   * references may be held internally.
   * Params:
   *   address = a #GSocketAddress
   *   type = a #GSocketType
   *   protocol = a #GSocketProtocol
   *   sourceObject = Optional #GObject identifying this source
   *   effectiveAddress = location to store the address that was bound to, or %NULL.
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool addAddress(SocketAddress address, SocketType type, SocketProtocol protocol, ObjectG sourceObject, out SocketAddress effectiveAddress)
  {
    bool _retval;
    GSocketAddress* _effectiveAddress;
    GError *_err;
    _retval = g_socket_listener_add_address(cast(GSocketListener*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, type, protocol, sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, &_effectiveAddress, &_err);
    if (_err)
      throw new ErrorG(_err);
    effectiveAddress = new SocketAddress(cast(void*)_effectiveAddress, true);
    return _retval;
  }

  /**
   * Listens for TCP connections on any available port number for both
   * IPv6 and IPv4 $(LPAREN)if each is available$(RPAREN).
   * This is useful if you need to have a socket for incoming connections
   * but don't care about the specific port number.
   * source_object will be passed out in the various calls
   * to accept to identify this particular source, which is
   * useful if you're listening on multiple addresses and do
   * different things depending on what address is connected to.
   * Params:
   *   sourceObject = Optional #GObject identifying this source
   * Returns: the port number, or 0 in case of failure.
   */
  ushort addAnyInetPort(ObjectG sourceObject)
  {
    ushort _retval;
    GError *_err;
    _retval = g_socket_listener_add_any_inet_port(cast(GSocketListener*)cPtr, sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Helper function for [Gio.SocketListener.addAddress] that
   * creates a TCP/IP socket listening on IPv4 and IPv6 $(LPAREN)if
   * supported$(RPAREN) on the specified port on all interfaces.
   * source_object will be passed out in the various calls
   * to accept to identify this particular source, which is
   * useful if you're listening on multiple addresses and do
   * different things depending on what address is connected to.
   * Call [Gio.SocketListener.close] to stop listening on port; this will not
   * be done automatically when you drop your final reference to listener, as
   * references may be held internally.
   * Params:
   *   port = an IP port number $(LPAREN)non-zero$(RPAREN)
   *   sourceObject = Optional #GObject identifying this source
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool addInetPort(ushort port, ObjectG sourceObject)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_listener_add_inet_port(cast(GSocketListener*)cPtr, port, sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Adds socket to the set of sockets that we try to accept
   * new clients from. The socket must be bound to a local
   * address and listened to.
   * source_object will be passed out in the various calls
   * to accept to identify this particular source, which is
   * useful if you're listening on multiple addresses and do
   * different things depending on what address is connected to.
   * The socket will not be automatically closed when the listener is finalized
   * unless the listener held the final reference to the socket. Before GLib 2.42,
   * the socket was automatically closed on finalization of the listener, even
   * if references to it were held elsewhere.
   * Params:
   *   socket = a listening #GSocket
   *   sourceObject = Optional #GObject identifying this source
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool addSocket(Socket socket, ObjectG sourceObject)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_listener_add_socket(cast(GSocketListener*)cPtr, socket ? cast(GSocket*)socket.cPtr(false) : null, sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Closes all the sockets in the listener.
   */
  void close()
  {
    g_socket_listener_close(cast(GSocketListener*)cPtr);
  }

  /**
   * Sets the listen backlog on the sockets in the listener. This must be called
   * before adding any sockets, addresses or ports to the #GSocketListener $(LPAREN)for
   * example, by calling [Gio.SocketListener.addInetPort]$(RPAREN) to be effective.
   * See [Gio.Socket.setListenBacklog] for details
   * Params:
   *   listenBacklog = an integer
   */
  void setBacklog(int listenBacklog)
  {
    g_socket_listener_set_backlog(cast(GSocketListener*)cPtr, listenBacklog);
  }

  /**
   * Emitted when listener's activity on socket changes state.
   * Note that when listener is used to listen on both IPv4 and
   * IPv6, a separate set of signals will be emitted for each, and
   * the order they happen in is undefined.
   * Params
   *   event = the event that is occurring
   *   socket = the #GSocket the event is occurring on
   *   socketListener = the instance the signal is connected to
   */
  alias EventCallback = void delegate(SocketListenerEvent event, Socket socket, SocketListener socketListener);

  /**
   * Connect to Event signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEvent(EventCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("event", closure, after);
  }
}

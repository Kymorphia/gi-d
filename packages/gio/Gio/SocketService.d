module Gio.SocketService;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.SocketConnection;
import Gio.SocketListener;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GSocketService` is an object that represents a service that
 * is provided to the network or over local sockets.  When a new
 * connection is made to the service the [Gio.SocketService.incoming]
 * signal is emitted.
 * A `GSocketService` is a subclass of [Gio.SocketListener] and you need
 * to add the addresses you want to accept connections on with the
 * [Gio.SocketListener] APIs.
 * There are two options for implementing a network service based on
 * `GSocketService`. The first is to create the service using
 * [Gio.SocketService.new_] and to connect to the
 * [Gio.SocketService.incoming] signal. The second is to subclass
 * `GSocketService` and override the default signal handler implementation.
 * In either case, the handler must immediately return, or else it
 * will block additional incoming connections from being serviced.
 * If you are interested in writing connection handlers that contain
 * blocking code then see [Gio.ThreadedSocketService].
 * The socket service runs on the main loop of the
 * thread-default context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) of the thread it is
 * created in, and is not threadsafe in general. However, the calls to start and
 * stop the service are thread-safe so these can be used from threads that
 * handle incoming clients.
 */
class SocketService : SocketListener
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_service_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GSocketService with no sockets to listen for.
   * New listeners can be added with e.g. [Gio.SocketListener.addAddress]
   * or [Gio.SocketListener.addInetPort].
   * New services are created active, there is no need to call
   * [Gio.SocketService.start], unless [Gio.SocketService.stop] has been
   * called before.
   * Returns: a new #GSocketService.
   */
  this()
  {
    GSocketService* _cretval;
    _cretval = g_socket_service_new();
    this(_cretval, true);
  }

  /**
   * Check whether the service is active or not. An active
   * service will accept new clients that connect, while
   * a non-active service will let connecting clients queue
   * up until the service is started.
   * Returns: %TRUE if the service is active, %FALSE otherwise
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_socket_service_is_active(cast(GSocketService*)cPtr);
    return _retval;
  }

  /**
   * Restarts the service, i.e. start accepting connections
   * from the added sockets when the mainloop runs. This only needs
   * to be called after the service has been stopped from
   * [Gio.SocketService.stop].
   * This call is thread-safe, so it may be called from a thread
   * handling an incoming client request.
   */
  void start()
  {
    g_socket_service_start(cast(GSocketService*)cPtr);
  }

  /**
   * Stops the service, i.e. stops accepting connections
   * from the added sockets when the mainloop runs.
   * This call is thread-safe, so it may be called from a thread
   * handling an incoming client request.
   * Note that this only stops accepting new connections; it does not
   * close the listening sockets, and you can call
   * [Gio.SocketService.start] again later to begin listening again. To
   * close the listening sockets, call [Gio.SocketListener.close]. $(LPAREN)This
   * will happen automatically when the #GSocketService is finalized.$(RPAREN)
   * This must be called before calling [Gio.SocketListener.close] as
   * the socket service will start accepting connections immediately
   * when a new socket is added.
   */
  void stop()
  {
    g_socket_service_stop(cast(GSocketService*)cPtr);
  }

  /**
   * The ::incoming signal is emitted when a new incoming connection
   * to service needs to be handled. The handler must initiate the
   * handling of connection, but may not block; in essence,
   * asynchronous operations must be used.
   * connection will be unreffed once the signal handler returns,
   * so you need to ref it yourself if you are planning to use it.
   * Params
   *   connection = a new #GSocketConnection object
   *   sourceObject = the source_object passed to
   *     [Gio.SocketListener.addAddress]
   *   socketService = the instance the signal is connected to
   * Returns: %TRUE to stop other handlers from being called
   */
  alias IncomingCallback = bool delegate(SocketConnection connection, ObjectG sourceObject, SocketService socketService);

  /**
   * Connect to Incoming signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectIncoming(IncomingCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto socketService = getVal!SocketService(_paramVals);
      auto connection = getVal!SocketConnection(&_paramVals[1]);
      auto sourceObject = getVal!ObjectG(&_paramVals[2]);
      _retval = _dgClosure.dlg(connection, sourceObject, socketService);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("incoming", closure, after);
  }
}

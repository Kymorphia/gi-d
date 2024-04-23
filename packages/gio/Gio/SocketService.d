module Gio.SocketService;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.SocketConnection;
import Gio.SocketListener;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GSocketService is an object that represents a service that
 * is provided to the network or over local sockets.  When a new
 * connection is made to the service the #GSocketService::incoming
 * signal is emitted.
 *
 * A #GSocketService is a subclass of #GSocketListener and you need
 * to add the addresses you want to accept connections on with the
 * #GSocketListener APIs.
 *
 * There are two options for implementing a network service based on
 * #GSocketService. The first is to create the service using
 * g_socket_service_new() and to connect to the #GSocketService::incoming
 * signal. The second is to subclass #GSocketService and override the
 * default signal handler implementation.
 *
 * In either case, the handler must immediately return, or else it
 * will block additional incoming connections from being serviced.
 * If you are interested in writing connection handlers that contain
 * blocking code then see #GThreadedSocketService.
 *
 * The socket service runs on the main loop of the
 * [thread-default context][g-main-context-push-thread-default-context]
 * of the thread it is created in, and is not
 * threadsafe in general. However, the calls to start and stop the
 * service are thread-safe so these can be used from threads that
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

  /**
   * a new #GSocketService.
   */
  this()
  {
    GSocketService* _cretval;
    _cretval = g_socket_service_new();
    this(_cretval, true);
  }

  /**
   * %TRUE if the service is active, %FALSE otherwise
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_socket_service_is_active(cPtr!GSocketService);
    return _retval;
  }

  /**
   * Restarts the service, i.e. start accepting connections
   * from the added sockets when the mainloop runs. This only needs
   * to be called after the service has been stopped from
   * g_socket_service_stop().
   *
   * This call is thread-safe, so it may be called from a thread
   * handling an incoming client request.
   */
  void start()
  {
    g_socket_service_start(cPtr!GSocketService);
  }

  /**
   * Stops the service, i.e. stops accepting connections
   * from the added sockets when the mainloop runs.
   *
   * This call is thread-safe, so it may be called from a thread
   * handling an incoming client request.
   *
   * Note that this only stops accepting new connections; it does not
   * close the listening sockets, and you can call
   * g_socket_service_start() again later to begin listening again. To
   * close the listening sockets, call g_socket_listener_close(). (This
   * will happen automatically when the #GSocketService is finalized.)
   *
   * This must be called before calling g_socket_listener_close() as
   * the socket service will start accepting connections immediately
   * when a new socket is added.
   */
  void stop()
  {
    g_socket_service_stop(cPtr!GSocketService);
  }

  /**
   * %TRUE to stop other handlers from being called
   */
  ulong connectIncoming(bool delegate(SocketConnection connection, ObjectG sourceObject, SocketService socketService) dlg, ConnectFlags flags = ConnectFlags.Default)
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
    return connectSignalClosure("incoming", closure, (flags & ConnectFlags.After) != 0);
  }
}

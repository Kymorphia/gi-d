module Gio.ThreadedSocketService;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.SocketConnection;
import Gio.SocketService;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GThreadedSocketService` is a simple subclass of [Gio.SocketService]
 * that handles incoming connections by creating a worker thread and
 * dispatching the connection to it by emitting the
 * [Gio.ThreadedSocketService.run] in the new thread.
 * The signal handler may perform blocking I/O and need not return
 * until the connection is closed.
 * The service is implemented using a thread pool, so there is a
 * limited amount of threads available to serve incoming requests.
 * The service automatically stops the [Gio.SocketService] from accepting
 * new connections when all threads are busy.
 * As with [Gio.SocketService], you may connect to
 * [Gio.ThreadedSocketService.run], or subclass and override the default
 * handler.
 */
class ThreadedSocketService : SocketService
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
    return g_threaded_socket_service_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GThreadedSocketService with no listeners. Listeners
   * must be added with one of the #GSocketListener "add" methods.
   * Params:
   *   maxThreads = the maximal number of threads to execute concurrently
   *     handling incoming clients, -1 means no limit
   * Returns: a new #GSocketService.
   */
  this(int maxThreads)
  {
    GSocketService* _cretval;
    _cretval = g_threaded_socket_service_new(maxThreads);
    this(_cretval, true);
  }

  /**
   * The ::run signal is emitted in a worker thread in response to an
   * incoming connection. This thread is dedicated to handling
   * connection and may perform blocking IO. The signal handler need
   * not return until the connection is closed.
   * Params
   *   connection = a new #GSocketConnection object.
   *   sourceObject = the source_object passed to [Gio.SocketListener.addAddress].
   *   threadedSocketService = the instance the signal is connected to
   * Returns: %TRUE to stop further signal handlers from being called
   */
  alias RunCallback = bool delegate(SocketConnection connection, ObjectG sourceObject, ThreadedSocketService threadedSocketService);

  /**
   * Connect to Run signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectRun(RunCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto threadedSocketService = getVal!ThreadedSocketService(_paramVals);
      auto connection = getVal!SocketConnection(&_paramVals[1]);
      auto sourceObject = getVal!ObjectG(&_paramVals[2]);
      _retval = _dgClosure.dlg(connection, sourceObject, threadedSocketService);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("run", closure, (flags & ConnectFlags.After) != 0);
  }
}

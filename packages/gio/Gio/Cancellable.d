module Gio.Cancellable;

import GLib.ErrorG;
import GLib.Source;
import GLib.Types;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GCancellable` allows operations to be cancelled.
 * `GCancellable` is a thread-safe operation cancellation stack used
 * throughout GIO to allow for cancellation of synchronous and
 * asynchronous operations.
 */
class Cancellable : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_cancellable_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GCancellable object.
   * Applications that want to start one or more operations
   * that should be cancellable should create a #GCancellable
   * and pass it to the operations.
   * One #GCancellable can be used in multiple consecutive
   * operations or in multiple concurrent operations.
   * Returns: a #GCancellable.
   */
  this()
  {
    GCancellable* _cretval;
    _cretval = g_cancellable_new();
    this(_cretval, true);
  }

  /**
   * Gets the top cancellable from the stack.
   * Returns: a #GCancellable from the top
   *   of the stack, or %NULL if the stack is empty.
   */
  static Cancellable getCurrent()
  {
    GCancellable* _cretval;
    _cretval = g_cancellable_get_current();
    auto _retval = _cretval ? ObjectG.getDObject!Cancellable(cast(GCancellable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Will set cancellable to cancelled, and will emit the
   * #GCancellable::cancelled signal. $(LPAREN)However, see the warning about
   * race conditions in the documentation for that signal if you are
   * planning to connect to it.$(RPAREN)
   * This function is thread-safe. In other words, you can safely call
   * it from a thread other than the one running the operation that was
   * passed the cancellable.
   * If cancellable is %NULL, this function returns immediately for convenience.
   * The convention within GIO is that cancelling an asynchronous
   * operation causes it to complete asynchronously. That is, if you
   * cancel the operation from the same thread in which it is running,
   * then the operation's #GAsyncReadyCallback will not be invoked until
   * the application returns to the main loop.
   */
  void cancel()
  {
    g_cancellable_cancel(cast(GCancellable*)cPtr);
  }

  /**
   * Disconnects a handler from a cancellable instance similar to
   * [GObject.Global.signalHandlerDisconnect].  Additionally, in the event that a
   * signal handler is currently running, this call will block until the
   * handler has finished.  Calling this function from a
   * #GCancellable::cancelled signal handler will therefore result in a
   * deadlock.
   * This avoids a race condition where a thread cancels at the
   * same time as the cancellable operation is finished and the
   * signal handler is removed. See #GCancellable::cancelled for
   * details on how to use this.
   * If cancellable is %NULL or handler_id is `0` this function does
   * nothing.
   * Params:
   *   handlerId = Handler id of the handler to be disconnected, or `0`.
   */
  void disconnect(ulong handlerId)
  {
    g_cancellable_disconnect(cast(GCancellable*)cPtr, handlerId);
  }

  /**
   * Gets the file descriptor for a cancellable job. This can be used to
   * implement cancellable operations on Unix systems. The returned fd will
   * turn readable when cancellable is cancelled.
   * You are not supposed to read from the fd yourself, just check for
   * readable status. Reading to unset the readable status is done
   * with [Gio.Cancellable.reset].
   * After a successful return from this function, you should use
   * [Gio.Cancellable.releaseFd] to free up resources allocated for
   * the returned file descriptor.
   * See also [Gio.Cancellable.makePollfd].
   * Returns: A valid file descriptor. `-1` if the file descriptor
   *   is not supported, or on errors.
   */
  int getFd()
  {
    int _retval;
    _retval = g_cancellable_get_fd(cast(GCancellable*)cPtr);
    return _retval;
  }

  /**
   * Checks if a cancellable job has been cancelled.
   * Returns: %TRUE if cancellable is cancelled,
   *   FALSE if called with %NULL or if item is not cancelled.
   */
  bool isCancelled()
  {
    bool _retval;
    _retval = g_cancellable_is_cancelled(cast(GCancellable*)cPtr);
    return _retval;
  }

  /**
   * Creates a #GPollFD corresponding to cancellable; this can be passed
   * to [GLib.DGLibGlobal.poll] and used to poll for cancellation. This is useful both
   * for unix systems without a native poll and for portability to
   * windows.
   * When this function returns %TRUE, you should use
   * [Gio.Cancellable.releaseFd] to free up resources allocated for the
   * pollfd. After a %FALSE return, do not call [Gio.Cancellable.releaseFd].
   * If this function returns %FALSE, either no cancellable was given or
   * resource limits prevent this function from allocating the necessary
   * structures for polling. $(LPAREN)On Linux, you will likely have reached
   * the maximum number of file descriptors.$(RPAREN) The suggested way to handle
   * these cases is to ignore the cancellable.
   * You are not supposed to read from the fd yourself, just check for
   * readable status. Reading to unset the readable status is done
   * with [Gio.Cancellable.reset].
   * Params:
   *   pollfd = a pointer to a #GPollFD
   * Returns: %TRUE if pollfd was successfully initialized, %FALSE on
   *   failure to prepare the cancellable.
   */
  bool makePollfd(PollFD pollfd)
  {
    bool _retval;
    _retval = g_cancellable_make_pollfd(cast(GCancellable*)cPtr, &pollfd);
    return _retval;
  }

  /**
   * Pops cancellable off the cancellable stack $(LPAREN)verifying that cancellable
   * is on the top of the stack$(RPAREN).
   */
  void popCurrent()
  {
    g_cancellable_pop_current(cast(GCancellable*)cPtr);
  }

  /**
   * Pushes cancellable onto the cancellable stack. The current
   * cancellable can then be received using [Gio.Cancellable.getCurrent].
   * This is useful when implementing cancellable operations in
   * code that does not allow you to pass down the cancellable object.
   * This is typically called automatically by e.g. #GFile operations,
   * so you rarely have to call this yourself.
   */
  void pushCurrent()
  {
    g_cancellable_push_current(cast(GCancellable*)cPtr);
  }

  /**
   * Releases a resources previously allocated by [Gio.Cancellable.getFd]
   * or [Gio.Cancellable.makePollfd].
   * For compatibility reasons with older releases, calling this function
   * is not strictly required, the resources will be automatically freed
   * when the cancellable is finalized. However, the cancellable will
   * block scarce file descriptors until it is finalized if this function
   * is not called. This can cause the application to run out of file
   * descriptors when many #GCancellables are used at the same time.
   */
  void releaseFd()
  {
    g_cancellable_release_fd(cast(GCancellable*)cPtr);
  }

  /**
   * Resets cancellable to its uncancelled state.
   * If cancellable is currently in use by any cancellable operation
   * then the behavior of this function is undefined.
   * Note that it is generally not a good idea to reuse an existing
   * cancellable for more operations after it has been cancelled once,
   * as this function might tempt you to do. The recommended practice
   * is to drop the reference to a cancellable after cancelling it,
   * and let it die with the outstanding async operations. You should
   * create a fresh cancellable for further async operations.
   */
  void reset()
  {
    g_cancellable_reset(cast(GCancellable*)cPtr);
  }

  /**
   * If the cancellable is cancelled, sets the error to notify
   * that the operation was cancelled.
   * Returns: %TRUE if cancellable was cancelled, %FALSE if it was not
   */
  bool setErrorIfCancelled()
  {
    bool _retval;
    GError *_err;
    _retval = g_cancellable_set_error_if_cancelled(cast(GCancellable*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Creates a source that triggers if cancellable is cancelled and
   * calls its callback of type #GCancellableSourceFunc. This is
   * primarily useful for attaching to another $(LPAREN)non-cancellable$(RPAREN) source
   * with [GLib.Source.addChildSource] to add cancellability to it.
   * For convenience, you can call this with a %NULL #GCancellable,
   * in which case the source will never trigger.
   * The new #GSource will hold a reference to the #GCancellable.
   * Returns: the new #GSource.
   */
  Source sourceNew()
  {
    GSource* _cretval;
    _cretval = g_cancellable_source_new(cast(GCancellable*)cPtr);
    auto _retval = _cretval ? new Source(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Emitted when the operation has been cancelled.
   * Can be used by implementations of cancellable operations. If the
   * operation is cancelled from another thread, the signal will be
   * emitted in the thread that cancelled the operation, not the
   * thread that is running the operation.
   * Note that disconnecting from this signal $(LPAREN)or any signal$(RPAREN) in a
   * multi-threaded program is prone to race conditions. For instance
   * it is possible that a signal handler may be invoked even after
   * a call to [GObject.Global.signalHandlerDisconnect] for that handler has
   * already returned.
   * There is also a problem when cancellation happens right before
   * connecting to the signal. If this happens the signal will
   * unexpectedly not be emitted, and checking before connecting to
   * the signal leaves a race condition where this is still happening.
   * In order to make it safe and easy to connect handlers there
   * are two helper functions: [Gio.Cancellable.connect] and
   * [Gio.Cancellable.disconnect] which protect against problems
   * like this.
   * An example of how to us this:
   * |[<!-- language\="C" -->
   * // Make sure we don't do unnecessary work if already cancelled
   * if $(LPAREN)g_cancellable_set_error_if_cancelled $(LPAREN)cancellable, error$(RPAREN)$(RPAREN)
   * return;
   * // Set up all the data needed to be able to handle cancellation
   * // of the operation
   * my_data \= my_data_new $(LPAREN)...$(RPAREN);
   * id \= 0;
   * if $(LPAREN)cancellable$(RPAREN)
   * id \= g_cancellable_connect $(LPAREN)cancellable,
   * G_CALLBACK $(LPAREN)cancelled_handler$(RPAREN)
   * data, NULL$(RPAREN);
   * // cancellable operation here...
   * g_cancellable_disconnect $(LPAREN)cancellable, id$(RPAREN);
   * // cancelled_handler is never called after this, it is now safe
   * // to free the data
   * my_data_free $(LPAREN)my_data$(RPAREN);
   * ]|
   * Note that the cancelled signal is emitted in the thread that
   * the user cancelled from, which may be the main thread. So, the
   * cancellable signal should not do something that can block.
   *   cancellable = the instance the signal is connected to
   */
  alias CancelledCallback = void delegate(Cancellable cancellable);

  /**
   * Connect to Cancelled signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCancelled(CancelledCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cancellable = getVal!Cancellable(_paramVals);
      _dgClosure.dlg(cancellable);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cancelled", closure, after);
  }
}

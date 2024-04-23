module Gio.Cancellable;

import GLib.ErrorG;
import GLib.Source;
import GLib.Types;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * GCancellable is a thread-safe operation cancellation stack used
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

  /**
   * a #GCancellable.
   */
  this()
  {
    GCancellable* _cretval;
    _cretval = g_cancellable_new();
    this(_cretval, true);
  }

  /**
   * a #GCancellable from the top
   * of the stack, or %NULL if the stack is empty.
   */
  static Cancellable getCurrent()
  {
    GCancellable* _cretval;
    _cretval = g_cancellable_get_current();
    Cancellable _retval = ObjectG.getDObject!Cancellable(cast(GCancellable*)_cretval, false);
    return _retval;
  }

  /**
   * Will set @cancellable to cancelled, and will emit the
   * #GCancellable::cancelled signal. (However, see the warning about
   * race conditions in the documentation for that signal if you are
   * planning to connect to it.)
   *
   * This function is thread-safe. In other words, you can safely call
   * it from a thread other than the one running the operation that was
   * passed the @cancellable.
   *
   * If @cancellable is %NULL, this function returns immediately for convenience.
   *
   * The convention within GIO is that cancelling an asynchronous
   * operation causes it to complete asynchronously. That is, if you
   * cancel the operation from the same thread in which it is running,
   * then the operation's #GAsyncReadyCallback will not be invoked until
   * the application returns to the main loop.
   */
  void cancel()
  {
    g_cancellable_cancel(cPtr!GCancellable);
  }

  /**
   * Disconnects a handler from a cancellable instance similar to
   * g_signal_handler_disconnect().  Additionally, in the event that a
   * signal handler is currently running, this call will block until the
   * handler has finished.  Calling this function from a
   * #GCancellable::cancelled signal handler will therefore result in a
   * deadlock.
   *
   * This avoids a race condition where a thread cancels at the
   * same time as the cancellable operation is finished and the
   * signal handler is removed. See #GCancellable::cancelled for
   * details on how to use this.
   *
   * If @cancellable is %NULL or @handler_id is `0` this function does
   * nothing.
   */
  void disconnect(ulong handlerId)
  {
    g_cancellable_disconnect(cPtr!GCancellable, handlerId);
  }

  /**
   * A valid file descriptor. `-1` if the file descriptor
   * is not supported, or on errors.
   */
  int getFd()
  {
    int _retval;
    _retval = g_cancellable_get_fd(cPtr!GCancellable);
    return _retval;
  }

  /**
   * %TRUE if @cancellable is cancelled,
   * FALSE if called with %NULL or if item is not cancelled.
   */
  bool isCancelled()
  {
    bool _retval;
    _retval = g_cancellable_is_cancelled(cPtr!GCancellable);
    return _retval;
  }

  /**
   * %TRUE if @pollfd was successfully initialized, %FALSE on
   * failure to prepare the cancellable.
   */
  bool makePollfd(PollFD pollfd)
  {
    bool _retval;
    _retval = g_cancellable_make_pollfd(cPtr!GCancellable, &pollfd);
    return _retval;
  }

  /**
   * Pops @cancellable off the cancellable stack (verifying that @cancellable
   * is on the top of the stack).
   */
  void popCurrent()
  {
    g_cancellable_pop_current(cPtr!GCancellable);
  }

  /**
   * Pushes @cancellable onto the cancellable stack. The current
   * cancellable can then be received using g_cancellable_get_current().
   *
   * This is useful when implementing cancellable operations in
   * code that does not allow you to pass down the cancellable object.
   *
   * This is typically called automatically by e.g. #GFile operations,
   * so you rarely have to call this yourself.
   */
  void pushCurrent()
  {
    g_cancellable_push_current(cPtr!GCancellable);
  }

  /**
   * Releases a resources previously allocated by g_cancellable_get_fd()
   * or g_cancellable_make_pollfd().
   *
   * For compatibility reasons with older releases, calling this function
   * is not strictly required, the resources will be automatically freed
   * when the @cancellable is finalized. However, the @cancellable will
   * block scarce file descriptors until it is finalized if this function
   * is not called. This can cause the application to run out of file
   * descriptors when many #GCancellables are used at the same time.
   */
  void releaseFd()
  {
    g_cancellable_release_fd(cPtr!GCancellable);
  }

  /**
   * Resets @cancellable to its uncancelled state.
   *
   * If cancellable is currently in use by any cancellable operation
   * then the behavior of this function is undefined.
   *
   * Note that it is generally not a good idea to reuse an existing
   * cancellable for more operations after it has been cancelled once,
   * as this function might tempt you to do. The recommended practice
   * is to drop the reference to a cancellable after cancelling it,
   * and let it die with the outstanding async operations. You should
   * create a fresh cancellable for further async operations.
   */
  void reset()
  {
    g_cancellable_reset(cPtr!GCancellable);
  }

  /**
   * %TRUE if @cancellable was cancelled, %FALSE if it was not
   */
  bool setErrorIfCancelled()
  {
    bool _retval;
    GError *_err;
    _retval = g_cancellable_set_error_if_cancelled(cPtr!GCancellable, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the new #GSource.
   */
  Source sourceNew()
  {
    GSource* _cretval;
    _cretval = g_cancellable_source_new(cPtr!GCancellable);
    Source _retval = new Source(cast(GSource*)_cretval, true);
    return _retval;
  }

  /**
   * Emitted when the operation has been cancelled.
   *
   * Can be used by implementations of cancellable operations. If the
   * operation is cancelled from another thread, the signal will be
   * emitted in the thread that cancelled the operation, not the
   * thread that is running the operation.
   *
   * Note that disconnecting from this signal (or any signal) in a
   * multi-threaded program is prone to race conditions. For instance
   * it is possible that a signal handler may be invoked even after
   * a call to g_signal_handler_disconnect() for that handler has
   * already returned.
   *
   * There is also a problem when cancellation happens right before
   * connecting to the signal. If this happens the signal will
   * unexpectedly not be emitted, and checking before connecting to
   * the signal leaves a race condition where this is still happening.
   *
   * In order to make it safe and easy to connect handlers there
   * are two helper functions: g_cancellable_connect() and
   * g_cancellable_disconnect() which protect against problems
   * like this.
   *
   * An example of how to us this:
   * |[<!-- language="C" -->
   * // Make sure we don't do unnecessary work if already cancelled
   * if (g_cancellable_set_error_if_cancelled (cancellable, error))
   * return;
   *
   * // Set up all the data needed to be able to handle cancellation
   * // of the operation
   * my_data = my_data_new (...);
   *
   * id = 0;
   * if (cancellable)
   * id = g_cancellable_connect (cancellable,
   * G_CALLBACK (cancelled_handler)
   * data, NULL);
   *
   * // cancellable operation here...
   *
   * g_cancellable_disconnect (cancellable, id);
   *
   * // cancelled_handler is never called after this, it is now safe
   * // to free the data
   * my_data_free (my_data);
   * ]|
   *
   * Note that the cancelled signal is emitted in the thread that
   * the user cancelled from, which may be the main thread. So, the
   * cancellable signal should not do something that can block.
   */
  ulong connectCancelled(void delegate(Cancellable cancellable) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cancellable = getVal!Cancellable(_paramVals);
      _dgClosure.dlg(cancellable);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cancelled", closure, (flags & ConnectFlags.After) != 0);
  }
}

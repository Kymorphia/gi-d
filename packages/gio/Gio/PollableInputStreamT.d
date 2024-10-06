module Gio.PollableInputStreamT;

public import GLib.ErrorG;
public import GLib.Source;
public import Gid.gid;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GPollableInputStream` is implemented by [Gio.InputStream]s that
 * can be polled for readiness to read. This can be used when
 * interfacing with a non-GIO API that expects
 * UNIX-file-descriptor-style asynchronous I/O rather than GIO-style.
 * Some classes may implement `GPollableInputStream` but have only certain
 * instances of that class be pollable. If [Gio.PollableInputStream.canPoll]
 * returns false, then the behavior of other `GPollableInputStream` methods is
 * undefined.
 */
template PollableInputStreamT(TStruct)
{

  /**
   * Checks if stream is actually pollable. Some classes may implement
   * #GPollableInputStream but have only certain instances of that class
   * be pollable. If this method returns %FALSE, then the behavior of
   * other #GPollableInputStream methods is undefined.
   * For any given stream, the value returned by this method is constant;
   * a stream cannot switch from pollable to non-pollable or vice versa.
   * Returns: %TRUE if stream is pollable, %FALSE if not.
   */
  override bool canPoll()
  {
    bool _retval;
    _retval = g_pollable_input_stream_can_poll(cast(GPollableInputStream*)cPtr);
    return _retval;
  }

  /**
   * Creates a #GSource that triggers when stream can be read, or
   * cancellable is triggered or an error occurs. The callback on the
   * source is of the #GPollableSourceFunc type.
   * As with [Gio.PollableInputStream.isReadable], it is possible that
   * the stream may not actually be readable even after the source
   * triggers, so you should use [Gio.PollableInputStream.readNonblocking]
   * rather than [Gio.InputStream.read] from the callback.
   * The behaviour of this method is undefined if
   * [Gio.PollableInputStream.canPoll] returns %FALSE for stream.
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a new #GSource
   */
  override Source createSource(Cancellable cancellable)
  {
    GSource* _cretval;
    _cretval = g_pollable_input_stream_create_source(cast(GPollableInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null);
    auto _retval = _cretval ? new Source(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if stream can be read.
   * Note that some stream types may not be able to implement this 100%
   * reliably, and it is possible that a call to [Gio.InputStream.read]
   * after this returns %TRUE would still block. To guarantee
   * non-blocking behavior, you should always use
   * [Gio.PollableInputStream.readNonblocking], which will return a
   * %G_IO_ERROR_WOULD_BLOCK error rather than blocking.
   * The behaviour of this method is undefined if
   * [Gio.PollableInputStream.canPoll] returns %FALSE for stream.
   * Returns: %TRUE if stream is readable, %FALSE if not. If an error
   *   has occurred on stream, this will result in
   *   [Gio.PollableInputStream.isReadable] returning %TRUE, and the
   *   next attempt to read will return the error.
   */
  override bool isReadable()
  {
    bool _retval;
    _retval = g_pollable_input_stream_is_readable(cast(GPollableInputStream*)cPtr);
    return _retval;
  }

  /**
   * Attempts to read up to count bytes from stream into buffer, as
   * with [Gio.InputStream.read]. If stream is not currently readable,
   * this will immediately return %G_IO_ERROR_WOULD_BLOCK, and you can
   * use [Gio.PollableInputStream.createSource] to create a #GSource
   * that will be triggered when stream is readable.
   * Note that since this method never blocks, you cannot actually
   * use cancellable to cancel it. However, it will return an error
   * if cancellable has already been cancelled when you call, which
   * may happen if you call this method after a source triggers due
   * to having been cancelled.
   * The behaviour of this method is undefined if
   * [Gio.PollableInputStream.canPoll] returns %FALSE for stream.
   * Params:
   *   buffer = a
   *     buffer to read data into $(LPAREN)which should be at least count bytes long$(RPAREN).
   *   cancellable = a #GCancellable, or %NULL
   * Returns: the number of bytes read, or -1 on error $(LPAREN)including
   *   %G_IO_ERROR_WOULD_BLOCK$(RPAREN).
   */
  override ptrdiff_t readNonblocking(ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _count;
    GError *_err;
    _retval = g_pollable_input_stream_read_nonblocking(cast(GPollableInputStream*)cPtr, buffer.ptr, _count, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
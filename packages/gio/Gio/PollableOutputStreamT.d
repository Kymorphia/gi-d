module Gio.PollableOutputStreamT;

public import GLib.ErrorG;
public import GLib.Source;
public import GLib.Types;
public import Gid.Gid;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GPollableOutputStream is implemented by #GOutputStreams that
 * can be polled for readiness to write. This can be used when
 * interfacing with a non-GIO API that expects
 * UNIX-file-descriptor-style asynchronous I/O rather than GIO-style.
 *
 * Some classes may implement #GPollableOutputStream but have only certain
 * instances of that class be pollable. If g_pollable_output_stream_can_poll()
 * returns %FALSE, then the behavior of other #GPollableOutputStream methods is
 * undefined.
 */
template PollableOutputStreamT(TStruct)
{

  /**
   * %TRUE if @stream is pollable, %FALSE if not.
   */
  override bool canPoll()
  {
    bool _retval;
    _retval = g_pollable_output_stream_can_poll(cPtr!GPollableOutputStream);
    return _retval;
  }

  /**
   * a new #GSource
   */
  override Source createSource(Cancellable cancellable)
  {
    GSource* _cretval;
    _cretval = g_pollable_output_stream_create_source(cPtr!GPollableOutputStream, cancellable ? cancellable.cPtr!GCancellable : null);
    Source _retval = new Source(cast(GSource*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @stream is writable, %FALSE if not. If an error
   * has occurred on @stream, this will result in
   * g_pollable_output_stream_is_writable() returning %TRUE, and the
   * next attempt to write will return the error.
   */
  override bool isWritable()
  {
    bool _retval;
    _retval = g_pollable_output_stream_is_writable(cPtr!GPollableOutputStream);
    return _retval;
  }

  /**
   * the number of bytes written, or -1 on error (including
   * %G_IO_ERROR_WOULD_BLOCK).
   */
  override ptrdiff_t writeNonblocking(ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    auto _buffer = cast(void*)buffer.ptr;
    GError *_err;
    _retval = g_pollable_output_stream_write_nonblocking(cPtr!GPollableOutputStream, _buffer, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %@G_POLLABLE_RETURN_OK on success, %G_POLLABLE_RETURN_WOULD_BLOCK
   * if the stream is not currently writable (and @error is *not* set), or
   * %G_POLLABLE_RETURN_FAILED if there was an error in which case @error will
   * be set.
   */
  override PollableReturn writevNonblocking(OutputVector[] vectors, out size_t bytesWritten, Cancellable cancellable)
  {
    GPollableReturn _cretval;
    auto _vectors = cast(const(GOutputVector)*)vectors.ptr;
    GError *_err;
    _cretval = g_pollable_output_stream_writev_nonblocking(cPtr!GPollableOutputStream, _vectors, vectors ? cast(size_t)vectors.length : 0, cast(size_t*)&bytesWritten, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    PollableReturn _retval = cast(PollableReturn)_cretval;
    return _retval;
  }
}

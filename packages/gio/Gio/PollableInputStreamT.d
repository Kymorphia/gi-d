module Gio.PollableInputStreamT;

public import GLib.ErrorG;
public import GLib.Source;
public import GLib.Types;
public import Gid.Gid;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GPollableInputStream is implemented by #GInputStreams that
 * can be polled for readiness to read. This can be used when
 * interfacing with a non-GIO API that expects
 * UNIX-file-descriptor-style asynchronous I/O rather than GIO-style.
 *
 * Some classes may implement #GPollableInputStream but have only certain
 * instances of that class be pollable. If g_pollable_input_stream_can_poll()
 * returns %FALSE, then the behavior of other #GPollableInputStream methods is
 * undefined.
 */
template PollableInputStreamT(TStruct)
{

  /**
   * %TRUE if @stream is pollable, %FALSE if not.
   */
  override bool canPoll()
  {
    bool _retval;
    _retval = g_pollable_input_stream_can_poll(cPtr!GPollableInputStream);
    return _retval;
  }

  /**
   * a new #GSource
   */
  override Source createSource(Cancellable cancellable)
  {
    GSource* _cretval;
    _cretval = g_pollable_input_stream_create_source(cPtr!GPollableInputStream, cancellable ? cancellable.cPtr!GCancellable : null);
    Source _retval = new Source(cast(GSource*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @stream is readable, %FALSE if not. If an error
   * has occurred on @stream, this will result in
   * g_pollable_input_stream_is_readable() returning %TRUE, and the
   * next attempt to read will return the error.
   */
  override bool isReadable()
  {
    bool _retval;
    _retval = g_pollable_input_stream_is_readable(cPtr!GPollableInputStream);
    return _retval;
  }

  /**
   * the number of bytes read, or -1 on error (including
   * %G_IO_ERROR_WOULD_BLOCK).
   */
  override ptrdiff_t readNonblocking(ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_pollable_input_stream_read_nonblocking(cPtr!GPollableInputStream, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

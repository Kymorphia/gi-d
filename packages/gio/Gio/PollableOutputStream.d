module Gio.PollableOutputStream;

import GLib.ErrorG;
import GLib.Source;
import GLib.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
interface PollableOutputStream
{

  static GType getType()
  {
    return g_pollable_output_stream_get_type();
  }

  /**
   * %TRUE if @stream is pollable, %FALSE if not.
   */
  bool canPoll();

  /**
   * a new #GSource
   */
  Source createSource(Cancellable cancellable);

  /**
   * %TRUE if @stream is writable, %FALSE if not. If an error
   * has occurred on @stream, this will result in
   * g_pollable_output_stream_is_writable() returning %TRUE, and the
   * next attempt to write will return the error.
   */
  bool isWritable();

  /**
   * the number of bytes written, or -1 on error (including
   * %G_IO_ERROR_WOULD_BLOCK).
   */
  ptrdiff_t writeNonblocking(ubyte[] buffer, Cancellable cancellable);

  /**
   * %@G_POLLABLE_RETURN_OK on success, %G_POLLABLE_RETURN_WOULD_BLOCK
   * if the stream is not currently writable (and @error is *not* set), or
   * %G_POLLABLE_RETURN_FAILED if there was an error in which case @error will
   * be set.
   */
  PollableReturn writevNonblocking(OutputVector[] vectors, out size_t bytesWritten, Cancellable cancellable);
}

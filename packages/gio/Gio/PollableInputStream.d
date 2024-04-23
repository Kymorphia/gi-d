module Gio.PollableInputStream;

import GLib.ErrorG;
import GLib.Source;
import GLib.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
interface PollableInputStream
{

  static GType getType()
  {
    return g_pollable_input_stream_get_type();
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
   * %TRUE if @stream is readable, %FALSE if not. If an error
   * has occurred on @stream, this will result in
   * g_pollable_input_stream_is_readable() returning %TRUE, and the
   * next attempt to read will return the error.
   */
  bool isReadable();

  /**
   * the number of bytes read, or -1 on error (including
   * %G_IO_ERROR_WOULD_BLOCK).
   */
  ptrdiff_t readNonblocking(ref ubyte[] buffer, Cancellable cancellable);
}

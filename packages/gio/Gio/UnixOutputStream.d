module Gio.UnixOutputStream;

import Gid.gid;
import Gio.FileDescriptorBased;
import Gio.FileDescriptorBasedT;
import Gio.OutputStream;
import Gio.PollableOutputStream;
import Gio.PollableOutputStreamT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GUnixOutputStream` implements [Gio.OutputStream] for writing to a UNIX
 * file descriptor, including asynchronous operations. $(LPAREN)If the file
 * descriptor refers to a socket or pipe, this will use `poll$(LPAREN)$(RPAREN)` to do
 * asynchronous I/O. If it refers to a regular file, it will fall back
 * to doing asynchronous I/O in another thread.$(RPAREN)
 * Note that `<gio/gunixoutputstream.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config file
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
class UnixOutputStream : OutputStream, FileDescriptorBased, PollableOutputStream
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
    return g_unix_output_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin FileDescriptorBasedT!GUnixOutputStream;
  mixin PollableOutputStreamT!GUnixOutputStream;

  /**
   * Creates a new #GUnixOutputStream for the given fd.
   * If close_fd, is %TRUE, the file descriptor will be closed when
   * the output stream is destroyed.
   * Params:
   *   fd = a UNIX file descriptor
   *   closeFd = %TRUE to close the file descriptor when done
   * Returns: a new #GOutputStream
   */
  this(int fd, bool closeFd)
  {
    GOutputStream* _cretval;
    _cretval = g_unix_output_stream_new(fd, closeFd);
    this(_cretval, true);
  }

  /**
   * Returns whether the file descriptor of stream will be
   * closed when the stream is closed.
   * Returns: %TRUE if the file descriptor is closed when done
   */
  bool getCloseFd()
  {
    bool _retval;
    _retval = g_unix_output_stream_get_close_fd(cast(GUnixOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Return the UNIX file descriptor that the stream writes to.
   * Returns: The file descriptor of stream
   */
  int getFd()
  {
    int _retval;
    _retval = g_unix_output_stream_get_fd(cast(GUnixOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Sets whether the file descriptor of stream shall be closed
   * when the stream is closed.
   * Params:
   *   closeFd = %TRUE to close the file descriptor when done
   */
  void setCloseFd(bool closeFd)
  {
    g_unix_output_stream_set_close_fd(cast(GUnixOutputStream*)cPtr, closeFd);
  }
}

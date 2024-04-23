module Gio.UnixInputStream;

import GObject.ObjectG;
import Gid.Gid;
import Gio.FileDescriptorBased;
import Gio.FileDescriptorBasedT;
import Gio.InputStream;
import Gio.PollableInputStream;
import Gio.PollableInputStreamT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GUnixInputStream implements #GInputStream for reading from a UNIX
 * file descriptor, including asynchronous operations. (If the file
 * descriptor refers to a socket or pipe, this will use poll() to do
 * asynchronous I/O. If it refers to a regular file, it will fall back
 * to doing asynchronous I/O in another thread.)
 *
 * Note that `<gio/gunixinputstream.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file when using it.
 */
class UnixInputStream : InputStream, FileDescriptorBased, PollableInputStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_unix_input_stream_get_type();
  }

  mixin FileDescriptorBasedT!GUnixInputStream;
  mixin PollableInputStreamT!GUnixInputStream;

  /**
   * a new #GUnixInputStream
   */
  this(int fd, bool closeFd)
  {
    GInputStream* _cretval;
    _cretval = g_unix_input_stream_new(fd, closeFd);
    this(_cretval, true);
  }

  /**
   * %TRUE if the file descriptor is closed when done
   */
  bool getCloseFd()
  {
    bool _retval;
    _retval = g_unix_input_stream_get_close_fd(cPtr!GUnixInputStream);
    return _retval;
  }

  /**
   * The file descriptor of @stream
   */
  int getFd()
  {
    int _retval;
    _retval = g_unix_input_stream_get_fd(cPtr!GUnixInputStream);
    return _retval;
  }

  /**
   * Sets whether the file descriptor of @stream shall be closed
   * when the stream is closed.
   */
  void setCloseFd(bool closeFd)
  {
    g_unix_input_stream_set_close_fd(cPtr!GUnixInputStream, closeFd);
  }
}

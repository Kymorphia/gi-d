module Gio.UnixFDMessage;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.Gid;
import Gio.SocketControlMessage;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * This #GSocketControlMessage contains a #GUnixFDList.
 * It may be sent using g_socket_send_message() and received using
 * g_socket_receive_message() over UNIX sockets (ie: sockets in the
 * %G_SOCKET_FAMILY_UNIX family). The file descriptors are copied
 * between processes by the kernel.
 *
 * For an easier way to send and receive file descriptors over
 * stream-oriented UNIX sockets, see g_unix_connection_send_fd() and
 * g_unix_connection_receive_fd().
 *
 * Note that `<gio/gunixfdmessage.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file when using it.
 */
class UnixFDMessage : SocketControlMessage
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_unix_fd_message_get_type();
  }

  /**
   * a new #GUnixFDMessage
   */
  this()
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_fd_message_new();
    this(_cretval, true);
  }

  /**
   * a new #GUnixFDMessage
   */
  static SocketControlMessage newWithFdList(UnixFDList fdList)
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_fd_message_new_with_fd_list(fdList ? fdList.cPtr!GUnixFDList : null);
    SocketControlMessage _retval = ObjectG.getDObject!SocketControlMessage(cast(GSocketControlMessage*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE in case of success, else %FALSE (and @error is set)
   */
  bool appendFd(int fd)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_fd_message_append_fd(cPtr!GUnixFDMessage, fd, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the #GUnixFDList from @message
   */
  UnixFDList getFdList()
  {
    GUnixFDList* _cretval;
    _cretval = g_unix_fd_message_get_fd_list(cPtr!GUnixFDMessage);
    UnixFDList _retval = ObjectG.getDObject!UnixFDList(cast(GUnixFDList*)_cretval, false);
    return _retval;
  }

  /**
   * an array of file
   * descriptors
   */
  int[] stealFds()
  {
    int* _cretval;
    int _cretlength;
    _cretval = g_unix_fd_message_steal_fds(cPtr!GUnixFDMessage, &_cretlength);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}

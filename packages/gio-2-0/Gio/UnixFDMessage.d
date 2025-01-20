module Gio.UnixFDMessage;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.SocketControlMessage;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * This [Gio.SocketControlMessage] contains a [Gio.UnixFDList].
 * It may be sent using [Gio.Socket.sendMessage] and received using
 * [Gio.Socket.receiveMessage] over UNIX sockets $(LPAREN)ie: sockets in the
 * `G_SOCKET_FAMILY_UNIX` family$(RPAREN). The file descriptors are copied
 * between processes by the kernel.
 * For an easier way to send and receive file descriptors over
 * stream-oriented UNIX sockets, see [Gio.UnixConnection.sendFd] and
 * [Gio.UnixConnection.receiveFd].
 * Note that `<gio/gunixfdmessage.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
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

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GUnixFDMessage containing an empty file descriptor
   * list.
   * Returns: a new #GUnixFDMessage
   */
  this()
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_fd_message_new();
    this(_cretval, true);
  }

  /**
   * Creates a new #GUnixFDMessage containing list.
   * Params:
   *   fdList = a #GUnixFDList
   * Returns: a new #GUnixFDMessage
   */
  static UnixFDMessage newWithFdList(UnixFDList fdList)
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_fd_message_new_with_fd_list(fdList ? cast(GUnixFDList*)fdList.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!UnixFDMessage(cast(GSocketControlMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds a file descriptor to message.
   * The file descriptor is duplicated using dup$(LPAREN)$(RPAREN). You keep your copy
   * of the descriptor and the copy contained in message will be closed
   * when message is finalized.
   * A possible cause of failure is exceeding the per-process or
   * system-wide file descriptor limit.
   * Params:
   *   fd = a valid open file descriptor
   * Returns: %TRUE in case of success, else %FALSE $(LPAREN)and error is set$(RPAREN)
   */
  bool appendFd(int fd)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_fd_message_append_fd(cast(GUnixFDMessage*)cPtr, fd, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the #GUnixFDList contained in message.  This function does not
   * return a reference to the caller, but the returned list is valid for
   * the lifetime of message.
   * Returns: the #GUnixFDList from message
   */
  UnixFDList getFdList()
  {
    GUnixFDList* _cretval;
    _cretval = g_unix_fd_message_get_fd_list(cast(GUnixFDMessage*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!UnixFDList(cast(GUnixFDList*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the array of file descriptors that is contained in this
   * object.
   * After this call, the descriptors are no longer contained in
   * message. Further calls will return an empty list $(LPAREN)unless more
   * descriptors have been added$(RPAREN).
   * The return result of this function must be freed with [GLib.Global.gfree].
   * The caller is also responsible for closing all of the file
   * descriptors.
   * If length is non-%NULL then it is set to the number of file
   * descriptors in the returned array. The returned array is also
   * terminated with -1.
   * This function never returns %NULL. In case there are no file
   * descriptors contained in message, an empty array is returned.
   * Returns: an array of file
   *   descriptors
   */
  int[] stealFds()
  {
    int* _cretval;
    int _cretlength;
    _cretval = g_unix_fd_message_steal_fds(cast(GUnixFDMessage*)cPtr, &_cretlength);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}

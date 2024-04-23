module Gio.UnixFDList;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GUnixFDList contains a list of file descriptors.  It owns the file
 * descriptors that it contains, closing them when finalized.
 *
 * It may be wrapped in a #GUnixFDMessage and sent over a #GSocket in
 * the %G_SOCKET_FAMILY_UNIX family by using g_socket_send_message()
 * and received using g_socket_receive_message().
 *
 * Before 2.74, `<gio/gunixfdlist.h>` belonged to the UNIX-specific GIO
 * interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file when
 * using it.
 *
 * Since 2.74, the API is available for Windows.
 */
class UnixFDList : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_unix_fd_list_get_type();
  }

  /**
   * a new #GUnixFDList
   */
  this()
  {
    GUnixFDList* _cretval;
    _cretval = g_unix_fd_list_new();
    this(_cretval, true);
  }

  /**
   * a new #GUnixFDList
   */
  static UnixFDList newFromArray(int[] fds)
  {
    GUnixFDList* _cretval;
    auto _fds = cast(const(int)*)fds.ptr;
    _cretval = g_unix_fd_list_new_from_array(_fds, fds ? cast(int)fds.length : 0);
    UnixFDList _retval = ObjectG.getDObject!UnixFDList(cast(GUnixFDList*)_cretval, true);
    return _retval;
  }

  /**
   * the index of the appended fd in case of success, else -1
   * (and @error is set)
   */
  int append(int fd)
  {
    int _retval;
    GError *_err;
    _retval = g_unix_fd_list_append(cPtr!GUnixFDList, fd, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the file descriptor, or -1 in case of error
   */
  int get(int index)
  {
    int _retval;
    GError *_err;
    _retval = g_unix_fd_list_get(cPtr!GUnixFDList, index, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the length of @list
   */
  int getLength()
  {
    int _retval;
    _retval = g_unix_fd_list_get_length(cPtr!GUnixFDList);
    return _retval;
  }

  /**
   * an array of file
   * descriptors
   */
  int[] peekFds()
  {
    const(int)* _cretval;
    int _cretlength;
    _cretval = g_unix_fd_list_peek_fds(cPtr!GUnixFDList, &_cretlength);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
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
    _cretval = g_unix_fd_list_steal_fds(cPtr!GUnixFDList, &_cretlength);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}

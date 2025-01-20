module Gio.UnixFDList;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GUnixFDList` contains a list of file descriptors.  It owns the file
 * descriptors that it contains, closing them when finalized.
 * It may be wrapped in a
 * [`GUnixFDMessage`](../gio-unix/class.UnixFDMessage.html) and sent over a
 * [Gio.Socket] in the `G_SOCKET_FAMILY_UNIX` family by using
 * [Gio.Socket.sendMessage] and received using
 * [Gio.Socket.receiveMessage].
 * Before 2.74, `<gio/gunixfdlist.h>` belonged to the UNIX-specific GIO
 * interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file when
 * using it.
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

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GUnixFDList containing no file descriptors.
   * Returns: a new #GUnixFDList
   */
  this()
  {
    GUnixFDList* _cretval;
    _cretval = g_unix_fd_list_new();
    this(_cretval, true);
  }

  /**
   * Creates a new #GUnixFDList containing the file descriptors given in
   * fds.  The file descriptors become the property of the new list and
   * may no longer be used by the caller.  The array itself is owned by
   * the caller.
   * Each file descriptor in the array should be set to close-on-exec.
   * If n_fds is -1 then fds must be terminated with -1.
   * Params:
   *   fds = the initial list of file descriptors
   * Returns: a new #GUnixFDList
   */
  static UnixFDList newFromArray(int[] fds)
  {
    GUnixFDList* _cretval;
    int _nFds;
    if (fds)
      _nFds = cast(int)fds.length;

    auto _fds = cast(const(int)*)fds.ptr;
    _cretval = g_unix_fd_list_new_from_array(_fds, _nFds);
    auto _retval = _cretval ? ObjectG.getDObject!UnixFDList(cast(GUnixFDList*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds a file descriptor to list.
   * The file descriptor is duplicated using dup$(LPAREN)$(RPAREN). You keep your copy
   * of the descriptor and the copy contained in list will be closed
   * when list is finalized.
   * A possible cause of failure is exceeding the per-process or
   * system-wide file descriptor limit.
   * The index of the file descriptor in the list is returned.  If you use
   * this index with [Gio.UnixFDList.get] then you will receive back a
   * duplicated copy of the same file descriptor.
   * Params:
   *   fd = a valid open file descriptor
   * Returns: the index of the appended fd in case of success, else -1
   *   $(LPAREN)and error is set$(RPAREN)
   */
  int append(int fd)
  {
    int _retval;
    GError *_err;
    _retval = g_unix_fd_list_append(cast(GUnixFDList*)cPtr, fd, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets a file descriptor out of list.
   * index_ specifies the index of the file descriptor to get.  It is a
   * programmer error for index_ to be out of range; see
   * [Gio.UnixFDList.getLength].
   * The file descriptor is duplicated using dup$(LPAREN)$(RPAREN) and set as
   * close-on-exec before being returned.  You must call close$(LPAREN)$(RPAREN) on it
   * when you are done.
   * A possible cause of failure is exceeding the per-process or
   * system-wide file descriptor limit.
   * Params:
   *   index = the index into the list
   * Returns: the file descriptor, or -1 in case of error
   */
  int get(int index)
  {
    int _retval;
    GError *_err;
    _retval = g_unix_fd_list_get(cast(GUnixFDList*)cPtr, index, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the length of list $(LPAREN)ie: the number of file descriptors
   * contained within$(RPAREN).
   * Returns: the length of list
   */
  int getLength()
  {
    int _retval;
    _retval = g_unix_fd_list_get_length(cast(GUnixFDList*)cPtr);
    return _retval;
  }

  /**
   * Returns the array of file descriptors that is contained in this
   * object.
   * After this call, the descriptors remain the property of list.  The
   * caller must not close them and must not free the array.  The array is
   * valid only until list is changed in any way.
   * If length is non-%NULL then it is set to the number of file
   * descriptors in the returned array. The returned array is also
   * terminated with -1.
   * This function never returns %NULL. In case there are no file
   * descriptors contained in list, an empty array is returned.
   * Returns: an array of file
   *   descriptors
   */
  int[] peekFds()
  {
    const(int)* _cretval;
    int _cretlength;
    _cretval = g_unix_fd_list_peek_fds(cast(GUnixFDList*)cPtr, &_cretlength);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Returns the array of file descriptors that is contained in this
   * object.
   * After this call, the descriptors are no longer contained in
   * list. Further calls will return an empty list $(LPAREN)unless more
   * descriptors have been added$(RPAREN).
   * The return result of this function must be freed with [GLib.Global.gfree].
   * The caller is also responsible for closing all of the file
   * descriptors.  The file descriptors in the array are set to
   * close-on-exec.
   * If length is non-%NULL then it is set to the number of file
   * descriptors in the returned array. The returned array is also
   * terminated with -1.
   * This function never returns %NULL. In case there are no file
   * descriptors contained in list, an empty array is returned.
   * Returns: an array of file
   *   descriptors
   */
  int[] stealFds()
  {
    int* _cretval;
    int _cretlength;
    _cretval = g_unix_fd_list_steal_fds(cast(GUnixFDList*)cPtr, &_cretlength);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}

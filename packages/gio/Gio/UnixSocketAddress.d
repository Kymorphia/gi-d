module Gio.UnixSocketAddress;

import GObject.ObjectG;
import Gid.gid;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Support for UNIX-domain $(LPAREN)also known as local$(RPAREN) sockets, corresponding to
 * `struct sockaddr_un`.
 * UNIX domain sockets are generally visible in the filesystem.
 * However, some systems support abstract socket names which are not
 * visible in the filesystem and not affected by the filesystem
 * permissions, visibility, etc. Currently this is only supported
 * under Linux. If you attempt to use abstract sockets on other
 * systems, function calls may return `G_IO_ERROR_NOT_SUPPORTED`
 * errors. You can use [Gio.UnixSocketAddress.abstractNamesSupported]
 * to see if abstract names are supported.
 * Since GLib 2.72, `GUnixSocketAddress` is available on all platforms. It
 * requires underlying system support $(LPAREN)such as Windows 10 with `AF_UNIX`$(RPAREN) at
 * run time.
 * Before GLib 2.72, `<gio/gunixsocketaddress.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 */
class UnixSocketAddress : SocketAddress
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
    return g_unix_socket_address_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GUnixSocketAddress for path.
   * To create abstract socket addresses, on systems that support that,
   * use [Gio.UnixSocketAddress.newAbstract].
   * Params:
   *   path = the socket path
   * Returns: a new #GUnixSocketAddress
   */
  this(string path)
  {
    GSocketAddress* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_unix_socket_address_new(_path);
    this(_cretval, true);
  }

  /**
   * Creates a new %G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED
   * #GUnixSocketAddress for path.
   * Params:
   *   path = the abstract name
   * Returns: a new #GUnixSocketAddress

   * Deprecated: Use [Gio.UnixSocketAddress.newWithType].
   */
  static UnixSocketAddress newAbstract(string path)
  {
    GSocketAddress* _cretval;
    int _pathLen;
    if (path)
      _pathLen = cast(int)path.length;

    auto _path = cast(const(char)*)path.ptr;
    _cretval = g_unix_socket_address_new_abstract(_path, _pathLen);
    auto _retval = _cretval ? ObjectG.getDObject!UnixSocketAddress(cast(GSocketAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GUnixSocketAddress of type type with name path.
   * If type is %G_UNIX_SOCKET_ADDRESS_PATH, this is equivalent to
   * calling [Gio.UnixSocketAddress.new_].
   * If type is %G_UNIX_SOCKET_ADDRESS_ANONYMOUS, path and path_len will be
   * ignored.
   * If path_type is %G_UNIX_SOCKET_ADDRESS_ABSTRACT, then path_len
   * bytes of path will be copied to the socket's path, and only those
   * bytes will be considered part of the name. $(LPAREN)If path_len is -1,
   * then path is assumed to be NUL-terminated.$(RPAREN) For example, if path
   * was "test", then calling [Gio.SocketAddress.getNativeSize] on the
   * returned socket would return 7 $(LPAREN)2 bytes of overhead, 1 byte for the
   * abstract-socket indicator byte, and 4 bytes for the name "test"$(RPAREN).
   * If path_type is %G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED, then
   * path_len bytes of path will be copied to the socket's path, the
   * rest of the path will be padded with 0 bytes, and the entire
   * zero-padded buffer will be considered the name. $(LPAREN)As above, if
   * path_len is -1, then path is assumed to be NUL-terminated.$(RPAREN) In
   * this case, [Gio.SocketAddress.getNativeSize] will always return
   * the full size of a `struct sockaddr_un`, although
   * [Gio.UnixSocketAddress.getPathLen] will still return just the
   * length of path.
   * %G_UNIX_SOCKET_ADDRESS_ABSTRACT is preferred over
   * %G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED for new programs. Of course,
   * when connecting to a server created by another process, you must
   * use the appropriate type corresponding to how that process created
   * its listening socket.
   * Params:
   *   path = the name
   *   type = a #GUnixSocketAddressType
   * Returns: a new #GUnixSocketAddress
   */
  static UnixSocketAddress newWithType(string path, UnixSocketAddressType type)
  {
    GSocketAddress* _cretval;
    int _pathLen;
    if (path)
      _pathLen = cast(int)path.length;

    auto _path = cast(const(char)*)path.ptr;
    _cretval = g_unix_socket_address_new_with_type(_path, _pathLen, type);
    auto _retval = _cretval ? ObjectG.getDObject!UnixSocketAddress(cast(GSocketAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if abstract UNIX domain socket names are supported.
   * Returns: %TRUE if supported, %FALSE otherwise
   */
  static bool abstractNamesSupported()
  {
    bool _retval;
    _retval = g_unix_socket_address_abstract_names_supported();
    return _retval;
  }

  /**
   * Gets address's type.
   * Returns: a #GUnixSocketAddressType
   */
  UnixSocketAddressType getAddressType()
  {
    GUnixSocketAddressType _cretval;
    _cretval = g_unix_socket_address_get_address_type(cast(GUnixSocketAddress*)cPtr);
    UnixSocketAddressType _retval = cast(UnixSocketAddressType)_cretval;
    return _retval;
  }

  /**
   * Tests if address is abstract.
   * Returns: %TRUE if the address is abstract, %FALSE otherwise

   * Deprecated: Use [Gio.UnixSocketAddress.getAddressType]
   */
  bool getIsAbstract()
  {
    bool _retval;
    _retval = g_unix_socket_address_get_is_abstract(cast(GUnixSocketAddress*)cPtr);
    return _retval;
  }

  /**
   * Gets address's path, or for abstract sockets the "name".
   * Guaranteed to be zero-terminated, but an abstract socket
   * may contain embedded zeros, and thus you should use
   * [Gio.UnixSocketAddress.getPathLen] to get the true length
   * of this string.
   * Returns: the path for address
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_unix_socket_address_get_path(cast(GUnixSocketAddress*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the length of address's path.
   * For details, see [Gio.UnixSocketAddress.getPath].
   * Returns: the length of the path
   */
  size_t getPathLen()
  {
    size_t _retval;
    _retval = g_unix_socket_address_get_path_len(cast(GUnixSocketAddress*)cPtr);
    return _retval;
  }
}

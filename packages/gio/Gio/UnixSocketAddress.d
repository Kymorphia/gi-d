module Gio.UnixSocketAddress;

import GObject.ObjectG;
import Gid.Gid;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Support for UNIX-domain (also known as local) sockets.
 *
 * UNIX domain sockets are generally visible in the filesystem.
 * However, some systems support abstract socket names which are not
 * visible in the filesystem and not affected by the filesystem
 * permissions, visibility, etc. Currently this is only supported
 * under Linux. If you attempt to use abstract sockets on other
 * systems, function calls may return %G_IO_ERROR_NOT_SUPPORTED
 * errors. You can use g_unix_socket_address_abstract_names_supported()
 * to see if abstract names are supported.
 *
 * Since GLib 2.72, #GUnixSocketAddress is available on all platforms. It
 * requires underlying system support (such as Windows 10 with `AF_UNIX`) at
 * run time.
 *
 * Before GLib 2.72, `<gio/gunixsocketaddress.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 */
class UnixSocketAddress : SocketAddress, SocketConnectable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_unix_socket_address_get_type();
  }

  mixin SocketConnectableT!GUnixSocketAddress;

  /**
   * a new #GUnixSocketAddress
   */
  this(string path)
  {
    GSocketAddress* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_unix_socket_address_new(_path);
    this(_cretval, true);
  }

  /**
   * a new #GUnixSocketAddress
   */
  static SocketAddress newAbstract(string path)
  {
    GSocketAddress* _cretval;
    auto _path = cast(const(char)*)path.ptr;
    _cretval = g_unix_socket_address_new_abstract(_path, path ? cast(int)path.length : 0);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GUnixSocketAddress
   */
  static SocketAddress newWithType(string path, UnixSocketAddressType type)
  {
    GSocketAddress* _cretval;
    auto _path = cast(const(char)*)path.ptr;
    _cretval = g_unix_socket_address_new_with_type(_path, path ? cast(int)path.length : 0, type);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if supported, %FALSE otherwise
   */
  static bool abstractNamesSupported()
  {
    bool _retval;
    _retval = g_unix_socket_address_abstract_names_supported();
    return _retval;
  }

  /**
   * a #GUnixSocketAddressType
   */
  UnixSocketAddressType getAddressType()
  {
    GUnixSocketAddressType _cretval;
    _cretval = g_unix_socket_address_get_address_type(cPtr!GUnixSocketAddress);
    UnixSocketAddressType _retval = cast(UnixSocketAddressType)_cretval;
    return _retval;
  }

  /**
   * %TRUE if the address is abstract, %FALSE otherwise
   */
  bool getIsAbstract()
  {
    bool _retval;
    _retval = g_unix_socket_address_get_is_abstract(cPtr!GUnixSocketAddress);
    return _retval;
  }

  /**
   * the path for @address
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_unix_socket_address_get_path(cPtr!GUnixSocketAddress);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the length of the path
   */
  size_t getPathLen()
  {
    size_t _retval;
    _retval = g_unix_socket_address_get_path_len(cPtr!GUnixSocketAddress);
    return _retval;
  }
}

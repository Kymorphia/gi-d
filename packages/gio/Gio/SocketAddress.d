module Gio.SocketAddress;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSocketAddress is the equivalent of struct sockaddr in the BSD
 * sockets API. This is an abstract class; use #GInetSocketAddress
 * for internet sockets, or #GUnixSocketAddress for UNIX domain sockets.
 */
class SocketAddress : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_address_get_type();
  }

  /**
   * a new #GSocketAddress if @native could successfully
   * be converted, otherwise %NULL
   */
  static SocketAddress newFromNative(void* native, size_t len)
  {
    GSocketAddress* _cretval;
    _cretval = g_socket_address_new_from_native(native, len);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * the socket family type of @address
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_socket_address_get_family(cPtr!GSocketAddress);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * the size of the native struct sockaddr that
   * @address represents
   */
  ptrdiff_t getNativeSize()
  {
    ptrdiff_t _retval;
    _retval = g_socket_address_get_native_size(cPtr!GSocketAddress);
    return _retval;
  }

  /**
   * %TRUE if @dest was filled in, %FALSE on error
   */
  bool toNative(void* dest, size_t destlen)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_address_to_native(cPtr!GSocketAddress, dest, destlen, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

module Gio.NativeSocketAddress;

import Gid.gid;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A socket address of some unknown native type.
 * This corresponds to a general `struct sockaddr` of a type not otherwise
 * handled by GLib.
 */
class NativeSocketAddress : SocketAddress
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
    return g_native_socket_address_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GNativeSocketAddress for native and len.
   * Params:
   *   native = a native address object
   *   len = the length of native, in bytes
   * Returns: a new #GNativeSocketAddress
   */
  this(void* native, size_t len)
  {
    GSocketAddress* _cretval;
    _cretval = g_native_socket_address_new(native, len);
    this(_cretval, true);
  }
}

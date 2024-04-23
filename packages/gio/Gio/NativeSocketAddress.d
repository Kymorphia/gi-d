module Gio.NativeSocketAddress;

import GObject.ObjectG;
import Gid.Gid;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A socket address of some unknown native type.
 */
class NativeSocketAddress : SocketAddress, SocketConnectable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_native_socket_address_get_type();
  }

  mixin SocketConnectableT!GNativeSocketAddress;

  /**
   * a new #GNativeSocketAddress
   */
  this(void* native, size_t len)
  {
    GSocketAddress* _cretval;
    _cretval = g_native_socket_address_new(native, len);
    this(_cretval, true);
  }
}

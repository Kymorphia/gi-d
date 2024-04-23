module Gio.TcpWrapperConnection;

import GObject.ObjectG;
import Gid.Gid;
import Gio.IOStream;
import Gio.Socket;
import Gio.SocketConnection;
import Gio.TcpConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GTcpWrapperConnection can be used to wrap a #GIOStream that is
 * based on a #GSocket, but which is not actually a
 * #GSocketConnection. This is used by #GSocketClient so that it can
 * always return a #GSocketConnection, even when the connection it has
 * actually created is not directly a #GSocketConnection.
 */
class TcpWrapperConnection : TcpConnection
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tcp_wrapper_connection_get_type();
  }

  /**
   * the new #GSocketConnection.
   */
  this(IOStream baseIoStream, Socket socket)
  {
    GSocketConnection* _cretval;
    _cretval = g_tcp_wrapper_connection_new(baseIoStream ? baseIoStream.cPtr!GIOStream : null, socket ? socket.cPtr!GSocket : null);
    this(_cretval, true);
  }

  /**
   * @conn's base #GIOStream
   */
  IOStream getBaseIoStream()
  {
    GIOStream* _cretval;
    _cretval = g_tcp_wrapper_connection_get_base_io_stream(cPtr!GTcpWrapperConnection);
    IOStream _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, false);
    return _retval;
  }
}

module Gio.TlsServerConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.Gid;
import Gio.IOStream;
import Gio.TlsCertificate;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GTlsServerConnection is the server-side subclass of #GTlsConnection,
 * representing a server-side TLS connection.
 */
interface TlsServerConnection
{

  static GType getType()
  {
    return g_tls_server_connection_get_type();
  }

  /**
   * the new
   * #GTlsServerConnection, or %NULL on error
   */
  static TlsServerConnection new_(IOStream baseIoStream, TlsCertificate certificate);
}

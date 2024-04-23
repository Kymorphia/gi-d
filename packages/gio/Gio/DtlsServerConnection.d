module Gio.DtlsServerConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.Gid;
import Gio.DatagramBased;
import Gio.TlsCertificate;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDtlsServerConnection is the server-side subclass of #GDtlsConnection,
 * representing a server-side DTLS connection.
 */
interface DtlsServerConnection
{

  static GType getType()
  {
    return g_dtls_server_connection_get_type();
  }

  /**
   * the new
   * #GDtlsServerConnection, or %NULL on error
   */
  static DtlsServerConnection new_(DatagramBased baseSocket, TlsCertificate certificate);
}

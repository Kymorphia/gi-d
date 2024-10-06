module Gio.TlsServerConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.IOStream;
import Gio.TlsCertificate;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GTlsServerConnection` is the server-side subclass of
 * [Gio.TlsConnection], representing a server-side TLS connection.
 */
interface TlsServerConnection
{

  static GType getType()
  {
    return g_tls_server_connection_get_type();
  }

  /**
   * Creates a new #GTlsServerConnection wrapping base_io_stream $(LPAREN)which
   * must have pollable input and output streams$(RPAREN).
   * See the documentation for #GTlsConnection:base-io-stream for restrictions
   * on when application code can run operations on the base_io_stream after
   * this function has returned.
   * Params:
   *   baseIoStream = the #GIOStream to wrap
   *   certificate = the default server certificate, or %NULL
   * Returns: the new
   *   #GTlsServerConnection, or %NULL on error
   */
  static TlsServerConnection new_(IOStream baseIoStream, TlsCertificate certificate);
}

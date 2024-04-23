module Gio.DtlsClientConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.Gid;
import Gio.DatagramBased;
import Gio.SocketConnectable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDtlsClientConnection is the client-side subclass of
 * #GDtlsConnection, representing a client-side DTLS connection.
 */
interface DtlsClientConnection
{

  static GType getType()
  {
    return g_dtls_client_connection_get_type();
  }

  /**
   * the new
   * #GDtlsClientConnection, or %NULL on error
   */
  static DtlsClientConnection new_(DatagramBased baseSocket, SocketConnectable serverIdentity);

  /**
   * a #GSocketConnectable describing the
   * expected server identity, or %NULL if the expected identity is not
   * known.
   */
  SocketConnectable getServerIdentity();

  /**
   * the validation flags
   */
  TlsCertificateFlags getValidationFlags();

  /**
   * Sets @conn's expected server identity, which is used both to tell
   * servers on virtual hosts which certificate to present, and also
   * to let @conn know what name to look for in the certificate when
   * performing %G_TLS_CERTIFICATE_BAD_IDENTITY validation, if enabled.
   */
  void setServerIdentity(SocketConnectable identity);

  /**
   * Sets @conn's validation flags, to override the default set of
   * checks performed when validating a server certificate. By default,
   * %G_TLS_CERTIFICATE_VALIDATE_ALL is used.
   *
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GDtlsClientConnection:validation-flags for more
   * information.
   */
  void setValidationFlags(TlsCertificateFlags flags);
}

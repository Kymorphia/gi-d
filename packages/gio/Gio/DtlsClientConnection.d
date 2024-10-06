module Gio.DtlsClientConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.DatagramBased;
import Gio.DatagramBasedT;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GDtlsClientConnection` is the client-side subclass of
 * [Gio.DtlsConnection], representing a client-side DTLS connection.
 */
interface DtlsClientConnection
{

  static GType getType()
  {
    return g_dtls_client_connection_get_type();
  }

  /**
   * Creates a new #GDtlsClientConnection wrapping base_socket which is
   * assumed to communicate with the server identified by server_identity.
   * Params:
   *   baseSocket = the #GDatagramBased to wrap
   *   serverIdentity = the expected identity of the server
   * Returns: the new
   *   #GDtlsClientConnection, or %NULL on error
   */
  static DtlsClientConnection new_(DatagramBased baseSocket, SocketConnectable serverIdentity);

  /**
   * Gets conn's expected server identity
   * Returns: a #GSocketConnectable describing the
   *   expected server identity, or %NULL if the expected identity is not
   *   known.
   */
  SocketConnectable getServerIdentity();

  /**
   * Gets conn's validation flags
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GDtlsClientConnection:validation-flags for more
   * information.
   * Returns: the validation flags

   * Deprecated: Do not attempt to ignore validation errors.
   */
  TlsCertificateFlags getValidationFlags();

  /**
   * Sets conn's expected server identity, which is used both to tell
   * servers on virtual hosts which certificate to present, and also
   * to let conn know what name to look for in the certificate when
   * performing %G_TLS_CERTIFICATE_BAD_IDENTITY validation, if enabled.
   * Params:
   *   identity = a #GSocketConnectable describing the expected server identity
   */
  void setServerIdentity(SocketConnectable identity);

  /**
   * Sets conn's validation flags, to override the default set of
   * checks performed when validating a server certificate. By default,
   * %G_TLS_CERTIFICATE_VALIDATE_ALL is used.
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GDtlsClientConnection:validation-flags for more
   * information.
   * Params:
   *   flags = the #GTlsCertificateFlags to use

   * Deprecated: Do not attempt to ignore validation errors.
   */
  void setValidationFlags(TlsCertificateFlags flags);
}

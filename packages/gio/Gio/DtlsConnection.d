module Gio.DtlsConnection;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.TlsCertificate;
import Gio.TlsDatabase;
import Gio.TlsInteraction;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDtlsConnection is the base DTLS connection class type, which wraps
 * a #GDatagramBased and provides DTLS encryption on top of it. Its
 * subclasses, #GDtlsClientConnection and #GDtlsServerConnection,
 * implement client-side and server-side DTLS, respectively.
 *
 * For TLS support, see #GTlsConnection.
 *
 * As DTLS is datagram based, #GDtlsConnection implements #GDatagramBased,
 * presenting a datagram-socket-like API for the encrypted connection. This
 * operates over a base datagram connection, which is also a #GDatagramBased
 * (#GDtlsConnection:base-socket).
 *
 * To close a DTLS connection, use g_dtls_connection_close().
 *
 * Neither #GDtlsServerConnection or #GDtlsClientConnection set the peer address
 * on their base #GDatagramBased if it is a #GSocket — it is up to the caller to
 * do that if they wish. If they do not, and g_socket_close() is called on the
 * base socket, the #GDtlsConnection will not raise a %G_IO_ERROR_NOT_CONNECTED
 * error on further I/O.
 */
interface DtlsConnection
{

  static GType getType()
  {
    return g_dtls_connection_get_type();
  }

  /**
   * %TRUE on success, %FALSE otherwise
   */
  bool close(Cancellable cancellable);

  /**
   * Asynchronously close the DTLS connection. See g_dtls_connection_close() for
   * more information.
   */
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on success, %FALSE on failure, in which
   * case @error will be set
   */
  bool closeFinish(AsyncResult result);

  /**
   * %TRUE if one of the signal handlers has returned
   * %TRUE to accept @peer_cert
   */
  bool emitAcceptCertificate(TlsCertificate peerCert, TlsCertificateFlags errors);

  /**
   * @conn's certificate, or %NULL
   */
  TlsCertificate getCertificate();

  /**
   * The name of the current DTLS ciphersuite, or %NULL
   */
  string getCiphersuiteName();

  /**
   * the certificate database that @conn uses or %NULL
   */
  TlsDatabase getDatabase();

  /**
   * The interaction object.
   */
  TlsInteraction getInteraction();

  /**
   * the negotiated protocol, or %NULL
   */
  string getNegotiatedProtocol();

  /**
   * @conn's peer's certificate, or %NULL
   */
  TlsCertificate getPeerCertificate();

  /**
   * @conn's peer's certificate errors
   */
  TlsCertificateFlags getPeerCertificateErrors();

  /**
   * The current DTLS protocol version
   */
  TlsProtocolVersion getProtocolVersion();

  /**
   * %G_TLS_REHANDSHAKE_SAFELY
   */
  TlsRehandshakeMode getRehandshakeMode();

  /**
   * %TRUE if @conn requires a proper TLS close notification.
   */
  bool getRequireCloseNotify();

  /**
   * success or failure
   */
  bool handshake(Cancellable cancellable);

  /**
   * Asynchronously performs a TLS handshake on @conn. See
   * g_dtls_connection_handshake() for more information.
   */
  void handshakeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on success, %FALSE on failure, in which
   * case @error will be set.
   */
  bool handshakeFinish(AsyncResult result);

  /**
   * Sets the list of application-layer protocols to advertise that the
   * caller is willing to speak on this connection. The
   * Application-Layer Protocol Negotiation (ALPN) extension will be
   * used to negotiate a compatible protocol with the peer; use
   * g_dtls_connection_get_negotiated_protocol() to find the negotiated
   * protocol after the handshake.  Specifying %NULL for the the value
   * of @protocols will disable ALPN negotiation.
   *
   * See [IANA TLS ALPN Protocol IDs](https://www.iana.org/assignments/tls-extensiontype-values/tls-extensiontype-values.xhtml#alpn-protocol-ids)
   * for a list of registered protocol IDs.
   */
  void setAdvertisedProtocols(string[] protocols);

  /**
   * This sets the certificate that @conn will present to its peer
   * during the TLS handshake. For a #GDtlsServerConnection, it is
   * mandatory to set this, and that will normally be done at construct
   * time.
   *
   * For a #GDtlsClientConnection, this is optional. If a handshake fails
   * with %G_TLS_ERROR_CERTIFICATE_REQUIRED, that means that the server
   * requires a certificate, and if you try connecting again, you should
   * call this method first. You can call
   * g_dtls_client_connection_get_accepted_cas() on the failed connection
   * to get a list of Certificate Authorities that the server will
   * accept certificates from.
   *
   * (It is also possible that a server will allow the connection with
   * or without a certificate; in that case, if you don't provide a
   * certificate, you can tell that the server requested one by the fact
   * that g_dtls_client_connection_get_accepted_cas() will return
   * non-%NULL.)
   */
  void setCertificate(TlsCertificate certificate);

  /**
   * Sets the certificate database that is used to verify peer certificates.
   * This is set to the default database by default. See
   * g_tls_backend_get_default_database(). If set to %NULL, then
   * peer certificate validation will always set the
   * %G_TLS_CERTIFICATE_UNKNOWN_CA error (meaning
   * #GDtlsConnection::accept-certificate will always be emitted on
   * client-side connections, unless that bit is not set in
   * #GDtlsClientConnection:validation-flags).
   *
   * There are nonintuitive security implications when using a non-default
   * database. See #GDtlsConnection:database for details.
   */
  void setDatabase(TlsDatabase database);

  /**
   * Set the object that will be used to interact with the user. It will be used
   * for things like prompting the user for passwords.
   *
   * The @interaction argument will normally be a derived subclass of
   * #GTlsInteraction. %NULL can also be provided if no user interaction
   * should occur for this connection.
   */
  void setInteraction(TlsInteraction interaction);

  /**
   * Since GLib 2.64, changing the rehandshake mode is no longer supported
   * and will have no effect. With TLS 1.3, rehandshaking has been removed from
   * the TLS protocol, replaced by separate post-handshake authentication and
   * rekey operations.
   */
  void setRehandshakeMode(TlsRehandshakeMode mode);

  /**
   * Sets whether or not @conn expects a proper TLS close notification
   * before the connection is closed. If this is %TRUE (the default),
   * then @conn will expect to receive a TLS close notification from its
   * peer before the connection is closed, and will return a
   * %G_TLS_ERROR_EOF error if the connection is closed without proper
   * notification (since this may indicate a network error, or
   * man-in-the-middle attack).
   *
   * In some protocols, the application will know whether or not the
   * connection was closed cleanly based on application-level data
   * (because the application-level data includes a length field, or is
   * somehow self-delimiting); in this case, the close notify is
   * redundant and may be omitted. You
   * can use g_dtls_connection_set_require_close_notify() to tell @conn
   * to allow an "unannounced" connection close, in which case the close
   * will show up as a 0-length read, as in a non-TLS
   * #GDatagramBased, and it is up to the application to check that
   * the data has been fully received.
   *
   * Note that this only affects the behavior when the peer closes the
   * connection; when the application calls g_dtls_connection_close_async() on
   * @conn itself, this will send a close notification regardless of the
   * setting of this property. If you explicitly want to do an unclean
   * close, you can close @conn's #GDtlsConnection:base-socket rather
   * than closing @conn itself.
   */
  void setRequireCloseNotify(bool requireCloseNotify);

  /**
   * %TRUE on success, %FALSE otherwise
   */
  bool shutdown(bool shutdownRead, bool shutdownWrite, Cancellable cancellable);

  /**
   * Asynchronously shut down part or all of the DTLS connection. See
   * g_dtls_connection_shutdown() for more information.
   */
  void shutdownAsync(bool shutdownRead, bool shutdownWrite, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on success, %FALSE on failure, in which
   * case @error will be set
   */
  bool shutdownFinish(AsyncResult result);

  /**
   * %TRUE to accept @peer_cert (which will also
   * immediately end the signal emission). %FALSE to allow the signal
   * emission to continue, which will cause the handshake to fail if
   * no one else overrides it.
   */
  ulong connectAcceptCertificate(bool delegate(TlsCertificate peerCert, TlsCertificateFlags errors, DtlsConnection dtlsConnection) dlg, ConnectFlags flags = ConnectFlags.Default);
}

module Gio.DtlsConnection;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.TlsCertificate;
import Gio.TlsDatabase;
import Gio.TlsInteraction;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GDtlsConnection` is the base DTLS connection class type, which wraps
 * a [Gio.DatagramBased] and provides DTLS encryption on top of it. Its
 * subclasses, [Gio.DtlsClientConnection] and
 * [Gio.DtlsServerConnection], implement client-side and server-side DTLS,
 * respectively.
 * For TLS support, see [Gio.TlsConnection].
 * As DTLS is datagram based, `GDtlsConnection` implements
 * [Gio.DatagramBased], presenting a datagram-socket-like API for the
 * encrypted connection. This operates over a base datagram connection, which is
 * also a `GDatagramBased` $(LPAREN)property@Gio.DtlsConnection:base-socket$(RPAREN).
 * To close a DTLS connection, use [Gio.DtlsConnection.close].
 * Neither [Gio.DtlsServerConnection] or [Gio.DtlsClientConnection]
 * set the peer address on their base [Gio.DatagramBased] if it is a
 * [Gio.Socket] — it is up to the caller to do that if they wish. If they
 * do not, and [Gio.Socket.close] is called on the base socket, the
 * `GDtlsConnection` will not raise a `G_IO_ERROR_NOT_CONNECTED` error on
 * further I/O.
 */
interface DtlsConnection
{

  static GType getType()
  {
    return g_dtls_connection_get_type();
  }

  /**
   * Close the DTLS connection. This is equivalent to calling
   * [Gio.DtlsConnection.shutdown] to shut down both sides of the connection.
   * Closing a #GDtlsConnection waits for all buffered but untransmitted data to
   * be sent before it completes. It then sends a `close_notify` DTLS alert to the
   * peer and may wait for a `close_notify` to be received from the peer. It does
   * not close the underlying #GDtlsConnection:base-socket; that must be closed
   * separately.
   * Once conn is closed, all other operations will return %G_IO_ERROR_CLOSED.
   * Closing a #GDtlsConnection multiple times will not return an error.
   * #GDtlsConnections will be automatically closed when the last reference is
   * dropped, but you might want to call this function to make sure resources are
   * released as early as possible.
   * If cancellable is cancelled, the #GDtlsConnection may be left
   * partially-closed and any pending untransmitted data may be lost. Call
   * [Gio.DtlsConnection.close] again to complete closing the #GDtlsConnection.
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   * Returns: %TRUE on success, %FALSE otherwise
   */
  bool close(Cancellable cancellable);

  /**
   * Asynchronously close the DTLS connection. See [Gio.DtlsConnection.close] for
   * more information.
   * Params:
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call when the close operation is complete
   */
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finish an asynchronous TLS close operation. See [Gio.DtlsConnection.close]
   * for more information.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE on success, %FALSE on failure, in which
   *   case error will be set
   */
  bool closeFinish(AsyncResult result);

  /**
   * Used by #GDtlsConnection implementations to emit the
   * #GDtlsConnection::accept-certificate signal.
   * Params:
   *   peerCert = the peer's #GTlsCertificate
   *   errors = the problems with peer_cert
   * Returns: %TRUE if one of the signal handlers has returned
   *   %TRUE to accept peer_cert
   */
  bool emitAcceptCertificate(TlsCertificate peerCert, TlsCertificateFlags errors);

  /**
   * Gets conn's certificate, as set by
   * [Gio.DtlsConnection.setCertificate].
   * Returns: conn's certificate, or %NULL
   */
  TlsCertificate getCertificate();

  /**
   * Returns the name of the current DTLS ciphersuite, or %NULL if the
   * connection has not handshaked or has been closed. Beware that the TLS
   * backend may use any of multiple different naming conventions, because
   * OpenSSL and GnuTLS have their own ciphersuite naming conventions that
   * are different from each other and different from the standard, IANA-
   * registered ciphersuite names. The ciphersuite name is intended to be
   * displayed to the user for informative purposes only, and parsing it
   * is not recommended.
   * Returns: The name of the current DTLS ciphersuite, or %NULL
   */
  string getCiphersuiteName();

  /**
   * Gets the certificate database that conn uses to verify
   * peer certificates. See [Gio.DtlsConnection.setDatabase].
   * Returns: the certificate database that conn uses or %NULL
   */
  TlsDatabase getDatabase();

  /**
   * Get the object that will be used to interact with the user. It will be used
   * for things like prompting the user for passwords. If %NULL is returned, then
   * no user interaction will occur for this connection.
   * Returns: The interaction object.
   */
  TlsInteraction getInteraction();

  /**
   * Gets the name of the application-layer protocol negotiated during
   * the handshake.
   * If the peer did not use the ALPN extension, or did not advertise a
   * protocol that matched one of conn's protocols, or the TLS backend
   * does not support ALPN, then this will be %NULL. See
   * [Gio.DtlsConnection.setAdvertisedProtocols].
   * Returns: the negotiated protocol, or %NULL
   */
  string getNegotiatedProtocol();

  /**
   * Gets conn's peer's certificate after the handshake has completed
   * or failed. $(LPAREN)It is not set during the emission of
   * #GDtlsConnection::accept-certificate.$(RPAREN)
   * Returns: conn's peer's certificate, or %NULL
   */
  TlsCertificate getPeerCertificate();

  /**
   * Gets the errors associated with validating conn's peer's
   * certificate, after the handshake has completed or failed. $(LPAREN)It is
   * not set during the emission of #GDtlsConnection::accept-certificate.$(RPAREN)
   * Returns: conn's peer's certificate errors
   */
  TlsCertificateFlags getPeerCertificateErrors();

  /**
   * Returns the current DTLS protocol version, which may be
   * %G_TLS_PROTOCOL_VERSION_UNKNOWN if the connection has not handshaked, or
   * has been closed, or if the TLS backend has implemented a protocol version
   * that is not a recognized #GTlsProtocolVersion.
   * Returns: The current DTLS protocol version
   */
  TlsProtocolVersion getProtocolVersion();

  /**
   * Gets conn rehandshaking mode. See
   * [Gio.DtlsConnection.setRehandshakeMode] for details.
   * Returns: %G_TLS_REHANDSHAKE_SAFELY

   * Deprecated: Changing the rehandshake mode is no longer
   *   required for compatibility. Also, rehandshaking has been removed
   *   from the TLS protocol in TLS 1.3.
   */
  TlsRehandshakeMode getRehandshakeMode();

  /**
   * Tests whether or not conn expects a proper TLS close notification
   * when the connection is closed. See
   * [Gio.DtlsConnection.setRequireCloseNotify] for details.
   * Returns: %TRUE if conn requires a proper TLS close notification.
   */
  bool getRequireCloseNotify();

  /**
   * Attempts a TLS handshake on conn.
   * On the client side, it is never necessary to call this method;
   * although the connection needs to perform a handshake after
   * connecting, #GDtlsConnection will handle this for you automatically
   * when you try to send or receive data on the connection. You can call
   * [Gio.DtlsConnection.handshake] manually if you want to know whether
   * the initial handshake succeeded or failed $(LPAREN)as opposed to just
   * immediately trying to use conn to read or write, in which case,
   * if it fails, it may not be possible to tell if it failed before
   * or after completing the handshake$(RPAREN), but beware that servers may reject
   * client authentication after the handshake has completed, so a
   * successful handshake does not indicate the connection will be usable.
   * Likewise, on the server side, although a handshake is necessary at
   * the beginning of the communication, you do not need to call this
   * function explicitly unless you want clearer error reporting.
   * Previously, calling [Gio.DtlsConnection.handshake] after the initial
   * handshake would trigger a rehandshake; however, this usage was
   * deprecated in GLib 2.60 because rehandshaking was removed from the
   * TLS protocol in TLS 1.3. Since GLib 2.64, calling this function after
   * the initial handshake will no longer do anything.
   * #GDtlsConnection::accept_certificate may be emitted during the
   * handshake.
   * Params:
   *   cancellable = a #GCancellable, or %NULL
   * Returns: success or failure
   */
  bool handshake(Cancellable cancellable);

  /**
   * Asynchronously performs a TLS handshake on conn. See
   * [Gio.DtlsConnection.handshake] for more information.
   * Params:
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call when the handshake is complete
   */
  void handshakeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finish an asynchronous TLS handshake operation. See
   * [Gio.DtlsConnection.handshake] for more information.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE on success, %FALSE on failure, in which
   *   case error will be set.
   */
  bool handshakeFinish(AsyncResult result);

  /**
   * Sets the list of application-layer protocols to advertise that the
   * caller is willing to speak on this connection. The
   * Application-Layer Protocol Negotiation $(LPAREN)ALPN$(RPAREN) extension will be
   * used to negotiate a compatible protocol with the peer; use
   * [Gio.DtlsConnection.getNegotiatedProtocol] to find the negotiated
   * protocol after the handshake.  Specifying %NULL for the the value
   * of protocols will disable ALPN negotiation.
   * See [IANA TLS ALPN Protocol IDs](https://www.iana.org/assignments/tls-extensiontype-values/tls-extensiontype-values.xhtml#alpn-protocol-ids)
   * for a list of registered protocol IDs.
   * Params:
   *   protocols = a %NULL-terminated
   *     array of ALPN protocol names $(LPAREN)eg, "http/1.1", "h2"$(RPAREN), or %NULL
   */
  void setAdvertisedProtocols(string[] protocols);

  /**
   * This sets the certificate that conn will present to its peer
   * during the TLS handshake. For a #GDtlsServerConnection, it is
   * mandatory to set this, and that will normally be done at construct
   * time.
   * For a #GDtlsClientConnection, this is optional. If a handshake fails
   * with %G_TLS_ERROR_CERTIFICATE_REQUIRED, that means that the server
   * requires a certificate, and if you try connecting again, you should
   * call this method first. You can call
   * [Gio.DtlsClientConnection.getAcceptedCas] on the failed connection
   * to get a list of Certificate Authorities that the server will
   * accept certificates from.
   * $(LPAREN)It is also possible that a server will allow the connection with
   * or without a certificate; in that case, if you don't provide a
   * certificate, you can tell that the server requested one by the fact
   * that [Gio.DtlsClientConnection.getAcceptedCas] will return
   * non-%NULL.$(RPAREN)
   * Params:
   *   certificate = the certificate to use for conn
   */
  void setCertificate(TlsCertificate certificate);

  /**
   * Sets the certificate database that is used to verify peer certificates.
   * This is set to the default database by default. See
   * [Gio.TlsBackend.getDefaultDatabase]. If set to %NULL, then
   * peer certificate validation will always set the
   * %G_TLS_CERTIFICATE_UNKNOWN_CA error $(LPAREN)meaning
   * #GDtlsConnection::accept-certificate will always be emitted on
   * client-side connections, unless that bit is not set in
   * #GDtlsClientConnection:validation-flags$(RPAREN).
   * There are nonintuitive security implications when using a non-default
   * database. See #GDtlsConnection:database for details.
   * Params:
   *   database = a #GTlsDatabase
   */
  void setDatabase(TlsDatabase database);

  /**
   * Set the object that will be used to interact with the user. It will be used
   * for things like prompting the user for passwords.
   * The interaction argument will normally be a derived subclass of
   * #GTlsInteraction. %NULL can also be provided if no user interaction
   * should occur for this connection.
   * Params:
   *   interaction = an interaction object, or %NULL
   */
  void setInteraction(TlsInteraction interaction);

  /**
   * Since GLib 2.64, changing the rehandshake mode is no longer supported
   * and will have no effect. With TLS 1.3, rehandshaking has been removed from
   * the TLS protocol, replaced by separate post-handshake authentication and
   * rekey operations.
   * Params:
   *   mode = the rehandshaking mode

   * Deprecated: Changing the rehandshake mode is no longer
   *   required for compatibility. Also, rehandshaking has been removed
   *   from the TLS protocol in TLS 1.3.
   */
  void setRehandshakeMode(TlsRehandshakeMode mode);

  /**
   * Sets whether or not conn expects a proper TLS close notification
   * before the connection is closed. If this is %TRUE $(LPAREN)the default$(RPAREN),
   * then conn will expect to receive a TLS close notification from its
   * peer before the connection is closed, and will return a
   * %G_TLS_ERROR_EOF error if the connection is closed without proper
   * notification $(LPAREN)since this may indicate a network error, or
   * man-in-the-middle attack$(RPAREN).
   * In some protocols, the application will know whether or not the
   * connection was closed cleanly based on application-level data
   * $(LPAREN)because the application-level data includes a length field, or is
   * somehow self-delimiting$(RPAREN); in this case, the close notify is
   * redundant and may be omitted. You
   * can use [Gio.DtlsConnection.setRequireCloseNotify] to tell conn
   * to allow an "unannounced" connection close, in which case the close
   * will show up as a 0-length read, as in a non-TLS
   * #GDatagramBased, and it is up to the application to check that
   * the data has been fully received.
   * Note that this only affects the behavior when the peer closes the
   * connection; when the application calls [Gio.DtlsConnection.closeAsync] on
   * conn itself, this will send a close notification regardless of the
   * setting of this property. If you explicitly want to do an unclean
   * close, you can close conn's #GDtlsConnection:base-socket rather
   * than closing conn itself.
   * Params:
   *   requireCloseNotify = whether or not to require close notification
   */
  void setRequireCloseNotify(bool requireCloseNotify);

  /**
   * Shut down part or all of a DTLS connection.
   * If shutdown_read is %TRUE then the receiving side of the connection is shut
   * down, and further reading is disallowed. Subsequent calls to
   * [Gio.DatagramBased.receiveMessages] will return %G_IO_ERROR_CLOSED.
   * If shutdown_write is %TRUE then the sending side of the connection is shut
   * down, and further writing is disallowed. Subsequent calls to
   * [Gio.DatagramBased.sendMessages] will return %G_IO_ERROR_CLOSED.
   * It is allowed for both shutdown_read and shutdown_write to be TRUE — this
   * is equivalent to calling [Gio.DtlsConnection.close].
   * If cancellable is cancelled, the #GDtlsConnection may be left
   * partially-closed and any pending untransmitted data may be lost. Call
   * [Gio.DtlsConnection.shutdown] again to complete closing the #GDtlsConnection.
   * Params:
   *   shutdownRead = %TRUE to stop reception of incoming datagrams
   *   shutdownWrite = %TRUE to stop sending outgoing datagrams
   *   cancellable = a #GCancellable, or %NULL
   * Returns: %TRUE on success, %FALSE otherwise
   */
  bool shutdown(bool shutdownRead, bool shutdownWrite, Cancellable cancellable);

  /**
   * Asynchronously shut down part or all of the DTLS connection. See
   * [Gio.DtlsConnection.shutdown] for more information.
   * Params:
   *   shutdownRead = %TRUE to stop reception of incoming datagrams
   *   shutdownWrite = %TRUE to stop sending outgoing datagrams
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call when the shutdown operation is complete
   */
  void shutdownAsync(bool shutdownRead, bool shutdownWrite, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finish an asynchronous TLS shutdown operation. See
   * [Gio.DtlsConnection.shutdown] for more information.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE on success, %FALSE on failure, in which
   *   case error will be set
   */
  bool shutdownFinish(AsyncResult result);

  /**
   * Emitted during the TLS handshake after the peer certificate has
   * been received. You can examine peer_cert's certification path by
   * calling [Gio.TlsCertificate.getIssuer] on it.
   * For a client-side connection, peer_cert is the server's
   * certificate, and the signal will only be emitted if the
   * certificate was not acceptable according to conn's
   * #GDtlsClientConnection:validation_flags. If you would like the
   * certificate to be accepted despite errors, return %TRUE from the
   * signal handler. Otherwise, if no handler accepts the certificate,
   * the handshake will fail with %G_TLS_ERROR_BAD_CERTIFICATE.
   * GLib guarantees that if certificate verification fails, this signal
   * will be emitted with at least one error will be set in errors, but
   * it does not guarantee that all possible errors will be set.
   * Accordingly, you may not safely decide to ignore any particular
   * type of error. For example, it would be incorrect to ignore
   * %G_TLS_CERTIFICATE_EXPIRED if you want to allow expired
   * certificates, because this could potentially be the only error flag
   * set even if other problems exist with the certificate.
   * For a server-side connection, peer_cert is the certificate
   * presented by the client, if this was requested via the server's
   * #GDtlsServerConnection:authentication_mode. On the server side,
   * the signal is always emitted when the client presents a
   * certificate, and the certificate will only be accepted if a
   * handler returns %TRUE.
   * Note that if this signal is emitted as part of asynchronous I/O
   * in the main thread, then you should not attempt to interact with
   * the user before returning from the signal handler. If you want to
   * let the user decide whether or not to accept the certificate, you
   * would have to return %FALSE from the signal handler on the first
   * attempt, and then after the connection attempt returns a
   * %G_TLS_ERROR_BAD_CERTIFICATE, you can interact with the user, and
   * if the user decides to accept the certificate, remember that fact,
   * create a new connection, and return %TRUE from the signal handler
   * the next time.
   * If you are doing I/O in another thread, you do not
   * need to worry about this, and can simply block in the signal
   * handler until the UI thread returns an answer.
   * Params
   *   peerCert = the peer's #GTlsCertificate
   *   errors = the problems with peer_cert.
   *   dtlsConnection = the instance the signal is connected to
   * Returns: %TRUE to accept peer_cert $(LPAREN)which will also
   *   immediately end the signal emission$(RPAREN). %FALSE to allow the signal
   *   emission to continue, which will cause the handshake to fail if
   *   no one else overrides it.
   */
  alias AcceptCertificateCallback = bool delegate(TlsCertificate peerCert, TlsCertificateFlags errors, DtlsConnection dtlsConnection);

  /**
   * Connect to AcceptCertificate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAcceptCertificate(AcceptCertificateCallback dlg, ConnectFlags flags = ConnectFlags.Default);
}
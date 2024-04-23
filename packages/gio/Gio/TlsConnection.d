module Gio.TlsConnection;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.TlsCertificate;
import Gio.TlsDatabase;
import Gio.TlsInteraction;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GTlsConnection is the base TLS connection class type, which wraps
 * a #GIOStream and provides TLS encryption on top of it. Its
 * subclasses, #GTlsClientConnection and #GTlsServerConnection,
 * implement client-side and server-side TLS, respectively.
 *
 * For DTLS (Datagram TLS) support, see #GDtlsConnection.
 */
class TlsConnection : IOStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tls_connection_get_type();
  }

  /**
   * %TRUE if one of the signal handlers has returned
   * %TRUE to accept @peer_cert
   */
  bool emitAcceptCertificate(TlsCertificate peerCert, TlsCertificateFlags errors)
  {
    bool _retval;
    _retval = g_tls_connection_emit_accept_certificate(cPtr!GTlsConnection, peerCert ? peerCert.cPtr!GTlsCertificate : null, errors);
    return _retval;
  }

  /**
   * @conn's certificate, or %NULL
   */
  TlsCertificate getCertificate()
  {
    GTlsCertificate* _cretval;
    _cretval = g_tls_connection_get_certificate(cPtr!GTlsConnection);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, false);
    return _retval;
  }

  /**
   * The name of the current TLS ciphersuite, or %NULL
   */
  string getCiphersuiteName()
  {
    char* _cretval;
    _cretval = g_tls_connection_get_ciphersuite_name(cPtr!GTlsConnection);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the certificate database that @conn uses or %NULL
   */
  TlsDatabase getDatabase()
  {
    GTlsDatabase* _cretval;
    _cretval = g_tls_connection_get_database(cPtr!GTlsConnection);
    TlsDatabase _retval = ObjectG.getDObject!TlsDatabase(cast(GTlsDatabase*)_cretval, false);
    return _retval;
  }

  /**
   * The interaction object.
   */
  TlsInteraction getInteraction()
  {
    GTlsInteraction* _cretval;
    _cretval = g_tls_connection_get_interaction(cPtr!GTlsConnection);
    TlsInteraction _retval = ObjectG.getDObject!TlsInteraction(cast(GTlsInteraction*)_cretval, false);
    return _retval;
  }

  /**
   * the negotiated protocol, or %NULL
   */
  string getNegotiatedProtocol()
  {
    const(char)* _cretval;
    _cretval = g_tls_connection_get_negotiated_protocol(cPtr!GTlsConnection);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @conn's peer's certificate, or %NULL
   */
  TlsCertificate getPeerCertificate()
  {
    GTlsCertificate* _cretval;
    _cretval = g_tls_connection_get_peer_certificate(cPtr!GTlsConnection);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, false);
    return _retval;
  }

  /**
   * @conn's peer's certificate errors
   */
  TlsCertificateFlags getPeerCertificateErrors()
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_tls_connection_get_peer_certificate_errors(cPtr!GTlsConnection);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * The current TLS protocol version
   */
  TlsProtocolVersion getProtocolVersion()
  {
    GTlsProtocolVersion _cretval;
    _cretval = g_tls_connection_get_protocol_version(cPtr!GTlsConnection);
    TlsProtocolVersion _retval = cast(TlsProtocolVersion)_cretval;
    return _retval;
  }

  /**
   * %G_TLS_REHANDSHAKE_SAFELY
   */
  TlsRehandshakeMode getRehandshakeMode()
  {
    GTlsRehandshakeMode _cretval;
    _cretval = g_tls_connection_get_rehandshake_mode(cPtr!GTlsConnection);
    TlsRehandshakeMode _retval = cast(TlsRehandshakeMode)_cretval;
    return _retval;
  }

  /**
   * %TRUE if @conn requires a proper TLS close
   * notification.
   */
  bool getRequireCloseNotify()
  {
    bool _retval;
    _retval = g_tls_connection_get_require_close_notify(cPtr!GTlsConnection);
    return _retval;
  }

  /**
   * whether @conn uses the system certificate database
   */
  bool getUseSystemCertdb()
  {
    bool _retval;
    _retval = g_tls_connection_get_use_system_certdb(cPtr!GTlsConnection);
    return _retval;
  }

  /**
   * success or failure
   */
  bool handshake(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_tls_connection_handshake(cPtr!GTlsConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously performs a TLS handshake on @conn. See
   * g_tls_connection_handshake() for more information.
   */
  void handshakeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_tls_connection_handshake_async(cPtr!GTlsConnection, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE on failure, in which
   * case @error will be set.
   */
  bool handshakeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_tls_connection_handshake_finish(cPtr!GTlsConnection, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the list of application-layer protocols to advertise that the
   * caller is willing to speak on this connection. The
   * Application-Layer Protocol Negotiation (ALPN) extension will be
   * used to negotiate a compatible protocol with the peer; use
   * g_tls_connection_get_negotiated_protocol() to find the negotiated
   * protocol after the handshake.  Specifying %NULL for the the value
   * of @protocols will disable ALPN negotiation.
   *
   * See [IANA TLS ALPN Protocol IDs](https://www.iana.org/assignments/tls-extensiontype-values/tls-extensiontype-values.xhtml#alpn-protocol-ids)
   * for a list of registered protocol IDs.
   */
  void setAdvertisedProtocols(string[] protocols)
  {
    char*[] _tmpprotocols;
    foreach (s; protocols)
      _tmpprotocols ~= s.toCString(false);
    _tmpprotocols ~= null;
    const(char*)* _protocols = _tmpprotocols.ptr;
    g_tls_connection_set_advertised_protocols(cPtr!GTlsConnection, _protocols);
  }

  /**
   * This sets the certificate that @conn will present to its peer
   * during the TLS handshake. For a #GTlsServerConnection, it is
   * mandatory to set this, and that will normally be done at construct
   * time.
   *
   * For a #GTlsClientConnection, this is optional. If a handshake fails
   * with %G_TLS_ERROR_CERTIFICATE_REQUIRED, that means that the server
   * requires a certificate, and if you try connecting again, you should
   * call this method first. You can call
   * g_tls_client_connection_get_accepted_cas() on the failed connection
   * to get a list of Certificate Authorities that the server will
   * accept certificates from.
   *
   * (It is also possible that a server will allow the connection with
   * or without a certificate; in that case, if you don't provide a
   * certificate, you can tell that the server requested one by the fact
   * that g_tls_client_connection_get_accepted_cas() will return
   * non-%NULL.)
   */
  void setCertificate(TlsCertificate certificate)
  {
    g_tls_connection_set_certificate(cPtr!GTlsConnection, certificate ? certificate.cPtr!GTlsCertificate : null);
  }

  /**
   * Sets the certificate database that is used to verify peer certificates.
   * This is set to the default database by default. See
   * g_tls_backend_get_default_database(). If set to %NULL, then
   * peer certificate validation will always set the
   * %G_TLS_CERTIFICATE_UNKNOWN_CA error (meaning
   * #GTlsConnection::accept-certificate will always be emitted on
   * client-side connections, unless that bit is not set in
   * #GTlsClientConnection:validation-flags).
   *
   * There are nonintuitive security implications when using a non-default
   * database. See #GTlsConnection:database for details.
   */
  void setDatabase(TlsDatabase database)
  {
    g_tls_connection_set_database(cPtr!GTlsConnection, database ? database.cPtr!GTlsDatabase : null);
  }

  /**
   * Set the object that will be used to interact with the user. It will be used
   * for things like prompting the user for passwords.
   *
   * The @interaction argument will normally be a derived subclass of
   * #GTlsInteraction. %NULL can also be provided if no user interaction
   * should occur for this connection.
   */
  void setInteraction(TlsInteraction interaction)
  {
    g_tls_connection_set_interaction(cPtr!GTlsConnection, interaction ? interaction.cPtr!GTlsInteraction : null);
  }

  /**
   * Since GLib 2.64, changing the rehandshake mode is no longer supported
   * and will have no effect. With TLS 1.3, rehandshaking has been removed from
   * the TLS protocol, replaced by separate post-handshake authentication and
   * rekey operations.
   */
  void setRehandshakeMode(TlsRehandshakeMode mode)
  {
    g_tls_connection_set_rehandshake_mode(cPtr!GTlsConnection, mode);
  }

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
   * redundant and sometimes omitted. (TLS 1.1 explicitly allows this;
   * in TLS 1.0 it is technically an error, but often done anyway.) You
   * can use g_tls_connection_set_require_close_notify() to tell @conn
   * to allow an "unannounced" connection close, in which case the close
   * will show up as a 0-length read, as in a non-TLS
   * #GSocketConnection, and it is up to the application to check that
   * the data has been fully received.
   *
   * Note that this only affects the behavior when the peer closes the
   * connection; when the application calls g_io_stream_close() itself
   * on @conn, this will send a close notification regardless of the
   * setting of this property. If you explicitly want to do an unclean
   * close, you can close @conn's #GTlsConnection:base-io-stream rather
   * than closing @conn itself, but note that this may only be done when no other
   * operations are pending on @conn or the base I/O stream.
   */
  void setRequireCloseNotify(bool requireCloseNotify)
  {
    g_tls_connection_set_require_close_notify(cPtr!GTlsConnection, requireCloseNotify);
  }

  /**
   * Sets whether @conn uses the system certificate database to verify
   * peer certificates. This is %TRUE by default. If set to %FALSE, then
   * peer certificate validation will always set the
   * %G_TLS_CERTIFICATE_UNKNOWN_CA error (meaning
   * #GTlsConnection::accept-certificate will always be emitted on
   * client-side connections, unless that bit is not set in
   * #GTlsClientConnection:validation-flags).
   */
  void setUseSystemCertdb(bool useSystemCertdb)
  {
    g_tls_connection_set_use_system_certdb(cPtr!GTlsConnection, useSystemCertdb);
  }

  /**
   * %TRUE to accept @peer_cert (which will also
   * immediately end the signal emission). %FALSE to allow the signal
   * emission to continue, which will cause the handshake to fail if
   * no one else overrides it.
   */
  ulong connectAcceptCertificate(bool delegate(TlsCertificate peerCert, TlsCertificateFlags errors, TlsConnection tlsConnection) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto tlsConnection = getVal!TlsConnection(_paramVals);
      auto peerCert = getVal!TlsCertificate(&_paramVals[1]);
      auto errors = getVal!TlsCertificateFlags(&_paramVals[2]);
      _retval = _dgClosure.dlg(peerCert, errors, tlsConnection);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("accept-certificate", closure, (flags & ConnectFlags.After) != 0);
  }
}

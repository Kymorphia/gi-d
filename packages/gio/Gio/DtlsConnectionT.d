module Gio.DtlsConnectionT;

public import GLib.ErrorG;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.TlsCertificate;
public import Gio.TlsDatabase;
public import Gio.TlsInteraction;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template DtlsConnectionT(TStruct)
{

  /**
   * %TRUE on success, %FALSE otherwise
   */
  override bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_dtls_connection_close(cPtr!GDtlsConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously close the DTLS connection. See g_dtls_connection_close() for
   * more information.
   */
  override void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_dtls_connection_close_async(cPtr!GDtlsConnection, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE on failure, in which
   * case @error will be set
   */
  override bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_dtls_connection_close_finish(cPtr!GDtlsConnection, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if one of the signal handlers has returned
   * %TRUE to accept @peer_cert
   */
  override bool emitAcceptCertificate(TlsCertificate peerCert, TlsCertificateFlags errors)
  {
    bool _retval;
    _retval = g_dtls_connection_emit_accept_certificate(cPtr!GDtlsConnection, peerCert ? peerCert.cPtr!GTlsCertificate : null, errors);
    return _retval;
  }

  /**
   * @conn's certificate, or %NULL
   */
  override TlsCertificate getCertificate()
  {
    GTlsCertificate* _cretval;
    _cretval = g_dtls_connection_get_certificate(cPtr!GDtlsConnection);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, false);
    return _retval;
  }

  /**
   * The name of the current DTLS ciphersuite, or %NULL
   */
  override string getCiphersuiteName()
  {
    char* _cretval;
    _cretval = g_dtls_connection_get_ciphersuite_name(cPtr!GDtlsConnection);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the certificate database that @conn uses or %NULL
   */
  override TlsDatabase getDatabase()
  {
    GTlsDatabase* _cretval;
    _cretval = g_dtls_connection_get_database(cPtr!GDtlsConnection);
    TlsDatabase _retval = ObjectG.getDObject!TlsDatabase(cast(GTlsDatabase*)_cretval, false);
    return _retval;
  }

  /**
   * The interaction object.
   */
  override TlsInteraction getInteraction()
  {
    GTlsInteraction* _cretval;
    _cretval = g_dtls_connection_get_interaction(cPtr!GDtlsConnection);
    TlsInteraction _retval = ObjectG.getDObject!TlsInteraction(cast(GTlsInteraction*)_cretval, false);
    return _retval;
  }

  /**
   * the negotiated protocol, or %NULL
   */
  override string getNegotiatedProtocol()
  {
    const(char)* _cretval;
    _cretval = g_dtls_connection_get_negotiated_protocol(cPtr!GDtlsConnection);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * @conn's peer's certificate, or %NULL
   */
  override TlsCertificate getPeerCertificate()
  {
    GTlsCertificate* _cretval;
    _cretval = g_dtls_connection_get_peer_certificate(cPtr!GDtlsConnection);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, false);
    return _retval;
  }

  /**
   * @conn's peer's certificate errors
   */
  override TlsCertificateFlags getPeerCertificateErrors()
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_dtls_connection_get_peer_certificate_errors(cPtr!GDtlsConnection);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * The current DTLS protocol version
   */
  override TlsProtocolVersion getProtocolVersion()
  {
    GTlsProtocolVersion _cretval;
    _cretval = g_dtls_connection_get_protocol_version(cPtr!GDtlsConnection);
    TlsProtocolVersion _retval = cast(TlsProtocolVersion)_cretval;
    return _retval;
  }

  /**
   * %G_TLS_REHANDSHAKE_SAFELY
   */
  override TlsRehandshakeMode getRehandshakeMode()
  {
    GTlsRehandshakeMode _cretval;
    _cretval = g_dtls_connection_get_rehandshake_mode(cPtr!GDtlsConnection);
    TlsRehandshakeMode _retval = cast(TlsRehandshakeMode)_cretval;
    return _retval;
  }

  /**
   * %TRUE if @conn requires a proper TLS close notification.
   */
  override bool getRequireCloseNotify()
  {
    bool _retval;
    _retval = g_dtls_connection_get_require_close_notify(cPtr!GDtlsConnection);
    return _retval;
  }

  /**
   * success or failure
   */
  override bool handshake(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_dtls_connection_handshake(cPtr!GDtlsConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously performs a TLS handshake on @conn. See
   * g_dtls_connection_handshake() for more information.
   */
  override void handshakeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_dtls_connection_handshake_async(cPtr!GDtlsConnection, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE on failure, in which
   * case @error will be set.
   */
  override bool handshakeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_dtls_connection_handshake_finish(cPtr!GDtlsConnection, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

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
  override void setAdvertisedProtocols(string[] protocols)
  {
    char*[] _tmpprotocols;
    foreach (s; protocols)
      _tmpprotocols ~= s.toCString(false);
    _tmpprotocols ~= null;
    const(char*)* _protocols = _tmpprotocols.ptr;
    g_dtls_connection_set_advertised_protocols(cPtr!GDtlsConnection, _protocols);
  }

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
  override void setCertificate(TlsCertificate certificate)
  {
    g_dtls_connection_set_certificate(cPtr!GDtlsConnection, certificate ? certificate.cPtr!GTlsCertificate : null);
  }

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
  override void setDatabase(TlsDatabase database)
  {
    g_dtls_connection_set_database(cPtr!GDtlsConnection, database ? database.cPtr!GTlsDatabase : null);
  }

  /**
   * Set the object that will be used to interact with the user. It will be used
   * for things like prompting the user for passwords.
   *
   * The @interaction argument will normally be a derived subclass of
   * #GTlsInteraction. %NULL can also be provided if no user interaction
   * should occur for this connection.
   */
  override void setInteraction(TlsInteraction interaction)
  {
    g_dtls_connection_set_interaction(cPtr!GDtlsConnection, interaction ? interaction.cPtr!GTlsInteraction : null);
  }

  /**
   * Since GLib 2.64, changing the rehandshake mode is no longer supported
   * and will have no effect. With TLS 1.3, rehandshaking has been removed from
   * the TLS protocol, replaced by separate post-handshake authentication and
   * rekey operations.
   */
  override void setRehandshakeMode(TlsRehandshakeMode mode)
  {
    g_dtls_connection_set_rehandshake_mode(cPtr!GDtlsConnection, mode);
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
  override void setRequireCloseNotify(bool requireCloseNotify)
  {
    g_dtls_connection_set_require_close_notify(cPtr!GDtlsConnection, requireCloseNotify);
  }

  /**
   * %TRUE on success, %FALSE otherwise
   */
  override bool shutdown(bool shutdownRead, bool shutdownWrite, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_dtls_connection_shutdown(cPtr!GDtlsConnection, shutdownRead, shutdownWrite, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously shut down part or all of the DTLS connection. See
   * g_dtls_connection_shutdown() for more information.
   */
  override void shutdownAsync(bool shutdownRead, bool shutdownWrite, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_dtls_connection_shutdown_async(cPtr!GDtlsConnection, shutdownRead, shutdownWrite, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE on failure, in which
   * case @error will be set
   */
  override bool shutdownFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_dtls_connection_shutdown_finish(cPtr!GDtlsConnection, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE to accept @peer_cert (which will also
   * immediately end the signal emission). %FALSE to allow the signal
   * emission to continue, which will cause the handshake to fail if
   * no one else overrides it.
   */
  ulong connectAcceptCertificate(bool delegate(TlsCertificate peerCert, TlsCertificateFlags errors, DtlsConnection dtlsConnection) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dtlsConnection = getVal!DtlsConnection(_paramVals);
      auto peerCert = getVal!TlsCertificate(&_paramVals[1]);
      auto errors = getVal!TlsCertificateFlags(&_paramVals[2]);
      _retval = _dgClosure.dlg(peerCert, errors, dtlsConnection);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("accept-certificate", closure, (flags & ConnectFlags.After) != 0);
  }
}

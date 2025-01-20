module Gio.TlsDatabase;

import GLib.ByteArray;
import GLib.ErrorG;
import GLib.List;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.TlsCertificate;
import Gio.TlsInteraction;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GTlsDatabase` is used to look up certificates and other information
 * from a certificate or key store. It is an abstract base class which
 * TLS library specific subtypes override.
 * A `GTlsDatabase` may be accessed from multiple threads by the TLS backend.
 * All implementations are required to be fully thread-safe.
 * Most common client applications will not directly interact with
 * `GTlsDatabase`. It is used internally by [Gio.TlsConnection].
 */
class TlsDatabase : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tls_database_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a handle string for the certificate. The database will only be able
   * to create a handle for certificates that originate from the database. In
   * cases where the database cannot create a handle for a certificate, %NULL
   * will be returned.
   * This handle should be stable across various instances of the application,
   * and between applications. If a certificate is modified in the database,
   * then it is not guaranteed that this handle will continue to point to it.
   * Params:
   *   certificate = certificate for which to create a handle.
   * Returns: a newly allocated string containing the
   *   handle.
   */
  string createCertificateHandle(TlsCertificate certificate)
  {
    char* _cretval;
    _cretval = g_tls_database_create_certificate_handle(cast(GTlsDatabase*)cPtr, certificate ? cast(GTlsCertificate*)certificate.cPtr(false) : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Look up a certificate by its handle.
   * The handle should have been created by calling
   * [Gio.TlsDatabase.createCertificateHandle] on a #GTlsDatabase object of
   * the same TLS backend. The handle is designed to remain valid across
   * instantiations of the database.
   * If the handle is no longer valid, or does not point to a certificate in
   * this database, then %NULL will be returned.
   * This function can block, use [Gio.TlsDatabase.lookupCertificateForHandleAsync] to perform
   * the lookup operation asynchronously.
   * Params:
   *   handle = a certificate handle
   *   interaction = used to interact with the user if necessary
   *   flags = Flags which affect the lookup.
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a newly allocated
   *   #GTlsCertificate, or %NULL. Use [GObject.ObjectG.unref] to release the certificate.
   */
  TlsCertificate lookupCertificateForHandle(string handle, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable)
  {
    GTlsCertificate* _cretval;
    const(char)* _handle = handle.toCString(false);
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_for_handle(cast(GTlsDatabase*)cPtr, _handle, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asynchronously look up a certificate by its handle in the database. See
   * [Gio.TlsDatabase.lookupCertificateForHandle] for more information.
   * Params:
   *   handle = a certificate handle
   *   interaction = used to interact with the user if necessary
   *   flags = Flags which affect the lookup.
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call when the operation completes
   */
  void lookupCertificateForHandleAsync(string handle, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _handle = handle.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_tls_database_lookup_certificate_for_handle_async(cast(GTlsDatabase*)cPtr, _handle, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finish an asynchronous lookup of a certificate by its handle. See
   * [Gio.TlsDatabase.lookupCertificateForHandle] for more information.
   * If the handle is no longer valid, or does not point to a certificate in
   * this database, then %NULL will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a newly allocated #GTlsCertificate object.
   *   Use [GObject.ObjectG.unref] to release the certificate.
   */
  TlsCertificate lookupCertificateForHandleFinish(AsyncResult result)
  {
    GTlsCertificate* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_for_handle_finish(cast(GTlsDatabase*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Look up the issuer of certificate in the database. The
   * #GTlsCertificate:issuer property of certificate is not modified, and
   * the two certificates are not hooked into a chain.
   * This function can block. Use [Gio.TlsDatabase.lookupCertificateIssuerAsync]
   * to perform the lookup operation asynchronously.
   * Beware this function cannot be used to build certification paths. The
   * issuer certificate returned by this function may not be the same as
   * the certificate that would actually be used to construct a valid
   * certification path during certificate verification.
   * [RFC 4158](https://datatracker.ietf.org/doc/html/rfc4158) explains
   * why an issuer certificate cannot be naively assumed to be part of the
   * the certification path $(LPAREN)though GLib's TLS backends may not follow the
   * path building strategies outlined in this RFC$(RPAREN). Due to the complexity
   * of certification path building, GLib does not provide any way to know
   * which certification path will actually be used when verifying a TLS
   * certificate. Accordingly, this function cannot be used to make
   * security-related decisions. Only GLib itself should make security
   * decisions about TLS certificates.
   * Params:
   *   certificate = a #GTlsCertificate
   *   interaction = used to interact with the user if necessary
   *   flags = flags which affect the lookup operation
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a newly allocated issuer #GTlsCertificate,
   *   or %NULL. Use [GObject.ObjectG.unref] to release the certificate.
   */
  TlsCertificate lookupCertificateIssuer(TlsCertificate certificate, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable)
  {
    GTlsCertificate* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_issuer(cast(GTlsDatabase*)cPtr, certificate ? cast(GTlsCertificate*)certificate.cPtr(false) : null, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asynchronously look up the issuer of certificate in the database. See
   * [Gio.TlsDatabase.lookupCertificateIssuer] for more information.
   * Params:
   *   certificate = a #GTlsCertificate
   *   interaction = used to interact with the user if necessary
   *   flags = flags which affect the lookup operation
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call when the operation completes
   */
  void lookupCertificateIssuerAsync(TlsCertificate certificate, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_tls_database_lookup_certificate_issuer_async(cast(GTlsDatabase*)cPtr, certificate ? cast(GTlsCertificate*)certificate.cPtr(false) : null, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finish an asynchronous lookup issuer operation. See
   * [Gio.TlsDatabase.lookupCertificateIssuer] for more information.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a newly allocated issuer #GTlsCertificate,
   *   or %NULL. Use [GObject.ObjectG.unref] to release the certificate.
   */
  TlsCertificate lookupCertificateIssuerFinish(AsyncResult result)
  {
    GTlsCertificate* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_issuer_finish(cast(GTlsDatabase*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Look up certificates issued by this issuer in the database.
   * This function can block, use [Gio.TlsDatabase.lookupCertificatesIssuedByAsync] to perform
   * the lookup operation asynchronously.
   * Params:
   *   issuerRawDn = a #GByteArray which holds the DER encoded issuer DN.
   *   interaction = used to interact with the user if necessary
   *   flags = Flags which affect the lookup operation.
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a newly allocated list of #GTlsCertificate
   *   objects. Use [GObject.ObjectG.unref] on each certificate, and [GLib.List.free] on the release the list.
   */
  List!(TlsCertificate) lookupCertificatesIssuedBy(ByteArray issuerRawDn, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificates_issued_by(cast(GTlsDatabase*)cPtr, issuerRawDn.cPtr, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(TlsCertificate) _retval = new List!(TlsCertificate)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Asynchronously look up certificates issued by this issuer in the database. See
   * [Gio.TlsDatabase.lookupCertificatesIssuedBy] for more information.
   * The database may choose to hold a reference to the issuer byte array for the duration
   * of this asynchronous operation. The byte array should not be modified during
   * this time.
   * Params:
   *   issuerRawDn = a #GByteArray which holds the DER encoded issuer DN.
   *   interaction = used to interact with the user if necessary
   *   flags = Flags which affect the lookup operation.
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call when the operation completes
   */
  void lookupCertificatesIssuedByAsync(ByteArray issuerRawDn, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_tls_database_lookup_certificates_issued_by_async(cast(GTlsDatabase*)cPtr, issuerRawDn.cPtr, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finish an asynchronous lookup of certificates. See
   * [Gio.TlsDatabase.lookupCertificatesIssuedBy] for more information.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a newly allocated list of #GTlsCertificate
   *   objects. Use [GObject.ObjectG.unref] on each certificate, and [GLib.List.free] on the release the list.
   */
  List!(TlsCertificate) lookupCertificatesIssuedByFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificates_issued_by_finish(cast(GTlsDatabase*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(TlsCertificate) _retval = new List!(TlsCertificate)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Determines the validity of a certificate chain, outside the context
   * of a TLS session.
   * chain is a chain of #GTlsCertificate objects each pointing to the next
   * certificate in the chain by its #GTlsCertificate:issuer property.
   * purpose describes the purpose $(LPAREN)or usage$(RPAREN) for which the certificate
   * is being used. Typically purpose will be set to %G_TLS_DATABASE_PURPOSE_AUTHENTICATE_SERVER
   * which means that the certificate is being used to authenticate a server
   * $(LPAREN)and we are acting as the client$(RPAREN).
   * The identity is used to ensure the server certificate is valid for
   * the expected peer identity. If the identity does not match the
   * certificate, %G_TLS_CERTIFICATE_BAD_IDENTITY will be set in the
   * return value. If identity is %NULL, that bit will never be set in
   * the return value. The peer identity may also be used to check for
   * pinned certificates $(LPAREN)trust exceptions$(RPAREN) in the database. These may
   * override the normal verification process on a host-by-host basis.
   * Currently there are no flags, and %G_TLS_DATABASE_VERIFY_NONE should be
   * used.
   * If chain is found to be valid, then the return value will be 0. If
   * chain is found to be invalid, then the return value will indicate at
   * least one problem found. If the function is unable to determine
   * whether chain is valid $(LPAREN)for example, because cancellable is
   * triggered before it completes$(RPAREN) then the return value will be
   * %G_TLS_CERTIFICATE_GENERIC_ERROR and error will be set accordingly.
   * error is not set when chain is successfully analyzed but found to
   * be invalid.
   * GLib guarantees that if certificate verification fails, at least one
   * error will be set in the return value, but it does not guarantee
   * that all possible errors will be set. Accordingly, you may not safely
   * decide to ignore any particular type of error. For example, it would
   * be incorrect to mask %G_TLS_CERTIFICATE_EXPIRED if you want to allow
   * expired certificates, because this could potentially be the only
   * error flag set even if other problems exist with the certificate.
   * Prior to GLib 2.48, GLib's default TLS backend modified chain to
   * represent the certification path built by #GTlsDatabase during
   * certificate verification by adjusting the #GTlsCertificate:issuer
   * property of each certificate in chain. Since GLib 2.48, this no
   * longer occurs, so you cannot rely on #GTlsCertificate:issuer to
   * represent the actual certification path used during certificate
   * verification.
   * Because TLS session context is not used, #GTlsDatabase may not
   * perform as many checks on the certificates as #GTlsConnection would.
   * For example, certificate constraints may not be honored, and
   * revocation checks may not be performed. The best way to verify TLS
   * certificates used by a TLS connection is to let #GTlsConnection
   * handle the verification.
   * The TLS backend may attempt to look up and add missing certificates
   * to the chain. This may involve HTTP requests to download missing
   * certificates.
   * This function can block. Use [Gio.TlsDatabase.verifyChainAsync] to
   * perform the verification operation asynchronously.
   * Params:
   *   chain = a #GTlsCertificate chain
   *   purpose = the purpose that this certificate chain will be used for.
   *   identity = the expected peer identity
   *   interaction = used to interact with the user if necessary
   *   flags = additional verify flags
   *   cancellable = a #GCancellable, or %NULL
   * Returns: the appropriate #GTlsCertificateFlags which represents the
   *   result of verification.
   */
  TlsCertificateFlags verifyChain(TlsCertificate chain, string purpose, SocketConnectable identity, TlsInteraction interaction, TlsDatabaseVerifyFlags flags, Cancellable cancellable)
  {
    GTlsCertificateFlags _cretval;
    const(char)* _purpose = purpose.toCString(false);
    GError *_err;
    _cretval = g_tls_database_verify_chain(cast(GTlsDatabase*)cPtr, chain ? cast(GTlsCertificate*)chain.cPtr(false) : null, _purpose, identity ? cast(GSocketConnectable*)(cast(ObjectG)identity).cPtr(false) : null, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * Asynchronously determines the validity of a certificate chain after
   * looking up and adding any missing certificates to the chain. See
   * [Gio.TlsDatabase.verifyChain] for more information.
   * Params:
   *   chain = a #GTlsCertificate chain
   *   purpose = the purpose that this certificate chain will be used for.
   *   identity = the expected peer identity
   *   interaction = used to interact with the user if necessary
   *   flags = additional verify flags
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call when the operation completes
   */
  void verifyChainAsync(TlsCertificate chain, string purpose, SocketConnectable identity, TlsInteraction interaction, TlsDatabaseVerifyFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _purpose = purpose.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_tls_database_verify_chain_async(cast(GTlsDatabase*)cPtr, chain ? cast(GTlsCertificate*)chain.cPtr(false) : null, _purpose, identity ? cast(GSocketConnectable*)(cast(ObjectG)identity).cPtr(false) : null, interaction ? cast(GTlsInteraction*)interaction.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finish an asynchronous verify chain operation. See
   * [Gio.TlsDatabase.verifyChain] for more information.
   * If chain is found to be valid, then the return value will be 0. If
   * chain is found to be invalid, then the return value will indicate
   * the problems found. If the function is unable to determine whether
   * chain is valid or not $(LPAREN)eg, because cancellable is triggered
   * before it completes$(RPAREN) then the return value will be
   * %G_TLS_CERTIFICATE_GENERIC_ERROR and error will be set
   * accordingly. error is not set when chain is successfully analyzed
   * but found to be invalid.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: the appropriate #GTlsCertificateFlags which represents the
   *   result of verification.
   */
  TlsCertificateFlags verifyChainFinish(AsyncResult result)
  {
    GTlsCertificateFlags _cretval;
    GError *_err;
    _cretval = g_tls_database_verify_chain_finish(cast(GTlsDatabase*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }
}

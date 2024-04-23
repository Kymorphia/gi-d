module Gio.TlsDatabase;

import GLib.ByteArray;
import GLib.ErrorG;
import GLib.List;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.SocketConnectable;
import Gio.TlsCertificate;
import Gio.TlsInteraction;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GTlsDatabase is used to look up certificates and other information
 * from a certificate or key store. It is an abstract base class which
 * TLS library specific subtypes override.
 *
 * A #GTlsDatabase may be accessed from multiple threads by the TLS backend.
 * All implementations are required to be fully thread-safe.
 *
 * Most common client applications will not directly interact with
 * #GTlsDatabase. It is used internally by #GTlsConnection.
 */
class TlsDatabase : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tls_database_get_type();
  }

  /**
   * a newly allocated string containing the
   * handle.
   */
  string createCertificateHandle(TlsCertificate certificate)
  {
    char* _cretval;
    _cretval = g_tls_database_create_certificate_handle(cPtr!GTlsDatabase, certificate ? certificate.cPtr!GTlsCertificate : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated
   * #GTlsCertificate, or %NULL. Use g_object_unref() to release the certificate.
   */
  TlsCertificate lookupCertificateForHandle(string handle, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable)
  {
    GTlsCertificate* _cretval;
    const(char)* _handle = handle.toCString(false);
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_for_handle(cPtr!GTlsDatabase, _handle, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously look up a certificate by its handle in the database. See
   * g_tls_database_lookup_certificate_for_handle() for more information.
   */
  void lookupCertificateForHandleAsync(string handle, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _handle = handle.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_tls_database_lookup_certificate_for_handle_async(cPtr!GTlsDatabase, _handle, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a newly allocated #GTlsCertificate object.
   * Use g_object_unref() to release the certificate.
   */
  TlsCertificate lookupCertificateForHandleFinish(AsyncResult result)
  {
    GTlsCertificate* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_for_handle_finish(cPtr!GTlsDatabase, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * a newly allocated issuer #GTlsCertificate,
   * or %NULL. Use g_object_unref() to release the certificate.
   */
  TlsCertificate lookupCertificateIssuer(TlsCertificate certificate, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable)
  {
    GTlsCertificate* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_issuer(cPtr!GTlsDatabase, certificate ? certificate.cPtr!GTlsCertificate : null, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously look up the issuer of @certificate in the database. See
   * g_tls_database_lookup_certificate_issuer() for more information.
   */
  void lookupCertificateIssuerAsync(TlsCertificate certificate, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_tls_database_lookup_certificate_issuer_async(cPtr!GTlsDatabase, certificate ? certificate.cPtr!GTlsCertificate : null, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a newly allocated issuer #GTlsCertificate,
   * or %NULL. Use g_object_unref() to release the certificate.
   */
  TlsCertificate lookupCertificateIssuerFinish(AsyncResult result)
  {
    GTlsCertificate* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificate_issuer_finish(cPtr!GTlsDatabase, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * a newly allocated list of #GTlsCertificate
   * objects. Use g_object_unref() on each certificate, and g_list_free() on the release the list.
   */
  List!(TlsCertificate, GTlsCertificate*) lookupCertificatesIssuedBy(ByteArray issuerRawDn, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificates_issued_by(cPtr!GTlsDatabase, issuerRawDn.cPtr, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(TlsCertificate, GTlsCertificate*) _retval = _cretval ? new List!(TlsCertificate, GTlsCertificate*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Asynchronously look up certificates issued by this issuer in the database. See
   * g_tls_database_lookup_certificates_issued_by() for more information.
   *
   * The database may choose to hold a reference to the issuer byte array for the duration
   * of this asynchronous operation. The byte array should not be modified during
   * this time.
   */
  void lookupCertificatesIssuedByAsync(ByteArray issuerRawDn, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_tls_database_lookup_certificates_issued_by_async(cPtr!GTlsDatabase, issuerRawDn.cPtr, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a newly allocated list of #GTlsCertificate
   * objects. Use g_object_unref() on each certificate, and g_list_free() on the release the list.
   */
  List!(TlsCertificate, GTlsCertificate*) lookupCertificatesIssuedByFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_tls_database_lookup_certificates_issued_by_finish(cPtr!GTlsDatabase, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(TlsCertificate, GTlsCertificate*) _retval = _cretval ? new List!(TlsCertificate, GTlsCertificate*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * the appropriate #GTlsCertificateFlags which represents the
   * result of verification.
   */
  TlsCertificateFlags verifyChain(TlsCertificate chain, string purpose, SocketConnectable identity, TlsInteraction interaction, TlsDatabaseVerifyFlags flags, Cancellable cancellable)
  {
    GTlsCertificateFlags _cretval;
    const(char)* _purpose = purpose.toCString(false);
    GError *_err;
    _cretval = g_tls_database_verify_chain(cPtr!GTlsDatabase, chain ? chain.cPtr!GTlsCertificate : null, _purpose, identity ? (cast(ObjectG)identity).cPtr!GSocketConnectable : null, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * Asynchronously determines the validity of a certificate chain after
   * looking up and adding any missing certificates to the chain. See
   * g_tls_database_verify_chain() for more information.
   */
  void verifyChainAsync(TlsCertificate chain, string purpose, SocketConnectable identity, TlsInteraction interaction, TlsDatabaseVerifyFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _purpose = purpose.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_tls_database_verify_chain_async(cPtr!GTlsDatabase, chain ? chain.cPtr!GTlsCertificate : null, _purpose, identity ? (cast(ObjectG)identity).cPtr!GSocketConnectable : null, interaction ? interaction.cPtr!GTlsInteraction : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * the appropriate #GTlsCertificateFlags which represents the
   * result of verification.
   */
  TlsCertificateFlags verifyChainFinish(AsyncResult result)
  {
    GTlsCertificateFlags _cretval;
    GError *_err;
    _cretval = g_tls_database_verify_chain_finish(cPtr!GTlsDatabase, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }
}

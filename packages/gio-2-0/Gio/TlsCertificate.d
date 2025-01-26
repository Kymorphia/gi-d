module Gio.TlsCertificate;

import GLib.DateTime;
import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.InetAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A certificate used for TLS authentication and encryption.
 * This can represent either a certificate only $(LPAREN)eg, the certificate
 * received by a client from a server$(RPAREN), or the combination of
 * a certificate and a private key $(LPAREN)which is needed when acting as a
 * [Gio.TlsServerConnection]$(RPAREN).
 */
class TlsCertificate : ObjectG
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
    return g_tls_certificate_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a #GTlsCertificate from the data in file.
   * As of 2.72, if the filename ends in `.p12` or `.pfx` the data is loaded by
   * [Gio.TlsCertificate.newFromPkcs12] otherwise it is loaded by
   * [Gio.TlsCertificate.newFromPem]. See those functions for
   * exact details.
   * If file cannot be read or parsed, the function will return %NULL and
   * set error.
   * Params:
   *   file = file containing a certificate to import
   * Returns: the new certificate, or %NULL on error
   */
  static TlsCertificate newFromFile(string file)
  {
    GTlsCertificate* _cretval;
    const(char)* _file = file.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_file(_file, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTlsCertificate from the data in file.
   * If file cannot be read or parsed, the function will return %NULL and
   * set error.
   * Any unknown file types will error with %G_IO_ERROR_NOT_SUPPORTED.
   * Currently only `.p12` and `.pfx` files are supported.
   * See [Gio.TlsCertificate.newFromPkcs12] for more details.
   * Params:
   *   file = file containing a certificate to import
   *   password = password for PKCS #12 files
   * Returns: the new certificate, or %NULL on error
   */
  static TlsCertificate newFromFileWithPassword(string file, string password)
  {
    GTlsCertificate* _cretval;
    const(char)* _file = file.toCString(false);
    const(char)* _password = password.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_file_with_password(_file, _password, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTlsCertificate from the PEM-encoded data in cert_file
   * and key_file. The returned certificate will be the first certificate
   * found in cert_file. As of GLib 2.44, if cert_file contains more
   * certificates it will try to load a certificate chain. All
   * certificates will be verified in the order found $(LPAREN)top-level
   * certificate should be the last one in the file$(RPAREN) and the
   * #GTlsCertificate:issuer property of each certificate will be set
   * accordingly if the verification succeeds. If any certificate in the
   * chain cannot be verified, the first certificate in the file will
   * still be returned.
   * If either file cannot be read or parsed, the function will return
   * %NULL and set error. Otherwise, this behaves like
   * [Gio.TlsCertificate.newFromPem].
   * Params:
   *   certFile = file containing one or more PEM-encoded
   *     certificates to import
   *   keyFile = file containing a PEM-encoded private key
   *     to import
   * Returns: the new certificate, or %NULL on error
   */
  static TlsCertificate newFromFiles(string certFile, string keyFile)
  {
    GTlsCertificate* _cretval;
    const(char)* _certFile = certFile.toCString(false);
    const(char)* _keyFile = keyFile.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_files(_certFile, _keyFile, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTlsCertificate from the PEM-encoded data in data. If
   * data includes both a certificate and a private key, then the
   * returned certificate will include the private key data as well. $(LPAREN)See
   * the #GTlsCertificate:private-key-pem property for information about
   * supported formats.$(RPAREN)
   * The returned certificate will be the first certificate found in
   * data. As of GLib 2.44, if data contains more certificates it will
   * try to load a certificate chain. All certificates will be verified in
   * the order found $(LPAREN)top-level certificate should be the last one in the
   * file$(RPAREN) and the #GTlsCertificate:issuer property of each certificate
   * will be set accordingly if the verification succeeds. If any
   * certificate in the chain cannot be verified, the first certificate in
   * the file will still be returned.
   * Params:
   *   data = PEM-encoded certificate data
   *   length = the length of data, or -1 if it's 0-terminated.
   * Returns: the new certificate, or %NULL if data is invalid
   */
  static TlsCertificate newFromPem(string data, ptrdiff_t length)
  {
    GTlsCertificate* _cretval;
    const(char)* _data = data.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_pem(_data, length, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTlsCertificate from a
   * [PKCS \#11](https://docs.oasis-open.org/pkcs11/pkcs11-base/v3.0/os/pkcs11-base-v3.0-os.html) URI.
   * An example pkcs11_uri would be `pkcs11:model\=Model;manufacturer\=Manufacture;serial\=1;token\=My%20Client%20Certificate;id\=%01`
   * Where the token’s layout is:
   * |[
   * Object 0:
   * URL: pkcs11:model\=Model;manufacturer\=Manufacture;serial\=1;token\=My%20Client%20Certificate;id\=%01;object\=private%20key;type\=private
   * Type: Private key $(LPAREN)RSA-2048$(RPAREN)
   * ID: 01
   * Object 1:
   * URL: pkcs11:model\=Model;manufacturer\=Manufacture;serial\=1;token\=My%20Client%20Certificate;id\=%01;object\=Certificate%20for%20Authentication;type\=cert
   * Type: X.509 Certificate $(LPAREN)RSA-2048$(RPAREN)
   * ID: 01
   * ]|
   * In this case the certificate and private key would both be detected and used as expected.
   * pkcs_uri may also just reference an X.509 certificate object and then optionally
   * private_key_pkcs11_uri allows using a private key exposed under a different URI.
   * Note that the private key is not accessed until usage and may fail or require a PIN later.
   * Params:
   *   pkcs11Uri = A PKCS \#11 URI
   *   privateKeyPkcs11Uri = A PKCS \#11 URI
   * Returns: the new certificate, or %NULL on error
   */
  static TlsCertificate newFromPkcs11Uris(string pkcs11Uri, string privateKeyPkcs11Uri)
  {
    GTlsCertificate* _cretval;
    const(char)* _pkcs11Uri = pkcs11Uri.toCString(false);
    const(char)* _privateKeyPkcs11Uri = privateKeyPkcs11Uri.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_pkcs11_uris(_pkcs11Uri, _privateKeyPkcs11Uri, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTlsCertificate from the data in data. It must contain
   * a certificate and matching private key.
   * If extra certificates are included they will be verified as a chain
   * and the #GTlsCertificate:issuer property will be set.
   * All other data will be ignored.
   * You can pass as single password for all of the data which will be
   * used both for the PKCS #12 container as well as encrypted
   * private keys. If decryption fails it will error with
   * %G_TLS_ERROR_BAD_CERTIFICATE_PASSWORD.
   * This constructor requires support in the current #GTlsBackend.
   * If support is missing it will error with
   * %G_IO_ERROR_NOT_SUPPORTED.
   * Other parsing failures will error with %G_TLS_ERROR_BAD_CERTIFICATE.
   * Params:
   *   data = DER-encoded PKCS #12 format certificate data
   *   password = optional password for encrypted certificate data
   * Returns: the new certificate, or %NULL if data is invalid
   */
  static TlsCertificate newFromPkcs12(ubyte[] data, string password)
  {
    GTlsCertificate* _cretval;
    size_t _length;
    if (data)
      _length = cast(size_t)data.length;

    auto _data = cast(const(ubyte)*)data.ptr;
    const(char)* _password = password.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_pkcs12(_data, _length, _password, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates one or more #GTlsCertificates from the PEM-encoded
   * data in file. If file cannot be read or parsed, the function will
   * return %NULL and set error. If file does not contain any
   * PEM-encoded certificates, this will return an empty list and not
   * set error.
   * Params:
   *   file = file containing PEM-encoded certificates to import
   * Returns: a
   *   #GList containing #GTlsCertificate objects. You must free the list
   *   and its contents when you are done with it.
   */
  static TlsCertificate[] listNewFromFile(string file)
  {
    GList* _cretval;
    const(char)* _file = file.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_list_new_from_file(_file, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = gListToD!(TlsCertificate, GidOwnership.Full)(cast(GList*)_cretval);
    return _retval;
  }

  /**
   * Gets the value of #GTlsCertificate:ip-addresses.
   * Returns: A #GPtrArray
   *   of #GInetAddress elements, or %NULL if it's not available.
   */
  InetAddress[] getIpAddresses()
  {
    GPtrArray* _cretval;
    _cretval = g_tls_certificate_get_ip_addresses(cast(GTlsCertificate*)cPtr);
    auto _retval = gPtrArrayToD!(InetAddress, GidOwnership.Container)(cast(GPtrArray*)_cretval);
    return _retval;
  }

  /**
   * Gets the #GTlsCertificate representing cert's issuer, if known
   * Returns: The certificate of cert's issuer,
   *   or %NULL if cert is self-signed or signed with an unknown
   *   certificate.
   */
  TlsCertificate getIssuer()
  {
    GTlsCertificate* _cretval;
    _cretval = g_tls_certificate_get_issuer(cast(GTlsCertificate*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the issuer name from the certificate.
   * Returns: The issuer name, or %NULL if it's not available.
   */
  string getIssuerName()
  {
    char* _cretval;
    _cretval = g_tls_certificate_get_issuer_name(cast(GTlsCertificate*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the time at which the certificate became or will become invalid.
   * Returns: The not-valid-after date, or %NULL if it's not available.
   */
  DateTime getNotValidAfter()
  {
    GDateTime* _cretval;
    _cretval = g_tls_certificate_get_not_valid_after(cast(GTlsCertificate*)cPtr);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the time at which the certificate became or will become valid.
   * Returns: The not-valid-before date, or %NULL if it's not available.
   */
  DateTime getNotValidBefore()
  {
    GDateTime* _cretval;
    _cretval = g_tls_certificate_get_not_valid_before(cast(GTlsCertificate*)cPtr);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the subject name from the certificate.
   * Returns: The subject name, or %NULL if it's not available.
   */
  string getSubjectName()
  {
    char* _cretval;
    _cretval = g_tls_certificate_get_subject_name(cast(GTlsCertificate*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Check if two #GTlsCertificate objects represent the same certificate.
   * The raw DER byte data of the two certificates are checked for equality.
   * This has the effect that two certificates may compare equal even if
   * their #GTlsCertificate:issuer, #GTlsCertificate:private-key, or
   * #GTlsCertificate:private-key-pem properties differ.
   * Params:
   *   certTwo = second certificate to compare
   * Returns: whether the same or not
   */
  bool isSame(TlsCertificate certTwo)
  {
    bool _retval;
    _retval = g_tls_certificate_is_same(cast(GTlsCertificate*)cPtr, certTwo ? cast(GTlsCertificate*)certTwo.cPtr(false) : null);
    return _retval;
  }

  /**
   * This verifies cert and returns a set of #GTlsCertificateFlags
   * indicating any problems found with it. This can be used to verify a
   * certificate outside the context of making a connection, or to
   * check a certificate against a CA that is not part of the system
   * CA database.
   * If cert is valid, %G_TLS_CERTIFICATE_NO_FLAGS is returned.
   * If identity is not %NULL, cert's name$(LPAREN)s$(RPAREN) will be compared against
   * it, and %G_TLS_CERTIFICATE_BAD_IDENTITY will be set in the return
   * value if it does not match. If identity is %NULL, that bit will
   * never be set in the return value.
   * If trusted_ca is not %NULL, then cert $(LPAREN)or one of the certificates
   * in its chain$(RPAREN) must be signed by it, or else
   * %G_TLS_CERTIFICATE_UNKNOWN_CA will be set in the return value. If
   * trusted_ca is %NULL, that bit will never be set in the return
   * value.
   * GLib guarantees that if certificate verification fails, at least one
   * error will be set in the return value, but it does not guarantee
   * that all possible errors will be set. Accordingly, you may not safely
   * decide to ignore any particular type of error. For example, it would
   * be incorrect to mask %G_TLS_CERTIFICATE_EXPIRED if you want to allow
   * expired certificates, because this could potentially be the only
   * error flag set even if other problems exist with the certificate.
   * Because TLS session context is not used, #GTlsCertificate may not
   * perform as many checks on the certificates as #GTlsConnection would.
   * For example, certificate constraints may not be honored, and
   * revocation checks may not be performed. The best way to verify TLS
   * certificates used by a TLS connection is to let #GTlsConnection
   * handle the verification.
   * Params:
   *   identity = the expected peer identity
   *   trustedCa = the certificate of a trusted authority
   * Returns: the appropriate #GTlsCertificateFlags
   */
  TlsCertificateFlags verify(SocketConnectable identity, TlsCertificate trustedCa)
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_tls_certificate_verify(cast(GTlsCertificate*)cPtr, identity ? cast(GSocketConnectable*)(cast(ObjectG)identity).cPtr(false) : null, trustedCa ? cast(GTlsCertificate*)trustedCa.cPtr(false) : null);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }
}

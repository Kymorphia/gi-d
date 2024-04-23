module Gio.TlsCertificate;

import GLib.Bytes;
import GLib.DateTime;
import GLib.ErrorG;
import GLib.List;
import GLib.PtrArray;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.InetAddress;
import Gio.SocketConnectable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A certificate used for TLS authentication and encryption.
 * This can represent either a certificate only (eg, the certificate
 * received by a client from a server), or the combination of
 * a certificate and a private key (which is needed when acting as a
 * #GTlsServerConnection).
 */
class TlsCertificate : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_tls_certificate_get_type();
  }

  /**
   * the new certificate, or %NULL on error
   */
  static TlsCertificate newFromFile(string file)
  {
    GTlsCertificate* _cretval;
    const(char)* _file = file.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_file(_file, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * the new certificate, or %NULL on error
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
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * the new certificate, or %NULL on error
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
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * the new certificate, or %NULL if @data is invalid
   */
  static TlsCertificate newFromPem(string data, ptrdiff_t length)
  {
    GTlsCertificate* _cretval;
    const(char)* _data = data.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_pem(_data, length, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * the new certificate, or %NULL on error
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
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * the new certificate, or %NULL if @data is invalid
   */
  static TlsCertificate newFromPkcs12(ubyte[] data, string password)
  {
    GTlsCertificate* _cretval;
    auto _data = cast(const(ubyte)*)data.ptr;
    const(char)* _password = password.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_new_from_pkcs12(_data, data ? cast(size_t)data.length : 0, _password, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, true);
    return _retval;
  }

  /**
   * a
   * #GList containing #GTlsCertificate objects. You must free the list
   * and its contents when you are done with it.
   */
  static List!(TlsCertificate, GTlsCertificate*) listNewFromFile(string file)
  {
    GList* _cretval;
    const(char)* _file = file.toCString(false);
    GError *_err;
    _cretval = g_tls_certificate_list_new_from_file(_file, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(TlsCertificate, GTlsCertificate*) _retval = _cretval ? new List!(TlsCertificate, GTlsCertificate*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * A #GPtrArray of
   * #GBytes elements, or %NULL if it's not available.
   */
  PtrArray!(Bytes, GBytes*) getDnsNames()
  {
    GPtrArray* _cretval;
    _cretval = g_tls_certificate_get_dns_names(cPtr!GTlsCertificate);
    PtrArray!(Bytes, GBytes*) _retval = _cretval ? new PtrArray!(Bytes, GBytes*)(_cretval, GidOwnership.Container) : null;
    return _retval;
  }

  /**
   * A #GPtrArray
   * of #GInetAddress elements, or %NULL if it's not available.
   */
  PtrArray!(InetAddress, GInetAddress*) getIpAddresses()
  {
    GPtrArray* _cretval;
    _cretval = g_tls_certificate_get_ip_addresses(cPtr!GTlsCertificate);
    PtrArray!(InetAddress, GInetAddress*) _retval = _cretval ? new PtrArray!(InetAddress, GInetAddress*)(_cretval, GidOwnership.Container) : null;
    return _retval;
  }

  /**
   * The certificate of @cert's issuer,
   * or %NULL if @cert is self-signed or signed with an unknown
   * certificate.
   */
  TlsCertificate getIssuer()
  {
    GTlsCertificate* _cretval;
    _cretval = g_tls_certificate_get_issuer(cPtr!GTlsCertificate);
    TlsCertificate _retval = ObjectG.getDObject!TlsCertificate(cast(GTlsCertificate*)_cretval, false);
    return _retval;
  }

  /**
   * The issuer name, or %NULL if it's not available.
   */
  string getIssuerName()
  {
    char* _cretval;
    _cretval = g_tls_certificate_get_issuer_name(cPtr!GTlsCertificate);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The not-valid-after date, or %NULL if it's not available.
   */
  DateTime getNotValidAfter()
  {
    GDateTime* _cretval;
    _cretval = g_tls_certificate_get_not_valid_after(cPtr!GTlsCertificate);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * The not-valid-before date, or %NULL if it's not available.
   */
  DateTime getNotValidBefore()
  {
    GDateTime* _cretval;
    _cretval = g_tls_certificate_get_not_valid_before(cPtr!GTlsCertificate);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * The subject name, or %NULL if it's not available.
   */
  string getSubjectName()
  {
    char* _cretval;
    _cretval = g_tls_certificate_get_subject_name(cPtr!GTlsCertificate);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * whether the same or not
   */
  bool isSame(TlsCertificate certTwo)
  {
    bool _retval;
    _retval = g_tls_certificate_is_same(cPtr!GTlsCertificate, certTwo ? certTwo.cPtr!GTlsCertificate : null);
    return _retval;
  }

  /**
   * the appropriate #GTlsCertificateFlags
   */
  TlsCertificateFlags verify(SocketConnectable identity, TlsCertificate trustedCa)
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_tls_certificate_verify(cPtr!GTlsCertificate, identity ? (cast(ObjectG)identity).cPtr!GSocketConnectable : null, trustedCa ? trustedCa.cPtr!GTlsCertificate : null);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }
}

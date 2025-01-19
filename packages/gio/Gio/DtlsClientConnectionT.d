module Gio.DtlsClientConnectionT;

public import Gio.DtlsClientConnectionIfaceProxy;
public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.DatagramBased;
public import Gio.DatagramBasedT;
public import Gio.SocketConnectable;
public import Gio.SocketConnectableT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GDtlsClientConnection` is the client-side subclass of
 * [Gio.DtlsConnection], representing a client-side DTLS connection.
 */
template DtlsClientConnectionT()
{


  /**
   * Gets conn's expected server identity
   * Returns: a #GSocketConnectable describing the
   *   expected server identity, or %NULL if the expected identity is not
   *   known.
   */
  override SocketConnectable getServerIdentity()
  {
    GSocketConnectable* _cretval;
    _cretval = g_dtls_client_connection_get_server_identity(cast(GDtlsClientConnection*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnectable(cast(GSocketConnectable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets conn's validation flags
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GDtlsClientConnection:validation-flags for more
   * information.
   * Returns: the validation flags

   * Deprecated: Do not attempt to ignore validation errors.
   */
  override TlsCertificateFlags getValidationFlags()
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_dtls_client_connection_get_validation_flags(cast(GDtlsClientConnection*)cPtr);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * Sets conn's expected server identity, which is used both to tell
   * servers on virtual hosts which certificate to present, and also
   * to let conn know what name to look for in the certificate when
   * performing %G_TLS_CERTIFICATE_BAD_IDENTITY validation, if enabled.
   * Params:
   *   identity = a #GSocketConnectable describing the expected server identity
   */
  override void setServerIdentity(SocketConnectable identity)
  {
    g_dtls_client_connection_set_server_identity(cast(GDtlsClientConnection*)cPtr, identity ? cast(GSocketConnectable*)(cast(ObjectG)identity).cPtr(false) : null);
  }

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
  override void setValidationFlags(TlsCertificateFlags flags)
  {
    g_dtls_client_connection_set_validation_flags(cast(GDtlsClientConnection*)cPtr, flags);
  }
}

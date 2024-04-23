module Gio.DtlsClientConnectionT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.DatagramBased;
public import Gio.SocketConnectable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GDtlsClientConnection is the client-side subclass of
 * #GDtlsConnection, representing a client-side DTLS connection.
 */
template DtlsClientConnectionT(TStruct)
{

  /**
   * the new
   * #GDtlsClientConnection, or %NULL on error
   */
  static DtlsClientConnection new_(DatagramBased baseSocket, SocketConnectable serverIdentity)
  {
    GDatagramBased* _cretval;
    GError *_err;
    _cretval = g_dtls_client_connection_new(baseSocket ? (cast(ObjectG)baseSocket).cPtr!GDatagramBased : null, serverIdentity ? (cast(ObjectG)serverIdentity).cPtr!GSocketConnectable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DtlsClientConnection _retval = ObjectG.getDObject!DtlsClientConnection(cast(GDatagramBased*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocketConnectable describing the
   * expected server identity, or %NULL if the expected identity is not
   * known.
   */
  override SocketConnectable getServerIdentity()
  {
    GSocketConnectable* _cretval;
    _cretval = g_dtls_client_connection_get_server_identity(cPtr!GDtlsClientConnection);
    SocketConnectable _retval = ObjectG.getDObject!SocketConnectable(cast(GSocketConnectable*)_cretval, false);
    return _retval;
  }

  /**
   * the validation flags
   */
  override TlsCertificateFlags getValidationFlags()
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_dtls_client_connection_get_validation_flags(cPtr!GDtlsClientConnection);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * Sets @conn's expected server identity, which is used both to tell
   * servers on virtual hosts which certificate to present, and also
   * to let @conn know what name to look for in the certificate when
   * performing %G_TLS_CERTIFICATE_BAD_IDENTITY validation, if enabled.
   */
  override void setServerIdentity(SocketConnectable identity)
  {
    g_dtls_client_connection_set_server_identity(cPtr!GDtlsClientConnection, identity ? (cast(ObjectG)identity).cPtr!GSocketConnectable : null);
  }

  /**
   * Sets @conn's validation flags, to override the default set of
   * checks performed when validating a server certificate. By default,
   * %G_TLS_CERTIFICATE_VALIDATE_ALL is used.
   *
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GDtlsClientConnection:validation-flags for more
   * information.
   */
  override void setValidationFlags(TlsCertificateFlags flags)
  {
    g_dtls_client_connection_set_validation_flags(cPtr!GDtlsClientConnection, flags);
  }
}

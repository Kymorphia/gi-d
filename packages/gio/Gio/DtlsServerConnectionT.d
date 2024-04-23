module Gio.DtlsServerConnectionT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.DatagramBased;
public import Gio.TlsCertificate;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GDtlsServerConnection is the server-side subclass of #GDtlsConnection,
 * representing a server-side DTLS connection.
 */
template DtlsServerConnectionT(TStruct)
{

  /**
   * the new
   * #GDtlsServerConnection, or %NULL on error
   */
  static DtlsServerConnection new_(DatagramBased baseSocket, TlsCertificate certificate)
  {
    GDatagramBased* _cretval;
    GError *_err;
    _cretval = g_dtls_server_connection_new(baseSocket ? (cast(ObjectG)baseSocket).cPtr!GDatagramBased : null, certificate ? certificate.cPtr!GTlsCertificate : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    DtlsServerConnection _retval = ObjectG.getDObject!DtlsServerConnection(cast(GDatagramBased*)_cretval, true);
    return _retval;
  }
}

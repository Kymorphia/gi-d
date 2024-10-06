module Gio.DtlsServerConnectionT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.DatagramBased;
public import Gio.DatagramBasedT;
public import Gio.TlsCertificate;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GDtlsServerConnection` is the server-side subclass of
 * [Gio.DtlsConnection], representing a server-side DTLS connection.
 */
template DtlsServerConnectionT(TStruct)
{

  /**
   * Creates a new #GDtlsServerConnection wrapping base_socket.
   * Params:
   *   baseSocket = the #GDatagramBased to wrap
   *   certificate = the default server certificate, or %NULL
   * Returns: the new
   *   #GDtlsServerConnection, or %NULL on error
   */
  static DtlsServerConnection new_(DatagramBased baseSocket, TlsCertificate certificate)
  {
    GDatagramBased* _cretval;
    GError *_err;
    _cretval = g_dtls_server_connection_new(baseSocket ? cast(GDatagramBased*)(cast(ObjectG)baseSocket).cPtr(false) : null, certificate ? cast(GTlsCertificate*)certificate.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!DtlsServerConnection(cast(GDatagramBased*)_cretval, true) : null;
    return _retval;
  }
}

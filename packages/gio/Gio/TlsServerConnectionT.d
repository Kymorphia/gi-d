module Gio.TlsServerConnectionT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.IOStream;
public import Gio.TlsCertificate;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GTlsServerConnection is the server-side subclass of #GTlsConnection,
 * representing a server-side TLS connection.
 */
template TlsServerConnectionT(TStruct)
{

  /**
   * the new
   * #GTlsServerConnection, or %NULL on error
   */
  static TlsServerConnection new_(IOStream baseIoStream, TlsCertificate certificate)
  {
    GIOStream* _cretval;
    GError *_err;
    _cretval = g_tls_server_connection_new(baseIoStream ? baseIoStream.cPtr!GIOStream : null, certificate ? certificate.cPtr!GTlsCertificate : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsServerConnection _retval = ObjectG.getDObject!TlsServerConnection(cast(GIOStream*)_cretval, true);
    return _retval;
  }
}

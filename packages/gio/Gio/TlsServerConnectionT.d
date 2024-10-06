module Gio.TlsServerConnectionT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.IOStream;
public import Gio.TlsCertificate;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GTlsServerConnection` is the server-side subclass of
 * [Gio.TlsConnection], representing a server-side TLS connection.
 */
template TlsServerConnectionT(TStruct)
{

  /**
   * Creates a new #GTlsServerConnection wrapping base_io_stream $(LPAREN)which
   * must have pollable input and output streams$(RPAREN).
   * See the documentation for #GTlsConnection:base-io-stream for restrictions
   * on when application code can run operations on the base_io_stream after
   * this function has returned.
   * Params:
   *   baseIoStream = the #GIOStream to wrap
   *   certificate = the default server certificate, or %NULL
   * Returns: the new
   *   #GTlsServerConnection, or %NULL on error
   */
  static TlsServerConnection new_(IOStream baseIoStream, TlsCertificate certificate)
  {
    GIOStream* _cretval;
    GError *_err;
    _cretval = g_tls_server_connection_new(baseIoStream ? cast(GIOStream*)baseIoStream.cPtr(false) : null, certificate ? cast(GTlsCertificate*)certificate.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsServerConnection(cast(GIOStream*)_cretval, true) : null;
    return _retval;
  }
}

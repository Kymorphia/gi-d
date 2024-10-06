module Gio.TlsClientConnectionT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.IOStream;
public import Gio.SocketConnectable;
public import Gio.SocketConnectableT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GTlsClientConnection` is the client-side subclass of
 * [Gio.TlsConnection], representing a client-side TLS connection.
 */
template TlsClientConnectionT(TStruct)
{

  /**
   * Creates a new #GTlsClientConnection wrapping base_io_stream $(LPAREN)which
   * must have pollable input and output streams$(RPAREN) which is assumed to
   * communicate with the server identified by server_identity.
   * See the documentation for #GTlsConnection:base-io-stream for restrictions
   * on when application code can run operations on the base_io_stream after
   * this function has returned.
   * Params:
   *   baseIoStream = the #GIOStream to wrap
   *   serverIdentity = the expected identity of the server
   * Returns: the new
   *   #GTlsClientConnection, or %NULL on error
   */
  static TlsClientConnection new_(IOStream baseIoStream, SocketConnectable serverIdentity)
  {
    GIOStream* _cretval;
    GError *_err;
    _cretval = g_tls_client_connection_new(baseIoStream ? cast(GIOStream*)baseIoStream.cPtr(false) : null, serverIdentity ? cast(GSocketConnectable*)(cast(ObjectG)serverIdentity).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsClientConnection(cast(GIOStream*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Possibly copies session state from one connection to another, for use
   * in TLS session resumption. This is not normally needed, but may be
   * used when the same session needs to be used between different
   * endpoints, as is required by some protocols, such as FTP over TLS.
   * source should have already completed a handshake and, since TLS 1.3,
   * it should have been used to read data at least once. conn should not
   * have completed a handshake.
   * It is not possible to know whether a call to this function will
   * actually do anything. Because session resumption is normally used
   * only for performance benefit, the TLS backend might not implement
   * this function. Even if implemented, it may not actually succeed in
   * allowing conn to resume source's TLS session, because the server
   * may not have sent a session resumption token to source, or it may
   * refuse to accept the token from conn. There is no way to know
   * whether a call to this function is actually successful.
   * Using this function is not required to benefit from session
   * resumption. If the TLS backend supports session resumption, the
   * session will be resumed automatically if it is possible to do so
   * without weakening the privacy guarantees normally provided by TLS,
   * without need to call this function. For example, with TLS 1.3,
   * a session ticket will be automatically copied from any
   * #GTlsClientConnection that has previously received session tickets
   * from the server, provided a ticket is available that has not
   * previously been used for session resumption, since session ticket
   * reuse would be a privacy weakness. Using this function causes the
   * ticket to be copied without regard for privacy considerations.
   * Params:
   *   source = a #GTlsClientConnection
   */
  override void copySessionState(TlsClientConnection source)
  {
    g_tls_client_connection_copy_session_state(cast(GTlsClientConnection*)cPtr, source ? cast(GTlsClientConnection*)(cast(ObjectG)source).cPtr(false) : null);
  }

  /**
   * Gets conn's expected server identity
   * Returns: a #GSocketConnectable describing the
   *   expected server identity, or %NULL if the expected identity is not
   *   known.
   */
  override SocketConnectable getServerIdentity()
  {
    GSocketConnectable* _cretval;
    _cretval = g_tls_client_connection_get_server_identity(cast(GTlsClientConnection*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnectable(cast(GSocketConnectable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * SSL 3.0 is no longer supported. See
   * [Gio.TlsClientConnection.setUseSsl3] for details.
   * Returns: %FALSE

   * Deprecated: SSL 3.0 is insecure.
   */
  override bool getUseSsl3()
  {
    bool _retval;
    _retval = g_tls_client_connection_get_use_ssl3(cast(GTlsClientConnection*)cPtr);
    return _retval;
  }

  /**
   * Gets conn's validation flags
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GTlsClientConnection:validation-flags for more
   * information.
   * Returns: the validation flags

   * Deprecated: Do not attempt to ignore validation errors.
   */
  override TlsCertificateFlags getValidationFlags()
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_tls_client_connection_get_validation_flags(cast(GTlsClientConnection*)cPtr);
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
    g_tls_client_connection_set_server_identity(cast(GTlsClientConnection*)cPtr, identity ? cast(GSocketConnectable*)(cast(ObjectG)identity).cPtr(false) : null);
  }

  /**
   * Since GLib 2.42.1, SSL 3.0 is no longer supported.
   * From GLib 2.42.1 through GLib 2.62, this function could be used to
   * force use of TLS 1.0, the lowest-supported TLS protocol version at
   * the time. In the past, this was needed to connect to broken TLS
   * servers that exhibited protocol version intolerance. Such servers
   * are no longer common, and using TLS 1.0 is no longer considered
   * acceptable.
   * Since GLib 2.64, this function does nothing.
   * Params:
   *   useSsl3 = a #gboolean, ignored

   * Deprecated: SSL 3.0 is insecure.
   */
  override void setUseSsl3(bool useSsl3)
  {
    g_tls_client_connection_set_use_ssl3(cast(GTlsClientConnection*)cPtr, useSsl3);
  }

  /**
   * Sets conn's validation flags, to override the default set of
   * checks performed when validating a server certificate. By default,
   * %G_TLS_CERTIFICATE_VALIDATE_ALL is used.
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GTlsClientConnection:validation-flags for more
   * information.
   * Params:
   *   flags = the #GTlsCertificateFlags to use

   * Deprecated: Do not attempt to ignore validation errors.
   */
  override void setValidationFlags(TlsCertificateFlags flags)
  {
    g_tls_client_connection_set_validation_flags(cast(GTlsClientConnection*)cPtr, flags);
  }
}

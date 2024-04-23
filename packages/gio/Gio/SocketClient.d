module Gio.SocketClient;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.ProxyResolver;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSocketClient is a lightweight high-level utility class for connecting to
 * a network host using a connection oriented socket type.
 *
 * You create a #GSocketClient object, set any options you want, and then
 * call a sync or async connect operation, which returns a #GSocketConnection
 * subclass on success.
 *
 * The type of the #GSocketConnection object returned depends on the type of
 * the underlying socket that is in use. For instance, for a TCP/IP connection
 * it will be a #GTcpConnection.
 *
 * As #GSocketClient is a lightweight object, you don't need to cache it. You
 * can just create a new one any time you need one.
 */
class SocketClient : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_client_get_type();
  }

  /**
   * a #GSocketClient.
   * Free the returned object with g_object_unref().
   */
  this()
  {
    GSocketClient* _cretval;
    _cretval = g_socket_client_new();
    this(_cretval, true);
  }

  /**
   * Enable proxy protocols to be handled by the application. When the
   * indicated proxy protocol is returned by the #GProxyResolver,
   * #GSocketClient will consider this protocol as supported but will
   * not try to find a #GProxy instance to handle handshaking. The
   * application must check for this case by calling
   * g_socket_connection_get_remote_address() on the returned
   * #GSocketConnection, and seeing if it's a #GProxyAddress of the
   * appropriate type, to determine whether or not it needs to handle
   * the proxy handshaking itself.
   *
   * This should be used for proxy protocols that are dialects of
   * another protocol such as HTTP proxy. It also allows cohabitation of
   * proxy protocols that are reused between protocols. A good example
   * is HTTP. It can be used to proxy HTTP, FTP and Gopher and can also
   * be use as generic socket proxy through the HTTP CONNECT method.
   *
   * When the proxy is detected as being an application proxy, TLS handshake
   * will be skipped. This is required to let the application do the proxy
   * specific handshake.
   */
  void addApplicationProxy(string protocol)
  {
    const(char)* _protocol = protocol.toCString(false);
    g_socket_client_add_application_proxy(cPtr!GSocketClient, _protocol);
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connect(SocketConnectable connectable, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect(cPtr!GSocketClient, connectable ? (cast(ObjectG)connectable).cPtr!GSocketConnectable : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * This is the asynchronous version of g_socket_client_connect().
   *
   * You may wish to prefer the asynchronous version even in synchronous
   * command line programs because, since 2.60, it implements
   * [RFC 8305](https://tools.ietf.org/html/rfc8305) "Happy Eyeballs"
   * recommendations to work around long connection timeouts in networks
   * where IPv6 is broken by performing an IPv4 connection simultaneously
   * without waiting for IPv6 to time out, which is not supported by the
   * synchronous call. (This is not an API guarantee, and may change in
   * the future.)
   *
   * When the operation is finished @callback will be
   * called. You can then call g_socket_client_connect_finish() to get
   * the result of the operation.
   */
  void connectAsync(SocketConnectable connectable, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_socket_client_connect_async(cPtr!GSocketClient, connectable ? (cast(ObjectG)connectable).cPtr!GSocketConnectable : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_finish(cPtr!GSocketClient, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToHost(string hostAndPort, ushort defaultPort, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    const(char)* _hostAndPort = hostAndPort.toCString(false);
    GError *_err;
    _cretval = g_socket_client_connect_to_host(cPtr!GSocketClient, _hostAndPort, defaultPort, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * This is the asynchronous version of g_socket_client_connect_to_host().
   *
   * When the operation is finished @callback will be
   * called. You can then call g_socket_client_connect_to_host_finish() to get
   * the result of the operation.
   */
  void connectToHostAsync(string hostAndPort, ushort defaultPort, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _hostAndPort = hostAndPort.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_socket_client_connect_to_host_async(cPtr!GSocketClient, _hostAndPort, defaultPort, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToHostFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_to_host_finish(cPtr!GSocketClient, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocketConnection if successful, or %NULL on error
   */
  SocketConnection connectToService(string domain, string service, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    const(char)* _domain = domain.toCString(false);
    const(char)* _service = service.toCString(false);
    GError *_err;
    _cretval = g_socket_client_connect_to_service(cPtr!GSocketClient, _domain, _service, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * This is the asynchronous version of
   * g_socket_client_connect_to_service().
   */
  void connectToServiceAsync(string domain, string service, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _domain = domain.toCString(false);
    const(char)* _service = service.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_socket_client_connect_to_service_async(cPtr!GSocketClient, _domain, _service, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToServiceFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_to_service_finish(cPtr!GSocketClient, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToUri(string uri, ushort defaultPort, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_socket_client_connect_to_uri(cPtr!GSocketClient, _uri, defaultPort, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * This is the asynchronous version of g_socket_client_connect_to_uri().
   *
   * When the operation is finished @callback will be
   * called. You can then call g_socket_client_connect_to_uri_finish() to get
   * the result of the operation.
   */
  void connectToUriAsync(string uri, ushort defaultPort, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _uri = uri.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_socket_client_connect_to_uri_async(cPtr!GSocketClient, _uri, defaultPort, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToUriFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_to_uri_finish(cPtr!GSocketClient, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * whether proxying is enabled
   */
  bool getEnableProxy()
  {
    bool _retval;
    _retval = g_socket_client_get_enable_proxy(cPtr!GSocketClient);
    return _retval;
  }

  /**
   * a #GSocketFamily
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_socket_client_get_family(cPtr!GSocketClient);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * a #GSocketAddress or %NULL. Do not free.
   */
  SocketAddress getLocalAddress()
  {
    GSocketAddress* _cretval;
    _cretval = g_socket_client_get_local_address(cPtr!GSocketClient);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, false);
    return _retval;
  }

  /**
   * a #GSocketProtocol
   */
  SocketProtocol getProtocol()
  {
    GSocketProtocol _cretval;
    _cretval = g_socket_client_get_protocol(cPtr!GSocketClient);
    SocketProtocol _retval = cast(SocketProtocol)_cretval;
    return _retval;
  }

  /**
   * The #GProxyResolver being used by
   * @client.
   */
  ProxyResolver getProxyResolver()
  {
    GProxyResolver* _cretval;
    _cretval = g_socket_client_get_proxy_resolver(cPtr!GSocketClient);
    ProxyResolver _retval = ObjectG.getDObject!ProxyResolver(cast(GProxyResolver*)_cretval, false);
    return _retval;
  }

  /**
   * a #GSocketFamily
   */
  SocketType getSocketType()
  {
    GSocketType _cretval;
    _cretval = g_socket_client_get_socket_type(cPtr!GSocketClient);
    SocketType _retval = cast(SocketType)_cretval;
    return _retval;
  }

  /**
   * the timeout in seconds
   */
  uint getTimeout()
  {
    uint _retval;
    _retval = g_socket_client_get_timeout(cPtr!GSocketClient);
    return _retval;
  }

  /**
   * whether @client uses TLS
   */
  bool getTls()
  {
    bool _retval;
    _retval = g_socket_client_get_tls(cPtr!GSocketClient);
    return _retval;
  }

  /**
   * the TLS validation flags
   */
  TlsCertificateFlags getTlsValidationFlags()
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_socket_client_get_tls_validation_flags(cPtr!GSocketClient);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * Sets whether or not @client attempts to make connections via a
   * proxy server. When enabled (the default), #GSocketClient will use a
   * #GProxyResolver to determine if a proxy protocol such as SOCKS is
   * needed, and automatically do the necessary proxy negotiation.
   *
   * See also g_socket_client_set_proxy_resolver().
   */
  void setEnableProxy(bool enable)
  {
    g_socket_client_set_enable_proxy(cPtr!GSocketClient, enable);
  }

  /**
   * Sets the socket family of the socket client.
   * If this is set to something other than %G_SOCKET_FAMILY_INVALID
   * then the sockets created by this object will be of the specified
   * family.
   *
   * This might be useful for instance if you want to force the local
   * connection to be an ipv4 socket, even though the address might
   * be an ipv6 mapped to ipv4 address.
   */
  void setFamily(SocketFamily family)
  {
    g_socket_client_set_family(cPtr!GSocketClient, family);
  }

  /**
   * Sets the local address of the socket client.
   * The sockets created by this object will bound to the
   * specified address (if not %NULL) before connecting.
   *
   * This is useful if you want to ensure that the local
   * side of the connection is on a specific port, or on
   * a specific interface.
   */
  void setLocalAddress(SocketAddress address)
  {
    g_socket_client_set_local_address(cPtr!GSocketClient, address ? address.cPtr!GSocketAddress : null);
  }

  /**
   * Sets the protocol of the socket client.
   * The sockets created by this object will use of the specified
   * protocol.
   *
   * If @protocol is %G_SOCKET_PROTOCOL_DEFAULT that means to use the default
   * protocol for the socket family and type.
   */
  void setProtocol(SocketProtocol protocol)
  {
    g_socket_client_set_protocol(cPtr!GSocketClient, protocol);
  }

  /**
   * Overrides the #GProxyResolver used by @client. You can call this if
   * you want to use specific proxies, rather than using the system
   * default proxy settings.
   *
   * Note that whether or not the proxy resolver is actually used
   * depends on the setting of #GSocketClient:enable-proxy, which is not
   * changed by this function (but which is %TRUE by default)
   */
  void setProxyResolver(ProxyResolver proxyResolver)
  {
    g_socket_client_set_proxy_resolver(cPtr!GSocketClient, proxyResolver ? (cast(ObjectG)proxyResolver).cPtr!GProxyResolver : null);
  }

  /**
   * Sets the socket type of the socket client.
   * The sockets created by this object will be of the specified
   * type.
   *
   * It doesn't make sense to specify a type of %G_SOCKET_TYPE_DATAGRAM,
   * as GSocketClient is used for connection oriented services.
   */
  void setSocketType(SocketType type)
  {
    g_socket_client_set_socket_type(cPtr!GSocketClient, type);
  }

  /**
   * Sets the I/O timeout for sockets created by @client. @timeout is a
   * time in seconds, or 0 for no timeout (the default).
   *
   * The timeout value affects the initial connection attempt as well,
   * so setting this may cause calls to g_socket_client_connect(), etc,
   * to fail with %G_IO_ERROR_TIMED_OUT.
   */
  void setTimeout(uint timeout)
  {
    g_socket_client_set_timeout(cPtr!GSocketClient, timeout);
  }

  /**
   * Sets whether @client creates TLS (aka SSL) connections. If @tls is
   * %TRUE, @client will wrap its connections in a #GTlsClientConnection
   * and perform a TLS handshake when connecting.
   *
   * Note that since #GSocketClient must return a #GSocketConnection,
   * but #GTlsClientConnection is not a #GSocketConnection, this
   * actually wraps the resulting #GTlsClientConnection in a
   * #GTcpWrapperConnection when returning it. You can use
   * g_tcp_wrapper_connection_get_base_io_stream() on the return value
   * to extract the #GTlsClientConnection.
   *
   * If you need to modify the behavior of the TLS handshake (eg, by
   * setting a client-side certificate to use, or connecting to the
   * #GTlsConnection::accept-certificate signal), you can connect to
   * @client's #GSocketClient::event signal and wait for it to be
   * emitted with %G_SOCKET_CLIENT_TLS_HANDSHAKING, which will give you
   * a chance to see the #GTlsClientConnection before the handshake
   * starts.
   */
  void setTls(bool tls)
  {
    g_socket_client_set_tls(cPtr!GSocketClient, tls);
  }

  /**
   * Sets the TLS validation flags used when creating TLS connections
   * via @client. The default value is %G_TLS_CERTIFICATE_VALIDATE_ALL.
   *
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GSocketClient:tls-validation-flags for more
   * information.
   */
  void setTlsValidationFlags(TlsCertificateFlags flags)
  {
    g_socket_client_set_tls_validation_flags(cPtr!GSocketClient, flags);
  }

  /**
   * Emitted when @client's activity on @connectable changes state.
   * Among other things, this can be used to provide progress
   * information about a network connection in the UI. The meanings of
   * the different @event values are as follows:
   *
   * - %G_SOCKET_CLIENT_RESOLVING: @client is about to look up @connectable
   * in DNS. @connection will be %NULL.
   *
   * - %G_SOCKET_CLIENT_RESOLVED:  @client has successfully resolved
   * @connectable in DNS. @connection will be %NULL.
   *
   * - %G_SOCKET_CLIENT_CONNECTING: @client is about to make a connection
   * to a remote host; either a proxy server or the destination server
   * itself. @connection is the #GSocketConnection, which is not yet
   * connected.  Since GLib 2.40, you can access the remote
   * address via g_socket_connection_get_remote_address().
   *
   * - %G_SOCKET_CLIENT_CONNECTED: @client has successfully connected
   * to a remote host. @connection is the connected #GSocketConnection.
   *
   * - %G_SOCKET_CLIENT_PROXY_NEGOTIATING: @client is about to negotiate
   * with a proxy to get it to connect to @connectable. @connection is
   * the #GSocketConnection to the proxy server.
   *
   * - %G_SOCKET_CLIENT_PROXY_NEGOTIATED: @client has negotiated a
   * connection to @connectable through a proxy server. @connection is
   * the stream returned from g_proxy_connect(), which may or may not
   * be a #GSocketConnection.
   *
   * - %G_SOCKET_CLIENT_TLS_HANDSHAKING: @client is about to begin a TLS
   * handshake. @connection is a #GTlsClientConnection.
   *
   * - %G_SOCKET_CLIENT_TLS_HANDSHAKED: @client has successfully completed
   * the TLS handshake. @connection is a #GTlsClientConnection.
   *
   * - %G_SOCKET_CLIENT_COMPLETE: @client has either successfully connected
   * to @connectable (in which case @connection is the #GSocketConnection
   * that it will be returning to the caller) or has failed (in which
   * case @connection is %NULL and the client is about to return an error).
   *
   * Each event except %G_SOCKET_CLIENT_COMPLETE may be emitted
   * multiple times (or not at all) for a given connectable (in
   * particular, if @client ends up attempting to connect to more than
   * one address). However, if @client emits the #GSocketClient::event
   * signal at all for a given connectable, then it will always emit
   * it with %G_SOCKET_CLIENT_COMPLETE when it is done.
   *
   * Note that there may be additional #GSocketClientEvent values in
   * the future; unrecognized @event values should be ignored.
   */
  ulong connectEvent(void delegate(SocketClientEvent event, SocketConnectable connectable, IOStream connection, SocketClient socketClient) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto socketClient = getVal!SocketClient(_paramVals);
      auto event = getVal!SocketClientEvent(&_paramVals[1]);
      auto connectable = getVal!SocketConnectable(&_paramVals[2]);
      auto connection = getVal!IOStream(&_paramVals[3]);
      _dgClosure.dlg(event, connectable, connection, socketClient);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("event", closure, (flags & ConnectFlags.After) != 0);
  }
}

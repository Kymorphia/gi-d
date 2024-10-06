module Gio.SocketClient;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.ProxyResolver;
import Gio.ProxyResolverT;
import Gio.SocketAddress;
import Gio.SocketConnectable;
import Gio.SocketConnectableT;
import Gio.SocketConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GSocketClient` is a lightweight high-level utility class for connecting to
 * a network host using a connection oriented socket type.
 * You create a `GSocketClient` object, set any options you want, and then
 * call a sync or async connect operation, which returns a
 * [Gio.SocketConnection] subclass on success.
 * The type of the [Gio.SocketConnection] object returned depends on the
 * type of the underlying socket that is in use. For instance, for a TCP/IP
 * connection it will be a [Gio.TcpConnection].
 * As `GSocketClient` is a lightweight object, you don't need to cache it. You
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

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GSocketClient with the default options.
   * Returns: a #GSocketClient.
   *   Free the returned object with [GObject.ObjectG.unref].
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
   * [Gio.SocketConnection.getRemoteAddress] on the returned
   * #GSocketConnection, and seeing if it's a #GProxyAddress of the
   * appropriate type, to determine whether or not it needs to handle
   * the proxy handshaking itself.
   * This should be used for proxy protocols that are dialects of
   * another protocol such as HTTP proxy. It also allows cohabitation of
   * proxy protocols that are reused between protocols. A good example
   * is HTTP. It can be used to proxy HTTP, FTP and Gopher and can also
   * be use as generic socket proxy through the HTTP CONNECT method.
   * When the proxy is detected as being an application proxy, TLS handshake
   * will be skipped. This is required to let the application do the proxy
   * specific handshake.
   * Params:
   *   protocol = The proxy protocol
   */
  void addApplicationProxy(string protocol)
  {
    const(char)* _protocol = protocol.toCString(false);
    g_socket_client_add_application_proxy(cast(GSocketClient*)cPtr, _protocol);
  }

  /**
   * Tries to resolve the connectable and make a network connection to it.
   * Upon a successful connection, a new #GSocketConnection is constructed
   * and returned.  The caller owns this new object and must drop their
   * reference to it when finished with it.
   * The type of the #GSocketConnection object returned depends on the type of
   * the underlying socket that is used. For instance, for a TCP/IP connection
   * it will be a #GTcpConnection.
   * The socket created will be the same family as the address that the
   * connectable resolves to, unless family is set with [Gio.SocketClient.setFamily]
   * or indirectly via [Gio.SocketClient.setLocalAddress]. The socket type
   * defaults to %G_SOCKET_TYPE_STREAM but can be set with
   * [Gio.SocketClient.setSocketType].
   * If a local address is specified with [Gio.SocketClient.setLocalAddress] the
   * socket will be bound to this address before connecting.
   * Params:
   *   connectable = a #GSocketConnectable specifying the remote address.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connect(SocketConnectable connectable, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect(cast(GSocketClient*)cPtr, connectable ? cast(GSocketConnectable*)(cast(ObjectG)connectable).cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This is the asynchronous version of [Gio.SocketClient.connect].
   * You may wish to prefer the asynchronous version even in synchronous
   * command line programs because, since 2.60, it implements
   * [RFC 8305](https://tools.ietf.org/html/rfc8305) "Happy Eyeballs"
   * recommendations to work around long connection timeouts in networks
   * where IPv6 is broken by performing an IPv4 connection simultaneously
   * without waiting for IPv6 to time out, which is not supported by the
   * synchronous call. $(LPAREN)This is not an API guarantee, and may change in
   * the future.$(RPAREN)
   * When the operation is finished callback will be
   * called. You can then call [Gio.SocketClient.connectFinish] to get
   * the result of the operation.
   * Params:
   *   connectable = a #GSocketConnectable specifying the remote address.
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback
   */
  void connectAsync(SocketConnectable connectable, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_socket_client_connect_async(cast(GSocketClient*)cPtr, connectable ? cast(GSocketConnectable*)(cast(ObjectG)connectable).cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an async connect operation. See [Gio.SocketClient.connectAsync]
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_finish(cast(GSocketClient*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This is a helper function for [Gio.SocketClient.connect].
   * Attempts to create a TCP connection to the named host.
   * host_and_port may be in any of a number of recognized formats; an IPv6
   * address, an IPv4 address, or a domain name $(LPAREN)in which case a DNS
   * lookup is performed$(RPAREN).  Quoting with [] is supported for all address
   * types.  A port override may be specified in the usual way with a
   * colon.  Ports may be given as decimal numbers or symbolic names $(LPAREN)in
   * which case an /etc/services lookup is performed$(RPAREN).
   * If no port override is given in host_and_port then default_port will be
   * used as the port number to connect to.
   * In general, host_and_port is expected to be provided by the user $(LPAREN)allowing
   * them to give the hostname, and a port override if necessary$(RPAREN) and
   * default_port is expected to be provided by the application.
   * In the case that an IP address is given, a single connection
   * attempt is made.  In the case that a name is given, multiple
   * connection attempts may be made, in turn and according to the
   * number of address records in DNS, until a connection succeeds.
   * Upon a successful connection, a new #GSocketConnection is constructed
   * and returned.  The caller owns this new object and must drop their
   * reference to it when finished with it.
   * In the event of any failure $(LPAREN)DNS error, service not found, no hosts
   * connectable$(RPAREN) %NULL is returned and error $(LPAREN)if non-%NULL$(RPAREN) is set
   * accordingly.
   * Params:
   *   hostAndPort = the name and optionally port of the host to connect to
   *   defaultPort = the default port to connect to
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToHost(string hostAndPort, ushort defaultPort, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    const(char)* _hostAndPort = hostAndPort.toCString(false);
    GError *_err;
    _cretval = g_socket_client_connect_to_host(cast(GSocketClient*)cPtr, _hostAndPort, defaultPort, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This is the asynchronous version of [Gio.SocketClient.connectToHost].
   * When the operation is finished callback will be
   * called. You can then call [Gio.SocketClient.connectToHostFinish] to get
   * the result of the operation.
   * Params:
   *   hostAndPort = the name and optionally the port of the host to connect to
   *   defaultPort = the default port to connect to
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback
   */
  void connectToHostAsync(string hostAndPort, ushort defaultPort, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _hostAndPort = hostAndPort.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_socket_client_connect_to_host_async(cast(GSocketClient*)cPtr, _hostAndPort, defaultPort, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an async connect operation. See [Gio.SocketClient.connectToHostAsync]
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToHostFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_to_host_finish(cast(GSocketClient*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Attempts to create a TCP connection to a service.
   * This call looks up the SRV record for service at domain for the
   * "tcp" protocol.  It then attempts to connect, in turn, to each of
   * the hosts providing the service until either a connection succeeds
   * or there are no hosts remaining.
   * Upon a successful connection, a new #GSocketConnection is constructed
   * and returned.  The caller owns this new object and must drop their
   * reference to it when finished with it.
   * In the event of any failure $(LPAREN)DNS error, service not found, no hosts
   * connectable$(RPAREN) %NULL is returned and error $(LPAREN)if non-%NULL$(RPAREN) is set
   * accordingly.
   * Params:
   *   domain = a domain name
   *   service = the name of the service to connect to
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a #GSocketConnection if successful, or %NULL on error
   */
  SocketConnection connectToService(string domain, string service, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    const(char)* _domain = domain.toCString(false);
    const(char)* _service = service.toCString(false);
    GError *_err;
    _cretval = g_socket_client_connect_to_service(cast(GSocketClient*)cPtr, _domain, _service, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This is the asynchronous version of
   * [Gio.SocketClient.connectToService].
   * Params:
   *   domain = a domain name
   *   service = the name of the service to connect to
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback
   */
  void connectToServiceAsync(string domain, string service, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _domain = domain.toCString(false);
    const(char)* _service = service.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_socket_client_connect_to_service_async(cast(GSocketClient*)cPtr, _domain, _service, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an async connect operation. See [Gio.SocketClient.connectToServiceAsync]
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToServiceFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_to_service_finish(cast(GSocketClient*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This is a helper function for [Gio.SocketClient.connect].
   * Attempts to create a TCP connection with a network URI.
   * uri may be any valid URI containing an "authority" $(LPAREN)hostname/port$(RPAREN)
   * component. If a port is not specified in the URI, default_port
   * will be used. TLS will be negotiated if #GSocketClient:tls is %TRUE.
   * $(LPAREN)#GSocketClient does not know to automatically assume TLS for
   * certain URI schemes.$(RPAREN)
   * Using this rather than [Gio.SocketClient.connect] or
   * [Gio.SocketClient.connectToHost] allows #GSocketClient to
   * determine when to use application-specific proxy protocols.
   * Upon a successful connection, a new #GSocketConnection is constructed
   * and returned.  The caller owns this new object and must drop their
   * reference to it when finished with it.
   * In the event of any failure $(LPAREN)DNS error, service not found, no hosts
   * connectable$(RPAREN) %NULL is returned and error $(LPAREN)if non-%NULL$(RPAREN) is set
   * accordingly.
   * Params:
   *   uri = A network URI
   *   defaultPort = the default port to connect to
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToUri(string uri, ushort defaultPort, Cancellable cancellable)
  {
    GSocketConnection* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_socket_client_connect_to_uri(cast(GSocketClient*)cPtr, _uri, defaultPort, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This is the asynchronous version of [Gio.SocketClient.connectToUri].
   * When the operation is finished callback will be
   * called. You can then call [Gio.SocketClient.connectToUriFinish] to get
   * the result of the operation.
   * Params:
   *   uri = a network uri
   *   defaultPort = the default port to connect to
   *   cancellable = a #GCancellable, or %NULL
   *   callback = a #GAsyncReadyCallback
   */
  void connectToUriAsync(string uri, ushort defaultPort, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _uri = uri.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_socket_client_connect_to_uri_async(cast(GSocketClient*)cPtr, _uri, defaultPort, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an async connect operation. See [Gio.SocketClient.connectToUriAsync]
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #GSocketConnection on success, %NULL on error.
   */
  SocketConnection connectToUriFinish(AsyncResult result)
  {
    GSocketConnection* _cretval;
    GError *_err;
    _cretval = g_socket_client_connect_to_uri_finish(cast(GSocketClient*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the proxy enable state; see [Gio.SocketClient.setEnableProxy]
   * Returns: whether proxying is enabled
   */
  bool getEnableProxy()
  {
    bool _retval;
    _retval = g_socket_client_get_enable_proxy(cast(GSocketClient*)cPtr);
    return _retval;
  }

  /**
   * Gets the socket family of the socket client.
   * See [Gio.SocketClient.setFamily] for details.
   * Returns: a #GSocketFamily
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_socket_client_get_family(cast(GSocketClient*)cPtr);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * Gets the local address of the socket client.
   * See [Gio.SocketClient.setLocalAddress] for details.
   * Returns: a #GSocketAddress or %NULL. Do not free.
   */
  SocketAddress getLocalAddress()
  {
    GSocketAddress* _cretval;
    _cretval = g_socket_client_get_local_address(cast(GSocketClient*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the protocol name type of the socket client.
   * See [Gio.SocketClient.setProtocol] for details.
   * Returns: a #GSocketProtocol
   */
  SocketProtocol getProtocol()
  {
    GSocketProtocol _cretval;
    _cretval = g_socket_client_get_protocol(cast(GSocketClient*)cPtr);
    SocketProtocol _retval = cast(SocketProtocol)_cretval;
    return _retval;
  }

  /**
   * Gets the #GProxyResolver being used by client. Normally, this will
   * be the resolver returned by [Gio.ProxyResolver.getDefault], but you
   * can override it with [Gio.SocketClient.setProxyResolver].
   * Returns: The #GProxyResolver being used by
   *   client.
   */
  ProxyResolver getProxyResolver()
  {
    GProxyResolver* _cretval;
    _cretval = g_socket_client_get_proxy_resolver(cast(GSocketClient*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ProxyResolver(cast(GProxyResolver*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the socket type of the socket client.
   * See [Gio.SocketClient.setSocketType] for details.
   * Returns: a #GSocketFamily
   */
  SocketType getSocketType()
  {
    GSocketType _cretval;
    _cretval = g_socket_client_get_socket_type(cast(GSocketClient*)cPtr);
    SocketType _retval = cast(SocketType)_cretval;
    return _retval;
  }

  /**
   * Gets the I/O timeout time for sockets created by client.
   * See [Gio.SocketClient.setTimeout] for details.
   * Returns: the timeout in seconds
   */
  uint getTimeout()
  {
    uint _retval;
    _retval = g_socket_client_get_timeout(cast(GSocketClient*)cPtr);
    return _retval;
  }

  /**
   * Gets whether client creates TLS connections. See
   * [Gio.SocketClient.setTls] for details.
   * Returns: whether client uses TLS
   */
  bool getTls()
  {
    bool _retval;
    _retval = g_socket_client_get_tls(cast(GSocketClient*)cPtr);
    return _retval;
  }

  /**
   * Gets the TLS validation flags used creating TLS connections via
   * client.
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GSocketClient:tls-validation-flags for more
   * information.
   * Returns: the TLS validation flags

   * Deprecated: Do not attempt to ignore validation errors.
   */
  TlsCertificateFlags getTlsValidationFlags()
  {
    GTlsCertificateFlags _cretval;
    _cretval = g_socket_client_get_tls_validation_flags(cast(GSocketClient*)cPtr);
    TlsCertificateFlags _retval = cast(TlsCertificateFlags)_cretval;
    return _retval;
  }

  /**
   * Sets whether or not client attempts to make connections via a
   * proxy server. When enabled $(LPAREN)the default$(RPAREN), #GSocketClient will use a
   * #GProxyResolver to determine if a proxy protocol such as SOCKS is
   * needed, and automatically do the necessary proxy negotiation.
   * See also [Gio.SocketClient.setProxyResolver].
   * Params:
   *   enable = whether to enable proxies
   */
  void setEnableProxy(bool enable)
  {
    g_socket_client_set_enable_proxy(cast(GSocketClient*)cPtr, enable);
  }

  /**
   * Sets the socket family of the socket client.
   * If this is set to something other than %G_SOCKET_FAMILY_INVALID
   * then the sockets created by this object will be of the specified
   * family.
   * This might be useful for instance if you want to force the local
   * connection to be an ipv4 socket, even though the address might
   * be an ipv6 mapped to ipv4 address.
   * Params:
   *   family = a #GSocketFamily
   */
  void setFamily(SocketFamily family)
  {
    g_socket_client_set_family(cast(GSocketClient*)cPtr, family);
  }

  /**
   * Sets the local address of the socket client.
   * The sockets created by this object will bound to the
   * specified address $(LPAREN)if not %NULL$(RPAREN) before connecting.
   * This is useful if you want to ensure that the local
   * side of the connection is on a specific port, or on
   * a specific interface.
   * Params:
   *   address = a #GSocketAddress, or %NULL
   */
  void setLocalAddress(SocketAddress address)
  {
    g_socket_client_set_local_address(cast(GSocketClient*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null);
  }

  /**
   * Sets the protocol of the socket client.
   * The sockets created by this object will use of the specified
   * protocol.
   * If protocol is %G_SOCKET_PROTOCOL_DEFAULT that means to use the default
   * protocol for the socket family and type.
   * Params:
   *   protocol = a #GSocketProtocol
   */
  void setProtocol(SocketProtocol protocol)
  {
    g_socket_client_set_protocol(cast(GSocketClient*)cPtr, protocol);
  }

  /**
   * Overrides the #GProxyResolver used by client. You can call this if
   * you want to use specific proxies, rather than using the system
   * default proxy settings.
   * Note that whether or not the proxy resolver is actually used
   * depends on the setting of #GSocketClient:enable-proxy, which is not
   * changed by this function $(LPAREN)but which is %TRUE by default$(RPAREN)
   * Params:
   *   proxyResolver = a #GProxyResolver, or %NULL for the
   *     default.
   */
  void setProxyResolver(ProxyResolver proxyResolver)
  {
    g_socket_client_set_proxy_resolver(cast(GSocketClient*)cPtr, proxyResolver ? cast(GProxyResolver*)(cast(ObjectG)proxyResolver).cPtr(false) : null);
  }

  /**
   * Sets the socket type of the socket client.
   * The sockets created by this object will be of the specified
   * type.
   * It doesn't make sense to specify a type of %G_SOCKET_TYPE_DATAGRAM,
   * as GSocketClient is used for connection oriented services.
   * Params:
   *   type = a #GSocketType
   */
  void setSocketType(SocketType type)
  {
    g_socket_client_set_socket_type(cast(GSocketClient*)cPtr, type);
  }

  /**
   * Sets the I/O timeout for sockets created by client. timeout is a
   * time in seconds, or 0 for no timeout $(LPAREN)the default$(RPAREN).
   * The timeout value affects the initial connection attempt as well,
   * so setting this may cause calls to [Gio.SocketClient.connect], etc,
   * to fail with %G_IO_ERROR_TIMED_OUT.
   * Params:
   *   timeout = the timeout
   */
  void setTimeout(uint timeout)
  {
    g_socket_client_set_timeout(cast(GSocketClient*)cPtr, timeout);
  }

  /**
   * Sets whether client creates TLS $(LPAREN)aka SSL$(RPAREN) connections. If tls is
   * %TRUE, client will wrap its connections in a #GTlsClientConnection
   * and perform a TLS handshake when connecting.
   * Note that since #GSocketClient must return a #GSocketConnection,
   * but #GTlsClientConnection is not a #GSocketConnection, this
   * actually wraps the resulting #GTlsClientConnection in a
   * #GTcpWrapperConnection when returning it. You can use
   * [Gio.TcpWrapperConnection.getBaseIoStream] on the return value
   * to extract the #GTlsClientConnection.
   * If you need to modify the behavior of the TLS handshake $(LPAREN)eg, by
   * setting a client-side certificate to use, or connecting to the
   * #GTlsConnection::accept-certificate signal$(RPAREN), you can connect to
   * client's #GSocketClient::event signal and wait for it to be
   * emitted with %G_SOCKET_CLIENT_TLS_HANDSHAKING, which will give you
   * a chance to see the #GTlsClientConnection before the handshake
   * starts.
   * Params:
   *   tls = whether to use TLS
   */
  void setTls(bool tls)
  {
    g_socket_client_set_tls(cast(GSocketClient*)cPtr, tls);
  }

  /**
   * Sets the TLS validation flags used when creating TLS connections
   * via client. The default value is %G_TLS_CERTIFICATE_VALIDATE_ALL.
   * This function does not work as originally designed and is impossible
   * to use correctly. See #GSocketClient:tls-validation-flags for more
   * information.
   * Params:
   *   flags = the validation flags

   * Deprecated: Do not attempt to ignore validation errors.
   */
  void setTlsValidationFlags(TlsCertificateFlags flags)
  {
    g_socket_client_set_tls_validation_flags(cast(GSocketClient*)cPtr, flags);
  }

  /**
   * Emitted when client's activity on connectable changes state.
   * Among other things, this can be used to provide progress
   * information about a network connection in the UI. The meanings of
   * the different event values are as follows:
   * - %G_SOCKET_CLIENT_RESOLVING: client is about to look up connectable
   * in DNS. connection will be %NULL.
   * - %G_SOCKET_CLIENT_RESOLVED:  client has successfully resolved
   * connectable in DNS. connection will be %NULL.
   * - %G_SOCKET_CLIENT_CONNECTING: client is about to make a connection
   * to a remote host; either a proxy server or the destination server
   * itself. connection is the #GSocketConnection, which is not yet
   * connected.  Since GLib 2.40, you can access the remote
   * address via [Gio.SocketConnection.getRemoteAddress].
   * - %G_SOCKET_CLIENT_CONNECTED: client has successfully connected
   * to a remote host. connection is the connected #GSocketConnection.
   * - %G_SOCKET_CLIENT_PROXY_NEGOTIATING: client is about to negotiate
   * with a proxy to get it to connect to connectable. connection is
   * the #GSocketConnection to the proxy server.
   * - %G_SOCKET_CLIENT_PROXY_NEGOTIATED: client has negotiated a
   * connection to connectable through a proxy server. connection is
   * the stream returned from [Gio.Proxy.connect], which may or may not
   * be a #GSocketConnection.
   * - %G_SOCKET_CLIENT_TLS_HANDSHAKING: client is about to begin a TLS
   * handshake. connection is a #GTlsClientConnection.
   * - %G_SOCKET_CLIENT_TLS_HANDSHAKED: client has successfully completed
   * the TLS handshake. connection is a #GTlsClientConnection.
   * - %G_SOCKET_CLIENT_COMPLETE: client has either successfully connected
   * to connectable $(LPAREN)in which case connection is the #GSocketConnection
   * that it will be returning to the caller$(RPAREN) or has failed $(LPAREN)in which
   * case connection is %NULL and the client is about to return an error$(RPAREN).
   * Each event except %G_SOCKET_CLIENT_COMPLETE may be emitted
   * multiple times $(LPAREN)or not at all$(RPAREN) for a given connectable $(LPAREN)in
   * particular, if client ends up attempting to connect to more than
   * one address$(RPAREN). However, if client emits the #GSocketClient::event
   * signal at all for a given connectable, then it will always emit
   * it with %G_SOCKET_CLIENT_COMPLETE when it is done.
   * Note that there may be additional #GSocketClientEvent values in
   * the future; unrecognized event values should be ignored.
   * Params
   *   event = the event that is occurring
   *   connectable = the #GSocketConnectable that event is occurring on
   *   connection = the current representation of the connection
   *   socketClient = the instance the signal is connected to
   */
  alias EventCallback = void delegate(SocketClientEvent event, SocketConnectable connectable, IOStream connection, SocketClient socketClient);

  /**
   * Connect to Event signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectEvent(EventCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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

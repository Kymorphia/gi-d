module Gio.Socket;

import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import Gid.gid;
import Gio.Cancellable;
import Gio.Credentials;
import Gio.DatagramBased;
import Gio.DatagramBasedT;
import Gio.InetAddress;
import Gio.Initable;
import Gio.InitableT;
import Gio.InputMessage;
import Gio.OutputMessage;
import Gio.SocketAddress;
import Gio.SocketConnection;
import Gio.SocketControlMessage;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GSocket` is a low-level networking primitive. It is a more or less
 * direct mapping of the BSD socket API in a portable GObject based API.
 * It supports both the UNIX socket implementations and winsock2 on Windows.
 * `GSocket` is the platform independent base upon which the higher level
 * network primitives are based. Applications are not typically meant to
 * use it directly, but rather through classes like [Gio.SocketClient],
 * [Gio.SocketService] and [Gio.SocketConnection]. However there may
 * be cases where direct use of `GSocket` is useful.
 * `GSocket` implements the [Gio.Initable] interface, so if it is manually
 * constructed by e.g. [GObject.ObjectG.new_] you must call
 * [Gio.Initable.init_] and check the results before using the object.
 * This is done automatically in [Gio.Socket.new_] and
 * [Gio.Socket.newFromFd], so these functions can return `NULL`.
 * Sockets operate in two general modes, blocking or non-blocking. When
 * in blocking mode all operations $(LPAREN)which don’t take an explicit blocking
 * parameter$(RPAREN) block until the requested operation
 * is finished or there is an error. In non-blocking mode all calls that
 * would block return immediately with a `G_IO_ERROR_WOULD_BLOCK` error.
 * To know when a call would successfully run you can call
 * [Gio.Socket.conditionCheck], or [Gio.Socket.conditionWait].
 * You can also use [Gio.Socket.createSource] and attach it to a
 * [GLib.MainContext] to get callbacks when I/O is possible.
 * Note that all sockets are always set to non blocking mode in the system, and
 * blocking mode is emulated in `GSocket`.
 * When working in non-blocking mode applications should always be able to
 * handle getting a `G_IO_ERROR_WOULD_BLOCK` error even when some other
 * function said that I/O was possible. This can easily happen in case
 * of a race condition in the application, but it can also happen for other
 * reasons. For instance, on Windows a socket is always seen as writable
 * until a write returns `G_IO_ERROR_WOULD_BLOCK`.
 * `GSocket`s can be either connection oriented or datagram based.
 * For connection oriented types you must first establish a connection by
 * either connecting to an address or accepting a connection from another
 * address. For connectionless socket types the target/source address is
 * specified or received in each I/O operation.
 * All socket file descriptors are set to be close-on-exec.
 * Note that creating a `GSocket` causes the signal `SIGPIPE` to be
 * ignored for the remainder of the program. If you are writing a
 * command-line utility that uses `GSocket`, you may need to take into
 * account the fact that your program will not automatically be killed
 * if it tries to write to `stdout` after it has been closed.
 * Like most other APIs in GLib, `GSocket` is not inherently thread safe. To use
 * a `GSocket` concurrently from multiple threads, you must implement your own
 * locking.
 * ## Nagle’s algorithm
 * Since GLib 2.80, `GSocket` will automatically set the `TCP_NODELAY` option on
 * all `G_SOCKET_TYPE_STREAM` sockets. This disables
 * [Nagle’s algorithm](https://en.wikipedia.org/wiki/Nagle%27s_algorithm) as it
 * typically does more harm than good on modern networks.
 * If your application needs Nagle’s algorithm enabled, call
 * [Gio.Socket.setOption] after constructing a `GSocket` to enable it:
 * ```c
 * socket \= g_socket_new $(LPAREN)…, G_SOCKET_TYPE_STREAM, …$(RPAREN);
 * if $(LPAREN)socket !\= NULL$(RPAREN)
 * {
 * g_socket_set_option $(LPAREN)socket, IPPROTO_TCP, TCP_NODELAY, FALSE, &local_error$(RPAREN);
 * // handle error if needed
 * }
 * ```
 */
class Socket : ObjectG, DatagramBased, Initable
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin DatagramBasedT!();
  mixin InitableT!();

  /**
   * Creates a new #GSocket with the defined family, type and protocol.
   * If protocol is 0 $(LPAREN)%G_SOCKET_PROTOCOL_DEFAULT$(RPAREN) the default protocol type
   * for the family and type is used.
   * The protocol is a family and type specific int that specifies what
   * kind of protocol to use. #GSocketProtocol lists several common ones.
   * Many families only support one protocol, and use 0 for this, others
   * support several and using 0 means to use the default protocol for
   * the family and type.
   * The protocol id is passed directly to the operating
   * system, so you can use protocols not listed in #GSocketProtocol if you
   * know the protocol number used for it.
   * Params:
   *   family = the socket family to use, e.g. %G_SOCKET_FAMILY_IPV4.
   *   type = the socket type to use.
   *   protocol = the id of the protocol to use, or 0 for default.
   * Returns: a #GSocket or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  this(SocketFamily family, SocketType type, SocketProtocol protocol)
  {
    GSocket* _cretval;
    GError *_err;
    _cretval = g_socket_new(family, type, protocol, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, true);
  }

  /**
   * Creates a new #GSocket from a native file descriptor
   * or winsock SOCKET handle.
   * This reads all the settings from the file descriptor so that
   * all properties should work. Note that the file descriptor
   * will be set to non-blocking mode, independent on the blocking
   * mode of the #GSocket.
   * On success, the returned #GSocket takes ownership of fd. On failure, the
   * caller must close fd themselves.
   * Since GLib 2.46, it is no longer a fatal error to call this on a non-socket
   * descriptor.  Instead, a GError will be set with code %G_IO_ERROR_FAILED
   * Params:
   *   fd = a native socket file descriptor.
   * Returns: a #GSocket or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  static Socket newFromFd(int fd)
  {
    GSocket* _cretval;
    GError *_err;
    _cretval = g_socket_new_from_fd(fd, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Accept incoming connections on a connection-based socket. This removes
   * the first outstanding connection request from the listening socket and
   * creates a #GSocket object for it.
   * The socket must be bound to a local address with [Gio.Socket.bind] and
   * must be listening for incoming connections $(LPAREN)[Gio.Socket.listen]$(RPAREN).
   * If there are no outstanding connections then the operation will block
   * or return %G_IO_ERROR_WOULD_BLOCK if non-blocking I/O is enabled.
   * To be notified of an incoming connection, wait for the %G_IO_IN condition.
   * Params:
   *   cancellable = a %GCancellable or %NULL
   * Returns: a new #GSocket, or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  Socket accept(Cancellable cancellable)
  {
    GSocket* _cretval;
    GError *_err;
    _cretval = g_socket_accept(cast(GSocket*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true) : null;
    return _retval;
  }

  /**
   * When a socket is created it is attached to an address family, but it
   * doesn't have an address in this family. [Gio.Socket.bind] assigns the
   * address $(LPAREN)sometimes called name$(RPAREN) of the socket.
   * It is generally required to bind to a local address before you can
   * receive connections. $(LPAREN)See [Gio.Socket.listen] and [Gio.Socket.accept] $(RPAREN).
   * In certain situations, you may also want to bind a socket that will be
   * used to initiate connections, though this is not normally required.
   * If socket is a TCP socket, then allow_reuse controls the setting
   * of the `SO_REUSEADDR` socket option; normally it should be %TRUE for
   * server sockets $(LPAREN)sockets that you will eventually call
   * [Gio.Socket.accept] on$(RPAREN), and %FALSE for client sockets. $(LPAREN)Failing to
   * set this flag on a server socket may cause [Gio.Socket.bind] to return
   * %G_IO_ERROR_ADDRESS_IN_USE if the server program is stopped and then
   * immediately restarted.$(RPAREN)
   * If socket is a UDP socket, then allow_reuse determines whether or
   * not other UDP sockets can be bound to the same address at the same
   * time. In particular, you can have several UDP sockets bound to the
   * same address, and they will all receive all of the multicast and
   * broadcast packets sent to that address. $(LPAREN)The behavior of unicast
   * UDP packets to an address with multiple listeners is not defined.$(RPAREN)
   * Params:
   *   address = a #GSocketAddress specifying the local address.
   *   allowReuse = whether to allow reusing this address
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool bind(SocketAddress address, bool allowReuse)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_bind(cast(GSocket*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, allowReuse, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Checks and resets the pending connect error for the socket.
   * This is used to check for errors when [Gio.Socket.connect] is
   * used in non-blocking mode.
   * Returns: %TRUE if no error, %FALSE otherwise, setting error to the error
   */
  bool checkConnectResult()
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_check_connect_result(cast(GSocket*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Closes the socket, shutting down any active connection.
   * Closing a socket does not wait for all outstanding I/O operations
   * to finish, so the caller should not rely on them to be guaranteed
   * to complete even if the close returns with no error.
   * Once the socket is closed, all other operations will return
   * %G_IO_ERROR_CLOSED. Closing a socket multiple times will not
   * return an error.
   * Sockets will be automatically closed when the last reference
   * is dropped, but you might want to call this function to make sure
   * resources are released as early as possible.
   * Beware that due to the way that TCP works, it is possible for
   * recently-sent data to be lost if either you close a socket while the
   * %G_IO_IN condition is set, or else if the remote connection tries to
   * send something to you after you close the socket but before it has
   * finished reading all of the data you sent. There is no easy generic
   * way to avoid this problem; the easiest fix is to design the network
   * protocol such that the client will never send data "out of turn".
   * Another solution is for the server to half-close the connection by
   * calling [Gio.Socket.shutdown] with only the shutdown_write flag set,
   * and then wait for the client to notice this and close its side of the
   * connection, after which the server can safely call [Gio.Socket.close].
   * $(LPAREN)This is what #GTcpConnection does if you call
   * [Gio.TcpConnection.setGracefulDisconnect]. But of course, this
   * only works if the client will close its connection after the server
   * does.$(RPAREN)
   * Returns: %TRUE on success, %FALSE on error
   */
  bool close()
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_close(cast(GSocket*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Checks on the readiness of socket to perform operations.
   * The operations specified in condition are checked for and masked
   * against the currently-satisfied conditions on socket. The result
   * is returned.
   * Note that on Windows, it is possible for an operation to return
   * %G_IO_ERROR_WOULD_BLOCK even immediately after
   * [Gio.Socket.conditionCheck] has claimed that the socket is ready for
   * writing. Rather than calling [Gio.Socket.conditionCheck] and then
   * writing to the socket if it succeeds, it is generally better to
   * simply try writing to the socket right away, and try again later if
   * the initial attempt returns %G_IO_ERROR_WOULD_BLOCK.
   * It is meaningless to specify %G_IO_ERR or %G_IO_HUP in condition;
   * these conditions will always be set in the output if they are true.
   * This call never blocks.
   * Params:
   *   condition = a #GIOCondition mask to check
   * Returns: the GIOCondition mask of the current state
   */
  IOCondition conditionCheck(IOCondition condition)
  {
    GIOCondition _cretval;
    _cretval = g_socket_condition_check(cast(GSocket*)cPtr, condition);
    IOCondition _retval = cast(IOCondition)_cretval;
    return _retval;
  }

  /**
   * Waits for up to timeout_us microseconds for condition to become true
   * on socket. If the condition is met, %TRUE is returned.
   * If cancellable is cancelled before the condition is met, or if
   * timeout_us $(LPAREN)or the socket's #GSocket:timeout$(RPAREN) is reached before the
   * condition is met, then %FALSE is returned and error, if non-%NULL,
   * is set to the appropriate value $(LPAREN)%G_IO_ERROR_CANCELLED or
   * %G_IO_ERROR_TIMED_OUT$(RPAREN).
   * If you don't want a timeout, use [Gio.Socket.conditionWait].
   * $(LPAREN)Alternatively, you can pass -1 for timeout_us.$(RPAREN)
   * Note that although timeout_us is in microseconds for consistency with
   * other GLib APIs, this function actually only has millisecond
   * resolution, and the behavior is undefined if timeout_us is not an
   * exact number of milliseconds.
   * Params:
   *   condition = a #GIOCondition mask to wait for
   *   timeoutUs = the maximum time $(LPAREN)in microseconds$(RPAREN) to wait, or -1
   *   cancellable = a #GCancellable, or %NULL
   * Returns: %TRUE if the condition was met, %FALSE otherwise
   */
  bool conditionTimedWait(IOCondition condition, long timeoutUs, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_condition_timed_wait(cast(GSocket*)cPtr, condition, timeoutUs, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Waits for condition to become true on socket. When the condition
   * is met, %TRUE is returned.
   * If cancellable is cancelled before the condition is met, or if the
   * socket has a timeout set and it is reached before the condition is
   * met, then %FALSE is returned and error, if non-%NULL, is set to
   * the appropriate value $(LPAREN)%G_IO_ERROR_CANCELLED or
   * %G_IO_ERROR_TIMED_OUT$(RPAREN).
   * See also [Gio.Socket.conditionTimedWait].
   * Params:
   *   condition = a #GIOCondition mask to wait for
   *   cancellable = a #GCancellable, or %NULL
   * Returns: %TRUE if the condition was met, %FALSE otherwise
   */
  bool conditionWait(IOCondition condition, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_condition_wait(cast(GSocket*)cPtr, condition, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Connect the socket to the specified remote address.
   * For connection oriented socket this generally means we attempt to make
   * a connection to the address. For a connection-less socket it sets
   * the default address for [Gio.Socket.send] and discards all incoming datagrams
   * from other sources.
   * Generally connection oriented sockets can only connect once, but
   * connection-less sockets can connect multiple times to change the
   * default address.
   * If the connect call needs to do network I/O it will block, unless
   * non-blocking I/O is enabled. Then %G_IO_ERROR_PENDING is returned
   * and the user can be notified of the connection finishing by waiting
   * for the G_IO_OUT condition. The result of the connection must then be
   * checked with [Gio.Socket.checkConnectResult].
   * Params:
   *   address = a #GSocketAddress specifying the remote address.
   *   cancellable = a %GCancellable or %NULL
   * Returns: %TRUE if connected, %FALSE on error.
   */
  bool connect(SocketAddress address, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_connect(cast(GSocket*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Creates a #GSocketConnection subclass of the right type for
   * socket.
   * Returns: a #GSocketConnection
   */
  SocketConnection connectionFactoryCreateConnection()
  {
    GSocketConnection* _cretval;
    _cretval = g_socket_connection_factory_create_connection(cast(GSocket*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Get the amount of data pending in the OS input buffer, without blocking.
   * If socket is a UDP or SCTP socket, this will return the size of
   * just the next packet, even if additional packets are buffered after
   * that one.
   * Note that on Windows, this function is rather inefficient in the
   * UDP case, and so if you know any plausible upper bound on the size
   * of the incoming packet, it is better to just do a
   * [Gio.Socket.receive] with a buffer of that size, rather than calling
   * [Gio.Socket.getAvailableBytes] first and then doing a receive of
   * exactly the right size.
   * Returns: the number of bytes that can be read from the socket
   *   without blocking or truncating, or -1 on error.
   */
  ptrdiff_t getAvailableBytes()
  {
    ptrdiff_t _retval;
    _retval = g_socket_get_available_bytes(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Gets the blocking mode of the socket. For details on blocking I/O,
   * see [Gio.Socket.setBlocking].
   * Returns: %TRUE if blocking I/O is used, %FALSE otherwise.
   */
  bool getBlocking()
  {
    bool _retval;
    _retval = g_socket_get_blocking(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Gets the broadcast setting on socket; if %TRUE,
   * it is possible to send packets to broadcast
   * addresses.
   * Returns: the broadcast setting on socket
   */
  bool getBroadcast()
  {
    bool _retval;
    _retval = g_socket_get_broadcast(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Returns the credentials of the foreign process connected to this
   * socket, if any $(LPAREN)e.g. it is only supported for %G_SOCKET_FAMILY_UNIX
   * sockets$(RPAREN).
   * If this operation isn't supported on the OS, the method fails with
   * the %G_IO_ERROR_NOT_SUPPORTED error. On Linux this is implemented
   * by reading the %SO_PEERCRED option on the underlying socket.
   * This method can be expected to be available on the following platforms:
   * - Linux since GLib 2.26
   * - OpenBSD since GLib 2.30
   * - Solaris, Illumos and OpenSolaris since GLib 2.40
   * - NetBSD since GLib 2.42
   * - macOS, tvOS, iOS since GLib 2.66
   * Other ways to obtain credentials from a foreign peer includes the
   * #GUnixCredentialsMessage type and
   * [Gio.UnixConnection.sendCredentials] /
   * [Gio.UnixConnection.receiveCredentials] functions.
   * Returns: %NULL if error is set, otherwise a #GCredentials object
   *   that must be freed with [GObject.ObjectG.unref].
   */
  Credentials getCredentials()
  {
    GCredentials* _cretval;
    GError *_err;
    _cretval = g_socket_get_credentials(cast(GSocket*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the socket family of the socket.
   * Returns: a #GSocketFamily
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_socket_get_family(cast(GSocket*)cPtr);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * Returns the underlying OS socket object. On unix this
   * is a socket file descriptor, and on Windows this is
   * a Winsock2 SOCKET handle. This may be useful for
   * doing platform specific or otherwise unusual operations
   * on the socket.
   * Returns: the file descriptor of the socket.
   */
  int getFd()
  {
    int _retval;
    _retval = g_socket_get_fd(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Gets the keepalive mode of the socket. For details on this,
   * see [Gio.Socket.setKeepalive].
   * Returns: %TRUE if keepalive is active, %FALSE otherwise.
   */
  bool getKeepalive()
  {
    bool _retval;
    _retval = g_socket_get_keepalive(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Gets the listen backlog setting of the socket. For details on this,
   * see [Gio.Socket.setListenBacklog].
   * Returns: the maximum number of pending connections.
   */
  int getListenBacklog()
  {
    int _retval;
    _retval = g_socket_get_listen_backlog(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Try to get the local address of a bound socket. This is only
   * useful if the socket has been bound to a local address,
   * either explicitly or implicitly when connecting.
   * Returns: a #GSocketAddress or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  SocketAddress getLocalAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_get_local_address(cast(GSocket*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the multicast loopback setting on socket; if %TRUE $(LPAREN)the
   * default$(RPAREN), outgoing multicast packets will be looped back to
   * multicast listeners on the same host.
   * Returns: the multicast loopback setting on socket
   */
  bool getMulticastLoopback()
  {
    bool _retval;
    _retval = g_socket_get_multicast_loopback(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Gets the multicast time-to-live setting on socket; see
   * [Gio.Socket.setMulticastTtl] for more details.
   * Returns: the multicast time-to-live setting on socket
   */
  uint getMulticastTtl()
  {
    uint _retval;
    _retval = g_socket_get_multicast_ttl(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of an integer-valued option on socket, as with
   * getsockopt$(LPAREN)$(RPAREN). $(LPAREN)If you need to fetch a  non-integer-valued option,
   * you will need to call getsockopt$(LPAREN)$(RPAREN) directly.$(RPAREN)
   * The [<gio/gnetworking.h>][gio-gnetworking.h]
   * header pulls in system headers that will define most of the
   * standard/portable socket options. For unusual socket protocols or
   * platform-dependent options, you may need to include additional
   * headers.
   * Note that even for socket options that are a single byte in size,
   * value is still a pointer to a #gint variable, not a #guchar;
   * [Gio.Socket.getOption] will handle the conversion internally.
   * Params:
   *   level = the "API level" of the option $(LPAREN)eg, `SOL_SOCKET`$(RPAREN)
   *   optname = the "name" of the option $(LPAREN)eg, `SO_BROADCAST`$(RPAREN)
   *   value = return location for the option value
   * Returns: success or failure. On failure, error will be set, and
   *   the system error value $(LPAREN)`errno` or WSAGetLastError$(LPAREN)$(RPAREN)$(RPAREN) will still
   *   be set to the result of the getsockopt$(LPAREN)$(RPAREN) call.
   */
  bool getOption(int level, int optname, out int value)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_get_option(cast(GSocket*)cPtr, level, optname, cast(int*)&value, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the socket protocol id the socket was created with.
   * In case the protocol is unknown, -1 is returned.
   * Returns: a protocol id, or -1 if unknown
   */
  SocketProtocol getProtocol()
  {
    GSocketProtocol _cretval;
    _cretval = g_socket_get_protocol(cast(GSocket*)cPtr);
    SocketProtocol _retval = cast(SocketProtocol)_cretval;
    return _retval;
  }

  /**
   * Try to get the remote address of a connected socket. This is only
   * useful for connection oriented sockets that have been connected.
   * Returns: a #GSocketAddress or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  SocketAddress getRemoteAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_get_remote_address(cast(GSocket*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the socket type of the socket.
   * Returns: a #GSocketType
   */
  SocketType getSocketType()
  {
    GSocketType _cretval;
    _cretval = g_socket_get_socket_type(cast(GSocket*)cPtr);
    SocketType _retval = cast(SocketType)_cretval;
    return _retval;
  }

  /**
   * Gets the timeout setting of the socket. For details on this, see
   * [Gio.Socket.setTimeout].
   * Returns: the timeout in seconds
   */
  uint getTimeout()
  {
    uint _retval;
    _retval = g_socket_get_timeout(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Gets the unicast time-to-live setting on socket; see
   * [Gio.Socket.setTtl] for more details.
   * Returns: the time-to-live setting on socket
   */
  uint getTtl()
  {
    uint _retval;
    _retval = g_socket_get_ttl(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Checks whether a socket is closed.
   * Returns: %TRUE if socket is closed, %FALSE otherwise
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_socket_is_closed(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Check whether the socket is connected. This is only useful for
   * connection-oriented sockets.
   * If using [Gio.Socket.shutdown], this function will return %TRUE until the
   * socket has been shut down for reading and writing. If you do a non-blocking
   * connect, this function will not return %TRUE until after you call
   * [Gio.Socket.checkConnectResult].
   * Returns: %TRUE if socket is connected, %FALSE otherwise.
   */
  bool isConnected()
  {
    bool _retval;
    _retval = g_socket_is_connected(cast(GSocket*)cPtr);
    return _retval;
  }

  /**
   * Registers socket to receive multicast messages sent to group.
   * socket must be a %G_SOCKET_TYPE_DATAGRAM socket, and must have
   * been bound to an appropriate interface and port with
   * [Gio.Socket.bind].
   * If iface is %NULL, the system will automatically pick an interface
   * to bind to based on group.
   * If source_specific is %TRUE, source-specific multicast as defined
   * in RFC 4604 is used. Note that on older platforms this may fail
   * with a %G_IO_ERROR_NOT_SUPPORTED error.
   * To bind to a given source-specific multicast address, use
   * [Gio.Socket.joinMulticastGroupSsm] instead.
   * Params:
   *   group = a #GInetAddress specifying the group address to join.
   *   sourceSpecific = %TRUE if source-specific multicast should be used
   *   iface = Name of the interface to use, or %NULL
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool joinMulticastGroup(InetAddress group, bool sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_join_multicast_group(cast(GSocket*)cPtr, group ? cast(GInetAddress*)group.cPtr(false) : null, sourceSpecific, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Registers socket to receive multicast messages sent to group.
   * socket must be a %G_SOCKET_TYPE_DATAGRAM socket, and must have
   * been bound to an appropriate interface and port with
   * [Gio.Socket.bind].
   * If iface is %NULL, the system will automatically pick an interface
   * to bind to based on group.
   * If source_specific is not %NULL, use source-specific multicast as
   * defined in RFC 4604. Note that on older platforms this may fail
   * with a %G_IO_ERROR_NOT_SUPPORTED error.
   * Note that this function can be called multiple times for the same
   * group with different source_specific in order to receive multicast
   * packets from more than one source.
   * Params:
   *   group = a #GInetAddress specifying the group address to join.
   *   sourceSpecific = a #GInetAddress specifying the
   *     source-specific multicast address or %NULL to ignore.
   *   iface = Name of the interface to use, or %NULL
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool joinMulticastGroupSsm(InetAddress group, InetAddress sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_join_multicast_group_ssm(cast(GSocket*)cPtr, group ? cast(GInetAddress*)group.cPtr(false) : null, sourceSpecific ? cast(GInetAddress*)sourceSpecific.cPtr(false) : null, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes socket from the multicast group defined by group, iface,
   * and source_specific $(LPAREN)which must all have the same values they had
   * when you joined the group$(RPAREN).
   * socket remains bound to its address and port, and can still receive
   * unicast messages after calling this.
   * To unbind to a given source-specific multicast address, use
   * [Gio.Socket.leaveMulticastGroupSsm] instead.
   * Params:
   *   group = a #GInetAddress specifying the group address to leave.
   *   sourceSpecific = %TRUE if source-specific multicast was used
   *   iface = Interface used
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool leaveMulticastGroup(InetAddress group, bool sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_leave_multicast_group(cast(GSocket*)cPtr, group ? cast(GInetAddress*)group.cPtr(false) : null, sourceSpecific, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes socket from the multicast group defined by group, iface,
   * and source_specific $(LPAREN)which must all have the same values they had
   * when you joined the group$(RPAREN).
   * socket remains bound to its address and port, and can still receive
   * unicast messages after calling this.
   * Params:
   *   group = a #GInetAddress specifying the group address to leave.
   *   sourceSpecific = a #GInetAddress specifying the
   *     source-specific multicast address or %NULL to ignore.
   *   iface = Name of the interface to use, or %NULL
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool leaveMulticastGroupSsm(InetAddress group, InetAddress sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_leave_multicast_group_ssm(cast(GSocket*)cPtr, group ? cast(GInetAddress*)group.cPtr(false) : null, sourceSpecific ? cast(GInetAddress*)sourceSpecific.cPtr(false) : null, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Marks the socket as a server socket, i.e. a socket that is used
   * to accept incoming requests using [Gio.Socket.accept].
   * Before calling this the socket must be bound to a local address using
   * [Gio.Socket.bind].
   * To set the maximum amount of outstanding clients, use
   * [Gio.Socket.setListenBacklog].
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool listen()
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_listen(cast(GSocket*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Receive data $(LPAREN)up to size bytes$(RPAREN) from a socket. This is mainly used by
   * connection-oriented sockets; it is identical to [Gio.Socket.receiveFrom]
   * with address set to %NULL.
   * For %G_SOCKET_TYPE_DATAGRAM and %G_SOCKET_TYPE_SEQPACKET sockets,
   * [Gio.Socket.receive] will always read either 0 or 1 complete messages from
   * the socket. If the received message is too large to fit in buffer, then
   * the data beyond size bytes will be discarded, without any explicit
   * indication that this has occurred.
   * For %G_SOCKET_TYPE_STREAM sockets, [Gio.Socket.receive] can return any
   * number of bytes, up to size. If more than size bytes have been
   * received, the additional data will be returned in future calls to
   * [Gio.Socket.receive].
   * If the socket is in blocking mode the call will block until there
   * is some data to receive, the connection is closed, or there is an
   * error. If there is no data available and the socket is in
   * non-blocking mode, a %G_IO_ERROR_WOULD_BLOCK error will be
   * returned. To be notified when data is available, wait for the
   * %G_IO_IN condition.
   * On error -1 is returned and error is set accordingly.
   * Params:
   *   buffer = a buffer to read data into $(LPAREN)which should be at least size bytes long$(RPAREN).
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes read, or 0 if the connection was closed by
   *   the peer, or -1 on error
   */
  ptrdiff_t receive(ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _size;
    GError *_err;
    _retval = g_socket_receive(cast(GSocket*)cPtr, buffer.ptr, _size, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Receive data $(LPAREN)up to size bytes$(RPAREN) from a socket.
   * If address is non-%NULL then address will be set equal to the
   * source address of the received packet.
   * address is owned by the caller.
   * See [Gio.Socket.receive] for additional information.
   * Params:
   *   address = a pointer to a #GSocketAddress
   *     pointer, or %NULL
   *   buffer = a buffer to read data into $(LPAREN)which should be at least size bytes long$(RPAREN).
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes read, or 0 if the connection was closed by
   *   the peer, or -1 on error
   */
  ptrdiff_t receiveFrom(out SocketAddress address, ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GSocketAddress* _address;
    size_t _size;
    GError *_err;
    _retval = g_socket_receive_from(cast(GSocket*)cPtr, &_address, buffer.ptr, _size, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    address = new SocketAddress(cast(void*)_address, true);
    return _retval;
  }

  /**
   * Receive data from a socket.  For receiving multiple messages, see
   * [Gio.Socket.receiveMessages]; for easier use, see
   * [Gio.Socket.receive] and [Gio.Socket.receiveFrom].
   * If address is non-%NULL then address will be set equal to the
   * source address of the received packet.
   * address is owned by the caller.
   * vector must point to an array of #GInputVector structs and
   * num_vectors must be the length of this array.  These structs
   * describe the buffers that received data will be scattered into.
   * If num_vectors is -1, then vectors is assumed to be terminated
   * by a #GInputVector with a %NULL buffer pointer.
   * As a special case, if num_vectors is 0 $(LPAREN)in which case, vectors
   * may of course be %NULL$(RPAREN), then a single byte is received and
   * discarded. This is to facilitate the common practice of sending a
   * single '\0' byte for the purposes of transferring ancillary data.
   * messages, if non-%NULL, will be set to point to a newly-allocated
   * array of #GSocketControlMessage instances or %NULL if no such
   * messages was received. These correspond to the control messages
   * received from the kernel, one #GSocketControlMessage per message
   * from the kernel. This array is %NULL-terminated and must be freed
   * by the caller using [GLib.Global.gfree] after calling [GObject.ObjectG.unref] on each
   * element. If messages is %NULL, any control messages received will
   * be discarded.
   * num_messages, if non-%NULL, will be set to the number of control
   * messages received.
   * If both messages and num_messages are non-%NULL, then
   * num_messages gives the number of #GSocketControlMessage instances
   * in messages $(LPAREN)ie: not including the %NULL terminator$(RPAREN).
   * flags is an in/out parameter. The commonly available arguments
   * for this are available in the #GSocketMsgFlags enum, but the
   * values there are the same as the system values, and the flags
   * are passed in as-is, so you can pass in system-specific flags too
   * $(LPAREN)and [Gio.Socket.receiveMessage] may pass system-specific flags out$(RPAREN).
   * Flags passed in to the parameter affect the receive operation; flags returned
   * out of it are relevant to the specific returned message.
   * As with [Gio.Socket.receive], data may be discarded if socket is
   * %G_SOCKET_TYPE_DATAGRAM or %G_SOCKET_TYPE_SEQPACKET and you do not
   * provide enough buffer space to read a complete message. You can pass
   * %G_SOCKET_MSG_PEEK in flags to peek at the current message without
   * removing it from the receive queue, but there is no portable way to find
   * out the length of the message other than by reading it into a
   * sufficiently-large buffer.
   * If the socket is in blocking mode the call will block until there
   * is some data to receive, the connection is closed, or there is an
   * error. If there is no data available and the socket is in
   * non-blocking mode, a %G_IO_ERROR_WOULD_BLOCK error will be
   * returned. To be notified when data is available, wait for the
   * %G_IO_IN condition.
   * On error -1 is returned and error is set accordingly.
   * Params:
   *   address = a pointer to a #GSocketAddress
   *     pointer, or %NULL
   *   vectors = an array of #GInputVector structs
   *   messages = a pointer
   *     which may be filled with an array of #GSocketControlMessages, or %NULL
   *   flags = a pointer to an int containing #GSocketMsgFlags flags,
   *     which may additionally contain
   *     [other platform specific flags](http://man7.org/linux/man-pages/man2/recv.2.html)
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes read, or 0 if the connection was closed by
   *   the peer, or -1 on error
   */
  ptrdiff_t receiveMessage(out SocketAddress address, InputVector[] vectors, out SocketControlMessage[] messages, ref int flags, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GSocketAddress* _address;
    int _numVectors;
    if (vectors)
      _numVectors = cast(int)vectors.length;

    auto _vectors = cast(GInputVector*)vectors.ptr;
    int _numMessages;
    GSocketControlMessage** _messages;
    GError *_err;
    _retval = g_socket_receive_message(cast(GSocket*)cPtr, &_address, _vectors, _numVectors, &_messages, &_numMessages, cast(int*)&flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    address = new SocketAddress(cast(void*)_address, true);
    messages.length = _numMessages;
    foreach (i; 0 .. _numMessages)
      messages[i] = ObjectG.getDObject!SocketControlMessage(_messages[i], true);
    safeFree(cast(void*)_messages);
    return _retval;
  }

  /**
   * Receive multiple data messages from socket in one go.  This is the most
   * complicated and fully-featured version of this call. For easier use, see
   * [Gio.Socket.receive], [Gio.Socket.receiveFrom], and [Gio.Socket.receiveMessage].
   * messages must point to an array of #GInputMessage structs and
   * num_messages must be the length of this array. Each #GInputMessage
   * contains a pointer to an array of #GInputVector structs describing the
   * buffers that the data received in each message will be written to. Using
   * multiple #GInputVectors is more memory-efficient than manually copying data
   * out of a single buffer to multiple sources, and more system-call-efficient
   * than making multiple calls to [Gio.Socket.receive], such as in scenarios where
   * a lot of data packets need to be received $(LPAREN)e.g. high-bandwidth video
   * streaming over RTP/UDP$(RPAREN).
   * flags modify how all messages are received. The commonly available
   * arguments for this are available in the #GSocketMsgFlags enum, but the
   * values there are the same as the system values, and the flags
   * are passed in as-is, so you can pass in system-specific flags too. These
   * flags affect the overall receive operation. Flags affecting individual
   * messages are returned in #GInputMessage.flags.
   * The other members of #GInputMessage are treated as described in its
   * documentation.
   * If #GSocket:blocking is %TRUE the call will block until num_messages have
   * been received, or the end of the stream is reached.
   * If #GSocket:blocking is %FALSE the call will return up to num_messages
   * without blocking, or %G_IO_ERROR_WOULD_BLOCK if no messages are queued in the
   * operating system to be received.
   * In blocking mode, if #GSocket:timeout is positive and is reached before any
   * messages are received, %G_IO_ERROR_TIMED_OUT is returned, otherwise up to
   * num_messages are returned. $(LPAREN)Note: This is effectively the
   * behaviour of `MSG_WAITFORONE` with recvmmsg$(LPAREN)$(RPAREN).$(RPAREN)
   * To be notified when messages are available, wait for the
   * %G_IO_IN condition. Note though that you may still receive
   * %G_IO_ERROR_WOULD_BLOCK from [Gio.Socket.receiveMessages] even if you were
   * previously notified of a %G_IO_IN condition.
   * If the remote peer closes the connection, any messages queued in the
   * operating system will be returned, and subsequent calls to
   * [Gio.Socket.receiveMessages] will return 0 (with no error set).
   * On error -1 is returned and error is set accordingly. An error will only
   * be returned if zero messages could be received; otherwise the number of
   * messages successfully received before the error will be returned.
   * Params:
   *   messages = an array of #GInputMessage structs
   *   flags = an int containing #GSocketMsgFlags flags for the overall operation,
   *     which may additionally contain
   *     [other platform specific flags](http://man7.org/linux/man-pages/man2/recv.2.html)
   *   cancellable = a %GCancellable or %NULL
   * Returns: number of messages received, or -1 on error. Note that the number
   *   of messages received may be smaller than num_messages if in non-blocking
   *   mode, if the peer closed the connection, or if num_messages
   *   was larger than `UIO_MAXIOV` $(LPAREN)1024$(RPAREN), in which case the caller may re-try
   *   to receive the remaining messages.
   */
  int receiveMessages(InputMessage[] messages, int flags, Cancellable cancellable)
  {
    int _retval;
    uint _numMessages;
    if (messages)
      _numMessages = cast(uint)messages.length;

    GInputMessage[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj.cInstance;
    GInputMessage* _messages = _tmpmessages.ptr;

    GError *_err;
    _retval = g_socket_receive_messages(cast(GSocket*)cPtr, _messages, _numMessages, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * This behaves exactly the same as [Gio.Socket.receive], except that
   * the choice of blocking or non-blocking behavior is determined by
   * the blocking argument rather than by socket's properties.
   * Params:
   *   buffer = a buffer to read data into $(LPAREN)which should be at least size bytes long$(RPAREN).
   *   blocking = whether to do blocking or non-blocking I/O
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes read, or 0 if the connection was closed by
   *   the peer, or -1 on error
   */
  ptrdiff_t receiveWithBlocking(ref ubyte[] buffer, bool blocking, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _size;
    GError *_err;
    _retval = g_socket_receive_with_blocking(cast(GSocket*)cPtr, buffer.ptr, _size, blocking, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to send size bytes from buffer on the socket. This is
   * mainly used by connection-oriented sockets; it is identical to
   * [Gio.Socket.sendTo] with address set to %NULL.
   * If the socket is in blocking mode the call will block until there is
   * space for the data in the socket queue. If there is no space available
   * and the socket is in non-blocking mode a %G_IO_ERROR_WOULD_BLOCK error
   * will be returned. To be notified when space is available, wait for the
   * %G_IO_OUT condition. Note though that you may still receive
   * %G_IO_ERROR_WOULD_BLOCK from [Gio.Socket.send] even if you were previously
   * notified of a %G_IO_OUT condition. $(LPAREN)On Windows in particular, this is
   * very common due to the way the underlying APIs work.$(RPAREN)
   * On error -1 is returned and error is set accordingly.
   * Params:
   *   buffer = the buffer
   *     containing the data to send.
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes written $(LPAREN)which may be less than size$(RPAREN), or -1
   *   on error
   */
  ptrdiff_t send(ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _size;
    if (buffer)
      _size = cast(size_t)buffer.length;

    auto _buffer = cast(const(ubyte)*)buffer.ptr;
    GError *_err;
    _retval = g_socket_send(cast(GSocket*)cPtr, _buffer, _size, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Send data to address on socket.  For sending multiple messages see
   * [Gio.Socket.sendMessages]; for easier use, see
   * [Gio.Socket.send] and [Gio.Socket.sendTo].
   * If address is %NULL then the message is sent to the default receiver
   * $(LPAREN)set by [Gio.Socket.connect]$(RPAREN).
   * vectors must point to an array of #GOutputVector structs and
   * num_vectors must be the length of this array. $(LPAREN)If num_vectors is -1,
   * then vectors is assumed to be terminated by a #GOutputVector with a
   * %NULL buffer pointer.$(RPAREN) The #GOutputVector structs describe the buffers
   * that the sent data will be gathered from. Using multiple
   * #GOutputVectors is more memory-efficient than manually copying
   * data from multiple sources into a single buffer, and more
   * network-efficient than making multiple calls to [Gio.Socket.send].
   * messages, if non-%NULL, is taken to point to an array of num_messages
   * #GSocketControlMessage instances. These correspond to the control
   * messages to be sent on the socket.
   * If num_messages is -1 then messages is treated as a %NULL-terminated
   * array.
   * flags modify how the message is sent. The commonly available arguments
   * for this are available in the #GSocketMsgFlags enum, but the
   * values there are the same as the system values, and the flags
   * are passed in as-is, so you can pass in system-specific flags too.
   * If the socket is in blocking mode the call will block until there is
   * space for the data in the socket queue. If there is no space available
   * and the socket is in non-blocking mode a %G_IO_ERROR_WOULD_BLOCK error
   * will be returned. To be notified when space is available, wait for the
   * %G_IO_OUT condition. Note though that you may still receive
   * %G_IO_ERROR_WOULD_BLOCK from [Gio.Socket.send] even if you were previously
   * notified of a %G_IO_OUT condition. $(LPAREN)On Windows in particular, this is
   * very common due to the way the underlying APIs work.$(RPAREN)
   * The sum of the sizes of each #GOutputVector in vectors must not be
   * greater than %G_MAXSSIZE. If the message can be larger than this,
   * then it is mandatory to use the [Gio.Socket.sendMessageWithTimeout]
   * function.
   * On error -1 is returned and error is set accordingly.
   * Params:
   *   address = a #GSocketAddress, or %NULL
   *   vectors = an array of #GOutputVector structs
   *   messages = a pointer to an
   *     array of #GSocketControlMessages, or %NULL.
   *   flags = an int containing #GSocketMsgFlags flags, which may additionally
   *     contain [other platform specific flags](http://man7.org/linux/man-pages/man2/recv.2.html)
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes written $(LPAREN)which may be less than size$(RPAREN), or -1
   *   on error
   */
  ptrdiff_t sendMessage(SocketAddress address, OutputVector[] vectors, SocketControlMessage[] messages, int flags, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    int _numVectors;
    if (vectors)
      _numVectors = cast(int)vectors.length;

    auto _vectors = cast(GOutputVector*)vectors.ptr;
    int _numMessages;
    if (messages)
      _numMessages = cast(int)messages.length;

    GSocketControlMessage*[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj ? cast(GSocketControlMessage*)obj.cPtr : null;
    GSocketControlMessage** _messages = cast(GSocketControlMessage**)_tmpmessages.ptr;

    GError *_err;
    _retval = g_socket_send_message(cast(GSocket*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, _vectors, _numVectors, _messages, _numMessages, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * This behaves exactly the same as [Gio.Socket.sendMessage], except that
   * the choice of timeout behavior is determined by the timeout_us argument
   * rather than by socket's properties.
   * On error %G_POLLABLE_RETURN_FAILED is returned and error is set accordingly, or
   * if the socket is currently not writable %G_POLLABLE_RETURN_WOULD_BLOCK is
   * returned. bytes_written will contain 0 in both cases.
   * Params:
   *   address = a #GSocketAddress, or %NULL
   *   vectors = an array of #GOutputVector structs
   *   messages = a pointer to an
   *     array of #GSocketControlMessages, or %NULL.
   *   flags = an int containing #GSocketMsgFlags flags, which may additionally
   *     contain [other platform specific flags](http://man7.org/linux/man-pages/man2/recv.2.html)
   *   timeoutUs = the maximum time $(LPAREN)in microseconds$(RPAREN) to wait, or -1
   *   bytesWritten = location to store the number of bytes that were written to the socket
   *   cancellable = a %GCancellable or %NULL
   * Returns: %G_POLLABLE_RETURN_OK if all data was successfully written,
   *   %G_POLLABLE_RETURN_WOULD_BLOCK if the socket is currently not writable, or
   *   %G_POLLABLE_RETURN_FAILED if an error happened and error is set.
   */
  PollableReturn sendMessageWithTimeout(SocketAddress address, OutputVector[] vectors, SocketControlMessage[] messages, int flags, long timeoutUs, out size_t bytesWritten, Cancellable cancellable)
  {
    GPollableReturn _cretval;
    int _numVectors;
    if (vectors)
      _numVectors = cast(int)vectors.length;

    auto _vectors = cast(const(GOutputVector)*)vectors.ptr;
    int _numMessages;
    if (messages)
      _numMessages = cast(int)messages.length;

    GSocketControlMessage*[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj ? cast(GSocketControlMessage*)obj.cPtr : null;
    GSocketControlMessage** _messages = cast(GSocketControlMessage**)_tmpmessages.ptr;

    GError *_err;
    _cretval = g_socket_send_message_with_timeout(cast(GSocket*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, _vectors, _numVectors, _messages, _numMessages, flags, timeoutUs, cast(size_t*)&bytesWritten, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    PollableReturn _retval = cast(PollableReturn)_cretval;
    return _retval;
  }

  /**
   * Send multiple data messages from socket in one go.  This is the most
   * complicated and fully-featured version of this call. For easier use, see
   * [Gio.Socket.send], [Gio.Socket.sendTo], and [Gio.Socket.sendMessage].
   * messages must point to an array of #GOutputMessage structs and
   * num_messages must be the length of this array. Each #GOutputMessage
   * contains an address to send the data to, and a pointer to an array of
   * #GOutputVector structs to describe the buffers that the data to be sent
   * for each message will be gathered from. Using multiple #GOutputVectors is
   * more memory-efficient than manually copying data from multiple sources
   * into a single buffer, and more network-efficient than making multiple
   * calls to [Gio.Socket.send]. Sending multiple messages in one go avoids the
   * overhead of making a lot of syscalls in scenarios where a lot of data
   * packets need to be sent $(LPAREN)e.g. high-bandwidth video streaming over RTP/UDP$(RPAREN),
   * or where the same data needs to be sent to multiple recipients.
   * flags modify how the message is sent. The commonly available arguments
   * for this are available in the #GSocketMsgFlags enum, but the
   * values there are the same as the system values, and the flags
   * are passed in as-is, so you can pass in system-specific flags too.
   * If the socket is in blocking mode the call will block until there is
   * space for all the data in the socket queue. If there is no space available
   * and the socket is in non-blocking mode a %G_IO_ERROR_WOULD_BLOCK error
   * will be returned if no data was written at all, otherwise the number of
   * messages sent will be returned. To be notified when space is available,
   * wait for the %G_IO_OUT condition. Note though that you may still receive
   * %G_IO_ERROR_WOULD_BLOCK from [Gio.Socket.send] even if you were previously
   * notified of a %G_IO_OUT condition. $(LPAREN)On Windows in particular, this is
   * very common due to the way the underlying APIs work.$(RPAREN)
   * On error -1 is returned and error is set accordingly. An error will only
   * be returned if zero messages could be sent; otherwise the number of messages
   * successfully sent before the error will be returned.
   * Params:
   *   messages = an array of #GOutputMessage structs
   *   flags = an int containing #GSocketMsgFlags flags, which may additionally
   *     contain [other platform specific flags](http://man7.org/linux/man-pages/man2/recv.2.html)
   *   cancellable = a %GCancellable or %NULL
   * Returns: number of messages sent, or -1 on error. Note that the number of
   *   messages sent may be smaller than num_messages if the socket is
   *   non-blocking or if num_messages was larger than UIO_MAXIOV $(LPAREN)1024$(RPAREN),
   *   in which case the caller may re-try to send the remaining messages.
   */
  int sendMessages(OutputMessage[] messages, int flags, Cancellable cancellable)
  {
    int _retval;
    uint _numMessages;
    if (messages)
      _numMessages = cast(uint)messages.length;

    GOutputMessage[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj.cInstance;
    GOutputMessage* _messages = _tmpmessages.ptr;

    GError *_err;
    _retval = g_socket_send_messages(cast(GSocket*)cPtr, _messages, _numMessages, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to send size bytes from buffer to address. If address is
   * %NULL then the message is sent to the default receiver $(LPAREN)set by
   * [Gio.Socket.connect]$(RPAREN).
   * See [Gio.Socket.send] for additional information.
   * Params:
   *   address = a #GSocketAddress, or %NULL
   *   buffer = the buffer
   *     containing the data to send.
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes written $(LPAREN)which may be less than size$(RPAREN), or -1
   *   on error
   */
  ptrdiff_t sendTo(SocketAddress address, ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _size;
    if (buffer)
      _size = cast(size_t)buffer.length;

    auto _buffer = cast(const(ubyte)*)buffer.ptr;
    GError *_err;
    _retval = g_socket_send_to(cast(GSocket*)cPtr, address ? cast(GSocketAddress*)address.cPtr(false) : null, _buffer, _size, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * This behaves exactly the same as [Gio.Socket.send], except that
   * the choice of blocking or non-blocking behavior is determined by
   * the blocking argument rather than by socket's properties.
   * Params:
   *   buffer = the buffer
   *     containing the data to send.
   *   blocking = whether to do blocking or non-blocking I/O
   *   cancellable = a %GCancellable or %NULL
   * Returns: Number of bytes written $(LPAREN)which may be less than size$(RPAREN), or -1
   *   on error
   */
  ptrdiff_t sendWithBlocking(ubyte[] buffer, bool blocking, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _size;
    if (buffer)
      _size = cast(size_t)buffer.length;

    auto _buffer = cast(const(ubyte)*)buffer.ptr;
    GError *_err;
    _retval = g_socket_send_with_blocking(cast(GSocket*)cPtr, _buffer, _size, blocking, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the blocking mode of the socket. In blocking mode
   * all operations $(LPAREN)which don’t take an explicit blocking parameter$(RPAREN) block until
   * they succeed or there is an error. In
   * non-blocking mode all functions return results immediately or
   * with a %G_IO_ERROR_WOULD_BLOCK error.
   * All sockets are created in blocking mode. However, note that the
   * platform level socket is always non-blocking, and blocking mode
   * is a GSocket level feature.
   * Params:
   *   blocking = Whether to use blocking I/O or not.
   */
  void setBlocking(bool blocking)
  {
    g_socket_set_blocking(cast(GSocket*)cPtr, blocking);
  }

  /**
   * Sets whether socket should allow sending to broadcast addresses.
   * This is %FALSE by default.
   * Params:
   *   broadcast = whether socket should allow sending to broadcast
   *     addresses
   */
  void setBroadcast(bool broadcast)
  {
    g_socket_set_broadcast(cast(GSocket*)cPtr, broadcast);
  }

  /**
   * Sets or unsets the %SO_KEEPALIVE flag on the underlying socket. When
   * this flag is set on a socket, the system will attempt to verify that the
   * remote socket endpoint is still present if a sufficiently long period of
   * time passes with no data being exchanged. If the system is unable to
   * verify the presence of the remote endpoint, it will automatically close
   * the connection.
   * This option is only functional on certain kinds of sockets. $(LPAREN)Notably,
   * %G_SOCKET_PROTOCOL_TCP sockets.$(RPAREN)
   * The exact time between pings is system- and protocol-dependent, but will
   * normally be at least two hours. Most commonly, you would set this flag
   * on a server socket if you want to allow clients to remain idle for long
   * periods of time, but also want to ensure that connections are eventually
   * garbage-collected if clients crash or become unreachable.
   * Params:
   *   keepalive = Value for the keepalive flag
   */
  void setKeepalive(bool keepalive)
  {
    g_socket_set_keepalive(cast(GSocket*)cPtr, keepalive);
  }

  /**
   * Sets the maximum number of outstanding connections allowed
   * when listening on this socket. If more clients than this are
   * connecting to the socket and the application is not handling them
   * on time then the new connections will be refused.
   * Note that this must be called before [Gio.Socket.listen] and has no
   * effect if called after that.
   * Params:
   *   backlog = the maximum number of pending connections.
   */
  void setListenBacklog(int backlog)
  {
    g_socket_set_listen_backlog(cast(GSocket*)cPtr, backlog);
  }

  /**
   * Sets whether outgoing multicast packets will be received by sockets
   * listening on that multicast address on the same host. This is %TRUE
   * by default.
   * Params:
   *   loopback = whether socket should receive messages sent to its
   *     multicast groups from the local host
   */
  void setMulticastLoopback(bool loopback)
  {
    g_socket_set_multicast_loopback(cast(GSocket*)cPtr, loopback);
  }

  /**
   * Sets the time-to-live for outgoing multicast datagrams on socket.
   * By default, this is 1, meaning that multicast packets will not leave
   * the local network.
   * Params:
   *   ttl = the time-to-live value for all multicast datagrams on socket
   */
  void setMulticastTtl(uint ttl)
  {
    g_socket_set_multicast_ttl(cast(GSocket*)cPtr, ttl);
  }

  /**
   * Sets the value of an integer-valued option on socket, as with
   * setsockopt$(LPAREN)$(RPAREN). $(LPAREN)If you need to set a non-integer-valued option,
   * you will need to call setsockopt$(LPAREN)$(RPAREN) directly.$(RPAREN)
   * The [<gio/gnetworking.h>][gio-gnetworking.h]
   * header pulls in system headers that will define most of the
   * standard/portable socket options. For unusual socket protocols or
   * platform-dependent options, you may need to include additional
   * headers.
   * Params:
   *   level = the "API level" of the option $(LPAREN)eg, `SOL_SOCKET`$(RPAREN)
   *   optname = the "name" of the option $(LPAREN)eg, `SO_BROADCAST`$(RPAREN)
   *   value = the value to set the option to
   * Returns: success or failure. On failure, error will be set, and
   *   the system error value $(LPAREN)`errno` or WSAGetLastError$(LPAREN)$(RPAREN)$(RPAREN) will still
   *   be set to the result of the setsockopt$(LPAREN)$(RPAREN) call.
   */
  bool setOption(int level, int optname, int value)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_set_option(cast(GSocket*)cPtr, level, optname, value, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the time in seconds after which I/O operations on socket will
   * time out if they have not yet completed.
   * On a blocking socket, this means that any blocking #GSocket
   * operation will time out after timeout seconds of inactivity,
   * returning %G_IO_ERROR_TIMED_OUT.
   * On a non-blocking socket, calls to [Gio.Socket.conditionWait] will
   * also fail with %G_IO_ERROR_TIMED_OUT after the given time. Sources
   * created with [Gio.Socket.createSource] will trigger after
   * timeout seconds of inactivity, with the requested condition
   * set, at which point calling [Gio.Socket.receive], [Gio.Socket.send],
   * [Gio.Socket.checkConnectResult], etc, will fail with
   * %G_IO_ERROR_TIMED_OUT.
   * If timeout is 0 $(LPAREN)the default$(RPAREN), operations will never time out
   * on their own.
   * Note that if an I/O operation is interrupted by a signal, this may
   * cause the timeout to be reset.
   * Params:
   *   timeout = the timeout for socket, in seconds, or 0 for none
   */
  void setTimeout(uint timeout)
  {
    g_socket_set_timeout(cast(GSocket*)cPtr, timeout);
  }

  /**
   * Sets the time-to-live for outgoing unicast packets on socket.
   * By default the platform-specific default value is used.
   * Params:
   *   ttl = the time-to-live value for all unicast packets on socket
   */
  void setTtl(uint ttl)
  {
    g_socket_set_ttl(cast(GSocket*)cPtr, ttl);
  }

  /**
   * Shut down part or all of a full-duplex connection.
   * If shutdown_read is %TRUE then the receiving side of the connection
   * is shut down, and further reading is disallowed.
   * If shutdown_write is %TRUE then the sending side of the connection
   * is shut down, and further writing is disallowed.
   * It is allowed for both shutdown_read and shutdown_write to be %TRUE.
   * One example where it is useful to shut down only one side of a connection is
   * graceful disconnect for TCP connections where you close the sending side,
   * then wait for the other side to close the connection, thus ensuring that the
   * other side saw all sent data.
   * Params:
   *   shutdownRead = whether to shut down the read side
   *   shutdownWrite = whether to shut down the write side
   * Returns: %TRUE on success, %FALSE on error
   */
  bool shutdown(bool shutdownRead, bool shutdownWrite)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_shutdown(cast(GSocket*)cPtr, shutdownRead, shutdownWrite, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Checks if a socket is capable of speaking IPv4.
   * IPv4 sockets are capable of speaking IPv4.  On some operating systems
   * and under some combinations of circumstances IPv6 sockets are also
   * capable of speaking IPv4.  See RFC 3493 section 3.7 for more
   * information.
   * No other types of sockets are currently considered as being capable
   * of speaking IPv4.
   * Returns: %TRUE if this socket can be used with IPv4.
   */
  bool speaksIpv4()
  {
    bool _retval;
    _retval = g_socket_speaks_ipv4(cast(GSocket*)cPtr);
    return _retval;
  }
}

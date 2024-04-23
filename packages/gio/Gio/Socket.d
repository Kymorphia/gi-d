module Gio.Socket;

import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
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
 * A #GSocket is a low-level networking primitive. It is a more or less
 * direct mapping of the BSD socket API in a portable GObject based API.
 * It supports both the UNIX socket implementations and winsock2 on Windows.
 *
 * #GSocket is the platform independent base upon which the higher level
 * network primitives are based. Applications are not typically meant to
 * use it directly, but rather through classes like #GSocketClient,
 * #GSocketService and #GSocketConnection. However there may be cases where
 * direct use of #GSocket is useful.
 *
 * #GSocket implements the #GInitable interface, so if it is manually constructed
 * by e.g. g_object_new() you must call g_initable_init() and check the
 * results before using the object. This is done automatically in
 * g_socket_new() and g_socket_new_from_fd(), so these functions can return
 * %NULL.
 *
 * Sockets operate in two general modes, blocking or non-blocking. When
 * in blocking mode all operations (which don’t take an explicit blocking
 * parameter) block until the requested operation
 * is finished or there is an error. In non-blocking mode all calls that
 * would block return immediately with a %G_IO_ERROR_WOULD_BLOCK error.
 * To know when a call would successfully run you can call g_socket_condition_check(),
 * or g_socket_condition_wait(). You can also use g_socket_create_source() and
 * attach it to a #GMainContext to get callbacks when I/O is possible.
 * Note that all sockets are always set to non blocking mode in the system, and
 * blocking mode is emulated in GSocket.
 *
 * When working in non-blocking mode applications should always be able to
 * handle getting a %G_IO_ERROR_WOULD_BLOCK error even when some other
 * function said that I/O was possible. This can easily happen in case
 * of a race condition in the application, but it can also happen for other
 * reasons. For instance, on Windows a socket is always seen as writable
 * until a write returns %G_IO_ERROR_WOULD_BLOCK.
 *
 * #GSockets can be either connection oriented or datagram based.
 * For connection oriented types you must first establish a connection by
 * either connecting to an address or accepting a connection from another
 * address. For connectionless socket types the target/source address is
 * specified or received in each I/O operation.
 *
 * All socket file descriptors are set to be close-on-exec.
 *
 * Note that creating a #GSocket causes the signal %SIGPIPE to be
 * ignored for the remainder of the program. If you are writing a
 * command-line utility that uses #GSocket, you may need to take into
 * account the fact that your program will not automatically be killed
 * if it tries to write to %stdout after it has been closed.
 *
 * Like most other APIs in GLib, #GSocket is not inherently thread safe. To use
 * a #GSocket concurrently from multiple threads, you must implement your own
 * locking.
 */
class Socket : ObjectG, DatagramBased, Initable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_get_type();
  }

  mixin DatagramBasedT!GSocket;
  mixin InitableT!GSocket;

  /**
   * a #GSocket or %NULL on error.
   * Free the returned object with g_object_unref().
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
   * a #GSocket or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  static Socket newFromFd(int fd)
  {
    GSocket* _cretval;
    GError *_err;
    _cretval = g_socket_new_from_fd(fd, &_err);
    if (_err)
      throw new ErrorG(_err);
    Socket _retval = ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GSocket, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  Socket accept(Cancellable cancellable)
  {
    GSocket* _cretval;
    GError *_err;
    _cretval = g_socket_accept(cPtr!GSocket, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Socket _retval = ObjectG.getDObject!Socket(cast(GSocket*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool bind(SocketAddress address, bool allowReuse)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_bind(cPtr!GSocket, address ? address.cPtr!GSocketAddress : null, allowReuse, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if no error, %FALSE otherwise, setting @error to the error
   */
  bool checkConnectResult()
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_check_connect_result(cPtr!GSocket, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error
   */
  bool close()
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_close(cPtr!GSocket, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the @GIOCondition mask of the current state
   */
  IOCondition conditionCheck(IOCondition condition)
  {
    GIOCondition _cretval;
    _cretval = g_socket_condition_check(cPtr!GSocket, condition);
    IOCondition _retval = cast(IOCondition)_cretval;
    return _retval;
  }

  /**
   * %TRUE if the condition was met, %FALSE otherwise
   */
  bool conditionTimedWait(IOCondition condition, long timeoutUs, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_condition_timed_wait(cPtr!GSocket, condition, timeoutUs, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the condition was met, %FALSE otherwise
   */
  bool conditionWait(IOCondition condition, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_condition_wait(cPtr!GSocket, condition, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if connected, %FALSE on error.
   */
  bool connect(SocketAddress address, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_connect(cPtr!GSocket, address ? address.cPtr!GSocketAddress : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GSocketConnection
   */
  SocketConnection connectionFactoryCreateConnection()
  {
    GSocketConnection* _cretval;
    _cretval = g_socket_connection_factory_create_connection(cPtr!GSocket);
    SocketConnection _retval = ObjectG.getDObject!SocketConnection(cast(GSocketConnection*)_cretval, true);
    return _retval;
  }

  /**
   * the number of bytes that can be read from the socket
   * without blocking or truncating, or -1 on error.
   */
  ptrdiff_t getAvailableBytes()
  {
    ptrdiff_t _retval;
    _retval = g_socket_get_available_bytes(cPtr!GSocket);
    return _retval;
  }

  /**
   * %TRUE if blocking I/O is used, %FALSE otherwise.
   */
  bool getBlocking()
  {
    bool _retval;
    _retval = g_socket_get_blocking(cPtr!GSocket);
    return _retval;
  }

  /**
   * the broadcast setting on @socket
   */
  bool getBroadcast()
  {
    bool _retval;
    _retval = g_socket_get_broadcast(cPtr!GSocket);
    return _retval;
  }

  /**
   * %NULL if @error is set, otherwise a #GCredentials object
   * that must be freed with g_object_unref().
   */
  Credentials getCredentials()
  {
    GCredentials* _cretval;
    GError *_err;
    _cretval = g_socket_get_credentials(cPtr!GSocket, &_err);
    if (_err)
      throw new ErrorG(_err);
    Credentials _retval = ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocketFamily
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_socket_get_family(cPtr!GSocket);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * the file descriptor of the socket.
   */
  int getFd()
  {
    int _retval;
    _retval = g_socket_get_fd(cPtr!GSocket);
    return _retval;
  }

  /**
   * %TRUE if keepalive is active, %FALSE otherwise.
   */
  bool getKeepalive()
  {
    bool _retval;
    _retval = g_socket_get_keepalive(cPtr!GSocket);
    return _retval;
  }

  /**
   * the maximum number of pending connections.
   */
  int getListenBacklog()
  {
    int _retval;
    _retval = g_socket_get_listen_backlog(cPtr!GSocket);
    return _retval;
  }

  /**
   * a #GSocketAddress or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  SocketAddress getLocalAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_get_local_address(cPtr!GSocket, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * the multicast loopback setting on @socket
   */
  bool getMulticastLoopback()
  {
    bool _retval;
    _retval = g_socket_get_multicast_loopback(cPtr!GSocket);
    return _retval;
  }

  /**
   * the multicast time-to-live setting on @socket
   */
  uint getMulticastTtl()
  {
    uint _retval;
    _retval = g_socket_get_multicast_ttl(cPtr!GSocket);
    return _retval;
  }

  /**
   * success or failure. On failure, @error will be set, and
   * the system error value (`errno` or WSAGetLastError()) will still
   * be set to the result of the getsockopt() call.
   */
  bool getOption(int level, int optname, out int value)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_get_option(cPtr!GSocket, level, optname, cast(int*)&value, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a protocol id, or -1 if unknown
   */
  SocketProtocol getProtocol()
  {
    GSocketProtocol _cretval;
    _cretval = g_socket_get_protocol(cPtr!GSocket);
    SocketProtocol _retval = cast(SocketProtocol)_cretval;
    return _retval;
  }

  /**
   * a #GSocketAddress or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  SocketAddress getRemoteAddress()
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_get_remote_address(cPtr!GSocket, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * a #GSocketType
   */
  SocketType getSocketType()
  {
    GSocketType _cretval;
    _cretval = g_socket_get_socket_type(cPtr!GSocket);
    SocketType _retval = cast(SocketType)_cretval;
    return _retval;
  }

  /**
   * the timeout in seconds
   */
  uint getTimeout()
  {
    uint _retval;
    _retval = g_socket_get_timeout(cPtr!GSocket);
    return _retval;
  }

  /**
   * the time-to-live setting on @socket
   */
  uint getTtl()
  {
    uint _retval;
    _retval = g_socket_get_ttl(cPtr!GSocket);
    return _retval;
  }

  /**
   * %TRUE if socket is closed, %FALSE otherwise
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_socket_is_closed(cPtr!GSocket);
    return _retval;
  }

  /**
   * %TRUE if socket is connected, %FALSE otherwise.
   */
  bool isConnected()
  {
    bool _retval;
    _retval = g_socket_is_connected(cPtr!GSocket);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool joinMulticastGroup(InetAddress group, bool sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_join_multicast_group(cPtr!GSocket, group ? group.cPtr!GInetAddress : null, sourceSpecific, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool joinMulticastGroupSsm(InetAddress group, InetAddress sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_join_multicast_group_ssm(cPtr!GSocket, group ? group.cPtr!GInetAddress : null, sourceSpecific ? sourceSpecific.cPtr!GInetAddress : null, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool leaveMulticastGroup(InetAddress group, bool sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_leave_multicast_group(cPtr!GSocket, group ? group.cPtr!GInetAddress : null, sourceSpecific, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool leaveMulticastGroupSsm(InetAddress group, InetAddress sourceSpecific, string iface)
  {
    bool _retval;
    const(char)* _iface = iface.toCString(false);
    GError *_err;
    _retval = g_socket_leave_multicast_group_ssm(cPtr!GSocket, group ? group.cPtr!GInetAddress : null, sourceSpecific ? sourceSpecific.cPtr!GInetAddress : null, _iface, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool listen()
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_listen(cPtr!GSocket, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes read, or 0 if the connection was closed by
   * the peer, or -1 on error
   */
  ptrdiff_t receive(ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_socket_receive(cPtr!GSocket, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes read, or 0 if the connection was closed by
   * the peer, or -1 on error
   */
  ptrdiff_t receiveFrom(out SocketAddress address, ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GSocketAddress* _address;
    GError *_err;
    _retval = g_socket_receive_from(cPtr!GSocket, &_address, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    address = new SocketAddress(cast(void*)_address, true);
    return _retval;
  }

  /**
   * Number of bytes read, or 0 if the connection was closed by
   * the peer, or -1 on error
   */
  ptrdiff_t receiveMessage(out SocketAddress address, InputVector[] vectors, out SocketControlMessage[] messages, inout int flags, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GSocketAddress* _address;
    auto _vectors = cast(GInputVector*)vectors.ptr;
    GSocketControlMessage** _messages;
    int _numMessages;
    GError *_err;
    _retval = g_socket_receive_message(cPtr!GSocket, &_address, _vectors, vectors ? cast(int)vectors.length : 0, &_messages, &_numMessages, cast(int*)&flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    address = new SocketAddress(cast(void*)_address, true);
    messages.length = _numMessages;
    foreach (i; 0 .. _numMessages)
      messages[i] = ObjectG.getDObject!SocketControlMessage(_messages[i], true);
    g_free(cast(void*)_messages);
    return _retval;
  }

  /**
   * number of messages received, or -1 on error. Note that the number
   * of messages received may be smaller than @num_messages if in non-blocking
   * mode, if the peer closed the connection, or if @num_messages
   * was larger than `UIO_MAXIOV` (1024), in which case the caller may re-try
   * to receive the remaining messages.
   */
  int receiveMessages(InputMessage[] messages, int flags, Cancellable cancellable)
  {
    int _retval;
    GInputMessage[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj.cInstance;
    GInputMessage* _messages = _tmpmessages.ptr;

    GError *_err;
    _retval = g_socket_receive_messages(cPtr!GSocket, _messages, messages ? cast(uint)messages.length : 0, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes read, or 0 if the connection was closed by
   * the peer, or -1 on error
   */
  ptrdiff_t receiveWithBlocking(ref ubyte[] buffer, bool blocking, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_socket_receive_with_blocking(cPtr!GSocket, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, blocking, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes written (which may be less than @size), or -1
   * on error
   */
  ptrdiff_t send(ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    auto _buffer = cast(const(ubyte)*)buffer.ptr;
    GError *_err;
    _retval = g_socket_send(cPtr!GSocket, _buffer, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes written (which may be less than @size), or -1
   * on error
   */
  ptrdiff_t sendMessage(SocketAddress address, OutputVector[] vectors, SocketControlMessage[] messages, int flags, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    auto _vectors = cast(GOutputVector*)vectors.ptr;
    GSocketControlMessage*[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj ? obj.cPtr!GSocketControlMessage : null;
    GSocketControlMessage** _messages = cast(GSocketControlMessage**)_tmpmessages.ptr;

    GError *_err;
    _retval = g_socket_send_message(cPtr!GSocket, address ? address.cPtr!GSocketAddress : null, _vectors, vectors ? cast(int)vectors.length : 0, _messages, messages ? cast(int)messages.length : 0, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %G_POLLABLE_RETURN_OK if all data was successfully written,
   * %G_POLLABLE_RETURN_WOULD_BLOCK if the socket is currently not writable, or
   * %G_POLLABLE_RETURN_FAILED if an error happened and @error is set.
   */
  PollableReturn sendMessageWithTimeout(SocketAddress address, OutputVector[] vectors, SocketControlMessage[] messages, int flags, long timeoutUs, out size_t bytesWritten, Cancellable cancellable)
  {
    GPollableReturn _cretval;
    auto _vectors = cast(const(GOutputVector)*)vectors.ptr;
    GSocketControlMessage*[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj ? obj.cPtr!GSocketControlMessage : null;
    GSocketControlMessage** _messages = cast(GSocketControlMessage**)_tmpmessages.ptr;

    GError *_err;
    _cretval = g_socket_send_message_with_timeout(cPtr!GSocket, address ? address.cPtr!GSocketAddress : null, _vectors, vectors ? cast(int)vectors.length : 0, _messages, messages ? cast(int)messages.length : 0, flags, timeoutUs, cast(size_t*)&bytesWritten, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    PollableReturn _retval = cast(PollableReturn)_cretval;
    return _retval;
  }

  /**
   * number of messages sent, or -1 on error. Note that the number of
   * messages sent may be smaller than @num_messages if the socket is
   * non-blocking or if @num_messages was larger than UIO_MAXIOV (1024),
   * in which case the caller may re-try to send the remaining messages.
   */
  int sendMessages(OutputMessage[] messages, int flags, Cancellable cancellable)
  {
    int _retval;
    GOutputMessage[] _tmpmessages;
    foreach (obj; messages)
      _tmpmessages ~= obj.cInstance;
    GOutputMessage* _messages = _tmpmessages.ptr;

    GError *_err;
    _retval = g_socket_send_messages(cPtr!GSocket, _messages, messages ? cast(uint)messages.length : 0, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes written (which may be less than @size), or -1
   * on error
   */
  ptrdiff_t sendTo(SocketAddress address, ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    auto _buffer = cast(const(ubyte)*)buffer.ptr;
    GError *_err;
    _retval = g_socket_send_to(cPtr!GSocket, address ? address.cPtr!GSocketAddress : null, _buffer, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes written (which may be less than @size), or -1
   * on error
   */
  ptrdiff_t sendWithBlocking(ubyte[] buffer, bool blocking, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    auto _buffer = cast(const(ubyte)*)buffer.ptr;
    GError *_err;
    _retval = g_socket_send_with_blocking(cPtr!GSocket, _buffer, buffer ? cast(size_t)buffer.length : 0, blocking, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the blocking mode of the socket. In blocking mode
   * all operations (which don’t take an explicit blocking parameter) block until
   * they succeed or there is an error. In
   * non-blocking mode all functions return results immediately or
   * with a %G_IO_ERROR_WOULD_BLOCK error.
   *
   * All sockets are created in blocking mode. However, note that the
   * platform level socket is always non-blocking, and blocking mode
   * is a GSocket level feature.
   */
  void setBlocking(bool blocking)
  {
    g_socket_set_blocking(cPtr!GSocket, blocking);
  }

  /**
   * Sets whether @socket should allow sending to broadcast addresses.
   * This is %FALSE by default.
   */
  void setBroadcast(bool broadcast)
  {
    g_socket_set_broadcast(cPtr!GSocket, broadcast);
  }

  /**
   * Sets or unsets the %SO_KEEPALIVE flag on the underlying socket. When
   * this flag is set on a socket, the system will attempt to verify that the
   * remote socket endpoint is still present if a sufficiently long period of
   * time passes with no data being exchanged. If the system is unable to
   * verify the presence of the remote endpoint, it will automatically close
   * the connection.
   *
   * This option is only functional on certain kinds of sockets. (Notably,
   * %G_SOCKET_PROTOCOL_TCP sockets.)
   *
   * The exact time between pings is system- and protocol-dependent, but will
   * normally be at least two hours. Most commonly, you would set this flag
   * on a server socket if you want to allow clients to remain idle for long
   * periods of time, but also want to ensure that connections are eventually
   * garbage-collected if clients crash or become unreachable.
   */
  void setKeepalive(bool keepalive)
  {
    g_socket_set_keepalive(cPtr!GSocket, keepalive);
  }

  /**
   * Sets the maximum number of outstanding connections allowed
   * when listening on this socket. If more clients than this are
   * connecting to the socket and the application is not handling them
   * on time then the new connections will be refused.
   *
   * Note that this must be called before g_socket_listen() and has no
   * effect if called after that.
   */
  void setListenBacklog(int backlog)
  {
    g_socket_set_listen_backlog(cPtr!GSocket, backlog);
  }

  /**
   * Sets whether outgoing multicast packets will be received by sockets
   * listening on that multicast address on the same host. This is %TRUE
   * by default.
   */
  void setMulticastLoopback(bool loopback)
  {
    g_socket_set_multicast_loopback(cPtr!GSocket, loopback);
  }

  /**
   * Sets the time-to-live for outgoing multicast datagrams on @socket.
   * By default, this is 1, meaning that multicast packets will not leave
   * the local network.
   */
  void setMulticastTtl(uint ttl)
  {
    g_socket_set_multicast_ttl(cPtr!GSocket, ttl);
  }

  /**
   * success or failure. On failure, @error will be set, and
   * the system error value (`errno` or WSAGetLastError()) will still
   * be set to the result of the setsockopt() call.
   */
  bool setOption(int level, int optname, int value)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_set_option(cPtr!GSocket, level, optname, value, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the time in seconds after which I/O operations on @socket will
   * time out if they have not yet completed.
   *
   * On a blocking socket, this means that any blocking #GSocket
   * operation will time out after @timeout seconds of inactivity,
   * returning %G_IO_ERROR_TIMED_OUT.
   *
   * On a non-blocking socket, calls to g_socket_condition_wait() will
   * also fail with %G_IO_ERROR_TIMED_OUT after the given time. Sources
   * created with g_socket_create_source() will trigger after
   * @timeout seconds of inactivity, with the requested condition
   * set, at which point calling g_socket_receive(), g_socket_send(),
   * g_socket_check_connect_result(), etc, will fail with
   * %G_IO_ERROR_TIMED_OUT.
   *
   * If @timeout is 0 (the default), operations will never time out
   * on their own.
   *
   * Note that if an I/O operation is interrupted by a signal, this may
   * cause the timeout to be reset.
   */
  void setTimeout(uint timeout)
  {
    g_socket_set_timeout(cPtr!GSocket, timeout);
  }

  /**
   * Sets the time-to-live for outgoing unicast packets on @socket.
   * By default the platform-specific default value is used.
   */
  void setTtl(uint ttl)
  {
    g_socket_set_ttl(cPtr!GSocket, ttl);
  }

  /**
   * %TRUE on success, %FALSE on error
   */
  bool shutdown(bool shutdownRead, bool shutdownWrite)
  {
    bool _retval;
    GError *_err;
    _retval = g_socket_shutdown(cPtr!GSocket, shutdownRead, shutdownWrite, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if this socket can be used with IPv4.
   */
  bool speaksIpv4()
  {
    bool _retval;
    _retval = g_socket_speaks_ipv4(cPtr!GSocket);
    return _retval;
  }
}

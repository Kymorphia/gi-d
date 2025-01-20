module Gio.UnixConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Credentials;
import Gio.SocketConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This is the subclass of [Gio.SocketConnection] that is created
 * for UNIX domain sockets.
 * It contains functions to do some of the UNIX socket specific
 * functionality like passing file descriptors.
 * Since GLib 2.72, `GUnixConnection` is available on all platforms. It requires
 * underlying system support $(LPAREN)such as Windows 10 with `AF_UNIX`$(RPAREN) at run time.
 * Before GLib 2.72, `<gio/gunixconnection.h>` belonged to the UNIX-specific GIO
 * interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file when
 * using it. This is no longer necessary since GLib 2.72.
 */
class UnixConnection : SocketConnection
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
    return g_unix_connection_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Receives credentials from the sending end of the connection.  The
   * sending end has to call [Gio.UnixConnection.sendCredentials] $(LPAREN)or
   * similar$(RPAREN) for this to work.
   * As well as reading the credentials this also reads $(LPAREN)and discards$(RPAREN) a
   * single byte from the stream, as this is required for credentials
   * passing to work on some implementations.
   * This method can be expected to be available on the following platforms:
   * - Linux since GLib 2.26
   * - FreeBSD since GLib 2.26
   * - GNU/kFreeBSD since GLib 2.36
   * - Solaris, Illumos and OpenSolaris since GLib 2.40
   * - GNU/Hurd since GLib 2.40
   * Other ways to exchange credentials with a foreign peer includes the
   * #GUnixCredentialsMessage type and [Gio.Socket.getCredentials] function.
   * Params:
   *   cancellable = A #GCancellable or %NULL.
   * Returns: Received credentials on success $(LPAREN)free with
   *   [GObject.ObjectG.unref]$(RPAREN), %NULL if error is set.
   */
  Credentials receiveCredentials(Cancellable cancellable)
  {
    GCredentials* _cretval;
    GError *_err;
    _cretval = g_unix_connection_receive_credentials(cast(GUnixConnection*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asynchronously receive credentials.
   * For more details, see [Gio.UnixConnection.receiveCredentials] which is
   * the synchronous version of this call.
   * When the operation is finished, callback will be called. You can then call
   * [Gio.UnixConnection.receiveCredentialsFinish] to get the result of the operation.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void receiveCredentialsAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_unix_connection_receive_credentials_async(cast(GUnixConnection*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous receive credentials operation started with
   * [Gio.UnixConnection.receiveCredentialsAsync].
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #GCredentials, or %NULL on error.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  Credentials receiveCredentialsFinish(AsyncResult result)
  {
    GCredentials* _cretval;
    GError *_err;
    _cretval = g_unix_connection_receive_credentials_finish(cast(GUnixConnection*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Receives a file descriptor from the sending end of the connection.
   * The sending end has to call [Gio.UnixConnection.sendFd] for this
   * to work.
   * As well as reading the fd this also reads a single byte from the
   * stream, as this is required for fd passing to work on some
   * implementations.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore
   * Returns: a file descriptor on success, -1 on error.
   */
  int receiveFd(Cancellable cancellable)
  {
    int _retval;
    GError *_err;
    _retval = g_unix_connection_receive_fd(cast(GUnixConnection*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Passes the credentials of the current user the receiving side
   * of the connection. The receiving end has to call
   * [Gio.UnixConnection.receiveCredentials] (or similar) to accept the
   * credentials.
   * As well as sending the credentials this also writes a single NUL
   * byte to the stream, as this is required for credentials passing to
   * work on some implementations.
   * This method can be expected to be available on the following platforms:
   * - Linux since GLib 2.26
   * - FreeBSD since GLib 2.26
   * - GNU/kFreeBSD since GLib 2.36
   * - Solaris, Illumos and OpenSolaris since GLib 2.40
   * - GNU/Hurd since GLib 2.40
   * Other ways to exchange credentials with a foreign peer includes the
   * #GUnixCredentialsMessage type and [Gio.Socket.getCredentials] function.
   * Params:
   *   cancellable = A #GCancellable or %NULL.
   * Returns: %TRUE on success, %FALSE if error is set.
   */
  bool sendCredentials(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_connection_send_credentials(cast(GUnixConnection*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously send credentials.
   * For more details, see [Gio.UnixConnection.sendCredentials] which is
   * the synchronous version of this call.
   * When the operation is finished, callback will be called. You can then call
   * [Gio.UnixConnection.sendCredentialsFinish] to get the result of the operation.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void sendCredentialsAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_unix_connection_send_credentials_async(cast(GUnixConnection*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous send credentials operation started with
   * [Gio.UnixConnection.sendCredentialsAsync].
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the operation was successful, otherwise %FALSE.
   */
  bool sendCredentialsFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_connection_send_credentials_finish(cast(GUnixConnection*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Passes a file descriptor to the receiving side of the
   * connection. The receiving end has to call [Gio.UnixConnection.receiveFd]
   * to accept the file descriptor.
   * As well as sending the fd this also writes a single byte to the
   * stream, as this is required for fd passing to work on some
   * implementations.
   * Params:
   *   fd = a file descriptor
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a %TRUE on success, %NULL on error.
   */
  bool sendFd(int fd, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_connection_send_fd(cast(GUnixConnection*)cPtr, fd, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

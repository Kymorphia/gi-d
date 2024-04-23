module Gio.UnixConnection;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Credentials;
import Gio.SocketConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This is the subclass of #GSocketConnection that is created
 * for UNIX domain sockets.
 *
 * It contains functions to do some of the UNIX socket specific
 * functionality like passing file descriptors.
 *
 * Since GLib 2.72, #GUnixConnection is available on all platforms. It requires
 * underlying system support (such as Windows 10 with `AF_UNIX`) at run time.
 *
 * Before GLib 2.72, `<gio/gunixconnection.h>` belonged to the UNIX-specific GIO
 * interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file when
 * using it. This is no longer necessary since GLib 2.72.
 */
class UnixConnection : SocketConnection
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_unix_connection_get_type();
  }

  /**
   * Received credentials on success (free with
   * g_object_unref()), %NULL if @error is set.
   */
  Credentials receiveCredentials(Cancellable cancellable)
  {
    GCredentials* _cretval;
    GError *_err;
    _cretval = g_unix_connection_receive_credentials(cPtr!GUnixConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Credentials _retval = ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously receive credentials.
   *
   * For more details, see g_unix_connection_receive_credentials() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called. You can then call
   * g_unix_connection_receive_credentials_finish() to get the result of the operation.
   */
  void receiveCredentialsAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_unix_connection_receive_credentials_async(cPtr!GUnixConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GCredentials, or %NULL on error.
   * Free the returned object with g_object_unref().
   */
  Credentials receiveCredentialsFinish(AsyncResult result)
  {
    GCredentials* _cretval;
    GError *_err;
    _cretval = g_unix_connection_receive_credentials_finish(cPtr!GUnixConnection, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Credentials _retval = ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, true);
    return _retval;
  }

  /**
   * a file descriptor on success, -1 on error.
   */
  int receiveFd(Cancellable cancellable)
  {
    int _retval;
    GError *_err;
    _retval = g_unix_connection_receive_fd(cPtr!GUnixConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE if @error is set.
   */
  bool sendCredentials(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_connection_send_credentials(cPtr!GUnixConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously send credentials.
   *
   * For more details, see g_unix_connection_send_credentials() which is
   * the synchronous version of this call.
   *
   * When the operation is finished, @callback will be called. You can then call
   * g_unix_connection_send_credentials_finish() to get the result of the operation.
   */
  void sendCredentialsAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_unix_connection_send_credentials_async(cPtr!GUnixConnection, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the operation was successful, otherwise %FALSE.
   */
  bool sendCredentialsFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_connection_send_credentials_finish(cPtr!GUnixConnection, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a %TRUE on success, %NULL on error.
   */
  bool sendFd(int fd, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_unix_connection_send_fd(cPtr!GUnixConnection, fd, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

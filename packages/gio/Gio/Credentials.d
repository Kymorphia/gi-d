module Gio.Credentials;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GCredentials type is a reference-counted wrapper for native
 * credentials. This information is typically used for identifying,
 * authenticating and authorizing other processes.
 *
 * Some operating systems supports looking up the credentials of the
 * remote peer of a communication endpoint - see e.g.
 * g_socket_get_credentials().
 *
 * Some operating systems supports securely sending and receiving
 * credentials over a Unix Domain Socket, see
 * #GUnixCredentialsMessage, g_unix_connection_send_credentials() and
 * g_unix_connection_receive_credentials() for details.
 *
 * On Linux, the native credential type is a `struct ucred` - see the
 * unix(7) man page for details. This corresponds to
 * %G_CREDENTIALS_TYPE_LINUX_UCRED.
 *
 * On Apple operating systems (including iOS, tvOS, and macOS),
 * the native credential type is a `struct xucred`.
 * This corresponds to %G_CREDENTIALS_TYPE_APPLE_XUCRED.
 *
 * On FreeBSD, Debian GNU/kFreeBSD, and GNU/Hurd, the native
 * credential type is a `struct cmsgcred`. This corresponds
 * to %G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED.
 *
 * On NetBSD, the native credential type is a `struct unpcbid`.
 * This corresponds to %G_CREDENTIALS_TYPE_NETBSD_UNPCBID.
 *
 * On OpenBSD, the native credential type is a `struct sockpeercred`.
 * This corresponds to %G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED.
 *
 * On Solaris (including OpenSolaris and its derivatives), the native
 * credential type is a `ucred_t`. This corresponds to
 * %G_CREDENTIALS_TYPE_SOLARIS_UCRED.
 *
 * Since GLib 2.72, on Windows, the native credentials may contain the PID of a
 * process. This corresponds to %G_CREDENTIALS_TYPE_WIN32_PID.
 */
class Credentials : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_credentials_get_type();
  }

  /**
   * A #GCredentials. Free with g_object_unref().
   */
  this()
  {
    GCredentials* _cretval;
    _cretval = g_credentials_new();
    this(_cretval, true);
  }

  /**
   * The UNIX process ID, or `-1` if @error is set.
   */
  int getUnixPid()
  {
    int _retval;
    GError *_err;
    _retval = g_credentials_get_unix_pid(cPtr!GCredentials, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * The UNIX user identifier or `-1` if @error is set.
   */
  uint getUnixUser()
  {
    uint _retval;
    GError *_err;
    _retval = g_credentials_get_unix_user(cPtr!GCredentials, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @credentials and @other_credentials has the same
   * user, %FALSE otherwise or if @error is set.
   */
  bool isSameUser(Credentials otherCredentials)
  {
    bool _retval;
    GError *_err;
    _retval = g_credentials_is_same_user(cPtr!GCredentials, otherCredentials ? otherCredentials.cPtr!GCredentials : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Copies the native credentials of type @native_type from @native
   * into @credentials.
   *
   * It is a programming error (which will cause a warning to be
   * logged) to use this method if there is no #GCredentials support for
   * the OS or if @native_type isn't supported by the OS.
   */
  void setNative(CredentialsType nativeType, void* native)
  {
    g_credentials_set_native(cPtr!GCredentials, nativeType, native);
  }

  /**
   * %TRUE if @uid was set, %FALSE if error is set.
   */
  bool setUnixUser(uint uid)
  {
    bool _retval;
    GError *_err;
    _retval = g_credentials_set_unix_user(cPtr!GCredentials, uid, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * A string that should be freed with g_free().
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_credentials_to_string(cPtr!GCredentials);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

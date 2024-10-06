module Gio.Credentials;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The `GCredentials` type is a reference-counted wrapper for native
 * credentials.
 * The information in `GCredentials` is typically used for identifying,
 * authenticating and authorizing other processes.
 * Some operating systems supports looking up the credentials of the remote
 * peer of a communication endpoint - see e.g. [Gio.Socket.getCredentials].
 * Some operating systems supports securely sending and receiving
 * credentials over a Unix Domain Socket, see [Gio.UnixCredentialsMessage],
 * [Gio.UnixConnection.sendCredentials] and
 * [Gio.UnixConnection.receiveCredentials] for details.
 * On Linux, the native credential type is a `struct ucred` - see the
 * [`unix$(LPAREN)7$(RPAREN)` man page]$(LPAREN)$(RPAREN)(man:unix7) for details. This corresponds to
 * `G_CREDENTIALS_TYPE_LINUX_UCRED`.
 * On Apple operating systems $(LPAREN)including iOS, tvOS, and macOS$(RPAREN), the native credential
 * type is a `struct xucred`. This corresponds to `G_CREDENTIALS_TYPE_APPLE_XUCRED`.
 * On FreeBSD, Debian GNU/kFreeBSD, and GNU/Hurd, the native credential type is a
 * `struct cmsgcred`. This corresponds to `G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED`.
 * On NetBSD, the native credential type is a `struct unpcbid`.
 * This corresponds to `G_CREDENTIALS_TYPE_NETBSD_UNPCBID`.
 * On OpenBSD, the native credential type is a `struct sockpeercred`.
 * This corresponds to `G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED`.
 * On Solaris $(LPAREN)including OpenSolaris and its derivatives$(RPAREN), the native credential type
 * is a `ucred_t`. This corresponds to `G_CREDENTIALS_TYPE_SOLARIS_UCRED`.
 * Since GLib 2.72, on Windows, the native credentials may contain the PID of a
 * process. This corresponds to `G_CREDENTIALS_TYPE_WIN32_PID`.
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

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GCredentials object with credentials matching the
   * the current process.
   * Returns: A #GCredentials. Free with [GObject.ObjectG.unref].
   */
  this()
  {
    GCredentials* _cretval;
    _cretval = g_credentials_new();
    this(_cretval, true);
  }

  /**
   * Tries to get the UNIX process identifier from credentials. This
   * method is only available on UNIX platforms.
   * This operation can fail if #GCredentials is not supported on the
   * OS or if the native credentials type does not contain information
   * about the UNIX process ID.
   * Returns: The UNIX process ID, or `-1` if error is set.
   */
  int getUnixPid()
  {
    int _retval;
    GError *_err;
    _retval = g_credentials_get_unix_pid(cast(GCredentials*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to get the UNIX user identifier from credentials. This
   * method is only available on UNIX platforms.
   * This operation can fail if #GCredentials is not supported on the
   * OS or if the native credentials type does not contain information
   * about the UNIX user.
   * Returns: The UNIX user identifier or `-1` if error is set.
   */
  uint getUnixUser()
  {
    uint _retval;
    GError *_err;
    _retval = g_credentials_get_unix_user(cast(GCredentials*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Checks if credentials and other_credentials is the same user.
   * This operation can fail if #GCredentials is not supported on the
   * the OS.
   * Params:
   *   otherCredentials = A #GCredentials.
   * Returns: %TRUE if credentials and other_credentials has the same
   *   user, %FALSE otherwise or if error is set.
   */
  bool isSameUser(Credentials otherCredentials)
  {
    bool _retval;
    GError *_err;
    _retval = g_credentials_is_same_user(cast(GCredentials*)cPtr, otherCredentials ? cast(GCredentials*)otherCredentials.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Copies the native credentials of type native_type from native
   * into credentials.
   * It is a programming error $(LPAREN)which will cause a warning to be
   * logged$(RPAREN) to use this method if there is no #GCredentials support for
   * the OS or if native_type isn't supported by the OS.
   * Params:
   *   nativeType = The type of native credentials to set.
   *   native = A pointer to native credentials.
   */
  void setNative(CredentialsType nativeType, void* native)
  {
    g_credentials_set_native(cast(GCredentials*)cPtr, nativeType, native);
  }

  /**
   * Tries to set the UNIX user identifier on credentials. This method
   * is only available on UNIX platforms.
   * This operation can fail if #GCredentials is not supported on the
   * OS or if the native credentials type does not contain information
   * about the UNIX user. It can also fail if the OS does not allow the
   * use of "spoofed" credentials.
   * Params:
   *   uid = The UNIX user identifier to set.
   * Returns: %TRUE if uid was set, %FALSE if error is set.
   */
  bool setUnixUser(uint uid)
  {
    bool _retval;
    GError *_err;
    _retval = g_credentials_set_unix_user(cast(GCredentials*)cPtr, uid, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Creates a human-readable textual representation of credentials
   * that can be used in logging and debug messages. The format of the
   * returned string may change in future GLib release.
   * Returns: A string that should be freed with [GLib.Global.gfree].
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_credentials_to_string(cast(GCredentials*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

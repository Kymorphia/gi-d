module Gio.UnixCredentialsMessage;

import GObject.ObjectG;
import Gid.Gid;
import Gio.Credentials;
import Gio.SocketControlMessage;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This #GSocketControlMessage contains a #GCredentials instance.  It
 * may be sent using g_socket_send_message() and received using
 * g_socket_receive_message() over UNIX sockets (ie: sockets in the
 * %G_SOCKET_FAMILY_UNIX family).
 *
 * For an easier way to send and receive credentials over
 * stream-oriented UNIX sockets, see
 * g_unix_connection_send_credentials() and
 * g_unix_connection_receive_credentials(). To receive credentials of
 * a foreign process connected to a socket, use
 * g_socket_get_credentials().
 *
 * Since GLib 2.72, #GUnixCredentialMessage is available on all platforms. It
 * requires underlying system support (such as Windows 10 with `AF_UNIX`) at run
 * time.
 *
 * Before GLib 2.72, `<gio/gunixcredentialsmessage.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 */
class UnixCredentialsMessage : SocketControlMessage
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_unix_credentials_message_get_type();
  }

  /**
   * a new #GUnixCredentialsMessage
   */
  this()
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_credentials_message_new();
    this(_cretval, true);
  }

  /**
   * a new #GUnixCredentialsMessage
   */
  static SocketControlMessage newWithCredentials(Credentials credentials)
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_credentials_message_new_with_credentials(credentials ? credentials.cPtr!GCredentials : null);
    SocketControlMessage _retval = ObjectG.getDObject!SocketControlMessage(cast(GSocketControlMessage*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if supported, %FALSE otherwise
   */
  static bool isSupported()
  {
    bool _retval;
    _retval = g_unix_credentials_message_is_supported();
    return _retval;
  }

  /**
   * A #GCredentials instance. Do not free, it is owned by @message.
   */
  Credentials getCredentials()
  {
    GCredentials* _cretval;
    _cretval = g_unix_credentials_message_get_credentials(cPtr!GUnixCredentialsMessage);
    Credentials _retval = ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, false);
    return _retval;
  }
}

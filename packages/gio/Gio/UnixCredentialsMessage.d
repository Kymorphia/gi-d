module Gio.UnixCredentialsMessage;

import GObject.ObjectG;
import Gid.gid;
import Gio.Credentials;
import Gio.SocketControlMessage;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This [Gio.SocketControlMessage] contains a [Gio.Credentials]
 * instance.  It may be sent using [Gio.Socket.sendMessage] and received
 * using [Gio.Socket.receiveMessage] over UNIX sockets $(LPAREN)ie: sockets in
 * the `G_SOCKET_FAMILY_UNIX` family$(RPAREN).
 * For an easier way to send and receive credentials over
 * stream-oriented UNIX sockets, see
 * [Gio.UnixConnection.sendCredentials] and
 * [Gio.UnixConnection.receiveCredentials]. To receive credentials of
 * a foreign process connected to a socket, use
 * [Gio.Socket.getCredentials].
 * Since GLib 2.72, `GUnixCredentialMessage` is available on all platforms. It
 * requires underlying system support $(LPAREN)such as Windows 10 with `AF_UNIX`$(RPAREN) at run
 * time.
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

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GUnixCredentialsMessage with credentials matching the current processes.
   * Returns: a new #GUnixCredentialsMessage
   */
  this()
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_credentials_message_new();
    this(_cretval, true);
  }

  /**
   * Creates a new #GUnixCredentialsMessage holding credentials.
   * Params:
   *   credentials = A #GCredentials object.
   * Returns: a new #GUnixCredentialsMessage
   */
  static UnixCredentialsMessage newWithCredentials(Credentials credentials)
  {
    GSocketControlMessage* _cretval;
    _cretval = g_unix_credentials_message_new_with_credentials(credentials ? cast(GCredentials*)credentials.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!UnixCredentialsMessage(cast(GSocketControlMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if passing #GCredentials on a #GSocket is supported on this platform.
   * Returns: %TRUE if supported, %FALSE otherwise
   */
  static bool isSupported()
  {
    bool _retval;
    _retval = g_unix_credentials_message_is_supported();
    return _retval;
  }

  /**
   * Gets the credentials stored in message.
   * Returns: A #GCredentials instance. Do not free, it is owned by message.
   */
  Credentials getCredentials()
  {
    GCredentials* _cretval;
    _cretval = g_unix_credentials_message_get_credentials(cast(GUnixCredentialsMessage*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Credentials(cast(GCredentials*)_cretval, false) : null;
    return _retval;
  }
}

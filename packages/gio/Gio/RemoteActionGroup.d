module Gio.RemoteActionGroup;

import GLib.Types;
import GLib.Variant;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The GRemoteActionGroup interface is implemented by #GActionGroup
 * instances that either transmit action invocations to other processes
 * or receive action invocations in the local process from other
 * processes.
 *
 * The interface has `_full` variants of the two
 * methods on #GActionGroup used to activate actions:
 * g_action_group_activate_action() and
 * g_action_group_change_action_state(). These variants allow a
 * "platform data" #GVariant to be specified: a dictionary providing
 * context for the action invocation (for example: timestamps, startup
 * notification IDs, etc).
 *
 * #GDBusActionGroup implements #GRemoteActionGroup.  This provides a
 * mechanism to send platform data for action invocations over D-Bus.
 *
 * Additionally, g_dbus_connection_export_action_group() will check if
 * the exported #GActionGroup implements #GRemoteActionGroup and use the
 * `_full` variants of the calls if available.  This
 * provides a mechanism by which to receive platform data for action
 * invocations that arrive by way of D-Bus.
 */
interface RemoteActionGroup
{

  static GType getType()
  {
    return g_remote_action_group_get_type();
  }

  /**
   * Activates the remote action.
   *
   * This is the same as g_action_group_activate_action() except that it
   * allows for provision of "platform data" to be sent along with the
   * activation request.  This typically contains details such as the user
   * interaction timestamp or startup notification information.
   *
   * @platform_data must be non-%NULL and must have the type
   * %G_VARIANT_TYPE_VARDICT.  If it is floating, it will be consumed.
   */
  void activateActionFull(string actionName, Variant parameter, Variant platformData);

  /**
   * Changes the state of a remote action.
   *
   * This is the same as g_action_group_change_action_state() except that
   * it allows for provision of "platform data" to be sent along with the
   * state change request.  This typically contains details such as the
   * user interaction timestamp or startup notification information.
   *
   * @platform_data must be non-%NULL and must have the type
   * %G_VARIANT_TYPE_VARDICT.  If it is floating, it will be consumed.
   */
  void changeActionStateFull(string actionName, Variant value, Variant platformData);
}

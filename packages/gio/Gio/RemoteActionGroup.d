module Gio.RemoteActionGroup;

public import Gio.RemoteActionGroupIfaceProxy;
import GLib.Variant;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The `GRemoteActionGroup` interface is implemented by [Gio.ActionGroup]
 * instances that either transmit action invocations to other processes
 * or receive action invocations in the local process from other
 * processes.
 * The interface has `_full` variants of the two
 * methods on [Gio.ActionGroup] used to activate actions:
 * [Gio.ActionGroup.activateAction] and
 * [Gio.ActionGroup.changeActionState]. These variants allow a
 * ‘platform data’ [GLib.Variant] to be specified: a dictionary providing
 * context for the action invocation $(LPAREN)for example: timestamps, startup
 * notification IDs, etc$(RPAREN).
 * [Gio.DBusActionGroup] implements `GRemoteActionGroup`.  This provides a
 * mechanism to send platform data for action invocations over D-Bus.
 * Additionally, [Gio.DBusConnection.exportActionGroup] will check if
 * the exported [Gio.ActionGroup] implements `GRemoteActionGroup` and use
 * the `_full` variants of the calls if available.  This
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
   * This is the same as [Gio.ActionGroup.activateAction] except that it
   * allows for provision of "platform data" to be sent along with the
   * activation request.  This typically contains details such as the user
   * interaction timestamp or startup notification information.
   * platform_data must be non-%NULL and must have the type
   * %G_VARIANT_TYPE_VARDICT.  If it is floating, it will be consumed.
   * Params:
   *   actionName = the name of the action to activate
   *   parameter = the optional parameter to the activation
   *   platformData = the platform data to send
   */
  void activateActionFull(string actionName, Variant parameter, Variant platformData);

  /**
   * Changes the state of a remote action.
   * This is the same as [Gio.ActionGroup.changeActionState] except that
   * it allows for provision of "platform data" to be sent along with the
   * state change request.  This typically contains details such as the
   * user interaction timestamp or startup notification information.
   * platform_data must be non-%NULL and must have the type
   * %G_VARIANT_TYPE_VARDICT.  If it is floating, it will be consumed.
   * Params:
   *   actionName = the name of the action to change the state of
   *   value = the new requested value for the state
   *   platformData = the platform data to send
   */
  void changeActionStateFull(string actionName, Variant value, Variant platformData);
}

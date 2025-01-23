module Gio.RemoteActionGroupT;

public import Gio.RemoteActionGroupIfaceProxy;
public import GLib.VariantG;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The `GRemoteActionGroup` interface is implemented by [Gio.ActionGroup]
 * instances that either transmit action invocations to other processes
 * or receive action invocations in the local process from other
 * processes.
 * The interface has `_full` variants of the two
 * methods on [Gio.ActionGroup] used to activate actions:
 * [Gio.ActionGroup.activateAction] and
 * [Gio.ActionGroup.changeActionState]. These variants allow a
 * ‘platform data’ [GLib.VariantG] to be specified: a dictionary providing
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
template RemoteActionGroupT()
{

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
  override void activateActionFull(string actionName, VariantG parameter, VariantG platformData)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_remote_action_group_activate_action_full(cast(GRemoteActionGroup*)cPtr, _actionName, parameter ? cast(VariantC*)parameter.cPtr(false) : null, platformData ? cast(VariantC*)platformData.cPtr(false) : null);
  }

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
  override void changeActionStateFull(string actionName, VariantG value, VariantG platformData)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_remote_action_group_change_action_state_full(cast(GRemoteActionGroup*)cPtr, _actionName, value ? cast(VariantC*)value.cPtr(false) : null, platformData ? cast(VariantC*)platformData.cPtr(false) : null);
  }
}

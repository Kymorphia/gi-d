module Gio.ActionGroup;

import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GObject.DClosure;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GActionGroup represents a group of actions. Actions can be used to
 * expose functionality in a structured way, either from one part of a
 * program to another, or to the outside world. Action groups are often
 * used together with a #GMenuModel that provides additional
 * representation data for displaying the actions to the user, e.g. in
 * a menu.
 *
 * The main way to interact with the actions in a GActionGroup is to
 * activate them with g_action_group_activate_action(). Activating an
 * action may require a #GVariant parameter. The required type of the
 * parameter can be inquired with g_action_group_get_action_parameter_type().
 * Actions may be disabled, see g_action_group_get_action_enabled().
 * Activating a disabled action has no effect.
 *
 * Actions may optionally have a state in the form of a #GVariant. The
 * current state of an action can be inquired with
 * g_action_group_get_action_state(). Activating a stateful action may
 * change its state, but it is also possible to set the state by calling
 * g_action_group_change_action_state().
 *
 * As typical example, consider a text editing application which has an
 * option to change the current font to 'bold'. A good way to represent
 * this would be a stateful action, with a boolean state. Activating the
 * action would toggle the state.
 *
 * Each action in the group has a unique name (which is a string).  All
 * method calls, except g_action_group_list_actions() take the name of
 * an action as an argument.
 *
 * The #GActionGroup API is meant to be the 'public' API to the action
 * group.  The calls here are exactly the interaction that 'external
 * forces' (eg: UI, incoming D-Bus messages, etc.) are supposed to have
 * with actions.  'Internal' APIs (ie: ones meant only to be accessed by
 * the action group implementation) are found on subclasses.  This is
 * why you will find - for example - g_action_group_get_action_enabled()
 * but not an equivalent set() call.
 *
 * Signals are emitted on the action group in response to state changes
 * on individual actions.
 *
 * Implementations of #GActionGroup should provide implementations for
 * the virtual functions g_action_group_list_actions() and
 * g_action_group_query_action().  The other virtual functions should
 * not be implemented - their "wrappers" are actually implemented with
 * calls to g_action_group_query_action().
 */
interface ActionGroup
{

  static GType getType()
  {
    return g_action_group_get_type();
  }

  /**
   * Emits the #GActionGroup::action-added signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  void actionAdded(string actionName);

  /**
   * Emits the #GActionGroup::action-enabled-changed signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  void actionEnabledChanged(string actionName, bool enabled);

  /**
   * Emits the #GActionGroup::action-removed signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  void actionRemoved(string actionName);

  /**
   * Emits the #GActionGroup::action-state-changed signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  void actionStateChanged(string actionName, Variant state);

  /**
   * Activate the named action within @action_group.
   *
   * If the action is expecting a parameter, then the correct type of
   * parameter must be given as @parameter.  If the action is expecting no
   * parameters then @parameter must be %NULL.  See
   * g_action_group_get_action_parameter_type().
   *
   * If the #GActionGroup implementation supports asynchronous remote
   * activation over D-Bus, this call may return before the relevant
   * D-Bus traffic has been sent, or any replies have been received. In
   * order to block on such asynchronous activation calls,
   * g_dbus_connection_flush() should be called prior to the code, which
   * depends on the result of the action activation. Without flushing
   * the D-Bus connection, there is no guarantee that the action would
   * have been activated.
   *
   * The following code which runs in a remote app instance, shows an
   * example of a "quit" action being activated on the primary app
   * instance over D-Bus. Here g_dbus_connection_flush() is called
   * before `exit()`. Without g_dbus_connection_flush(), the "quit" action
   * may fail to be activated on the primary instance.
   *
   * |[<!-- language="C" -->
   * // call "quit" action on primary instance
   * g_action_group_activate_action (G_ACTION_GROUP (app), "quit", NULL);
   *
   * // make sure the action is activated now
   * g_dbus_connection_flush (...);
   *
   * g_debug ("application has been terminated. exiting.");
   *
   * exit (0);
   * ]|
   */
  void activateAction(string actionName, Variant parameter);

  /**
   * Request for the state of the named action within @action_group to be
   * changed to @value.
   *
   * The action must be stateful and @value must be of the correct type.
   * See g_action_group_get_action_state_type().
   *
   * This call merely requests a change.  The action may refuse to change
   * its state or may change its state to something other than @value.
   * See g_action_group_get_action_state_hint().
   *
   * If the @value GVariant is floating, it is consumed.
   */
  void changeActionState(string actionName, Variant value);

  /**
   * whether or not the action is currently enabled
   */
  bool getActionEnabled(string actionName);

  /**
   * the parameter type
   */
  VariantType getActionParameterType(string actionName);

  /**
   * the current state of the action
   */
  Variant getActionState(string actionName);

  /**
   * the state range hint
   */
  Variant getActionStateHint(string actionName);

  /**
   * the state type, if the action is stateful
   */
  VariantType getActionStateType(string actionName);

  /**
   * whether the named action exists
   */
  bool hasAction(string actionName);

  /**
   * a %NULL-terminated array of the names of the
   * actions in the group
   */
  string[] listActions();

  /**
   * %TRUE if the action exists, else %FALSE
   */
  bool queryAction(string actionName, out bool enabled, out VariantType parameterType, out VariantType stateType, out Variant stateHint, out Variant state);

  /**
   * Signals that a new action was just added to the group.
   * This signal is emitted after the action has been added
   * and is now visible.
   */
  ulong connectActionAdded(void delegate(string actionName, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Signals that the enabled status of the named action has changed.
   */
  ulong connectActionEnabledChanged(void delegate(string actionName, bool enabled, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Signals that an action is just about to be removed from the group.
   * This signal is emitted before the action is removed, so the action
   * is still visible and can be queried from the signal handler.
   */
  ulong connectActionRemoved(void delegate(string actionName, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Signals that the state of the named action has changed.
   */
  ulong connectActionStateChanged(void delegate(string actionName, Variant value, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default);
}

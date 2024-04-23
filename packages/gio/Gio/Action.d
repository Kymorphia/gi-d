module Gio.Action;

import GLib.ErrorG;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GAction represents a single named action.
 *
 * The main interface to an action is that it can be activated with
 * g_action_activate().  This results in the 'activate' signal being
 * emitted.  An activation has a #GVariant parameter (which may be
 * %NULL).  The correct type for the parameter is determined by a static
 * parameter type (which is given at construction time).
 *
 * An action may optionally have a state, in which case the state may be
 * set with g_action_change_state().  This call takes a #GVariant.  The
 * correct type for the state is determined by a static state type
 * (which is given at construction time).
 *
 * The state may have a hint associated with it, specifying its valid
 * range.
 *
 * #GAction is merely the interface to the concept of an action, as
 * described above.  Various implementations of actions exist, including
 * #GSimpleAction.
 *
 * In all cases, the implementing class is responsible for storing the
 * name of the action, the parameter type, the enabled state, the
 * optional state type and the state and emitting the appropriate
 * signals when these change.  The implementor is responsible for filtering
 * calls to g_action_activate() and g_action_change_state() for type
 * safety and for the state being enabled.
 *
 * Probably the only useful thing to do with a #GAction is to put it
 * inside of a #GSimpleActionGroup.
 */
interface Action
{

  static GType getType()
  {
    return g_action_get_type();
  }

  /**
   * %TRUE if @action_name is valid
   */
  static bool nameIsValid(string actionName);

  /**
   * %TRUE if successful, else %FALSE with @error set
   */
  static bool parseDetailedName(string detailedName, out string actionName, out Variant targetValue);

  /**
   * a detailed format string
   */
  static string printDetailedName(string actionName, Variant targetValue);

  /**
   * Activates the action.
   *
   * @parameter must be the correct type of parameter for the action (ie:
   * the parameter type given at construction time).  If the parameter
   * type was %NULL then @parameter must also be %NULL.
   *
   * If the @parameter GVariant is floating, it is consumed.
   */
  void activate(Variant parameter);

  /**
   * Request for the state of @action to be changed to @value.
   *
   * The action must be stateful and @value must be of the correct type.
   * See g_action_get_state_type().
   *
   * This call merely requests a change.  The action may refuse to change
   * its state or may change its state to something other than @value.
   * See g_action_get_state_hint().
   *
   * If the @value GVariant is floating, it is consumed.
   */
  void changeState(Variant value);

  /**
   * whether the action is enabled
   */
  bool getEnabled();

  /**
   * the name of the action
   */
  string getName();

  /**
   * the parameter type
   */
  VariantType getParameterType();

  /**
   * the current state of the action
   */
  Variant getState();

  /**
   * the state range hint
   */
  Variant getStateHint();

  /**
   * the state type, if the action is stateful
   */
  VariantType getStateType();
}

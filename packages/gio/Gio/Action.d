module Gio.Action;

import GLib.ErrorG;
import GLib.Variant;
import GLib.VariantType;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GAction` represents a single named action.
 * The main interface to an action is that it can be activated with
 * [Gio.Action.activate]. This results in the 'activate' signal being
 * emitted. An activation has a `GVariant` parameter $(LPAREN)which may be
 * `NULL`$(RPAREN). The correct type for the parameter is determined by a static
 * parameter type $(LPAREN)which is given at construction time$(RPAREN).
 * An action may optionally have a state, in which case the state may be
 * set with [Gio.Action.changeState]. This call takes a #GVariant. The
 * correct type for the state is determined by a static state type
 * $(LPAREN)which is given at construction time$(RPAREN).
 * The state may have a hint associated with it, specifying its valid
 * range.
 * `GAction` is merely the interface to the concept of an action, as
 * described above.  Various implementations of actions exist, including
 * [Gio.SimpleAction].
 * In all cases, the implementing class is responsible for storing the
 * name of the action, the parameter type, the enabled state, the optional
 * state type and the state and emitting the appropriate signals when these
 * change. The implementor is responsible for filtering calls to
 * [Gio.Action.activate] and [Gio.Action.changeState]
 * for type safety and for the state being enabled.
 * Probably the only useful thing to do with a `GAction` is to put it
 * inside of a [Gio.SimpleActionGroup].
 */
interface Action
{

  static GType getType()
  {
    return g_action_get_type();
  }

  /**
   * Checks if action_name is valid.
   * action_name is valid if it consists only of alphanumeric characters,
   * plus '-' and '.'.  The empty string is not a valid action name.
   * It is an error to call this function with a non-utf8 action_name.
   * action_name must not be %NULL.
   * Params:
   *   actionName = a potential action name
   * Returns: %TRUE if action_name is valid
   */
  static bool nameIsValid(string actionName);

  /**
   * Parses a detailed action name into its separate name and target
   * components.
   * Detailed action names can have three formats.
   * The first format is used to represent an action name with no target
   * value and consists of just an action name containing no whitespace
   * nor the characters `:`, `$(LPAREN)` or `$(RPAREN)`.  For example: `app.action`.
   * The second format is used to represent an action with a target value
   * that is a non-empty string consisting only of alphanumerics, plus `-`
   * and `.`.  In that case, the action name and target value are
   * separated by a double colon $(LPAREN)`::`$(RPAREN).  For example:
   * `app.action::target`.
   * The third format is used to represent an action with any type of
   * target value, including strings.  The target value follows the action
   * name, surrounded in parens.  For example: `app.action$(LPAREN)42$(RPAREN)`.  The
   * target value is parsed using [GLib.Variant.parse].  If a tuple-typed
   * value is desired, it must be specified in the same way, resulting in
   * two sets of parens, for example: `app.action$(LPAREN)$(LPAREN)1,2,3$(RPAREN)$(RPAREN)`.  A string
   * target can be specified this way as well: `app.action$(LPAREN)'target'$(RPAREN)`.
   * For strings, this third format must be used if target value is
   * empty or contains characters other than alphanumerics, `-` and `.`.
   * If this function returns %TRUE, a non-%NULL value is guaranteed to be returned
   * in action_name $(LPAREN)if a pointer is passed in$(RPAREN). A %NULL value may still be
   * returned in target_value, as the detailed_name may not contain a target.
   * If returned, the #GVariant in target_value is guaranteed to not be floating.
   * Params:
   *   detailedName = a detailed action name
   *   actionName = the action name
   *   targetValue = the target value,
   *     or %NULL for no target
   * Returns: %TRUE if successful, else %FALSE with error set
   */
  static bool parseDetailedName(string detailedName, out string actionName, out Variant targetValue);

  /**
   * Formats a detailed action name from action_name and target_value.
   * It is an error to call this function with an invalid action name.
   * This function is the opposite of [Gio.Action.parseDetailedName].
   * It will produce a string that can be parsed back to the action_name
   * and target_value by that function.
   * See that function for the types of strings that will be printed by
   * this function.
   * Params:
   *   actionName = a valid action name
   *   targetValue = a #GVariant target value, or %NULL
   * Returns: a detailed format string
   */
  static string printDetailedName(string actionName, Variant targetValue);

  /**
   * Activates the action.
   * parameter must be the correct type of parameter for the action $(LPAREN)ie:
   * the parameter type given at construction time$(RPAREN).  If the parameter
   * type was %NULL then parameter must also be %NULL.
   * If the parameter GVariant is floating, it is consumed.
   * Params:
   *   parameter = the parameter to the activation
   */
  void activate(Variant parameter);

  /**
   * Request for the state of action to be changed to value.
   * The action must be stateful and value must be of the correct type.
   * See [Gio.Action.getStateType].
   * This call merely requests a change.  The action may refuse to change
   * its state or may change its state to something other than value.
   * See [Gio.Action.getStateHint].
   * If the value GVariant is floating, it is consumed.
   * Params:
   *   value = the new state
   */
  void changeState(Variant value);

  /**
   * Checks if action is currently enabled.
   * An action must be enabled in order to be activated or in order to
   * have its state changed from outside callers.
   * Returns: whether the action is enabled
   */
  bool getEnabled();

  /**
   * Queries the name of action.
   * Returns: the name of the action
   */
  string getName();

  /**
   * Queries the type of the parameter that must be given when activating
   * action.
   * When activating the action using [Gio.Action.activate], the #GVariant
   * given to that function must be of the type returned by this function.
   * In the case that this function returns %NULL, you must not give any
   * #GVariant, but %NULL instead.
   * Returns: the parameter type
   */
  VariantType getParameterType();

  /**
   * Queries the current state of action.
   * If the action is not stateful then %NULL will be returned.  If the
   * action is stateful then the type of the return value is the type
   * given by [Gio.Action.getStateType].
   * The return value $(LPAREN)if non-%NULL$(RPAREN) should be freed with
   * [GLib.Variant.unref] when it is no longer required.
   * Returns: the current state of the action
   */
  Variant getState();

  /**
   * Requests a hint about the valid range of values for the state of
   * action.
   * If %NULL is returned it either means that the action is not stateful
   * or that there is no hint about the valid range of values for the
   * state of the action.
   * If a #GVariant array is returned then each item in the array is a
   * possible value for the state.  If a #GVariant pair $(LPAREN)ie: two-tuple$(RPAREN) is
   * returned then the tuple specifies the inclusive lower and upper bound
   * of valid values for the state.
   * In any case, the information is merely a hint.  It may be possible to
   * have a state value outside of the hinted range and setting a value
   * within the range may fail.
   * The return value $(LPAREN)if non-%NULL$(RPAREN) should be freed with
   * [GLib.Variant.unref] when it is no longer required.
   * Returns: the state range hint
   */
  Variant getStateHint();

  /**
   * Queries the type of the state of action.
   * If the action is stateful $(LPAREN)e.g. created with
   * [Gio.SimpleAction.newStateful]$(RPAREN) then this function returns the
   * #GVariantType of the state.  This is the type of the initial value
   * given as the state. All calls to [Gio.Action.changeState] must give a
   * #GVariant of this type and [Gio.Action.getState] will return a
   * #GVariant of the same type.
   * If the action is not stateful $(LPAREN)e.g. created with [Gio.SimpleAction.new_]$(RPAREN)
   * then this function will return %NULL. In that case, [Gio.Action.getState]
   * will return %NULL and you must not call [Gio.Action.changeState].
   * Returns: the state type, if the action is stateful
   */
  VariantType getStateType();
}

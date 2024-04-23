module Gio.ActionT;

public import GLib.ErrorG;
public import GLib.Types;
public import GLib.Variant;
public import GLib.VariantType;
public import Gid.Gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template ActionT(TStruct)
{

  /**
   * %TRUE if @action_name is valid
   */
  static bool nameIsValid(string actionName)
  {
    bool _retval;
    const(char)* _actionName = actionName.toCString(false);
    _retval = g_action_name_is_valid(_actionName);
    return _retval;
  }

  /**
   * %TRUE if successful, else %FALSE with @error set
   */
  static bool parseDetailedName(string detailedName, out string actionName, out Variant targetValue)
  {
    bool _retval;
    const(char)* _detailedName = detailedName.toCString(false);
    char* _actionName;
    GVariant* _targetValue;
    GError *_err;
    _retval = g_action_parse_detailed_name(_detailedName, &_actionName, &_targetValue, &_err);
    if (_err)
      throw new ErrorG(_err);
    actionName = _actionName.fromCString(true);
    targetValue = new Variant(cast(void*)_targetValue, true);
    return _retval;
  }

  /**
   * a detailed format string
   */
  static string printDetailedName(string actionName, Variant targetValue)
  {
    char* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_print_detailed_name(_actionName, targetValue ? targetValue.cPtr!GVariant : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Activates the action.
   *
   * @parameter must be the correct type of parameter for the action (ie:
   * the parameter type given at construction time).  If the parameter
   * type was %NULL then @parameter must also be %NULL.
   *
   * If the @parameter GVariant is floating, it is consumed.
   */
  override void activate(Variant parameter)
  {
    g_action_activate(cPtr!GAction, parameter ? parameter.cPtr!GVariant : null);
  }

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
  override void changeState(Variant value)
  {
    g_action_change_state(cPtr!GAction, value ? value.cPtr!GVariant : null);
  }

  /**
   * whether the action is enabled
   */
  override bool getEnabled()
  {
    bool _retval;
    _retval = g_action_get_enabled(cPtr!GAction);
    return _retval;
  }

  /**
   * the name of the action
   */
  override string getName()
  {
    const(char)* _cretval;
    _cretval = g_action_get_name(cPtr!GAction);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the parameter type
   */
  override VariantType getParameterType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_action_get_parameter_type(cPtr!GAction);
    VariantType _retval = new VariantType(cast(GVariantType*)_cretval, false);
    return _retval;
  }

  /**
   * the current state of the action
   */
  override Variant getState()
  {
    GVariant* _cretval;
    _cretval = g_action_get_state(cPtr!GAction);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the state range hint
   */
  override Variant getStateHint()
  {
    GVariant* _cretval;
    _cretval = g_action_get_state_hint(cPtr!GAction);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the state type, if the action is stateful
   */
  override VariantType getStateType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_action_get_state_type(cPtr!GAction);
    VariantType _retval = new VariantType(cast(GVariantType*)_cretval, false);
    return _retval;
  }
}

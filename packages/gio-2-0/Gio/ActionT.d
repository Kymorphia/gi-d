module Gio.ActionT;

public import Gio.ActionIfaceProxy;
public import GLib.ErrorG;
public import GLib.Variant;
public import GLib.VariantType;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template ActionT()
{




  /**
   * Activates the action.
   * parameter must be the correct type of parameter for the action $(LPAREN)ie:
   * the parameter type given at construction time$(RPAREN).  If the parameter
   * type was %NULL then parameter must also be %NULL.
   * If the parameter GVariant is floating, it is consumed.
   * Params:
   *   parameter = the parameter to the activation
   */
  override void activate(Variant parameter)
  {
    g_action_activate(cast(GAction*)cPtr, parameter ? cast(GVariant*)parameter.cPtr(false) : null);
  }

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
  override void changeState(Variant value)
  {
    g_action_change_state(cast(GAction*)cPtr, value ? cast(GVariant*)value.cPtr(false) : null);
  }

  /**
   * Checks if action is currently enabled.
   * An action must be enabled in order to be activated or in order to
   * have its state changed from outside callers.
   * Returns: whether the action is enabled
   */
  override bool getEnabled()
  {
    bool _retval;
    _retval = g_action_get_enabled(cast(GAction*)cPtr);
    return _retval;
  }

  /**
   * Queries the name of action.
   * Returns: the name of the action
   */
  override string getName()
  {
    const(char)* _cretval;
    _cretval = g_action_get_name(cast(GAction*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Queries the type of the parameter that must be given when activating
   * action.
   * When activating the action using [Gio.Action.activate], the #GVariant
   * given to that function must be of the type returned by this function.
   * In the case that this function returns %NULL, you must not give any
   * #GVariant, but %NULL instead.
   * Returns: the parameter type
   */
  override VariantType getParameterType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_action_get_parameter_type(cast(GAction*)cPtr);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Queries the current state of action.
   * If the action is not stateful then %NULL will be returned.  If the
   * action is stateful then the type of the return value is the type
   * given by [Gio.Action.getStateType].
   * The return value $(LPAREN)if non-%NULL$(RPAREN) should be freed with
   * [GLib.Variant.unref] when it is no longer required.
   * Returns: the current state of the action
   */
  override Variant getState()
  {
    GVariant* _cretval;
    _cretval = g_action_get_state(cast(GAction*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

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
  override Variant getStateHint()
  {
    GVariant* _cretval;
    _cretval = g_action_get_state_hint(cast(GAction*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

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
  override VariantType getStateType()
  {
    const(GVariantType)* _cretval;
    _cretval = g_action_get_state_type(cast(GAction*)cPtr);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, false) : null;
    return _retval;
  }
}

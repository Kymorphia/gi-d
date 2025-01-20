module Gio.SimpleAction;

import GLib.Variant;
import GLib.VariantType;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Action;
import Gio.ActionT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GSimpleAction` is the obvious simple implementation of the
 * [Gio.Action] interface. This is the easiest way to create an action for
 * purposes of adding it to a [Gio.SimpleActionGroup].
 */
class SimpleAction : ObjectG, Action
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_simple_action_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionT!();

  /**
   * Creates a new action.
   * The created action is stateless. See [Gio.SimpleAction.newStateful] to create
   * an action that has state.
   * Params:
   *   name = the name of the action
   *   parameterType = the type of parameter that will be passed to
   *     handlers for the #GSimpleAction::activate signal, or %NULL for no parameter
   * Returns: a new #GSimpleAction
   */
  this(string name, VariantType parameterType)
  {
    GSimpleAction* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_simple_action_new(_name, parameterType ? cast(GVariantType*)parameterType.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Creates a new stateful action.
   * All future state values must have the same #GVariantType as the initial
   * state.
   * If the state #GVariant is floating, it is consumed.
   * Params:
   *   name = the name of the action
   *   parameterType = the type of the parameter that will be passed to
   *     handlers for the #GSimpleAction::activate signal, or %NULL for no parameter
   *   state = the initial state of the action
   * Returns: a new #GSimpleAction
   */
  static SimpleAction newStateful(string name, VariantType parameterType, Variant state)
  {
    GSimpleAction* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_simple_action_new_stateful(_name, parameterType ? cast(GVariantType*)parameterType.cPtr(false) : null, state ? cast(GVariant*)state.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!SimpleAction(cast(GSimpleAction*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets the action as enabled or not.
   * An action must be enabled in order to be activated or in order to
   * have its state changed from outside callers.
   * This should only be called by the implementor of the action.  Users
   * of the action should not attempt to modify its enabled flag.
   * Params:
   *   enabled = whether the action is enabled
   */
  void setEnabled(bool enabled)
  {
    g_simple_action_set_enabled(cast(GSimpleAction*)cPtr, enabled);
  }

  /**
   * Sets the state of the action.
   * This directly updates the 'state' property to the given value.
   * This should only be called by the implementor of the action.  Users
   * of the action should not attempt to directly modify the 'state'
   * property.  Instead, they should call [Gio.Action.changeState] to
   * request the change.
   * If the value GVariant is floating, it is consumed.
   * Params:
   *   value = the new #GVariant for the state
   */
  void setState(Variant value)
  {
    g_simple_action_set_state(cast(GSimpleAction*)cPtr, value ? cast(GVariant*)value.cPtr(false) : null);
  }

  /**
   * Sets the state hint for the action.
   * See [Gio.Action.getStateHint] for more information about
   * action state hints.
   * Params:
   *   stateHint = a #GVariant representing the state hint
   */
  void setStateHint(Variant stateHint)
  {
    g_simple_action_set_state_hint(cast(GSimpleAction*)cPtr, stateHint ? cast(GVariant*)stateHint.cPtr(false) : null);
  }

  /**
   * Indicates that the action was just activated.
   * parameter will always be of the expected type, i.e. the parameter type
   * specified when the action was created. If an incorrect type is given when
   * activating the action, this signal is not emitted.
   * Since GLib 2.40, if no handler is connected to this signal then the
   * default behaviour for boolean-stated actions with a %NULL parameter
   * type is to toggle them via the #GSimpleAction::change-state signal.
   * For stateful actions where the state type is equal to the parameter
   * type, the default is to forward them directly to
   * #GSimpleAction::change-state.  This should allow almost all users
   * of #GSimpleAction to connect only one handler or the other.
   * Params
   *   parameter = the parameter to the activation, or %NULL if it has
   *     no parameter
   *   simpleAction = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(Variant parameter, SimpleAction simpleAction);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto simpleAction = getVal!SimpleAction(_paramVals);
      auto parameter = getVal!Variant(&_paramVals[1]);
      _dgClosure.dlg(parameter, simpleAction);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }

  /**
   * Indicates that the action just received a request to change its
   * state.
   * value will always be of the correct state type, i.e. the type of the
   * initial state passed to [Gio.SimpleAction.newStateful]. If an incorrect
   * type is given when requesting to change the state, this signal is not
   * emitted.
   * If no handler is connected to this signal then the default
   * behaviour is to call [Gio.SimpleAction.setState] to set the state
   * to the requested value. If you connect a signal handler then no
   * default action is taken. If the state should change then you must
   * call [Gio.SimpleAction.setState] from the handler.
   * An example of a 'change-state' handler:
   * |[<!-- language\="C" -->
   * static void
   * change_volume_state $(LPAREN)GSimpleAction *action,
   * GVariant      *value,
   * gpointer       user_data$(RPAREN)
   * {
   * gint requested;
   * requested \= g_variant_get_int32 $(LPAREN)value$(RPAREN);
   * // Volume only goes from 0 to 10
   * if $(LPAREN)0 <\= requested && requested <\= 10$(RPAREN)
   * g_simple_action_set_state $(LPAREN)action, value$(RPAREN);
   * }
   * ]|
   * The handler need not set the state to the requested value.
   * It could set it to any value at all, or take some other action.
   * Params
   *   value = the requested value for the state
   *   simpleAction = the instance the signal is connected to
   */
  alias ChangeStateCallback = void delegate(Variant value, SimpleAction simpleAction);

  /**
   * Connect to ChangeState signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChangeState(ChangeStateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto simpleAction = getVal!SimpleAction(_paramVals);
      auto value = getVal!Variant(&_paramVals[1]);
      _dgClosure.dlg(value, simpleAction);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("change-state", closure, after);
  }
}

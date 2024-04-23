module Gio.SimpleAction;

import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Action;
import Gio.ActionT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GSimpleAction is the obvious simple implementation of the #GAction
 * interface. This is the easiest way to create an action for purposes of
 * adding it to a #GSimpleActionGroup.
 *
 * See also #GtkAction.
 */
class SimpleAction : ObjectG, Action
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_simple_action_get_type();
  }

  mixin ActionT!GSimpleAction;

  /**
   * a new #GSimpleAction
   */
  this(string name, VariantType parameterType)
  {
    GSimpleAction* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_simple_action_new(_name, parameterType ? parameterType.cPtr!GVariantType : null);
    this(_cretval, true);
  }

  /**
   * a new #GSimpleAction
   */
  static SimpleAction newStateful(string name, VariantType parameterType, Variant state)
  {
    GSimpleAction* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_simple_action_new_stateful(_name, parameterType ? parameterType.cPtr!GVariantType : null, state ? state.cPtr!GVariant : null);
    SimpleAction _retval = ObjectG.getDObject!SimpleAction(cast(GSimpleAction*)_cretval, true);
    return _retval;
  }

  /**
   * Sets the action as enabled or not.
   *
   * An action must be enabled in order to be activated or in order to
   * have its state changed from outside callers.
   *
   * This should only be called by the implementor of the action.  Users
   * of the action should not attempt to modify its enabled flag.
   */
  void setEnabled(bool enabled)
  {
    g_simple_action_set_enabled(cPtr!GSimpleAction, enabled);
  }

  /**
   * Sets the state of the action.
   *
   * This directly updates the 'state' property to the given value.
   *
   * This should only be called by the implementor of the action.  Users
   * of the action should not attempt to directly modify the 'state'
   * property.  Instead, they should call g_action_change_state() to
   * request the change.
   *
   * If the @value GVariant is floating, it is consumed.
   */
  void setState(Variant value)
  {
    g_simple_action_set_state(cPtr!GSimpleAction, value ? value.cPtr!GVariant : null);
  }

  /**
   * Sets the state hint for the action.
   *
   * See g_action_get_state_hint() for more information about
   * action state hints.
   */
  void setStateHint(Variant stateHint)
  {
    g_simple_action_set_state_hint(cPtr!GSimpleAction, stateHint ? stateHint.cPtr!GVariant : null);
  }

  /**
   * Indicates that the action was just activated.
   *
   * @parameter will always be of the expected type, i.e. the parameter type
   * specified when the action was created. If an incorrect type is given when
   * activating the action, this signal is not emitted.
   *
   * Since GLib 2.40, if no handler is connected to this signal then the
   * default behaviour for boolean-stated actions with a %NULL parameter
   * type is to toggle them via the #GSimpleAction::change-state signal.
   * For stateful actions where the state type is equal to the parameter
   * type, the default is to forward them directly to
   * #GSimpleAction::change-state.  This should allow almost all users
   * of #GSimpleAction to connect only one handler or the other.
   */
  ulong connectActivate(void delegate(Variant parameter, SimpleAction simpleAction) dlg, ConnectFlags flags = ConnectFlags.Default)
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
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Indicates that the action just received a request to change its
   * state.
   *
   * @value will always be of the correct state type, i.e. the type of the
   * initial state passed to g_simple_action_new_stateful(). If an incorrect
   * type is given when requesting to change the state, this signal is not
   * emitted.
   *
   * If no handler is connected to this signal then the default
   * behaviour is to call g_simple_action_set_state() to set the state
   * to the requested value. If you connect a signal handler then no
   * default action is taken. If the state should change then you must
   * call g_simple_action_set_state() from the handler.
   *
   * An example of a 'change-state' handler:
   * |[<!-- language="C" -->
   * static void
   * change_volume_state (GSimpleAction *action,
   * GVariant      *value,
   * gpointer       user_data)
   * {
   * gint requested;
   *
   * requested = g_variant_get_int32 (value);
   *
   * // Volume only goes from 0 to 10
   * if (0 <= requested && requested <= 10)
   * g_simple_action_set_state (action, value);
   * }
   * ]|
   *
   * The handler need not set the state to the requested value.
   * It could set it to any value at all, or take some other action.
   */
  ulong connectChangeState(void delegate(Variant value, SimpleAction simpleAction) dlg, ConnectFlags flags = ConnectFlags.Default)
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
    return connectSignalClosure("change-state", closure, (flags & ConnectFlags.After) != 0);
  }
}

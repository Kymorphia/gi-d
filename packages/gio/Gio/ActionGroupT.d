module Gio.ActionGroupT;

public import GLib.Variant;
public import GLib.VariantType;
public import GObject.DClosure;
public import GObject.Types;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GActionGroup` represents a group of actions.
 * Actions can be used to expose functionality in a structured way, either
 * from one part of a program to another, or to the outside world. Action
 * groups are often used together with a `GMenuModel` that provides additional
 * representation data for displaying the actions to the user, e.g. in a menu.
 * The main way to interact with the actions in a `GActionGroup` is to
 * activate them with [Gio.ActionGroup.activateAction]. Activating an
 * action may require a `GVariant` parameter. The required type of the
 * parameter can be inquired with [Gio.ActionGroup.getActionParameterType].
 * Actions may be disabled, see [Gio.ActionGroup.getActionEnabled].
 * Activating a disabled action has no effect.
 * Actions may optionally have a state in the form of a #GVariant. The current
 * state of an action can be inquired with [Gio.ActionGroup.getActionState].
 * Activating a stateful action may change its state, but it is also possible to
 * set the state by calling [Gio.ActionGroup.changeActionState].
 * As typical example, consider a text editing application which has an
 * option to change the current font to 'bold'. A good way to represent
 * this would be a stateful action, with a boolean state. Activating the
 * action would toggle the state.
 * Each action in the group has a unique name $(LPAREN)which is a string$(RPAREN).  All
 * method calls, except [Gio.ActionGroup.listActions] take the name of
 * an action as an argument.
 * The `GActionGroup` API is meant to be the 'public' API to the action
 * group. The calls here are exactly the interaction that 'external
 * forces' $(LPAREN)eg: UI, incoming D-Bus messages, etc.$(RPAREN) are supposed to have
 * with actions. 'Internal' APIs $(LPAREN)ie: ones meant only to be accessed by
 * the action group implementation$(RPAREN) are found on subclasses. This is
 * why you will find - for example - [Gio.ActionGroup.getActionEnabled]
 * but not an equivalent set$(LPAREN)$(RPAREN) call.
 * Signals are emitted on the action group in response to state changes
 * on individual actions.
 * Implementations of `GActionGroup` should provide implementations for
 * the virtual functions [Gio.ActionGroup.listActions] and
 * [Gio.ActionGroup.queryAction]. The other virtual functions should
 * not be implemented - their "wrappers" are actually implemented with
 * calls to [Gio.ActionGroup.queryAction].
 */
template ActionGroupT(TStruct)
{

  /**
   * Emits the #GActionGroup::action-added signal on action_group.
   * This function should only be called by #GActionGroup implementations.
   * Params:
   *   actionName = the name of an action in the group
   */
  override void actionAdded(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_added(cast(GActionGroup*)cPtr, _actionName);
  }

  /**
   * Emits the #GActionGroup::action-enabled-changed signal on action_group.
   * This function should only be called by #GActionGroup implementations.
   * Params:
   *   actionName = the name of an action in the group
   *   enabled = whether or not the action is now enabled
   */
  override void actionEnabledChanged(string actionName, bool enabled)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_enabled_changed(cast(GActionGroup*)cPtr, _actionName, enabled);
  }

  /**
   * Emits the #GActionGroup::action-removed signal on action_group.
   * This function should only be called by #GActionGroup implementations.
   * Params:
   *   actionName = the name of an action in the group
   */
  override void actionRemoved(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_removed(cast(GActionGroup*)cPtr, _actionName);
  }

  /**
   * Emits the #GActionGroup::action-state-changed signal on action_group.
   * This function should only be called by #GActionGroup implementations.
   * Params:
   *   actionName = the name of an action in the group
   *   state = the new state of the named action
   */
  override void actionStateChanged(string actionName, Variant state)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_state_changed(cast(GActionGroup*)cPtr, _actionName, state ? cast(GVariant*)state.cPtr(false) : null);
  }

  /**
   * Activate the named action within action_group.
   * If the action is expecting a parameter, then the correct type of
   * parameter must be given as parameter.  If the action is expecting no
   * parameters then parameter must be %NULL.  See
   * [Gio.ActionGroup.getActionParameterType].
   * If the #GActionGroup implementation supports asynchronous remote
   * activation over D-Bus, this call may return before the relevant
   * D-Bus traffic has been sent, or any replies have been received. In
   * order to block on such asynchronous activation calls,
   * [Gio.DBusConnection.flush] should be called prior to the code, which
   * depends on the result of the action activation. Without flushing
   * the D-Bus connection, there is no guarantee that the action would
   * have been activated.
   * The following code which runs in a remote app instance, shows an
   * example of a "quit" action being activated on the primary app
   * instance over D-Bus. Here [Gio.DBusConnection.flush] is called
   * before `exit$(LPAREN)$(RPAREN)`. Without [Gio.DBusConnection.flush], the "quit" action
   * may fail to be activated on the primary instance.
   * |[<!-- language\="C" -->
   * // call "quit" action on primary instance
   * g_action_group_activate_action $(LPAREN)G_ACTION_GROUP $(LPAREN)app$(RPAREN), "quit", NULL$(RPAREN);
   * // make sure the action is activated now
   * g_dbus_connection_flush $(LPAREN)...$(RPAREN);
   * g_debug $(LPAREN)"application has been terminated. exiting."$(RPAREN);
   * exit $(LPAREN)0$(RPAREN);
   * ]|
   * Params:
   *   actionName = the name of the action to activate
   *   parameter = parameters to the activation
   */
  override void activateAction(string actionName, Variant parameter)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_activate_action(cast(GActionGroup*)cPtr, _actionName, parameter ? cast(GVariant*)parameter.cPtr(false) : null);
  }

  /**
   * Request for the state of the named action within action_group to be
   * changed to value.
   * The action must be stateful and value must be of the correct type.
   * See [Gio.ActionGroup.getActionStateType].
   * This call merely requests a change.  The action may refuse to change
   * its state or may change its state to something other than value.
   * See [Gio.ActionGroup.getActionStateHint].
   * If the value GVariant is floating, it is consumed.
   * Params:
   *   actionName = the name of the action to request the change on
   *   value = the new state
   */
  override void changeActionState(string actionName, Variant value)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_change_action_state(cast(GActionGroup*)cPtr, _actionName, value ? cast(GVariant*)value.cPtr(false) : null);
  }

  /**
   * Checks if the named action within action_group is currently enabled.
   * An action must be enabled in order to be activated or in order to
   * have its state changed from outside callers.
   * Params:
   *   actionName = the name of the action to query
   * Returns: whether or not the action is currently enabled
   */
  override bool getActionEnabled(string actionName)
  {
    bool _retval;
    const(char)* _actionName = actionName.toCString(false);
    _retval = g_action_group_get_action_enabled(cast(GActionGroup*)cPtr, _actionName);
    return _retval;
  }

  /**
   * Queries the type of the parameter that must be given when activating
   * the named action within action_group.
   * When activating the action using [Gio.ActionGroup.activateAction],
   * the #GVariant given to that function must be of the type returned
   * by this function.
   * In the case that this function returns %NULL, you must not give any
   * #GVariant, but %NULL instead.
   * The parameter type of a particular action will never change but it is
   * possible for an action to be removed and for a new action to be added
   * with the same name but a different parameter type.
   * Params:
   *   actionName = the name of the action to query
   * Returns: the parameter type
   */
  override VariantType getActionParameterType(string actionName)
  {
    const(GVariantType)* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_parameter_type(cast(GActionGroup*)cPtr, _actionName);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Queries the current state of the named action within action_group.
   * If the action is not stateful then %NULL will be returned.  If the
   * action is stateful then the type of the return value is the type
   * given by [Gio.ActionGroup.getActionStateType].
   * The return value $(LPAREN)if non-%NULL$(RPAREN) should be freed with
   * [GLib.Variant.unref] when it is no longer required.
   * Params:
   *   actionName = the name of the action to query
   * Returns: the current state of the action
   */
  override Variant getActionState(string actionName)
  {
    GVariant* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_state(cast(GActionGroup*)cPtr, _actionName);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Requests a hint about the valid range of values for the state of the
   * named action within action_group.
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
   * Params:
   *   actionName = the name of the action to query
   * Returns: the state range hint
   */
  override Variant getActionStateHint(string actionName)
  {
    GVariant* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_state_hint(cast(GActionGroup*)cPtr, _actionName);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Queries the type of the state of the named action within
   * action_group.
   * If the action is stateful then this function returns the
   * #GVariantType of the state.  All calls to
   * [Gio.ActionGroup.changeActionState] must give a #GVariant of this
   * type and [Gio.ActionGroup.getActionState] will return a #GVariant
   * of the same type.
   * If the action is not stateful then this function will return %NULL.
   * In that case, [Gio.ActionGroup.getActionState] will return %NULL
   * and you must not call [Gio.ActionGroup.changeActionState].
   * The state type of a particular action will never change but it is
   * possible for an action to be removed and for a new action to be added
   * with the same name but a different state type.
   * Params:
   *   actionName = the name of the action to query
   * Returns: the state type, if the action is stateful
   */
  override VariantType getActionStateType(string actionName)
  {
    const(GVariantType)* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_state_type(cast(GActionGroup*)cPtr, _actionName);
    auto _retval = _cretval ? new VariantType(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if the named action exists within action_group.
   * Params:
   *   actionName = the name of the action to check for
   * Returns: whether the named action exists
   */
  override bool hasAction(string actionName)
  {
    bool _retval;
    const(char)* _actionName = actionName.toCString(false);
    _retval = g_action_group_has_action(cast(GActionGroup*)cPtr, _actionName);
    return _retval;
  }

  /**
   * Lists the actions contained within action_group.
   * The caller is responsible for freeing the list with [GLib.Global.strfreev] when
   * it is no longer required.
   * Returns: a %NULL-terminated array of the names of the
   *   actions in the group
   */
  override string[] listActions()
  {
    char** _cretval;
    _cretval = g_action_group_list_actions(cast(GActionGroup*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Queries all aspects of the named action within an action_group.
   * This function acquires the information available from
   * [Gio.ActionGroup.hasAction], [Gio.ActionGroup.getActionEnabled],
   * [Gio.ActionGroup.getActionParameterType],
   * [Gio.ActionGroup.getActionStateType],
   * [Gio.ActionGroup.getActionStateHint] and
   * [Gio.ActionGroup.getActionState] with a single function call.
   * This provides two main benefits.
   * The first is the improvement in efficiency that comes with not having
   * to perform repeated lookups of the action in order to discover
   * different things about it.  The second is that implementing
   * #GActionGroup can now be done by only overriding this one virtual
   * function.
   * The interface provides a default implementation of this function that
   * calls the individual functions, as required, to fetch the
   * information.  The interface also provides default implementations of
   * those functions that call this function.  All implementations,
   * therefore, must override either this function or all of the others.
   * If the action exists, %TRUE is returned and any of the requested
   * fields $(LPAREN)as indicated by having a non-%NULL reference passed in$(RPAREN) are
   * filled.  If the action doesn't exist, %FALSE is returned and the
   * fields may or may not have been modified.
   * Params:
   *   actionName = the name of an action in the group
   *   enabled = if the action is presently enabled
   *   parameterType = the parameter type, or %NULL if none needed
   *   stateType = the state type, or %NULL if stateless
   *   stateHint = the state hint, or %NULL if none
   *   state = the current state, or %NULL if stateless
   * Returns: %TRUE if the action exists, else %FALSE
   */
  override bool queryAction(string actionName, out bool enabled, out VariantType parameterType, out VariantType stateType, out Variant stateHint, out Variant state)
  {
    bool _retval;
    const(char)* _actionName = actionName.toCString(false);
    const(GVariantType)* _parameterType;
    const(GVariantType)* _stateType;
    GVariant* _stateHint;
    GVariant* _state;
    _retval = g_action_group_query_action(cast(GActionGroup*)cPtr, _actionName, cast(bool*)&enabled, &_parameterType, &_stateType, &_stateHint, &_state);
    parameterType = new VariantType(cast(void*)_parameterType, false);
    stateType = new VariantType(cast(void*)_stateType, false);
    stateHint = new Variant(cast(void*)_stateHint, true);
    state = new Variant(cast(void*)_state, true);
    return _retval;
  }

  /**
   * Signals that a new action was just added to the group.
   * This signal is emitted after the action has been added
   * and is now visible.
   * Params
   *   actionName = the name of the action in action_group
   *   actionGroup = the instance the signal is connected to
   */
  alias ActionAddedCallback = void delegate(string actionName, ActionGroup actionGroup);

  /**
   * Connect to ActionAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActionAdded(ActionAddedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(actionName, actionGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("action-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Signals that the enabled status of the named action has changed.
   * Params
   *   actionName = the name of the action in action_group
   *   enabled = whether the action is enabled or not
   *   actionGroup = the instance the signal is connected to
   */
  alias ActionEnabledChangedCallback = void delegate(string actionName, bool enabled, ActionGroup actionGroup);

  /**
   * Connect to ActionEnabledChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActionEnabledChanged(ActionEnabledChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      auto enabled = getVal!bool(&_paramVals[2]);
      _dgClosure.dlg(actionName, enabled, actionGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("action-enabled-changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Signals that an action is just about to be removed from the group.
   * This signal is emitted before the action is removed, so the action
   * is still visible and can be queried from the signal handler.
   * Params
   *   actionName = the name of the action in action_group
   *   actionGroup = the instance the signal is connected to
   */
  alias ActionRemovedCallback = void delegate(string actionName, ActionGroup actionGroup);

  /**
   * Connect to ActionRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActionRemoved(ActionRemovedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(actionName, actionGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("action-removed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Signals that the state of the named action has changed.
   * Params
   *   actionName = the name of the action in action_group
   *   value = the new value of the state
   *   actionGroup = the instance the signal is connected to
   */
  alias ActionStateChangedCallback = void delegate(string actionName, Variant value, ActionGroup actionGroup);

  /**
   * Connect to ActionStateChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActionStateChanged(ActionStateChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      auto value = getVal!Variant(&_paramVals[2]);
      _dgClosure.dlg(actionName, value, actionGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("action-state-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

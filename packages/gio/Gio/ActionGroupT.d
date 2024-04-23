module Gio.ActionGroupT;

public import GLib.Types;
public import GLib.Variant;
public import GLib.VariantType;
public import GObject.DClosure;
public import GObject.Types;
public import Gid.Gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template ActionGroupT(TStruct)
{

  /**
   * Emits the #GActionGroup::action-added signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  override void actionAdded(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_added(cPtr!GActionGroup, _actionName);
  }

  /**
   * Emits the #GActionGroup::action-enabled-changed signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  override void actionEnabledChanged(string actionName, bool enabled)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_enabled_changed(cPtr!GActionGroup, _actionName, enabled);
  }

  /**
   * Emits the #GActionGroup::action-removed signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  override void actionRemoved(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_removed(cPtr!GActionGroup, _actionName);
  }

  /**
   * Emits the #GActionGroup::action-state-changed signal on @action_group.
   *
   * This function should only be called by #GActionGroup implementations.
   */
  override void actionStateChanged(string actionName, Variant state)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_action_state_changed(cPtr!GActionGroup, _actionName, state ? state.cPtr!GVariant : null);
  }

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
  override void activateAction(string actionName, Variant parameter)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_activate_action(cPtr!GActionGroup, _actionName, parameter ? parameter.cPtr!GVariant : null);
  }

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
  override void changeActionState(string actionName, Variant value)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_group_change_action_state(cPtr!GActionGroup, _actionName, value ? value.cPtr!GVariant : null);
  }

  /**
   * whether or not the action is currently enabled
   */
  override bool getActionEnabled(string actionName)
  {
    bool _retval;
    const(char)* _actionName = actionName.toCString(false);
    _retval = g_action_group_get_action_enabled(cPtr!GActionGroup, _actionName);
    return _retval;
  }

  /**
   * the parameter type
   */
  override VariantType getActionParameterType(string actionName)
  {
    const(GVariantType)* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_parameter_type(cPtr!GActionGroup, _actionName);
    VariantType _retval = new VariantType(cast(GVariantType*)_cretval, false);
    return _retval;
  }

  /**
   * the current state of the action
   */
  override Variant getActionState(string actionName)
  {
    GVariant* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_state(cPtr!GActionGroup, _actionName);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the state range hint
   */
  override Variant getActionStateHint(string actionName)
  {
    GVariant* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_state_hint(cPtr!GActionGroup, _actionName);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the state type, if the action is stateful
   */
  override VariantType getActionStateType(string actionName)
  {
    const(GVariantType)* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_group_get_action_state_type(cPtr!GActionGroup, _actionName);
    VariantType _retval = new VariantType(cast(GVariantType*)_cretval, false);
    return _retval;
  }

  /**
   * whether the named action exists
   */
  override bool hasAction(string actionName)
  {
    bool _retval;
    const(char)* _actionName = actionName.toCString(false);
    _retval = g_action_group_has_action(cPtr!GActionGroup, _actionName);
    return _retval;
  }

  /**
   * a %NULL-terminated array of the names of the
   * actions in the group
   */
  override string[] listActions()
  {
    char** _cretval;
    _cretval = g_action_group_list_actions(cPtr!GActionGroup);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * %TRUE if the action exists, else %FALSE
   */
  override bool queryAction(string actionName, out bool enabled, out VariantType parameterType, out VariantType stateType, out Variant stateHint, out Variant state)
  {
    bool _retval;
    const(char)* _actionName = actionName.toCString(false);
    const(GVariantType)* _parameterType;
    const(GVariantType)* _stateType;
    GVariant* _stateHint;
    GVariant* _state;
    _retval = g_action_group_query_action(cPtr!GActionGroup, _actionName, cast(bool*)&enabled, &_parameterType, &_stateType, &_stateHint, &_state);
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
   */
  ulong connectActionAdded(void delegate(string actionName, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      char* _actionName = actionName.toCString(false);
      _dgClosure.dlg(actionName, actionGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("action-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Signals that the enabled status of the named action has changed.
   */
  ulong connectActionEnabledChanged(void delegate(string actionName, bool enabled, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      char* _actionName = actionName.toCString(false);
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
   */
  ulong connectActionRemoved(void delegate(string actionName, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      char* _actionName = actionName.toCString(false);
      _dgClosure.dlg(actionName, actionGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("action-removed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Signals that the state of the named action has changed.
   */
  ulong connectActionStateChanged(void delegate(string actionName, Variant value, ActionGroup actionGroup) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto actionGroup = getVal!ActionGroup(_paramVals);
      auto actionName = getVal!string(&_paramVals[1]);
      char* _actionName = actionName.toCString(false);
      auto value = getVal!Variant(&_paramVals[2]);
      _dgClosure.dlg(actionName, value, actionGroup);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("action-state-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

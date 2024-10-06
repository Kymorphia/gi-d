module Gtk.Switch;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Actionable;
import Gtk.ActionableT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSwitch` is a "light switch" that has two states: on or off.
 * ![An example GtkSwitch](switch.png)
 * The user can control which state should be active by clicking the
 * empty area, or by dragging the handle.
 * `GtkSwitch` can also handle situations where the underlying state
 * changes with a delay. In this case, the slider position indicates
 * the user's recent change $(LPAREN)as indicated by the [Gtk.Switch.active]
 * property$(RPAREN), and the color indicates whether the underlying state $(LPAREN)represented
 * by the [Gtk.Switch.state] property$(RPAREN) has been updated yet.
 * ![GtkSwitch with delayed state change](switch-state.png)
 * See signal@Gtk.Switch::state-set for details.
 * # CSS nodes
 * ```
 * switch
 * ├── image
 * ├── image
 * ╰── slider
 * ```
 * `GtkSwitch` has four css nodes, the main node with the name switch and
 * subnodes for the slider and the on and off images. Neither of them is
 * using any style classes.
 * # Accessibility
 * `GtkSwitch` uses the %GTK_ACCESSIBLE_ROLE_SWITCH role.
 */
class Switch : Widget, Actionable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_switch_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionableT!GtkSwitch;

  /**
   * Creates a new `GtkSwitch` widget.
   * Returns: the newly created `GtkSwitch` instance
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_switch_new();
    this(_cretval, false);
  }

  /**
   * Gets whether the `GtkSwitch` is in its “on” or “off” state.
   * Returns: %TRUE if the `GtkSwitch` is active, and %FALSE otherwise
   */
  bool getActive()
  {
    bool _retval;
    _retval = gtk_switch_get_active(cast(GtkSwitch*)cPtr);
    return _retval;
  }

  /**
   * Gets the underlying state of the `GtkSwitch`.
   * Returns: the underlying state
   */
  bool getState()
  {
    bool _retval;
    _retval = gtk_switch_get_state(cast(GtkSwitch*)cPtr);
    return _retval;
  }

  /**
   * Changes the state of self to the desired one.
   * Params:
   *   isActive = %TRUE if self should be active, and %FALSE otherwise
   */
  void setActive(bool isActive)
  {
    gtk_switch_set_active(cast(GtkSwitch*)cPtr, isActive);
  }

  /**
   * Sets the underlying state of the `GtkSwitch`.
   * This function is typically called from a signalGtk.Switch::state-set
   * signal handler in order to set up delayed state changes.
   * See signalGtk.Switch::state-set for details.
   * Params:
   *   state = the new state
   */
  void setState(bool state)
  {
    gtk_switch_set_state(cast(GtkSwitch*)cPtr, state);
  }

  /**
   * Emitted to animate the switch.
   * Applications should never connect to this signal,
   * but use the [Gtk.Switch.active] property.
   *   switch_ = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(Switch switch_);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto switch_ = getVal!Switch(_paramVals);
      _dgClosure.dlg(switch_);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to change the underlying state.
   * The ::state-set signal is emitted when the user changes the switch
   * position. The default handler keeps the state in sync with the
   * [Gtk.Switch.active] property.
   * To implement delayed state change, applications can connect to this
   * signal, initiate the change of the underlying state, and call
   * [Gtk.Switch.setState] when the underlying state change is
   * complete. The signal handler should return %TRUE to prevent the
   * default handler from running.
   * Visually, the underlying state is represented by the trough color of
   * the switch, while the [Gtk.Switch.active] property is
   * represented by the position of the switch.
   * Params
   *   state = the new state of the switch
   *   switch_ = the instance the signal is connected to
   * Returns: %TRUE to stop the signal emission
   */
  alias StateSetCallback = bool delegate(bool state, Switch switch_);

  /**
   * Connect to StateSet signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectStateSet(StateSetCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto switch_ = getVal!Switch(_paramVals);
      auto state = getVal!bool(&_paramVals[1]);
      _retval = _dgClosure.dlg(state, switch_);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("state-set", closure, (flags & ConnectFlags.After) != 0);
  }
}

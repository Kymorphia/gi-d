module Gtk.SpinButton;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleRange;
import Gtk.AccessibleRangeT;
import Gtk.AccessibleT;
import Gtk.Adjustment;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.CellEditable;
import Gtk.CellEditableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Editable;
import Gtk.EditableT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkSpinButton` is an ideal way to allow the user to set the
 * value of some attribute.
 * ![An example GtkSpinButton](spinbutton.png)
 * Rather than having to directly type a number into a `GtkEntry`,
 * `GtkSpinButton` allows the user to click on one of two arrows
 * to increment or decrement the displayed value. A value can still be
 * typed in, with the bonus that it can be checked to ensure it is in a
 * given range.
 * The main properties of a `GtkSpinButton` are through an adjustment.
 * See the [Gtk.Adjustment] documentation for more details about
 * an adjustment's properties.
 * Note that `GtkSpinButton` will by default make its entry large enough
 * to accommodate the lower and upper bounds of the adjustment. If this
 * is not desired, the automatic sizing can be turned off by explicitly
 * setting property@Gtk.Editable:width-chars to a value !\= -1.
 * ## Using a GtkSpinButton to get an integer
 * ```c
 * // Provides a function to retrieve an integer value from a GtkSpinButton
 * // and creates a spin button to model percentage values.
 * int
 * grab_int_value $(LPAREN)GtkSpinButton *button,
 * gpointer       user_data$(RPAREN)
 * {
 * return gtk_spin_button_get_value_as_int $(LPAREN)button$(RPAREN);
 * }
 * void
 * create_integer_spin_button $(LPAREN)void$(RPAREN)
 * {
 * GtkWidget *window, *button;
 * GtkAdjustment *adjustment;
 * adjustment \= gtk_adjustment_new $(LPAREN)50.0, 0.0, 100.0, 1.0, 5.0, 0.0$(RPAREN);
 * window \= gtk_window_new $(LPAREN)$(RPAREN);
 * // creates the spinbutton, with no decimal places
 * button \= gtk_spin_button_new $(LPAREN)adjustment, 1.0, 0$(RPAREN);
 * gtk_window_set_child $(LPAREN)GTK_WINDOW $(LPAREN)window$(RPAREN), button$(RPAREN);
 * gtk_window_present $(LPAREN)GTK_WINDOW $(LPAREN)window$(RPAREN)$(RPAREN);
 * }
 * ```
 * ## Using a GtkSpinButton to get a floating point value
 * ```c
 * // Provides a function to retrieve a floating point value from a
 * // GtkSpinButton, and creates a high precision spin button.
 * float
 * grab_float_value $(LPAREN)GtkSpinButton *button,
 * gpointer       user_data$(RPAREN)
 * {
 * return gtk_spin_button_get_value $(LPAREN)button$(RPAREN);
 * }
 * void
 * create_floating_spin_button $(LPAREN)void$(RPAREN)
 * {
 * GtkWidget *window, *button;
 * GtkAdjustment *adjustment;
 * adjustment \= gtk_adjustment_new $(LPAREN)2.500, 0.0, 5.0, 0.001, 0.1, 0.0$(RPAREN);
 * window \= gtk_window_new $(LPAREN)$(RPAREN);
 * // creates the spinbutton, with three decimal places
 * button \= gtk_spin_button_new $(LPAREN)adjustment, 0.001, 3$(RPAREN);
 * gtk_window_set_child $(LPAREN)GTK_WINDOW $(LPAREN)window$(RPAREN), button$(RPAREN);
 * gtk_window_present $(LPAREN)GTK_WINDOW $(LPAREN)window$(RPAREN)$(RPAREN);
 * }
 * ```
 * # CSS nodes
 * ```
 * spinbutton.horizontal
 * ├── text
 * │    ├── undershoot.left
 * │    ╰── undershoot.right
 * ├── button.down
 * ╰── button.up
 * ```
 * ```
 * spinbutton.vertical
 * ├── button.up
 * ├── text
 * │    ├── undershoot.left
 * │    ╰── undershoot.right
 * ╰── button.down
 * ```
 * `GtkSpinButton`s main CSS node has the name spinbutton. It creates subnodes
 * for the entry and the two buttons, with these names. The button nodes have
 * the style classes .up and .down. The `GtkText` subnodes $(LPAREN)if present$(RPAREN) are put
 * below the text node. The orientation of the spin button is reflected in
 * the .vertical or .horizontal style class on the main node.
 * # Accessibility
 * `GtkSpinButton` uses the %GTK_ACCESSIBLE_ROLE_SPIN_BUTTON role.
 */
class SpinButton : Widget, AccessibleRange, CellEditable, Editable, Orientable
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
    return gtk_spin_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleRangeT!();
  mixin CellEditableT!();
  mixin EditableT!();
  mixin OrientableT!();

  /**
   * Creates a new `GtkSpinButton`.
   * Params:
   *   adjustment = the `GtkAdjustment` that this spin button should use
   *   climbRate = specifies by how much the rate of change in the value will
   *     accelerate if you continue to hold down an up/down button or arrow key
   *   digits = the number of decimal places to display
   * Returns: The new `GtkSpinButton`
   */
  this(Adjustment adjustment, double climbRate, uint digits)
  {
    GtkWidget* _cretval;
    _cretval = gtk_spin_button_new(adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null, climbRate, digits);
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkSpinButton` with the given properties.
   * This is a convenience constructor that allows creation
   * of a numeric `GtkSpinButton` without manually creating
   * an adjustment. The value is initially set to the minimum
   * value and a page increment of 10 * step is the default.
   * The precision of the spin button is equivalent to the
   * precision of step.
   * Note that the way in which the precision is derived works
   * best if step is a power of ten. If the resulting precision
   * is not suitable for your needs, use
   * [Gtk.SpinButton.setDigits] to correct it.
   * Params:
   *   min = Minimum allowable value
   *   max = Maximum allowable value
   *   step = Increment added or subtracted by spinning the widget
   * Returns: The new `GtkSpinButton`
   */
  static SpinButton newWithRange(double min, double max, double step)
  {
    GtkWidget* _cretval;
    _cretval = gtk_spin_button_new_with_range(min, max, step);
    auto _retval = _cretval ? ObjectG.getDObject!SpinButton(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Changes the properties of an existing spin button.
   * The adjustment, climb rate, and number of decimal places
   * are updated accordingly.
   * Params:
   *   adjustment = a `GtkAdjustment` to replace the spin button’s
   *     existing adjustment, or %NULL to leave its current adjustment unchanged
   *   climbRate = the new climb rate
   *   digits = the number of decimal places to display in the spin button
   */
  void configure(Adjustment adjustment, double climbRate, uint digits)
  {
    gtk_spin_button_configure(cast(GtkSpinButton*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null, climbRate, digits);
  }

  /**
   * Retrieves the value set by [Gtk.SpinButton.setActivatesDefault].
   * Returns: %TRUE if the spin button will activate the default widget
   */
  bool getActivatesDefault()
  {
    bool _retval;
    _retval = gtk_spin_button_get_activates_default(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Get the adjustment associated with a `GtkSpinButton`.
   * Returns: the `GtkAdjustment` of spin_button
   */
  Adjustment getAdjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_spin_button_get_adjustment(cast(GtkSpinButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the acceleration rate for repeated changes.
   * Returns: the acceleration rate
   */
  double getClimbRate()
  {
    double _retval;
    _retval = gtk_spin_button_get_climb_rate(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Fetches the precision of spin_button.
   * Returns: the current precision
   */
  uint getDigits()
  {
    uint _retval;
    _retval = gtk_spin_button_get_digits(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the current step and page the increments
   * used by spin_button.
   * See [Gtk.SpinButton.setIncrements].
   * Params:
   *   step = location to store step increment
   *   page = location to store page increment
   */
  void getIncrements(out double step, out double page)
  {
    gtk_spin_button_get_increments(cast(GtkSpinButton*)cPtr, cast(double*)&step, cast(double*)&page);
  }

  /**
   * Returns whether non-numeric text can be typed into the spin button.
   * Returns: %TRUE if only numeric text can be entered
   */
  bool getNumeric()
  {
    bool _retval;
    _retval = gtk_spin_button_get_numeric(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the range allowed for spin_button.
   * See [Gtk.SpinButton.setRange].
   * Params:
   *   min = location to store minimum allowed value
   *   max = location to store maximum allowed value
   */
  void getRange(out double min, out double max)
  {
    gtk_spin_button_get_range(cast(GtkSpinButton*)cPtr, cast(double*)&min, cast(double*)&max);
  }

  /**
   * Returns whether the values are corrected to the nearest step.
   * Returns: %TRUE if values are snapped to the nearest step
   */
  bool getSnapToTicks()
  {
    bool _retval;
    _retval = gtk_spin_button_get_snap_to_ticks(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the update behavior of a spin button.
   * See [Gtk.SpinButton.setUpdatePolicy].
   * Returns: the current update policy
   */
  SpinButtonUpdatePolicy getUpdatePolicy()
  {
    GtkSpinButtonUpdatePolicy _cretval;
    _cretval = gtk_spin_button_get_update_policy(cast(GtkSpinButton*)cPtr);
    SpinButtonUpdatePolicy _retval = cast(SpinButtonUpdatePolicy)_cretval;
    return _retval;
  }

  /**
   * Get the value in the spin_button.
   * Returns: the value of spin_button
   */
  double getValue()
  {
    double _retval;
    _retval = gtk_spin_button_get_value(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Get the value spin_button represented as an integer.
   * Returns: the value of spin_button
   */
  int getValueAsInt()
  {
    int _retval;
    _retval = gtk_spin_button_get_value_as_int(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the spin button’s value wraps around to the
   * opposite limit when the upper or lower limit of the range is
   * exceeded.
   * Returns: %TRUE if the spin button wraps around
   */
  bool getWrap()
  {
    bool _retval;
    _retval = gtk_spin_button_get_wrap(cast(GtkSpinButton*)cPtr);
    return _retval;
  }

  /**
   * Sets whether activating the spin button will activate the default
   * widget for the window containing the spin button.
   * See [Gtk.SpinButton.activate] for what counts as activation.
   * Params:
   *   activatesDefault = %TRUE to activate window’s default widget on activation
   */
  void setActivatesDefault(bool activatesDefault)
  {
    gtk_spin_button_set_activates_default(cast(GtkSpinButton*)cPtr, activatesDefault);
  }

  /**
   * Replaces the `GtkAdjustment` associated with spin_button.
   * Params:
   *   adjustment = a `GtkAdjustment` to replace the existing adjustment
   */
  void setAdjustment(Adjustment adjustment)
  {
    gtk_spin_button_set_adjustment(cast(GtkSpinButton*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
  }

  /**
   * Sets the acceleration rate for repeated changes when you
   * hold down a button or key.
   * Params:
   *   climbRate = the rate of acceleration, must be >\= 0
   */
  void setClimbRate(double climbRate)
  {
    gtk_spin_button_set_climb_rate(cast(GtkSpinButton*)cPtr, climbRate);
  }

  /**
   * Set the precision to be displayed by spin_button.
   * Up to 20 digit precision is allowed.
   * Params:
   *   digits = the number of digits after the decimal point to be
   *     displayed for the spin button’s value
   */
  void setDigits(uint digits)
  {
    gtk_spin_button_set_digits(cast(GtkSpinButton*)cPtr, digits);
  }

  /**
   * Sets the step and page increments for spin_button.
   * This affects how quickly the value changes when
   * the spin button’s arrows are activated.
   * Params:
   *   step = increment applied for a button 1 press.
   *   page = increment applied for a button 2 press.
   */
  void setIncrements(double step, double page)
  {
    gtk_spin_button_set_increments(cast(GtkSpinButton*)cPtr, step, page);
  }

  /**
   * Sets the flag that determines if non-numeric text can be typed
   * into the spin button.
   * Params:
   *   numeric = flag indicating if only numeric entry is allowed
   */
  void setNumeric(bool numeric)
  {
    gtk_spin_button_set_numeric(cast(GtkSpinButton*)cPtr, numeric);
  }

  /**
   * Sets the minimum and maximum allowable values for spin_button.
   * If the current value is outside this range, it will be adjusted
   * to fit within the range, otherwise it will remain unchanged.
   * Params:
   *   min = minimum allowable value
   *   max = maximum allowable value
   */
  void setRange(double min, double max)
  {
    gtk_spin_button_set_range(cast(GtkSpinButton*)cPtr, min, max);
  }

  /**
   * Sets the policy as to whether values are corrected to the
   * nearest step increment when a spin button is activated after
   * providing an invalid value.
   * Params:
   *   snapToTicks = a flag indicating if invalid values should be corrected
   */
  void setSnapToTicks(bool snapToTicks)
  {
    gtk_spin_button_set_snap_to_ticks(cast(GtkSpinButton*)cPtr, snapToTicks);
  }

  /**
   * Sets the update behavior of a spin button.
   * This determines whether the spin button is always
   * updated or only when a valid value is set.
   * Params:
   *   policy = a `GtkSpinButtonUpdatePolicy` value
   */
  void setUpdatePolicy(SpinButtonUpdatePolicy policy)
  {
    gtk_spin_button_set_update_policy(cast(GtkSpinButton*)cPtr, policy);
  }

  /**
   * Sets the value of spin_button.
   * Params:
   *   value = the new value
   */
  void setValue(double value)
  {
    gtk_spin_button_set_value(cast(GtkSpinButton*)cPtr, value);
  }

  /**
   * Sets the flag that determines if a spin button value wraps
   * around to the opposite limit when the upper or lower limit
   * of the range is exceeded.
   * Params:
   *   wrap = a flag indicating if wrapping behavior is performed
   */
  void setWrap(bool wrap)
  {
    gtk_spin_button_set_wrap(cast(GtkSpinButton*)cPtr, wrap);
  }

  /**
   * Increment or decrement a spin button’s value in a specified
   * direction by a specified amount.
   * Params:
   *   direction = a `GtkSpinType` indicating the direction to spin
   *   increment = step increment to apply in the specified direction
   */
  void spin(SpinType direction, double increment)
  {
    gtk_spin_button_spin(cast(GtkSpinButton*)cPtr, direction, increment);
  }

  /**
   * Manually force an update of the spin button.
   */
  void update()
  {
    gtk_spin_button_update(cast(GtkSpinButton*)cPtr);
  }

  /**
   * Emitted when the spin button is activated.
   * The keybindings for this signal are all forms of the <kbd>Enter</kbd> key.
   * If the <kbd>Enter</kbd> key results in the value being committed to the
   * spin button, then activation does not occur until <kbd>Enter</kbd> is
   * pressed again.
   *   spinButton = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(SpinButton spinButton);

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
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto spinButton = getVal!SpinButton(_paramVals);
      _dgClosure.dlg(spinButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }

  /**
   * Emitted when the user initiates a value change.
   * This is a [keybinding signal](class.SignalAction.html).
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control the cursor
   * programmatically.
   * The default bindings for this signal are Up/Down and PageUp/PageDown.
   * Params
   *   scroll = a `GtkScrollType` to specify the speed and amount of change
   *   spinButton = the instance the signal is connected to
   */
  alias ChangeValueCallback = void delegate(ScrollType scroll, SpinButton spinButton);

  /**
   * Connect to ChangeValue signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChangeValue(ChangeValueCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto spinButton = getVal!SpinButton(_paramVals);
      auto scroll = getVal!ScrollType(&_paramVals[1]);
      _dgClosure.dlg(scroll, spinButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("change-value", closure, after);
  }

  /**
   * Emitted to tweak the formatting of the value for display.
   * ```c
   * // show leading zeros
   * static gboolean
   * on_output $(LPAREN)GtkSpinButton *spin,
   * gpointer       data$(RPAREN)
   * {
   * char *text;
   * int value;
   * value \= gtk_spin_button_get_value_as_int $(LPAREN)spin$(RPAREN);
   * text \= g_strdup_printf $(LPAREN)"%02d", value$(RPAREN);
   * gtk_editable_set_text $(LPAREN)GTK_EDITABLE $(LPAREN)spin$(RPAREN), text$(RPAREN):
   * g_free $(LPAREN)text$(RPAREN);
   * return TRUE;
   * }
   * ```
   *   spinButton = the instance the signal is connected to
   * Returns: %TRUE if the value has been displayed
   */
  alias OutputCallback = bool delegate(SpinButton spinButton);

  /**
   * Connect to Output signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectOutput(OutputCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto spinButton = getVal!SpinButton(_paramVals);
      _retval = _dgClosure.dlg(spinButton);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("output", closure, after);
  }

  /**
   * Emitted when the value is changed.
   * Also see the [Gtk.SpinButton.output] signal.
   *   spinButton = the instance the signal is connected to
   */
  alias ValueChangedCallback = void delegate(SpinButton spinButton);

  /**
   * Connect to ValueChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectValueChanged(ValueChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto spinButton = getVal!SpinButton(_paramVals);
      _dgClosure.dlg(spinButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("value-changed", closure, after);
  }

  /**
   * Emitted right after the spinbutton wraps from its maximum
   * to its minimum value or vice-versa.
   *   spinButton = the instance the signal is connected to
   */
  alias WrappedCallback = void delegate(SpinButton spinButton);

  /**
   * Connect to Wrapped signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectWrapped(WrappedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto spinButton = getVal!SpinButton(_paramVals);
      _dgClosure.dlg(spinButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("wrapped", closure, after);
  }
}

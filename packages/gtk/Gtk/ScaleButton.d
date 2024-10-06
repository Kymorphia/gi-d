module Gtk.ScaleButton;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleRange;
import Gtk.AccessibleRangeT;
import Gtk.AccessibleT;
import Gtk.Adjustment;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.Button;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkScaleButton` provides a button which pops up a scale widget.
 * This kind of widget is commonly used for volume controls in multimedia
 * applications, and GTK provides a [Gtk.VolumeButton] subclass that
 * is tailored for this use case.
 * # CSS nodes
 * ```
 * scalebutton.scale
 * ╰── button.toggle
 * ╰── <icon>
 * ```
 * `GtkScaleButton` has a single CSS node with name scalebutton and `.scale`
 * style class, and contains a `button` node with a `.toggle` style class.
 */
class ScaleButton : Widget, AccessibleRange, Orientable
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
    return gtk_scale_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleRangeT!GtkScaleButton;
  mixin OrientableT!GtkScaleButton;

  /**
   * Queries a `GtkScaleButton` and returns its current state.
   * Returns %TRUE if the scale button is pressed in and %FALSE
   * if it is raised.
   * Returns: whether the button is pressed
   */
  bool getActive()
  {
    bool _retval;
    _retval = gtk_scale_button_get_active(cast(GtkScaleButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GtkAdjustment` associated with the `GtkScaleButton`’s scale.
   * See [Gtk.Range.getAdjustment] for details.
   * Returns: the adjustment associated with the scale
   */
  Adjustment getAdjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_scale_button_get_adjustment(cast(GtkScaleButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the button has a frame.
   * Returns: %TRUE if the button has a frame
   */
  bool getHasFrame()
  {
    bool _retval;
    _retval = gtk_scale_button_get_has_frame(cast(GtkScaleButton*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the minus button of the `GtkScaleButton`.
   * Returns: the minus button
   *   of the `GtkScaleButton`
   */
  Button getMinusButton()
  {
    GtkWidget* _cretval;
    _cretval = gtk_scale_button_get_minus_button(cast(GtkScaleButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Button(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the plus button of the `GtkScaleButton.`
   * Returns: the plus button
   *   of the `GtkScaleButton`
   */
  Button getPlusButton()
  {
    GtkWidget* _cretval;
    _cretval = gtk_scale_button_get_plus_button(cast(GtkScaleButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Button(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the popup of the `GtkScaleButton`.
   * Returns: the popup of the `GtkScaleButton`
   */
  Widget getPopup()
  {
    GtkWidget* _cretval;
    _cretval = gtk_scale_button_get_popup(cast(GtkScaleButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current value of the scale button.
   * Returns: current value of the scale button
   */
  double getValue()
  {
    double _retval;
    _retval = gtk_scale_button_get_value(cast(GtkScaleButton*)cPtr);
    return _retval;
  }

  /**
   * Sets the `GtkAdjustment` to be used as a model
   * for the `GtkScaleButton`’s scale.
   * See [Gtk.Range.setAdjustment] for details.
   * Params:
   *   adjustment = a `GtkAdjustment`
   */
  void setAdjustment(Adjustment adjustment)
  {
    gtk_scale_button_set_adjustment(cast(GtkScaleButton*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
  }

  /**
   * Sets the style of the button.
   * Params:
   *   hasFrame = whether the button should have a visible frame
   */
  void setHasFrame(bool hasFrame)
  {
    gtk_scale_button_set_has_frame(cast(GtkScaleButton*)cPtr, hasFrame);
  }

  /**
   * Sets the current value of the scale.
   * If the value is outside the minimum or maximum range values,
   * it will be clamped to fit inside them.
   * The scale button emits the signalGtk.ScaleButton::value-changed
   * signal if the value changes.
   * Params:
   *   value = new value of the scale button
   */
  void setValue(double value)
  {
    gtk_scale_button_set_value(cast(GtkScaleButton*)cPtr, value);
  }

  /**
   * Emitted to dismiss the popup.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is <kbd>Escape</kbd>.
   *   scaleButton = the instance the signal is connected to
   */
  alias PopdownCallback = void delegate(ScaleButton scaleButton);

  /**
   * Connect to Popdown signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPopdown(PopdownCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto scaleButton = getVal!ScaleButton(_paramVals);
      _dgClosure.dlg(scaleButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("popdown", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to popup the scale widget.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are <kbd>Space</kbd>,
   * <kbd>Enter</kbd> and <kbd>Return</kbd>.
   *   scaleButton = the instance the signal is connected to
   */
  alias PopupCallback = void delegate(ScaleButton scaleButton);

  /**
   * Connect to Popup signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPopup(PopupCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto scaleButton = getVal!ScaleButton(_paramVals);
      _dgClosure.dlg(scaleButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("popup", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the value field has changed.
   * Params
   *   value = the new value
   *   scaleButton = the instance the signal is connected to
   */
  alias ValueChangedCallback = void delegate(double value, ScaleButton scaleButton);

  /**
   * Connect to ValueChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectValueChanged(ValueChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto scaleButton = getVal!ScaleButton(_paramVals);
      auto value = getVal!double(&_paramVals[1]);
      _dgClosure.dlg(value, scaleButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("value-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

module Gtk.Adjustment;

import GObject.DClosure;
import GObject.InitiallyUnowned;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkAdjustment` is a model for a numeric value.
 * The `GtkAdjustment` has an associated lower and upper bound.
 * It also contains step and page increments, and a page size.
 * Adjustments are used within several GTK widgets, including
 * [Gtk.SpinButton], [Gtk.Viewport], [Gtk.Scrollbar]
 * and [Gtk.Scale].
 * The `GtkAdjustment` object does not update the value itself. Instead
 * it is left up to the owner of the `GtkAdjustment` to control the value.
 */
class Adjustment : InitiallyUnowned
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
    return gtk_adjustment_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkAdjustment`.
   * Params:
   *   value = the initial value
   *   lower = the minimum value
   *   upper = the maximum value
   *   stepIncrement = the step increment
   *   pageIncrement = the page increment
   *   pageSize = the page size
   * Returns: a new `GtkAdjustment`
   */
  this(double value, double lower, double upper, double stepIncrement, double pageIncrement, double pageSize)
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_adjustment_new(value, lower, upper, stepIncrement, pageIncrement, pageSize);
    this(_cretval, false);
  }

  /**
   * Updates the value property to ensure that the range
   * between lower and upper is in the current page.
   * The current page goes from `value` to `value` + `page-size`.
   * If the range is larger than the page size, then only the
   * start of it will be in the current page.
   * A signalGtk.Adjustment::value-changed signal will be emitted
   * if the value is changed.
   * Params:
   *   lower = the lower value
   *   upper = the upper value
   */
  void clampPage(double lower, double upper)
  {
    gtk_adjustment_clamp_page(cast(GtkAdjustment*)cPtr, lower, upper);
  }

  /**
   * Sets all properties of the adjustment at once.
   * Use this function to avoid multiple emissions of the
   * [Gtk.Adjustment.changed] signal. See
   * [Gtk.Adjustment.setLower] for an alternative
   * way of compressing multiple emissions of
   * [Gtk.Adjustment.changed] into one.
   * Params:
   *   value = the new value
   *   lower = the new minimum value
   *   upper = the new maximum value
   *   stepIncrement = the new step increment
   *   pageIncrement = the new page increment
   *   pageSize = the new page size
   */
  void configure(double value, double lower, double upper, double stepIncrement, double pageIncrement, double pageSize)
  {
    gtk_adjustment_configure(cast(GtkAdjustment*)cPtr, value, lower, upper, stepIncrement, pageIncrement, pageSize);
  }

  /**
   * Retrieves the minimum value of the adjustment.
   * Returns: The current minimum value of the adjustment
   */
  double getLower()
  {
    double _retval;
    _retval = gtk_adjustment_get_lower(cast(GtkAdjustment*)cPtr);
    return _retval;
  }

  /**
   * Gets the smaller of step increment and page increment.
   * Returns: the minimum increment of adjustment
   */
  double getMinimumIncrement()
  {
    double _retval;
    _retval = gtk_adjustment_get_minimum_increment(cast(GtkAdjustment*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the page increment of the adjustment.
   * Returns: The current page increment of the adjustment
   */
  double getPageIncrement()
  {
    double _retval;
    _retval = gtk_adjustment_get_page_increment(cast(GtkAdjustment*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the page size of the adjustment.
   * Returns: The current page size of the adjustment
   */
  double getPageSize()
  {
    double _retval;
    _retval = gtk_adjustment_get_page_size(cast(GtkAdjustment*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the step increment of the adjustment.
   * Returns: The current step increment of the adjustment.
   */
  double getStepIncrement()
  {
    double _retval;
    _retval = gtk_adjustment_get_step_increment(cast(GtkAdjustment*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the maximum value of the adjustment.
   * Returns: The current maximum value of the adjustment
   */
  double getUpper()
  {
    double _retval;
    _retval = gtk_adjustment_get_upper(cast(GtkAdjustment*)cPtr);
    return _retval;
  }

  /**
   * Gets the current value of the adjustment.
   * Returns: The current value of the adjustment
   */
  double getValue()
  {
    double _retval;
    _retval = gtk_adjustment_get_value(cast(GtkAdjustment*)cPtr);
    return _retval;
  }

  /**
   * Sets the minimum value of the adjustment.
   * When setting multiple adjustment properties via their individual
   * setters, multiple [Gtk.Adjustment.changed] signals will
   * be emitted. However, since the emission of the
   * [Gtk.Adjustment.changed] signal is tied to the emission
   * of the ::notify signals of the changed properties, it’s possible
   * to compress the [Gtk.Adjustment.changed] signals into one
   * by calling [GObject.ObjectG.freezeNotify] and [GObject.ObjectG.thawNotify]
   * around the calls to the individual setters.
   * Alternatively, using a single [GObject.ObjectG.set] for all the properties
   * to change, or using [Gtk.Adjustment.configure] has the same effect.
   * Params:
   *   lower = the new minimum value
   */
  void setLower(double lower)
  {
    gtk_adjustment_set_lower(cast(GtkAdjustment*)cPtr, lower);
  }

  /**
   * Sets the page increment of the adjustment.
   * See [Gtk.Adjustment.setLower] about how to compress
   * multiple emissions of the [Gtk.Adjustment.changed]
   * signal when setting multiple adjustment properties.
   * Params:
   *   pageIncrement = the new page increment
   */
  void setPageIncrement(double pageIncrement)
  {
    gtk_adjustment_set_page_increment(cast(GtkAdjustment*)cPtr, pageIncrement);
  }

  /**
   * Sets the page size of the adjustment.
   * See [Gtk.Adjustment.setLower] about how to compress
   * multiple emissions of the [Gtk.Adjustment.changed]
   * signal when setting multiple adjustment properties.
   * Params:
   *   pageSize = the new page size
   */
  void setPageSize(double pageSize)
  {
    gtk_adjustment_set_page_size(cast(GtkAdjustment*)cPtr, pageSize);
  }

  /**
   * Sets the step increment of the adjustment.
   * See [Gtk.Adjustment.setLower] about how to compress
   * multiple emissions of the [Gtk.Adjustment.changed]
   * signal when setting multiple adjustment properties.
   * Params:
   *   stepIncrement = the new step increment
   */
  void setStepIncrement(double stepIncrement)
  {
    gtk_adjustment_set_step_increment(cast(GtkAdjustment*)cPtr, stepIncrement);
  }

  /**
   * Sets the maximum value of the adjustment.
   * Note that values will be restricted by `upper - page-size`
   * if the page-size property is nonzero.
   * See [Gtk.Adjustment.setLower] about how to compress
   * multiple emissions of the [Gtk.Adjustment.changed]
   * signal when setting multiple adjustment properties.
   * Params:
   *   upper = the new maximum value
   */
  void setUpper(double upper)
  {
    gtk_adjustment_set_upper(cast(GtkAdjustment*)cPtr, upper);
  }

  /**
   * Sets the `GtkAdjustment` value.
   * The value is clamped to lie between [Gtk.Adjustment.lower]
   * and [Gtk.Adjustment.upper].
   * Note that for adjustments which are used in a `GtkScrollbar`,
   * the effective range of allowed values goes from
   * [Gtk.Adjustment.lower] to
   * [Gtk.Adjustment.upper] - propertyGtk.Adjustment:page-size.
   * Params:
   *   value = the new value
   */
  void setValue(double value)
  {
    gtk_adjustment_set_value(cast(GtkAdjustment*)cPtr, value);
  }

  /**
   * Emitted when one or more of the `GtkAdjustment` properties have been
   * changed.
   * Note that the [Gtk.Adjustment.value] property is
   * covered by the signalGtk.Adjustment::value-changed signal.
   *   adjustment = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Adjustment adjustment);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto adjustment = getVal!Adjustment(_paramVals);
      _dgClosure.dlg(adjustment);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }

  /**
   * Emitted when the value has been changed.
   *   adjustment = the instance the signal is connected to
   */
  alias ValueChangedCallback = void delegate(Adjustment adjustment);

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
      auto adjustment = getVal!Adjustment(_paramVals);
      _dgClosure.dlg(adjustment);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("value-changed", closure, after);
  }
}

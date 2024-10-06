module Gtk.Range;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gdk.Rectangle;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleRange;
import Gtk.AccessibleRangeT;
import Gtk.AccessibleT;
import Gtk.Adjustment;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkRange` is the common base class for widgets which visualize an
 * adjustment.
 * Widgets that are derived from `GtkRange` include
 * [Gtk.Scale] and [Gtk.Scrollbar].
 * Apart from signals for monitoring the parameters of the adjustment,
 * `GtkRange` provides properties and methods for setting a
 * “fill level” on range widgets. See [Gtk.Range.setFillLevel].
 */
class Range : Widget, AccessibleRange, Orientable
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
    return gtk_range_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleRangeT!GtkRange;
  mixin OrientableT!GtkRange;

  /**
   * Get the adjustment which is the “model” object for `GtkRange`.
   * Returns: a `GtkAdjustment`
   */
  Adjustment getAdjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_range_get_adjustment(cast(GtkRange*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current position of the fill level indicator.
   * Returns: The current fill level
   */
  double getFillLevel()
  {
    double _retval;
    _retval = gtk_range_get_fill_level(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the `GtkRange` respects text direction.
   * See [Gtk.Range.setFlippable].
   * Returns: %TRUE if the range is flippable
   */
  bool getFlippable()
  {
    bool _retval;
    _retval = gtk_range_get_flippable(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the range is inverted.
   * See [Gtk.Range.setInverted].
   * Returns: %TRUE if the range is inverted
   */
  bool getInverted()
  {
    bool _retval;
    _retval = gtk_range_get_inverted(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * This function returns the area that contains the range’s trough,
   * in coordinates relative to range's origin.
   * This function is useful mainly for `GtkRange` subclasses.
   * Params:
   *   rangeRect = return location for the range rectangle
   */
  void getRangeRect(out Rectangle rangeRect)
  {
    GdkRectangle _rangeRect;
    gtk_range_get_range_rect(cast(GtkRange*)cPtr, &_rangeRect);
    rangeRect = new Rectangle(cast(void*)&_rangeRect, false);
  }

  /**
   * Gets whether the range is restricted to the fill level.
   * Returns: %TRUE if range is restricted to the fill level.
   */
  bool getRestrictToFillLevel()
  {
    bool _retval;
    _retval = gtk_range_get_restrict_to_fill_level(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * Gets the number of digits to round the value to when
   * it changes.
   * See signalGtk.Range::change-value.
   * Returns: the number of digits to round to
   */
  int getRoundDigits()
  {
    int _retval;
    _retval = gtk_range_get_round_digits(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the range displays the fill level graphically.
   * Returns: %TRUE if range shows the fill level.
   */
  bool getShowFillLevel()
  {
    bool _retval;
    _retval = gtk_range_get_show_fill_level(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * This function returns sliders range along the long dimension,
   * in widget->window coordinates.
   * This function is useful mainly for `GtkRange` subclasses.
   * Params:
   *   sliderStart = return location for the slider's start
   *   sliderEnd = return location for the slider's end
   */
  void getSliderRange(out int sliderStart, out int sliderEnd)
  {
    gtk_range_get_slider_range(cast(GtkRange*)cPtr, cast(int*)&sliderStart, cast(int*)&sliderEnd);
  }

  /**
   * This function is useful mainly for `GtkRange` subclasses.
   * See [Gtk.Range.setSliderSizeFixed].
   * Returns: whether the range’s slider has a fixed size.
   */
  bool getSliderSizeFixed()
  {
    bool _retval;
    _retval = gtk_range_get_slider_size_fixed(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * Gets the current value of the range.
   * Returns: current value of the range.
   */
  double getValue()
  {
    double _retval;
    _retval = gtk_range_get_value(cast(GtkRange*)cPtr);
    return _retval;
  }

  /**
   * Sets the adjustment to be used as the “model” object for the `GtkRange`
   * The adjustment indicates the current range value, the minimum and
   * maximum range values, the step/page increments used for keybindings
   * and scrolling, and the page size.
   * The page size is normally 0 for `GtkScale` and nonzero for `GtkScrollbar`,
   * and indicates the size of the visible area of the widget being scrolled.
   * The page size affects the size of the scrollbar slider.
   * Params:
   *   adjustment = a `GtkAdjustment`
   */
  void setAdjustment(Adjustment adjustment)
  {
    gtk_range_set_adjustment(cast(GtkRange*)cPtr, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
  }

  /**
   * Set the new position of the fill level indicator.
   * The “fill level” is probably best described by its most prominent
   * use case, which is an indicator for the amount of pre-buffering in
   * a streaming media player. In that use case, the value of the range
   * would indicate the current play position, and the fill level would
   * be the position up to which the file/stream has been downloaded.
   * This amount of prebuffering can be displayed on the range’s trough
   * and is themeable separately from the trough. To enable fill level
   * display, use [Gtk.Range.setShowFillLevel]. The range defaults
   * to not showing the fill level.
   * Additionally, it’s possible to restrict the range’s slider position
   * to values which are smaller than the fill level. This is controlled
   * by [Gtk.Range.setRestrictToFillLevel] and is by default
   * enabled.
   * Params:
   *   fillLevel = the new position of the fill level indicator
   */
  void setFillLevel(double fillLevel)
  {
    gtk_range_set_fill_level(cast(GtkRange*)cPtr, fillLevel);
  }

  /**
   * Sets whether the `GtkRange` respects text direction.
   * If a range is flippable, it will switch its direction
   * if it is horizontal and its direction is %GTK_TEXT_DIR_RTL.
   * See [Gtk.Widget.getDirection].
   * Params:
   *   flippable = %TRUE to make the range flippable
   */
  void setFlippable(bool flippable)
  {
    gtk_range_set_flippable(cast(GtkRange*)cPtr, flippable);
  }

  /**
   * Sets the step and page sizes for the range.
   * The step size is used when the user clicks the `GtkScrollbar`
   * arrows or moves a `GtkScale` via arrow keys. The page size
   * is used for example when moving via Page Up or Page Down keys.
   * Params:
   *   step = step size
   *   page = page size
   */
  void setIncrements(double step, double page)
  {
    gtk_range_set_increments(cast(GtkRange*)cPtr, step, page);
  }

  /**
   * Sets whether to invert the range.
   * Ranges normally move from lower to higher values as the
   * slider moves from top to bottom or left to right. Inverted
   * ranges have higher values at the top or on the right rather
   * than on the bottom or left.
   * Params:
   *   setting = %TRUE to invert the range
   */
  void setInverted(bool setting)
  {
    gtk_range_set_inverted(cast(GtkRange*)cPtr, setting);
  }

  /**
   * Sets the allowable values in the `GtkRange`.
   * The range value is clamped to be between min and max.
   * $(LPAREN)If the range has a non-zero page size, it is clamped
   * between min and max - page-size.$(RPAREN)
   * Params:
   *   min = minimum range value
   *   max = maximum range value
   */
  void setRange(double min, double max)
  {
    gtk_range_set_range(cast(GtkRange*)cPtr, min, max);
  }

  /**
   * Sets whether the slider is restricted to the fill level.
   * See [Gtk.Range.setFillLevel] for a general description
   * of the fill level concept.
   * Params:
   *   restrictToFillLevel = Whether the fill level restricts slider movement.
   */
  void setRestrictToFillLevel(bool restrictToFillLevel)
  {
    gtk_range_set_restrict_to_fill_level(cast(GtkRange*)cPtr, restrictToFillLevel);
  }

  /**
   * Sets the number of digits to round the value to when
   * it changes.
   * See signalGtk.Range::change-value.
   * Params:
   *   roundDigits = the precision in digits, or -1
   */
  void setRoundDigits(int roundDigits)
  {
    gtk_range_set_round_digits(cast(GtkRange*)cPtr, roundDigits);
  }

  /**
   * Sets whether a graphical fill level is show on the trough.
   * See [Gtk.Range.setFillLevel] for a general description
   * of the fill level concept.
   * Params:
   *   showFillLevel = Whether a fill level indicator graphics is shown.
   */
  void setShowFillLevel(bool showFillLevel)
  {
    gtk_range_set_show_fill_level(cast(GtkRange*)cPtr, showFillLevel);
  }

  /**
   * Sets whether the range’s slider has a fixed size, or a size that
   * depends on its adjustment’s page size.
   * This function is useful mainly for `GtkRange` subclasses.
   * Params:
   *   sizeFixed = %TRUE to make the slider size constant
   */
  void setSliderSizeFixed(bool sizeFixed)
  {
    gtk_range_set_slider_size_fixed(cast(GtkRange*)cPtr, sizeFixed);
  }

  /**
   * Sets the current value of the range.
   * If the value is outside the minimum or maximum range values,
   * it will be clamped to fit inside them. The range emits the
   * signalGtk.Range::value-changed signal if the value changes.
   * Params:
   *   value = new value of the range
   */
  void setValue(double value)
  {
    gtk_range_set_value(cast(GtkRange*)cPtr, value);
  }

  /**
   * Emitted before clamping a value, to give the application a
   * chance to adjust the bounds.
   * Params
   *   value = the value before we clamp
   *   range = the instance the signal is connected to
   */
  alias AdjustBoundsCallback = void delegate(double value, Range range);

  /**
   * Connect to AdjustBounds signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAdjustBounds(AdjustBoundsCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto range = getVal!Range(_paramVals);
      auto value = getVal!double(&_paramVals[1]);
      _dgClosure.dlg(value, range);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("adjust-bounds", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a scroll action is performed on a range.
   * It allows an application to determine the type of scroll event
   * that occurred and the resultant new value. The application can
   * handle the event itself and return %TRUE to prevent further
   * processing. Or, by returning %FALSE, it can pass the event to
   * other handlers until the default GTK handler is reached.
   * The value parameter is unrounded. An application that overrides
   * the ::change-value signal is responsible for clamping the value
   * to the desired number of decimal digits; the default GTK
   * handler clamps the value based on propertyGtk.Range:round-digits.
   * Params
   *   scroll = the type of scroll action that was performed
   *   value = the new value resulting from the scroll action
   *   range = the instance the signal is connected to
   * Returns: %TRUE to prevent other handlers from being invoked for
   *   the signal, %FALSE to propagate the signal further
   */
  alias ChangeValueCallback = bool delegate(ScrollType scroll, double value, Range range);

  /**
   * Connect to ChangeValue signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectChangeValue(ChangeValueCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto range = getVal!Range(_paramVals);
      auto scroll = getVal!ScrollType(&_paramVals[1]);
      auto value = getVal!double(&_paramVals[2]);
      _retval = _dgClosure.dlg(scroll, value, range);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("change-value", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Virtual function that moves the slider.
   * Used for keybindings.
   * Params
   *   step = how to move the slider
   *   range = the instance the signal is connected to
   */
  alias MoveSliderCallback = void delegate(ScrollType step, Range range);

  /**
   * Connect to MoveSlider signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectMoveSlider(MoveSliderCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto range = getVal!Range(_paramVals);
      auto step = getVal!ScrollType(&_paramVals[1]);
      _dgClosure.dlg(step, range);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-slider", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the range value changes.
   *   range = the instance the signal is connected to
   */
  alias ValueChangedCallback = void delegate(Range range);

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
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto range = getVal!Range(_paramVals);
      _dgClosure.dlg(range);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("value-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

module Gtk.Scale;

import GObject.ObjectG;
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
import Gtk.Range;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.Layout;

/**
 * A `GtkScale` is a slider control used to select a numeric value.
 * ![An example GtkScale](scales.png)
 * To use it, you’ll probably want to investigate the methods on its base
 * class, [Gtk.Range], in addition to the methods for `GtkScale` itself.
 * To set the value of a scale, you would normally use [Gtk.Range.setValue].
 * To detect changes to the value, you would normally use the
 * signal@Gtk.Range::value-changed signal.
 * Note that using the same upper and lower bounds for the `GtkScale` $(LPAREN)through
 * the `GtkRange` methods$(RPAREN) will hide the slider itself. This is useful for
 * applications that want to show an undeterminate value on the scale, without
 * changing the layout of the application $(LPAREN)such as movie or music players$(RPAREN).
 * # GtkScale as GtkBuildable
 * `GtkScale` supports a custom `<marks>` element, which can contain multiple
 * `<mark\>` elements. The “value” and “position” attributes have the same
 * meaning as [Gtk.Scale.addMark] parameters of the same name. If
 * the element is not empty, its content is taken as the markup to show at
 * the mark. It can be translated with the usual ”translatable” and
 * “context” attributes.
 * # CSS nodes
 * ```
 * scale[.fine-tune][.marks-before][.marks-after]
 * ├── [value][.top][.right][.bottom][.left]
 * ├── marks.top
 * │   ├── mark
 * │   ┊    ├── [label]
 * │   ┊    ╰── indicator
 * ┊   ┊
 * │   ╰── mark
 * ├── marks.bottom
 * │   ├── mark
 * │   ┊    ├── indicator
 * │   ┊    ╰── [label]
 * ┊   ┊
 * │   ╰── mark
 * ╰── trough
 * ├── [fill]
 * ├── [highlight]
 * ╰── slider
 * ```
 * `GtkScale` has a main CSS node with name scale and a subnode for its contents,
 * with subnodes named trough and slider.
 * The main node gets the style class .fine-tune added when the scale is in
 * 'fine-tuning' mode.
 * If the scale has an origin $(LPAREN)see [Gtk.Scale.setHasOrigin]$(RPAREN), there is
 * a subnode with name highlight below the trough node that is used for rendering
 * the highlighted part of the trough.
 * If the scale is showing a fill level $(LPAREN)see [Gtk.Range.setShowFillLevel]$(RPAREN),
 * there is a subnode with name fill below the trough node that is used for
 * rendering the filled in part of the trough.
 * If marks are present, there is a marks subnode before or after the trough
 * node, below which each mark gets a node with name mark. The marks nodes get
 * either the .top or .bottom style class.
 * The mark node has a subnode named indicator. If the mark has text, it also
 * has a subnode named label. When the mark is either above or left of the
 * scale, the label subnode is the first when present. Otherwise, the indicator
 * subnode is the first.
 * The main CSS node gets the 'marks-before' and/or 'marks-after' style classes
 * added depending on what marks are present.
 * If the scale is displaying the value $(LPAREN)see property@Gtk.Scale:draw-value$(RPAREN),
 * there is subnode with name value. This node will get the .top or .bottom style
 * classes similar to the marks node.
 * # Accessibility
 * `GtkScale` uses the %GTK_ACCESSIBLE_ROLE_SLIDER role.
 */
class Scale : Range
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
    return gtk_scale_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkScale`.
   * Params:
   *   orientation = the scale’s orientation.
   *   adjustment = the [Gtk.Adjustment] which sets
   *     the range of the scale, or %NULL to create a new adjustment.
   * Returns: a new `GtkScale`
   */
  this(Orientation orientation, Adjustment adjustment)
  {
    GtkWidget* _cretval;
    _cretval = gtk_scale_new(orientation, adjustment ? cast(GtkAdjustment*)adjustment.cPtr(false) : null);
    this(_cretval, false);
  }

  /**
   * Creates a new scale widget with a range from min to max.
   * The returns scale will have the given orientation and will let the
   * user input a number between min and max $(LPAREN)including min and max$(RPAREN)
   * with the increment step. step must be nonzero; it’s the distance
   * the slider moves when using the arrow keys to adjust the scale
   * value.
   * Note that the way in which the precision is derived works best if
   * step is a power of ten. If the resulting precision is not suitable
   * for your needs, use [Gtk.Scale.setDigits] to correct it.
   * Params:
   *   orientation = the scale’s orientation.
   *   min = minimum value
   *   max = maximum value
   *   step = step increment $(LPAREN)tick size$(RPAREN) used with keyboard shortcuts
   * Returns: a new `GtkScale`
   */
  static Scale newWithRange(Orientation orientation, double min, double max, double step)
  {
    GtkWidget* _cretval;
    _cretval = gtk_scale_new_with_range(orientation, min, max, step);
    auto _retval = _cretval ? ObjectG.getDObject!Scale(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a mark at value.
   * A mark is indicated visually by drawing a tick mark next to the scale,
   * and GTK makes it easy for the user to position the scale exactly at the
   * marks value.
   * If markup is not %NULL, text is shown next to the tick mark.
   * To remove marks from a scale, use [Gtk.Scale.clearMarks].
   * Params:
   *   value = the value at which the mark is placed, must be between
   *     the lower and upper limits of the scales’ adjustment
   *   position = where to draw the mark. For a horizontal scale, %GTK_POS_TOP
   *     and %GTK_POS_LEFT are drawn above the scale, anything else below.
   *     For a vertical scale, %GTK_POS_LEFT and %GTK_POS_TOP are drawn to
   *     the left of the scale, anything else to the right.
   *   markup = Text to be shown at the mark, using Pango markup
   */
  void addMark(double value, PositionType position, string markup)
  {
    const(char)* _markup = markup.toCString(false);
    gtk_scale_add_mark(cast(GtkScale*)cPtr, value, position, _markup);
  }

  /**
   * Removes any marks that have been added.
   */
  void clearMarks()
  {
    gtk_scale_clear_marks(cast(GtkScale*)cPtr);
  }

  /**
   * Gets the number of decimal places that are displayed in the value.
   * Returns: the number of decimal places that are displayed
   */
  int getDigits()
  {
    int _retval;
    _retval = gtk_scale_get_digits(cast(GtkScale*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the current value is displayed as a string
   * next to the slider.
   * Returns: whether the current value is displayed as a string
   */
  bool getDrawValue()
  {
    bool _retval;
    _retval = gtk_scale_get_draw_value(cast(GtkScale*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the scale has an origin.
   * Returns: %TRUE if the scale has an origin.
   */
  bool getHasOrigin()
  {
    bool _retval;
    _retval = gtk_scale_get_has_origin(cast(GtkScale*)cPtr);
    return _retval;
  }

  /**
   * Gets the `PangoLayout` used to display the scale.
   * The returned object is owned by the scale so does not need
   * to be freed by the caller.
   * Returns: the [Pango.Layout]
   *   for this scale, or %NULL if the propertyGtk.Scale:draw-value
   *   property is %FALSE.
   */
  Layout getLayout()
  {
    PangoLayout* _cretval;
    _cretval = gtk_scale_get_layout(cast(GtkScale*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the coordinates where the scale will draw the
   * `PangoLayout` representing the text in the scale.
   * Remember when using the `PangoLayout` function you need to
   * convert to and from pixels using `PANGO_PIXELS$(LPAREN)$(RPAREN)` or `PANGO_SCALE`.
   * If the propertyGtk.Scale:draw-value property is %FALSE, the return
   * values are undefined.
   * Params:
   *   x = location to store X offset of layout
   *   y = location to store Y offset of layout
   */
  void getLayoutOffsets(out int x, out int y)
  {
    gtk_scale_get_layout_offsets(cast(GtkScale*)cPtr, cast(int*)&x, cast(int*)&y);
  }

  /**
   * Gets the position in which the current value is displayed.
   * Returns: the position in which the current value is displayed
   */
  PositionType getValuePos()
  {
    GtkPositionType _cretval;
    _cretval = gtk_scale_get_value_pos(cast(GtkScale*)cPtr);
    PositionType _retval = cast(PositionType)_cretval;
    return _retval;
  }

  /**
   * Sets the number of decimal places that are displayed in the value.
   * Also causes the value of the adjustment to be rounded to this number
   * of digits, so the retrieved value matches the displayed one, if
   * propertyGtk.Scale:draw-value is %TRUE when the value changes. If
   * you want to enforce rounding the value when propertyGtk.Scale:draw-value
   * is %FALSE, you can set propertyGtk.Range:round-digits instead.
   * Note that rounding to a small number of digits can interfere with
   * the smooth autoscrolling that is built into `GtkScale`. As an alternative,
   * you can use [Gtk.Scale.setFormatValueFunc] to format the displayed
   * value yourself.
   * Params:
   *   digits = the number of decimal places to display,
   *     e.g. use 1 to display 1.0, 2 to display 1.00, etc
   */
  void setDigits(int digits)
  {
    gtk_scale_set_digits(cast(GtkScale*)cPtr, digits);
  }

  /**
   * Specifies whether the current value is displayed as a string next
   * to the slider.
   * Params:
   *   drawValue = %TRUE to draw the value
   */
  void setDrawValue(bool drawValue)
  {
    gtk_scale_set_draw_value(cast(GtkScale*)cPtr, drawValue);
  }

  /**
   * func allows you to change how the scale value is displayed.
   * The given function will return an allocated string representing
   * value. That string will then be used to display the scale's value.
   * If #NULL is passed as func, the value will be displayed on
   * its own, rounded according to the value of the
   * [Gtk.Scale.digits] property.
   * Params:
   *   func = function that formats the value
   */
  void setFormatValueFunc(ScaleFormatValueFunc func)
  {
    extern(C) char* _funcCallback(GtkScale* scale, double value, void* userData)
    {
      string _dretval;
      auto _dlg = cast(ScaleFormatValueFunc*)userData;

      _dretval = (*_dlg)(scale ? ObjectG.getDObject!Scale(cast(void*)scale, false) : null, value);
      char* _retval = _dretval.toCString(true);

      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    gtk_scale_set_format_value_func(cast(GtkScale*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Sets whether the scale has an origin.
   * If propertyGtk.Scale:has-origin is set to %TRUE $(LPAREN)the default$(RPAREN),
   * the scale will highlight the part of the trough between the origin
   * $(LPAREN)bottom or left side$(RPAREN) and the current value.
   * Params:
   *   hasOrigin = %TRUE if the scale has an origin
   */
  void setHasOrigin(bool hasOrigin)
  {
    gtk_scale_set_has_origin(cast(GtkScale*)cPtr, hasOrigin);
  }

  /**
   * Sets the position in which the current value is displayed.
   * Params:
   *   pos = the position in which the current value is displayed
   */
  void setValuePos(PositionType pos)
  {
    gtk_scale_set_value_pos(cast(GtkScale*)cPtr, pos);
  }
}

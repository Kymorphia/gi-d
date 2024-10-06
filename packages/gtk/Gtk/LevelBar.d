module Gtk.LevelBar;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleRange;
import Gtk.AccessibleRangeT;
import Gtk.AccessibleT;
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
 * `GtkLevelBar` is a widget that can be used as a level indicator.
 * Typical use cases are displaying the strength of a password, or
 * showing the charge level of a battery.
 * ![An example GtkLevelBar](levelbar.png)
 * Use [Gtk.LevelBar.setValue] to set the current value, and
 * [Gtk.LevelBar.addOffsetValue] to set the value offsets at which
 * the bar will be considered in a different state. GTK will add a few
 * offsets by default on the level bar: %GTK_LEVEL_BAR_OFFSET_LOW,
 * %GTK_LEVEL_BAR_OFFSET_HIGH and %GTK_LEVEL_BAR_OFFSET_FULL, with
 * values 0.25, 0.75 and 1.0 respectively.
 * Note that it is your responsibility to update preexisting offsets
 * when changing the minimum or maximum value. GTK will simply clamp
 * them to the new range.
 * ## Adding a custom offset on the bar
 * ```c
 * static GtkWidget *
 * create_level_bar $(LPAREN)void$(RPAREN)
 * {
 * GtkWidget *widget;
 * GtkLevelBar *bar;
 * widget \= gtk_level_bar_new $(LPAREN)$(RPAREN);
 * bar \= GTK_LEVEL_BAR $(LPAREN)widget$(RPAREN);
 * // This changes the value of the default low offset
 * gtk_level_bar_add_offset_value $(LPAREN)bar,
 * GTK_LEVEL_BAR_OFFSET_LOW,
 * 0.10$(RPAREN);
 * // This adds a new offset to the bar; the application will
 * // be able to change its color CSS like this:
 * //
 * // levelbar block.my-offset {
 * //   background-color: magenta;
 * //   border-style: solid;
 * //   border-color: black;
 * //   border-width: 1px;
 * // }
 * gtk_level_bar_add_offset_value $(LPAREN)bar, "my-offset", 0.60$(RPAREN);
 * return widget;
 * }
 * ```
 * The default interval of values is between zero and one, but it’s possible
 * to modify the interval using [Gtk.LevelBar.setMinValue] and
 * [Gtk.LevelBar.setMaxValue]. The value will be always drawn in
 * proportion to the admissible interval, i.e. a value of 15 with a specified
 * interval between 10 and 20 is equivalent to a value of 0.5 with an interval
 * between 0 and 1. When %GTK_LEVEL_BAR_MODE_DISCRETE is used, the bar level
 * is rendered as a finite number of separated blocks instead of a single one.
 * The number of blocks that will be rendered is equal to the number of units
 * specified by the admissible interval.
 * For instance, to build a bar rendered with five blocks, it’s sufficient to
 * set the minimum value to 0 and the maximum value to 5 after changing the
 * indicator mode to discrete.
 * # GtkLevelBar as GtkBuildable
 * The `GtkLevelBar` implementation of the `GtkBuildable` interface supports a
 * custom `<offsets>` element, which can contain any number of `<offset>` elements,
 * each of which must have "name" and "value" attributes.
 * # CSS nodes
 * ```
 * levelbar[.discrete]
 * ╰── trough
 * ├── block.filled.level-name
 * ┊
 * ├── block.empty
 * ┊
 * ```
 * `GtkLevelBar` has a main CSS node with name levelbar and one of the style
 * classes .discrete or .continuous and a subnode with name trough. Below the
 * trough node are a number of nodes with name block and style class .filled
 * or .empty. In continuous mode, there is exactly one node of each, in discrete
 * mode, the number of filled and unfilled nodes corresponds to blocks that are
 * drawn. The block.filled nodes also get a style class .level-name corresponding
 * to the level for the current value.
 * In horizontal orientation, the nodes are always arranged from left to right,
 * regardless of text direction.
 * # Accessibility
 * `GtkLevelBar` uses the %GTK_ACCESSIBLE_ROLE_METER role.
 */
class LevelBar : Widget, AccessibleRange, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_level_bar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleRangeT!GtkLevelBar;
  mixin OrientableT!GtkLevelBar;

  /**
   * Creates a new `GtkLevelBar`.
   * Returns: a `GtkLevelBar`.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_level_bar_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkLevelBar` for the specified interval.
   * Params:
   *   minValue = a positive value
   *   maxValue = a positive value
   * Returns: a `GtkLevelBar`
   */
  static LevelBar newForInterval(double minValue, double maxValue)
  {
    GtkWidget* _cretval;
    _cretval = gtk_level_bar_new_for_interval(minValue, maxValue);
    auto _retval = _cretval ? ObjectG.getDObject!LevelBar(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a new offset marker on self at the position specified by value.
   * When the bar value is in the interval topped by value $(LPAREN)or between value
   * and propertyGtk.LevelBar:max-value in case the offset is the last one
   * on the bar$(RPAREN) a style class named `level-`name will be applied
   * when rendering the level bar fill.
   * If another offset marker named name exists, its value will be
   * replaced by value.
   * Params:
   *   name = the name of the new offset
   *   value = the value for the new offset
   */
  void addOffsetValue(string name, double value)
  {
    const(char)* _name = name.toCString(false);
    gtk_level_bar_add_offset_value(cast(GtkLevelBar*)cPtr, _name, value);
  }

  /**
   * Returns whether the levelbar is inverted.
   * Returns: %TRUE if the level bar is inverted
   */
  bool getInverted()
  {
    bool _retval;
    _retval = gtk_level_bar_get_inverted(cast(GtkLevelBar*)cPtr);
    return _retval;
  }

  /**
   * Returns the `max-value` of the `GtkLevelBar`.
   * Returns: a positive value
   */
  double getMaxValue()
  {
    double _retval;
    _retval = gtk_level_bar_get_max_value(cast(GtkLevelBar*)cPtr);
    return _retval;
  }

  /**
   * Returns the `min-value` of the `GtkLevelBar`.
   * Returns: a positive value
   */
  double getMinValue()
  {
    double _retval;
    _retval = gtk_level_bar_get_min_value(cast(GtkLevelBar*)cPtr);
    return _retval;
  }

  /**
   * Returns the `mode` of the `GtkLevelBar`.
   * Returns: a `GtkLevelBarMode`
   */
  LevelBarMode getMode()
  {
    GtkLevelBarMode _cretval;
    _cretval = gtk_level_bar_get_mode(cast(GtkLevelBar*)cPtr);
    LevelBarMode _retval = cast(LevelBarMode)_cretval;
    return _retval;
  }

  /**
   * Fetches the value specified for the offset marker name in self.
   * Params:
   *   name = the name of an offset in the bar
   *   value = location where to store the value
   * Returns: %TRUE if the specified offset is found
   */
  bool getOffsetValue(string name, out double value)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = gtk_level_bar_get_offset_value(cast(GtkLevelBar*)cPtr, _name, cast(double*)&value);
    return _retval;
  }

  /**
   * Returns the `value` of the `GtkLevelBar`.
   * Returns: a value in the interval between
   *   propertyGtk.LevelBar:min-value and propertyGtk.LevelBar:max-value
   */
  double getValue()
  {
    double _retval;
    _retval = gtk_level_bar_get_value(cast(GtkLevelBar*)cPtr);
    return _retval;
  }

  /**
   * Removes an offset marker from a `GtkLevelBar`.
   * The marker must have been previously added with
   * [Gtk.LevelBar.addOffsetValue].
   * Params:
   *   name = the name of an offset in the bar
   */
  void removeOffsetValue(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_level_bar_remove_offset_value(cast(GtkLevelBar*)cPtr, _name);
  }

  /**
   * Sets whether the `GtkLevelBar` is inverted.
   * Params:
   *   inverted = %TRUE to invert the level bar
   */
  void setInverted(bool inverted)
  {
    gtk_level_bar_set_inverted(cast(GtkLevelBar*)cPtr, inverted);
  }

  /**
   * Sets the `max-value` of the `GtkLevelBar`.
   * You probably want to update preexisting level offsets after calling
   * this function.
   * Params:
   *   value = a positive value
   */
  void setMaxValue(double value)
  {
    gtk_level_bar_set_max_value(cast(GtkLevelBar*)cPtr, value);
  }

  /**
   * Sets the `min-value` of the `GtkLevelBar`.
   * You probably want to update preexisting level offsets after calling
   * this function.
   * Params:
   *   value = a positive value
   */
  void setMinValue(double value)
  {
    gtk_level_bar_set_min_value(cast(GtkLevelBar*)cPtr, value);
  }

  /**
   * Sets the `mode` of the `GtkLevelBar`.
   * Params:
   *   mode = a `GtkLevelBarMode`
   */
  void setMode(LevelBarMode mode)
  {
    gtk_level_bar_set_mode(cast(GtkLevelBar*)cPtr, mode);
  }

  /**
   * Sets the value of the `GtkLevelBar`.
   * Params:
   *   value = a value in the interval between
   *     propertyGtk.LevelBar:min-value and propertyGtk.LevelBar:max-value
   */
  void setValue(double value)
  {
    gtk_level_bar_set_value(cast(GtkLevelBar*)cPtr, value);
  }

  /**
   * Emitted when an offset specified on the bar changes value.
   * This typically is the result of a [Gtk.LevelBar.addOffsetValue]
   * call.
   * The signal supports detailed connections; you can connect to the
   * detailed signal "changed::x" in order to only receive callbacks when
   * the value of offset "x" changes.
   * Params
   *   name = the name of the offset that changed value
   *   levelBar = the instance the signal is connected to
   */
  alias OffsetChangedCallback = void delegate(string name, LevelBar levelBar);

  /**
   * Connect to OffsetChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectOffsetChanged(OffsetChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto levelBar = getVal!LevelBar(_paramVals);
      auto name = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(name, levelBar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("offset-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

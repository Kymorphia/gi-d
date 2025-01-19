module Gtk.ProgressBar;

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
import Pango.Types;

/**
 * `GtkProgressBar` is typically used to display the progress of a long
 * running operation.
 * It provides a visual clue that processing is underway. `GtkProgressBar`
 * can be used in two different modes: percentage mode and activity mode.
 * ![An example GtkProgressBar](progressbar.png)
 * When an application can determine how much work needs to take place
 * $(LPAREN)e.g. read a fixed number of bytes from a file$(RPAREN) and can monitor its
 * progress, it can use the `GtkProgressBar` in percentage mode and the
 * user sees a growing bar indicating the percentage of the work that
 * has been completed. In this mode, the application is required to call
 * [Gtk.ProgressBar.setFraction] periodically to update the progress bar.
 * When an application has no accurate way of knowing the amount of work
 * to do, it can use the `GtkProgressBar` in activity mode, which shows
 * activity by a block moving back and forth within the progress area. In
 * this mode, the application is required to call [Gtk.ProgressBar.pulse]
 * periodically to update the progress bar.
 * There is quite a bit of flexibility provided to control the appearance
 * of the `GtkProgressBar`. Functions are provided to control the orientation
 * of the bar, optional text can be displayed along with the bar, and the
 * step size used in activity mode can be set.
 * # CSS nodes
 * ```
 * progressbar[.osd]
 * ├── [text]
 * ╰── trough[.empty][.full]
 * ╰── progress[.pulse]
 * ```
 * `GtkProgressBar` has a main CSS node with name progressbar and subnodes with
 * names text and trough, of which the latter has a subnode named progress. The
 * text subnode is only present if text is shown. The progress subnode has the
 * style class .pulse when in activity mode. It gets the style classes .left,
 * .right, .top or .bottom added when the progress 'touches' the corresponding
 * end of the GtkProgressBar. The .osd class on the progressbar node is for use
 * in overlays like the one Epiphany has for page loading progress.
 * # Accessibility
 * `GtkProgressBar` uses the %GTK_ACCESSIBLE_ROLE_PROGRESS_BAR role.
 */
class ProgressBar : Widget, AccessibleRange, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_progress_bar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleRangeT!();
  mixin OrientableT!();

  /**
   * Creates a new `GtkProgressBar`.
   * Returns: a `GtkProgressBar`.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_progress_bar_new();
    this(_cretval, false);
  }

  /**
   * Returns the ellipsizing position of the progress bar.
   * See [Gtk.ProgressBar.setEllipsize].
   * Returns: `PangoEllipsizeMode`
   */
  EllipsizeMode getEllipsize()
  {
    PangoEllipsizeMode _cretval;
    _cretval = gtk_progress_bar_get_ellipsize(cast(GtkProgressBar*)cPtr);
    EllipsizeMode _retval = cast(EllipsizeMode)_cretval;
    return _retval;
  }

  /**
   * Returns the current fraction of the task that’s been completed.
   * Returns: a fraction from 0.0 to 1.0
   */
  double getFraction()
  {
    double _retval;
    _retval = gtk_progress_bar_get_fraction(cast(GtkProgressBar*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the progress bar is inverted.
   * Returns: %TRUE if the progress bar is inverted
   */
  bool getInverted()
  {
    bool _retval;
    _retval = gtk_progress_bar_get_inverted(cast(GtkProgressBar*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the pulse step.
   * See [Gtk.ProgressBar.setPulseStep].
   * Returns: a fraction from 0.0 to 1.0
   */
  double getPulseStep()
  {
    double _retval;
    _retval = gtk_progress_bar_get_pulse_step(cast(GtkProgressBar*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the `GtkProgressBar` shows text.
   * See [Gtk.ProgressBar.setShowText].
   * Returns: %TRUE if text is shown in the progress bar
   */
  bool getShowText()
  {
    bool _retval;
    _retval = gtk_progress_bar_get_show_text(cast(GtkProgressBar*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the text that is displayed with the progress bar.
   * The return value is a reference to the text, not a copy of it,
   * so will become invalid if you change the text in the progress bar.
   * Returns: the text
   */
  string getText()
  {
    const(char)* _cretval;
    _cretval = gtk_progress_bar_get_text(cast(GtkProgressBar*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Indicates that some progress has been made, but you don’t know how much.
   * Causes the progress bar to enter “activity mode,” where a block
   * bounces back and forth. Each call to [Gtk.ProgressBar.pulse]
   * causes the block to move by a little bit $(LPAREN)the amount of movement
   * per pulse is determined by [Gtk.ProgressBar.setPulseStep]$(RPAREN).
   */
  void pulse()
  {
    gtk_progress_bar_pulse(cast(GtkProgressBar*)cPtr);
  }

  /**
   * Sets the mode used to ellipsize the text.
   * The text is ellipsized if there is not enough space
   * to render the entire string.
   * Params:
   *   mode = a `PangoEllipsizeMode`
   */
  void setEllipsize(EllipsizeMode mode)
  {
    gtk_progress_bar_set_ellipsize(cast(GtkProgressBar*)cPtr, mode);
  }

  /**
   * Causes the progress bar to “fill in” the given fraction
   * of the bar.
   * The fraction should be between 0.0 and 1.0, inclusive.
   * Params:
   *   fraction = fraction of the task that’s been completed
   */
  void setFraction(double fraction)
  {
    gtk_progress_bar_set_fraction(cast(GtkProgressBar*)cPtr, fraction);
  }

  /**
   * Sets whether the progress bar is inverted.
   * Progress bars normally grow from top to bottom or left to right.
   * Inverted progress bars grow in the opposite direction.
   * Params:
   *   inverted = %TRUE to invert the progress bar
   */
  void setInverted(bool inverted)
  {
    gtk_progress_bar_set_inverted(cast(GtkProgressBar*)cPtr, inverted);
  }

  /**
   * Sets the fraction of total progress bar length to move the
   * bouncing block.
   * The bouncing block is moved when [Gtk.ProgressBar.pulse]
   * is called.
   * Params:
   *   fraction = fraction between 0.0 and 1.0
   */
  void setPulseStep(double fraction)
  {
    gtk_progress_bar_set_pulse_step(cast(GtkProgressBar*)cPtr, fraction);
  }

  /**
   * Sets whether the progress bar will show text next to the bar.
   * The shown text is either the value of the [Gtk.ProgressBar.text]
   * property or, if that is %NULL, the [Gtk.ProgressBar.fraction] value,
   * as a percentage.
   * To make a progress bar that is styled and sized suitably for containing
   * text $(LPAREN)even if the actual text is blank$(RPAREN), set propertyGtk.ProgressBar:show-text
   * to %TRUE and [Gtk.ProgressBar.text] to the empty string (not %NULL).
   * Params:
   *   showText = whether to show text
   */
  void setShowText(bool showText)
  {
    gtk_progress_bar_set_show_text(cast(GtkProgressBar*)cPtr, showText);
  }

  /**
   * Causes the given text to appear next to the progress bar.
   * If text is %NULL and propertyGtk.ProgressBar:show-text is %TRUE,
   * the current value of [Gtk.ProgressBar.fraction] will be displayed
   * as a percentage.
   * If text is non-%NULL and propertyGtk.ProgressBar:show-text is %TRUE,
   * the text will be displayed. In this case, it will not display the progress
   * percentage. If text is the empty string, the progress bar will still
   * be styled and sized suitably for containing text, as long as
   * propertyGtk.ProgressBar:show-text is %TRUE.
   * Params:
   *   text = a UTF-8 string
   */
  void setText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_progress_bar_set_text(cast(GtkProgressBar*)cPtr, _text);
  }
}

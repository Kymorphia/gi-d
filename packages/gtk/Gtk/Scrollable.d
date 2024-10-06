module Gtk.Scrollable;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Adjustment;
import Gtk.Border;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkScrollable` is an interface for widgets with native scrolling ability.
 * To implement this interface you should override the
 * [Gtk.Scrollable.hadjustment] and
 * [Gtk.Scrollable.vadjustment] properties.
 * ## Creating a scrollable widget
 * All scrollable widgets should do the following.
 * - When a parent widget sets the scrollable child widget’s adjustments,
 * the widget should connect to the signal@Gtk.Adjustment::value-changed
 * signal. The child widget should then populate the adjustments’ properties
 * as soon as possible, which usually means queueing an allocation right away
 * and populating the properties in the vfunc@Gtk.Widget.size_allocate
 * implementation.
 * - Because its preferred size is the size for a fully expanded widget,
 * the scrollable widget must be able to cope with underallocations.
 * This means that it must accept any value passed to its
 * vfunc@Gtk.Widget.size_allocate implementation.
 * - When the parent allocates space to the scrollable child widget,
 * the widget must ensure the adjustments’ property values are correct and up
 * to date, for example using [Gtk.Adjustment.configure].
 * - When any of the adjustments emits the signal@Gtk.Adjustment::value-changed
 * signal, the scrollable widget should scroll its contents.
 */
interface Scrollable
{

  static GType getType()
  {
    return gtk_scrollable_get_type();
  }

  /**
   * Returns the size of a non-scrolling border around the
   * outside of the scrollable.
   * An example for this would be treeview headers. GTK can use
   * this information to display overlaid graphics, like the
   * overshoot indication, at the right position.
   * Params:
   *   border = return location for the results
   * Returns: %TRUE if border has been set
   */
  bool getBorder(out Border border);

  /**
   * Retrieves the `GtkAdjustment` used for horizontal scrolling.
   * Returns: horizontal `GtkAdjustment`.
   */
  Adjustment getHadjustment();

  /**
   * Gets the horizontal `GtkScrollablePolicy`.
   * Returns: The horizontal `GtkScrollablePolicy`.
   */
  ScrollablePolicy getHscrollPolicy();

  /**
   * Retrieves the `GtkAdjustment` used for vertical scrolling.
   * Returns: vertical `GtkAdjustment`.
   */
  Adjustment getVadjustment();

  /**
   * Gets the vertical `GtkScrollablePolicy`.
   * Returns: The vertical `GtkScrollablePolicy`.
   */
  ScrollablePolicy getVscrollPolicy();

  /**
   * Sets the horizontal adjustment of the `GtkScrollable`.
   * Params:
   *   hadjustment = a `GtkAdjustment`
   */
  void setHadjustment(Adjustment hadjustment);

  /**
   * Sets the `GtkScrollablePolicy`.
   * The policy determines whether horizontal scrolling should start
   * below the minimum width or below the natural width.
   * Params:
   *   policy = the horizontal `GtkScrollablePolicy`
   */
  void setHscrollPolicy(ScrollablePolicy policy);

  /**
   * Sets the vertical adjustment of the `GtkScrollable`.
   * Params:
   *   vadjustment = a `GtkAdjustment`
   */
  void setVadjustment(Adjustment vadjustment);

  /**
   * Sets the `GtkScrollablePolicy`.
   * The policy determines whether vertical scrolling should start
   * below the minimum height or below the natural height.
   * Params:
   *   policy = the vertical `GtkScrollablePolicy`
   */
  void setVscrollPolicy(ScrollablePolicy policy);
}

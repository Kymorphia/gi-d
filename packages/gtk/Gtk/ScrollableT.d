module Gtk.ScrollableT;

public import GObject.ObjectG;
public import Gid.gid;
public import Gtk.Adjustment;
public import Gtk.Border;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

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
template ScrollableT(TStruct)
{

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
  override bool getBorder(out Border border)
  {
    bool _retval;
    GtkBorder _border;
    _retval = gtk_scrollable_get_border(cast(GtkScrollable*)cPtr, &_border);
    border = new Border(cast(void*)&_border, false);
    return _retval;
  }

  /**
   * Retrieves the `GtkAdjustment` used for horizontal scrolling.
   * Returns: horizontal `GtkAdjustment`.
   */
  override Adjustment getHadjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_scrollable_get_hadjustment(cast(GtkScrollable*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the horizontal `GtkScrollablePolicy`.
   * Returns: The horizontal `GtkScrollablePolicy`.
   */
  override ScrollablePolicy getHscrollPolicy()
  {
    GtkScrollablePolicy _cretval;
    _cretval = gtk_scrollable_get_hscroll_policy(cast(GtkScrollable*)cPtr);
    ScrollablePolicy _retval = cast(ScrollablePolicy)_cretval;
    return _retval;
  }

  /**
   * Retrieves the `GtkAdjustment` used for vertical scrolling.
   * Returns: vertical `GtkAdjustment`.
   */
  override Adjustment getVadjustment()
  {
    GtkAdjustment* _cretval;
    _cretval = gtk_scrollable_get_vadjustment(cast(GtkScrollable*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Adjustment(cast(GtkAdjustment*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the vertical `GtkScrollablePolicy`.
   * Returns: The vertical `GtkScrollablePolicy`.
   */
  override ScrollablePolicy getVscrollPolicy()
  {
    GtkScrollablePolicy _cretval;
    _cretval = gtk_scrollable_get_vscroll_policy(cast(GtkScrollable*)cPtr);
    ScrollablePolicy _retval = cast(ScrollablePolicy)_cretval;
    return _retval;
  }

  /**
   * Sets the horizontal adjustment of the `GtkScrollable`.
   * Params:
   *   hadjustment = a `GtkAdjustment`
   */
  override void setHadjustment(Adjustment hadjustment)
  {
    gtk_scrollable_set_hadjustment(cast(GtkScrollable*)cPtr, hadjustment ? cast(GtkAdjustment*)hadjustment.cPtr(false) : null);
  }

  /**
   * Sets the `GtkScrollablePolicy`.
   * The policy determines whether horizontal scrolling should start
   * below the minimum width or below the natural width.
   * Params:
   *   policy = the horizontal `GtkScrollablePolicy`
   */
  override void setHscrollPolicy(ScrollablePolicy policy)
  {
    gtk_scrollable_set_hscroll_policy(cast(GtkScrollable*)cPtr, policy);
  }

  /**
   * Sets the vertical adjustment of the `GtkScrollable`.
   * Params:
   *   vadjustment = a `GtkAdjustment`
   */
  override void setVadjustment(Adjustment vadjustment)
  {
    gtk_scrollable_set_vadjustment(cast(GtkScrollable*)cPtr, vadjustment ? cast(GtkAdjustment*)vadjustment.cPtr(false) : null);
  }

  /**
   * Sets the `GtkScrollablePolicy`.
   * The policy determines whether vertical scrolling should start
   * below the minimum height or below the natural height.
   * Params:
   *   policy = the vertical `GtkScrollablePolicy`
   */
  override void setVscrollPolicy(ScrollablePolicy policy)
  {
    gtk_scrollable_set_vscroll_policy(cast(GtkScrollable*)cPtr, policy);
  }
}

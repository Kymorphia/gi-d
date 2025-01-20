module Gtk.Viewport;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Adjustment;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.ScrollInfo;
import Gtk.Scrollable;
import Gtk.ScrollableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkViewport` implements scrollability for widgets that lack their
 * own scrolling capabilities.
 * Use `GtkViewport` to scroll child widgets such as `GtkGrid`,
 * `GtkBox`, and so on.
 * The `GtkViewport` will start scrolling content only if allocated
 * less than the child widget’s minimum size in a given orientation.
 * # CSS nodes
 * `GtkViewport` has a single CSS node with name `viewport`.
 * # Accessibility
 * Until GTK 4.10, `GtkViewport` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
 * Starting from GTK 4.12, `GtkViewport` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
 */
class Viewport : Widget, Scrollable
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
    return gtk_viewport_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ScrollableT!();

  /**
   * Creates a new `GtkViewport`.
   * The new viewport uses the given adjustments, or default
   * adjustments if none are given.
   * Params:
   *   hadjustment = horizontal adjustment
   *   vadjustment = vertical adjustment
   * Returns: a new `GtkViewport`
   */
  this(Adjustment hadjustment, Adjustment vadjustment)
  {
    GtkWidget* _cretval;
    _cretval = gtk_viewport_new(hadjustment ? cast(GtkAdjustment*)hadjustment.cPtr(false) : null, vadjustment ? cast(GtkAdjustment*)vadjustment.cPtr(false) : null);
    this(_cretval, false);
  }

  /**
   * Gets the child widget of viewport.
   * Returns: the child widget of viewport
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_viewport_get_child(cast(GtkViewport*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether the viewport is scrolling to keep the focused
   * child in view.
   * Returns: %TRUE if the viewport keeps the focus child scrolled to view
   */
  bool getScrollToFocus()
  {
    bool _retval;
    _retval = gtk_viewport_get_scroll_to_focus(cast(GtkViewport*)cPtr);
    return _retval;
  }

  /**
   * Scrolls a descendant of the viewport into view.
   * The viewport and the descendant must be visible and mapped for
   * this function to work, otherwise no scrolling will be performed.
   * Params:
   *   descendant = a descendant widget of the viewport
   *   scroll = details of how to perform
   *     the scroll operation or NULL to scroll into view
   */
  void scrollTo(Widget descendant, ScrollInfo scroll)
  {
    gtk_viewport_scroll_to(cast(GtkViewport*)cPtr, descendant ? cast(GtkWidget*)descendant.cPtr(false) : null, scroll ? cast(GtkScrollInfo*)scroll.cPtr(true) : null);
  }

  /**
   * Sets the child widget of viewport.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_viewport_set_child(cast(GtkViewport*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether the viewport should automatically scroll
   * to keep the focused child in view.
   * Params:
   *   scrollToFocus = whether to keep the focus widget scrolled to view
   */
  void setScrollToFocus(bool scrollToFocus)
  {
    gtk_viewport_set_scroll_to_focus(cast(GtkViewport*)cPtr, scrollToFocus);
  }
}

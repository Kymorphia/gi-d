module Gtk.CenterBox;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
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
 * `GtkCenterBox` arranges three children in a row, keeping the middle child
 * centered as well as possible.
 * ![An example GtkCenterBox](centerbox.png)
 * To add children to `GtkCenterBox`, use [Gtk.CenterBox.setStartWidget],
 * [Gtk.CenterBox.setCenterWidget] and
 * [Gtk.CenterBox.setEndWidget].
 * The sizing and positioning of children can be influenced with the
 * align and expand properties of the children.
 * # GtkCenterBox as GtkBuildable
 * The `GtkCenterBox` implementation of the `GtkBuildable` interface
 * supports placing children in the 3 positions by specifying “start”, “center”
 * or “end” as the “type” attribute of a `<child>` element.
 * # CSS nodes
 * `GtkCenterBox` uses a single CSS node with the name “box”,
 * The first child of the `GtkCenterBox` will be allocated depending on the
 * text direction, i.e. in left-to-right layouts it will be allocated on the
 * left and in right-to-left layouts on the right.
 * In vertical orientation, the nodes of the children are arranged from top to
 * bottom.
 * # Accessibility
 * Until GTK 4.10, `GtkCenterBox` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
 * Starting from GTK 4.12, `GtkCenterBox` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
 */
class CenterBox : Widget, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_center_box_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!();

  /**
   * Creates a new `GtkCenterBox`.
   * Returns: the new `GtkCenterBox`.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_center_box_new();
    this(_cretval, false);
  }

  /**
   * Gets the value set by [Gtk.CenterBox.setBaselinePosition].
   * Returns: the baseline position
   */
  BaselinePosition getBaselinePosition()
  {
    GtkBaselinePosition _cretval;
    _cretval = gtk_center_box_get_baseline_position(cast(GtkCenterBox*)cPtr);
    BaselinePosition _retval = cast(BaselinePosition)_cretval;
    return _retval;
  }

  /**
   * Gets the center widget, or %NULL if there is none.
   * Returns: the center widget.
   */
  Widget getCenterWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_center_box_get_center_widget(cast(GtkCenterBox*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the end widget, or %NULL if there is none.
   * Returns: the end widget.
   */
  Widget getEndWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_center_box_get_end_widget(cast(GtkCenterBox*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether self shrinks the center widget after other children.
   * Returns: whether to shrink the center widget after others
   */
  bool getShrinkCenterLast()
  {
    bool _retval;
    _retval = gtk_center_box_get_shrink_center_last(cast(GtkCenterBox*)cPtr);
    return _retval;
  }

  /**
   * Gets the start widget, or %NULL if there is none.
   * Returns: the start widget.
   */
  Widget getStartWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_center_box_get_start_widget(cast(GtkCenterBox*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the baseline position of a center box.
   * This affects only horizontal boxes with at least one baseline
   * aligned child. If there is more vertical space available than
   * requested, and the baseline is not allocated by the parent then
   * position is used to allocate the baseline wrt. the extra space
   * available.
   * Params:
   *   position = a `GtkBaselinePosition`
   */
  void setBaselinePosition(BaselinePosition position)
  {
    gtk_center_box_set_baseline_position(cast(GtkCenterBox*)cPtr, position);
  }

  /**
   * Sets the center widget.
   * To remove the existing center widget, pass %NULL.
   * Params:
   *   child = the new center widget
   */
  void setCenterWidget(Widget child)
  {
    gtk_center_box_set_center_widget(cast(GtkCenterBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the end widget.
   * To remove the existing end widget, pass %NULL.
   * Params:
   *   child = the new end widget
   */
  void setEndWidget(Widget child)
  {
    gtk_center_box_set_end_widget(cast(GtkCenterBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether to shrink the center widget after other children.
   * By default, when there's no space to give all three children their
   * natural widths, the start and end widgets start shrinking and the
   * center child keeps natural width until they reach minimum width.
   * If set to `FALSE`, start and end widgets keep natural width and the
   * center widget starts shrinking instead.
   * Params:
   *   shrinkCenterLast = whether to shrink the center widget after others
   */
  void setShrinkCenterLast(bool shrinkCenterLast)
  {
    gtk_center_box_set_shrink_center_last(cast(GtkCenterBox*)cPtr, shrinkCenterLast);
  }

  /**
   * Sets the start widget.
   * To remove the existing start widget, pass %NULL.
   * Params:
   *   child = the new start widget
   */
  void setStartWidget(Widget child)
  {
    gtk_center_box_set_start_widget(cast(GtkCenterBox*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }
}

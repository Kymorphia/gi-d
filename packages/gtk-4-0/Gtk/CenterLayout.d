module Gtk.CenterLayout;

import GObject.ObjectG;
import Gid.gid;
import Gtk.LayoutManager;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkCenterLayout` is a layout manager that manages up to three children.
 * The start widget is allocated at the start of the layout $(LPAREN)left in
 * left-to-right locales and right in right-to-left ones$(RPAREN), and the end
 * widget at the end.
 * The center widget is centered regarding the full width of the layout's.
 */
class CenterLayout : LayoutManager
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_center_layout_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCenterLayout`.
   * Returns: the newly created `GtkCenterLayout`
   */
  this()
  {
    GtkLayoutManager* _cretval;
    _cretval = gtk_center_layout_new();
    this(_cretval, true);
  }

  /**
   * Returns the baseline position of the layout.
   * Returns: The current baseline position of self.
   */
  BaselinePosition getBaselinePosition()
  {
    GtkBaselinePosition _cretval;
    _cretval = gtk_center_layout_get_baseline_position(cast(GtkCenterLayout*)cPtr);
    BaselinePosition _retval = cast(BaselinePosition)_cretval;
    return _retval;
  }

  /**
   * Returns the center widget of the layout.
   * Returns: the current center widget of self
   */
  Widget getCenterWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_center_layout_get_center_widget(cast(GtkCenterLayout*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the end widget of the layout.
   * Returns: the current end widget of self
   */
  Widget getEndWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_center_layout_get_end_widget(cast(GtkCenterLayout*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current orienration of the layout manager.
   * Returns: The current orientation of self
   */
  Orientation getOrientation()
  {
    GtkOrientation _cretval;
    _cretval = gtk_center_layout_get_orientation(cast(GtkCenterLayout*)cPtr);
    Orientation _retval = cast(Orientation)_cretval;
    return _retval;
  }

  /**
   * Gets whether self shrinks the center widget after other children.
   * Returns: whether to shrink the center widget after others
   */
  bool getShrinkCenterLast()
  {
    bool _retval;
    _retval = gtk_center_layout_get_shrink_center_last(cast(GtkCenterLayout*)cPtr);
    return _retval;
  }

  /**
   * Returns the start widget of the layout.
   * Returns: The current start widget of self
   */
  Widget getStartWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_center_layout_get_start_widget(cast(GtkCenterLayout*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the new baseline position of self
   * Params:
   *   baselinePosition = the new baseline position
   */
  void setBaselinePosition(BaselinePosition baselinePosition)
  {
    gtk_center_layout_set_baseline_position(cast(GtkCenterLayout*)cPtr, baselinePosition);
  }

  /**
   * Sets the new center widget of self.
   * To remove the existing center widget, pass %NULL.
   * Params:
   *   widget = the new center widget
   */
  void setCenterWidget(Widget widget)
  {
    gtk_center_layout_set_center_widget(cast(GtkCenterLayout*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Sets the new end widget of self.
   * To remove the existing center widget, pass %NULL.
   * Params:
   *   widget = the new end widget
   */
  void setEndWidget(Widget widget)
  {
    gtk_center_layout_set_end_widget(cast(GtkCenterLayout*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Sets the orientation of self.
   * Params:
   *   orientation = the new orientation
   */
  void setOrientation(Orientation orientation)
  {
    gtk_center_layout_set_orientation(cast(GtkCenterLayout*)cPtr, orientation);
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
    gtk_center_layout_set_shrink_center_last(cast(GtkCenterLayout*)cPtr, shrinkCenterLast);
  }

  /**
   * Sets the new start widget of self.
   * To remove the existing start widget, pass %NULL.
   * Params:
   *   widget = the new start widget
   */
  void setStartWidget(Widget widget)
  {
    gtk_center_layout_set_start_widget(cast(GtkCenterLayout*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }
}

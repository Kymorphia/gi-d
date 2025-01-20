module Gtk.AspectFrame;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkAspectFrame` preserves the aspect ratio of its child.
 * The frame can respect the aspect ratio of the child widget,
 * or use its own aspect ratio.
 * # CSS nodes
 * `GtkAspectFrame` uses a CSS node with name `frame`.
 * # Accessibility
 * Until GTK 4.10, `GtkAspectFrame` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
 * Starting from GTK 4.12, `GtkAspectFrame` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
 */
class AspectFrame : Widget
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
    return gtk_aspect_frame_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new `GtkAspectFrame`.
   * Params:
   *   xalign = Horizontal alignment of the child within the parent.
   *     Ranges from 0.0 $(LPAREN)left aligned$(RPAREN) to 1.0 $(LPAREN)right aligned$(RPAREN)
   *   yalign = Vertical alignment of the child within the parent.
   *     Ranges from 0.0 $(LPAREN)top aligned$(RPAREN) to 1.0 $(LPAREN)bottom aligned$(RPAREN)
   *   ratio = The desired aspect ratio.
   *   obeyChild = If %TRUE, ratio is ignored, and the aspect
   *     ratio is taken from the requistion of the child.
   * Returns: the new `GtkAspectFrame`.
   */
  this(float xalign, float yalign, float ratio, bool obeyChild)
  {
    GtkWidget* _cretval;
    _cretval = gtk_aspect_frame_new(xalign, yalign, ratio, obeyChild);
    this(_cretval, false);
  }

  /**
   * Gets the child widget of self.
   * Returns: the child widget of self
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_aspect_frame_get_child(cast(GtkAspectFrame*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the child's size request should override
   * the set aspect ratio of the `GtkAspectFrame`.
   * Returns: whether to obey the child's size request
   */
  bool getObeyChild()
  {
    bool _retval;
    _retval = gtk_aspect_frame_get_obey_child(cast(GtkAspectFrame*)cPtr);
    return _retval;
  }

  /**
   * Returns the desired aspect ratio of the child.
   * Returns: the desired aspect ratio
   */
  float getRatio()
  {
    float _retval;
    _retval = gtk_aspect_frame_get_ratio(cast(GtkAspectFrame*)cPtr);
    return _retval;
  }

  /**
   * Returns the horizontal alignment of the child within the
   * allocation of the `GtkAspectFrame`.
   * Returns: the horizontal alignment
   */
  float getXalign()
  {
    float _retval;
    _retval = gtk_aspect_frame_get_xalign(cast(GtkAspectFrame*)cPtr);
    return _retval;
  }

  /**
   * Returns the vertical alignment of the child within the
   * allocation of the `GtkAspectFrame`.
   * Returns: the vertical alignment
   */
  float getYalign()
  {
    float _retval;
    _retval = gtk_aspect_frame_get_yalign(cast(GtkAspectFrame*)cPtr);
    return _retval;
  }

  /**
   * Sets the child widget of self.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_aspect_frame_set_child(cast(GtkAspectFrame*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether the aspect ratio of the child's size
   * request should override the set aspect ratio of
   * the `GtkAspectFrame`.
   * Params:
   *   obeyChild = If %TRUE, ratio is ignored, and the aspect
   *     ratio is taken from the requisition of the child.
   */
  void setObeyChild(bool obeyChild)
  {
    gtk_aspect_frame_set_obey_child(cast(GtkAspectFrame*)cPtr, obeyChild);
  }

  /**
   * Sets the desired aspect ratio of the child.
   * Params:
   *   ratio = aspect ratio of the child
   */
  void setRatio(float ratio)
  {
    gtk_aspect_frame_set_ratio(cast(GtkAspectFrame*)cPtr, ratio);
  }

  /**
   * Sets the horizontal alignment of the child within the allocation
   * of the `GtkAspectFrame`.
   * Params:
   *   xalign = horizontal alignment, from 0.0 $(LPAREN)left aligned$(RPAREN) to 1.0 $(LPAREN)right aligned$(RPAREN)
   */
  void setXalign(float xalign)
  {
    gtk_aspect_frame_set_xalign(cast(GtkAspectFrame*)cPtr, xalign);
  }

  /**
   * Sets the vertical alignment of the child within the allocation
   * of the `GtkAspectFrame`.
   * Params:
   *   yalign = horizontal alignment, from 0.0 $(LPAREN)top aligned$(RPAREN) to 1.0 $(LPAREN)bottom aligned$(RPAREN)
   */
  void setYalign(float yalign)
  {
    gtk_aspect_frame_set_yalign(cast(GtkAspectFrame*)cPtr, yalign);
  }
}

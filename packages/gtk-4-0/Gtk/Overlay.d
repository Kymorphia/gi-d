module Gtk.Overlay;

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
 * `GtkOverlay` is a container which contains a single main child, on top
 * of which it can place “overlay” widgets.
 * ![An example GtkOverlay](overlay.png)
 * The position of each overlay widget is determined by its
 * [Gtk.Widget.halign] and [Gtk.Widget.valign]
 * properties. E.g. a widget with both alignments set to %GTK_ALIGN_START
 * will be placed at the top left corner of the `GtkOverlay` container,
 * whereas an overlay with halign set to %GTK_ALIGN_CENTER and valign set
 * to %GTK_ALIGN_END will be placed a the bottom edge of the `GtkOverlay`,
 * horizontally centered. The position can be adjusted by setting the margin
 * properties of the child to non-zero values.
 * More complicated placement of overlays is possible by connecting
 * to the signal@Gtk.Overlay::get-child-position signal.
 * An overlay’s minimum and natural sizes are those of its main child.
 * The sizes of overlay children are not considered when measuring these
 * preferred sizes.
 * # GtkOverlay as GtkBuildable
 * The `GtkOverlay` implementation of the `GtkBuildable` interface
 * supports placing a child as an overlay by specifying “overlay” as
 * the “type” attribute of a `<child>` element.
 * # CSS nodes
 * `GtkOverlay` has a single CSS node with the name “overlay”. Overlay children
 * whose alignments cause them to be positioned at an edge get the style classes
 * “.left”, “.right”, “.top”, and/or “.bottom” according to their position.
 */
class Overlay : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_overlay_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkOverlay`.
   * Returns: a new `GtkOverlay` object.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_overlay_new();
    this(_cretval, false);
  }

  /**
   * Adds widget to overlay.
   * The widget will be stacked on top of the main widget
   * added with [Gtk.Overlay.setChild].
   * The position at which widget is placed is determined
   * from its [Gtk.Widget.halign] and
   * [Gtk.Widget.valign] properties.
   * Params:
   *   widget = a `GtkWidget` to be added to the container
   */
  void addOverlay(Widget widget)
  {
    gtk_overlay_add_overlay(cast(GtkOverlay*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Gets the child widget of overlay.
   * Returns: the child widget of overlay
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_overlay_get_child(cast(GtkOverlay*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether widget should be clipped within the parent.
   * Params:
   *   widget = an overlay child of `GtkOverlay`
   * Returns: whether the widget is clipped within the parent.
   */
  bool getClipOverlay(Widget widget)
  {
    bool _retval;
    _retval = gtk_overlay_get_clip_overlay(cast(GtkOverlay*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets whether widget's size is included in the measurement of
   * overlay.
   * Params:
   *   widget = an overlay child of `GtkOverlay`
   * Returns: whether the widget is measured
   */
  bool getMeasureOverlay(Widget widget)
  {
    bool _retval;
    _retval = gtk_overlay_get_measure_overlay(cast(GtkOverlay*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
    return _retval;
  }

  /**
   * Removes an overlay that was added with [Gtk.Overlay.addOverlay].
   * Params:
   *   widget = a `GtkWidget` to be removed
   */
  void removeOverlay(Widget widget)
  {
    gtk_overlay_remove_overlay(cast(GtkOverlay*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Sets the child widget of overlay.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_overlay_set_child(cast(GtkOverlay*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets whether widget should be clipped within the parent.
   * Params:
   *   widget = an overlay child of `GtkOverlay`
   *   clipOverlay = whether the child should be clipped
   */
  void setClipOverlay(Widget widget, bool clipOverlay)
  {
    gtk_overlay_set_clip_overlay(cast(GtkOverlay*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, clipOverlay);
  }

  /**
   * Sets whether widget is included in the measured size of overlay.
   * The overlay will request the size of the largest child that has
   * this property set to %TRUE. Children who are not included may
   * be drawn outside of overlay's allocation if they are too large.
   * Params:
   *   widget = an overlay child of `GtkOverlay`
   *   measure = whether the child should be measured
   */
  void setMeasureOverlay(Widget widget, bool measure)
  {
    gtk_overlay_set_measure_overlay(cast(GtkOverlay*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null, measure);
  }
}

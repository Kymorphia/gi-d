module Gtk.OverlayLayoutChild;

import Gid.gid;
import Gtk.LayoutChild;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkLayoutChild` subclass for children in a `GtkOverlayLayout`.
 */
class OverlayLayoutChild : LayoutChild
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
    return gtk_overlay_layout_child_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves whether the child is clipped.
   * Returns: whether the child is clipped
   */
  bool getClipOverlay()
  {
    bool _retval;
    _retval = gtk_overlay_layout_child_get_clip_overlay(cast(GtkOverlayLayoutChild*)cPtr);
    return _retval;
  }

  /**
   * Retrieves whether the child is measured.
   * Returns: whether the child is measured
   */
  bool getMeasure()
  {
    bool _retval;
    _retval = gtk_overlay_layout_child_get_measure(cast(GtkOverlayLayoutChild*)cPtr);
    return _retval;
  }

  /**
   * Sets whether to clip this child.
   * Params:
   *   clipOverlay = whether to clip this child
   */
  void setClipOverlay(bool clipOverlay)
  {
    gtk_overlay_layout_child_set_clip_overlay(cast(GtkOverlayLayoutChild*)cPtr, clipOverlay);
  }

  /**
   * Sets whether to measure this child.
   * Params:
   *   measure = whether to measure this child
   */
  void setMeasure(bool measure)
  {
    gtk_overlay_layout_child_set_measure(cast(GtkOverlayLayoutChild*)cPtr, measure);
  }
}

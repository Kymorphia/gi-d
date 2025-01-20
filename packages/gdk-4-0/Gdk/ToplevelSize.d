module Gdk.ToplevelSize;

import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The `GdkToplevelSize` struct contains information that is useful
 * to compute the size of a toplevel.
 */
class ToplevelSize
{
  GdkToplevelSize* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.ToplevelSize");

    cInstancePtr = cast(GdkToplevelSize*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Retrieves the bounds the toplevel is placed within.
   * The bounds represent the largest size a toplevel may have while still being
   * able to fit within some type of boundary. Depending on the backend, this may
   * be equivalent to the dimensions of the work area or the monitor on which the
   * window is being presented on, or something else that limits the way a
   * toplevel can be presented.
   * Params:
   *   boundsWidth = return location for width
   *   boundsHeight = return location for height
   */
  void getBounds(out int boundsWidth, out int boundsHeight)
  {
    gdk_toplevel_size_get_bounds(cast(GdkToplevelSize*)cPtr, cast(int*)&boundsWidth, cast(int*)&boundsHeight);
  }

  /**
   * Sets the minimum size of the toplevel.
   * The minimum size corresponds to the limitations the toplevel can be shrunk
   * to, without resulting in incorrect painting. A user of a `GdkToplevel` should
   * calculate these given both the existing size, and the bounds retrieved from
   * the `GdkToplevelSize` object.
   * The minimum size should be within the bounds $(LPAREN)see
   * [Gdk.ToplevelSize.getBounds]$(RPAREN).
   * Params:
   *   minWidth = the minimum width
   *   minHeight = the minimum height
   */
  void setMinSize(int minWidth, int minHeight)
  {
    gdk_toplevel_size_set_min_size(cast(GdkToplevelSize*)cPtr, minWidth, minHeight);
  }

  /**
   * Sets the shadows size of the toplevel.
   * The shadow width corresponds to the part of the computed surface size
   * that would consist of the shadow margin surrounding the window, would
   * there be any.
   * Shadow width should only be set if
   * methodGtk.Display.supports_shadow_width is %TRUE.
   * Params:
   *   left = width of the left part of the shadow
   *   right = width of the right part of the shadow
   *   top = height of the top part of the shadow
   *   bottom = height of the bottom part of the shadow
   */
  void setShadowWidth(int left, int right, int top, int bottom)
  {
    gdk_toplevel_size_set_shadow_width(cast(GdkToplevelSize*)cPtr, left, right, top, bottom);
  }

  /**
   * Sets the size the toplevel prefers to be resized to.
   * The size should be within the bounds $(LPAREN)see
   * [Gdk.ToplevelSize.getBounds]$(RPAREN). The set size should
   * be considered as a hint, and should not be assumed to be
   * respected by the windowing system, or backend.
   * Params:
   *   width = the width
   *   height = the height
   */
  void setSize(int width, int height)
  {
    gdk_toplevel_size_set_size(cast(GdkToplevelSize*)cPtr, width, height);
  }
}

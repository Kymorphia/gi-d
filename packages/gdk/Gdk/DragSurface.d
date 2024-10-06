module Gdk.DragSurface;

import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * A `GdkDragSurface` is an interface for surfaces used during DND.
 */
interface DragSurface
{

  static GType getType()
  {
    return gdk_drag_surface_get_type();
  }

  /**
   * Present drag_surface.
   * Params:
   *   width = the unconstrained drag_surface width to layout
   *   height = the unconstrained drag_surface height to layout
   * Returns: %FALSE if it failed to be presented, otherwise %TRUE.
   */
  bool present(int width, int height);
}

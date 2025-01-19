module Gdk.DragSurfaceT;

public import Gdk.DragSurfaceIfaceProxy;
public import Gdk.Types;
public import Gdk.c.functions;
public import Gdk.c.types;
public import Gid.gid;

/**
 * A `GdkDragSurface` is an interface for surfaces used during DND.
 */
template DragSurfaceT()
{

  /**
   * Present drag_surface.
   * Params:
   *   width = the unconstrained drag_surface width to layout
   *   height = the unconstrained drag_surface height to layout
   * Returns: %FALSE if it failed to be presented, otherwise %TRUE.
   */
  override bool present(int width, int height)
  {
    bool _retval;
    _retval = gdk_drag_surface_present(cast(GdkDragSurface*)cPtr, width, height);
    return _retval;
  }
}

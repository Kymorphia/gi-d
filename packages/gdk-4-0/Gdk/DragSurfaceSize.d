module Gdk.DragSurfaceSize;

import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The `GdkDragSurfaceSize` struct contains information that is useful
 * to compute the size of a drag surface.
 */
class DragSurfaceSize
{
  GdkDragSurfaceSize* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gdk.DragSurfaceSize");

    cInstancePtr = cast(GdkDragSurfaceSize*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Sets the size the drag surface prefers to be resized to.
   * Params:
   *   width = the width
   *   height = the height
   */
  void setSize(int width, int height)
  {
    gdk_drag_surface_size_set_size(cast(GdkDragSurfaceSize*)cPtr, width, height);
  }
}

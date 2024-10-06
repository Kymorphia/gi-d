module Gsk.ColorNode;

import Gdk.RGBA;
import Gid.gid;
import Graphene.Rect;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node for a solid color.
 */
class ColorNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ColorNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will render the color specified by rgba into
   * the area given by bounds.
   * Params:
   *   rgba = a `GdkRGBA` specifying a color
   *   bounds = the rectangle to render the color into
   * Returns: A new `GskRenderNode`
   */
  this(RGBA rgba, Rect bounds)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_color_node_new(rgba ? cast(GdkRGBA*)rgba.cPtr(false) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Retrieves the color of the given node.
   * Returns: the color of the node
   */
  RGBA getColor()
  {
    const(GdkRGBA)* _cretval;
    _cretval = gsk_color_node_get_color(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RGBA(cast(void*)_cretval, false) : null;
    return _retval;
  }
}

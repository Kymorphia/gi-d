module Gsk.BlurNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node applying a blur effect to its single child.
 */
class BlurNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.BlurNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a render node that blurs the child.
   * Params:
   *   child = the child node to blur
   *   radius = the blur radius. Must be positive
   * Returns: a new `GskRenderNode`
   */
  this(RenderNode child, float radius)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_blur_node_new(child ? cast(GskRenderNode*)child.cPtr(false) : null, radius);
    this(_cretval, true);
  }

  /**
   * Retrieves the child `GskRenderNode` of the blur node.
   * Returns: the blurred child node
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_blur_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the blur radius of the node.
   * Returns: the blur radius
   */
  float getRadius()
  {
    float _retval;
    _retval = gsk_blur_node_get_radius(cast(GskRenderNode*)cPtr);
    return _retval;
  }
}

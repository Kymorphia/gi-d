module Gsk.OpacityNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node controlling the opacity of its single child node.
 */
class OpacityNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.OpacityNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will drawn the child with reduced
   * opacity.
   * Params:
   *   child = The node to draw
   *   opacity = The opacity to apply
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode child, float opacity)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_opacity_node_new(child ? cast(GskRenderNode*)child.cPtr(false) : null, opacity);
    this(_cretval, true);
  }

  /**
   * Gets the child node that is getting opacityed by the given node.
   * Returns: The child that is getting opacityed
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_opacity_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the transparency factor for an opacity node.
   * Returns: the opacity factor
   */
  float getOpacity()
  {
    float _retval;
    _retval = gsk_opacity_node_get_opacity(cast(GskRenderNode*)cPtr);
    return _retval;
  }
}

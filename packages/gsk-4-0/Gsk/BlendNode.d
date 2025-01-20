module Gsk.BlendNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node applying a blending function between its two child nodes.
 */
class BlendNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.BlendNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will use blend_mode to blend the top
   * node onto the bottom node.
   * Params:
   *   bottom = The bottom node to be drawn
   *   top = The node to be blended onto the bottom node
   *   blendMode = The blend mode to use
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode bottom, RenderNode top, BlendMode blendMode)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_blend_node_new(bottom ? cast(GskRenderNode*)bottom.cPtr(false) : null, top ? cast(GskRenderNode*)top.cPtr(false) : null, blendMode);
    this(_cretval, true);
  }

  /**
   * Retrieves the blend mode used by node.
   * Returns: the blend mode
   */
  BlendMode getBlendMode()
  {
    GskBlendMode _cretval;
    _cretval = gsk_blend_node_get_blend_mode(cast(GskRenderNode*)cPtr);
    BlendMode _retval = cast(BlendMode)_cretval;
    return _retval;
  }

  /**
   * Retrieves the bottom `GskRenderNode` child of the node.
   * Returns: the bottom child node
   */
  RenderNode getBottomChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_blend_node_get_bottom_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the top `GskRenderNode` child of the node.
   * Returns: the top child node
   */
  RenderNode getTopChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_blend_node_get_top_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }
}

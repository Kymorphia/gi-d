module Gsk.ClipNode;

import Gid.gid;
import Graphene.Rect;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node applying a rectangular clip to its single child node.
 */
class ClipNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ClipNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will clip the child to the area
   * given by clip.
   * Params:
   *   child = The node to draw
   *   clip = The clip to apply
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode child, Rect clip)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_clip_node_new(child ? cast(GskRenderNode*)child.cPtr(false) : null, clip ? cast(graphene_rect_t*)clip.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Gets the child node that is getting clipped by the given node.
   * Returns: The child that is getting clipped
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_clip_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the clip rectangle for node.
   * Returns: a clip rectangle
   */
  Rect getClip()
  {
    const(graphene_rect_t)* _cretval;
    _cretval = gsk_clip_node_get_clip(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }
}

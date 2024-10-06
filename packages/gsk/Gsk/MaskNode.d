module Gsk.MaskNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node masking one child node with another.
 */
class MaskNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.MaskNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will mask a given node by another.
   * The mask_mode determines how the 'mask values' are derived from
   * the colors of the mask. Applying the mask consists of multiplying
   * the 'mask value' with the alpha of the source.
   * Params:
   *   source = The source node to be drawn
   *   mask = The node to be used as mask
   *   maskMode = The mask mode to use
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode source, RenderNode mask, MaskMode maskMode)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_mask_node_new(source ? cast(GskRenderNode*)source.cPtr(false) : null, mask ? cast(GskRenderNode*)mask.cPtr(false) : null, maskMode);
    this(_cretval, true);
  }

  /**
   * Retrieves the mask `GskRenderNode` child of the node.
   * Returns: the mask child node
   */
  RenderNode getMask()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_mask_node_get_mask(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the mask mode used by node.
   * Returns: the mask mode
   */
  MaskMode getMaskMode()
  {
    GskMaskMode _cretval;
    _cretval = gsk_mask_node_get_mask_mode(cast(GskRenderNode*)cPtr);
    MaskMode _retval = cast(MaskMode)_cretval;
    return _retval;
  }

  /**
   * Retrieves the source `GskRenderNode` child of the node.
   * Returns: the source child node
   */
  RenderNode getSource()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_mask_node_get_source(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }
}

module Gsk.SubsurfaceNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node that potentially diverts a part of the scene graph to a subsurface.
 */
class SubsurfaceNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.SubsurfaceNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Gets the child node that is getting drawn by the given node.
   * Returns: the child `GskRenderNode`
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_subsurface_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }
}

module Gsk.ShadowNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Shadow;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node drawing one or more shadows behind its single child node.
 */
class ShadowNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ShadowNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will draw a child with the given
   * shadows below it.
   * Params:
   *   child = The node to draw
   *   shadows = The shadows to apply
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode child, Shadow[] shadows)
  {
    GskRenderNode* _cretval;
    size_t _nShadows;
    if (shadows)
      _nShadows = cast(size_t)shadows.length;

    GskShadow[] _tmpshadows;
    foreach (obj; shadows)
      _tmpshadows ~= obj.cInstance;
    const(GskShadow)* _shadows = _tmpshadows.ptr;
    _cretval = gsk_shadow_node_new(child ? cast(GskRenderNode*)child.cPtr(false) : null, _shadows, _nShadows);
    this(_cretval, true);
  }

  /**
   * Retrieves the child `GskRenderNode` of the shadow node.
   * Returns: the child render node
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_shadow_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the number of shadows in the node.
   * Returns: the number of shadows.
   */
  size_t getNShadows()
  {
    size_t _retval;
    _retval = gsk_shadow_node_get_n_shadows(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the shadow data at the given index i.
   * Params:
   *   i = the given index
   * Returns: the shadow data
   */
  Shadow getShadow(size_t i)
  {
    const(GskShadow)* _cretval;
    _cretval = gsk_shadow_node_get_shadow(cast(GskRenderNode*)cPtr, i);
    auto _retval = _cretval ? new Shadow(cast(GskShadow*)_cretval) : null;
    return _retval;
  }
}

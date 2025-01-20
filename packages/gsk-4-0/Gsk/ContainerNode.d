module Gsk.ContainerNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node that can contain other render nodes.
 */
class ContainerNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ContainerNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a new `GskRenderNode` instance for holding the given children.
   * The new node will acquire a reference to each of the children.
   * Params:
   *   children = The children of the node
   * Returns: the new `GskRenderNode`
   */
  this(RenderNode[] children)
  {
    GskRenderNode* _cretval;
    uint _nChildren;
    if (children)
      _nChildren = cast(uint)children.length;

    GskRenderNode*[] _tmpchildren;
    foreach (obj; children)
      _tmpchildren ~= obj ? cast(GskRenderNode*)obj.cPtr : null;
    GskRenderNode** _children = cast(GskRenderNode**)_tmpchildren.ptr;
    _cretval = gsk_container_node_new(_children, _nChildren);
    this(_cretval, true);
  }

  /**
   * Gets one of the children of container.
   * Params:
   *   idx = the position of the child to get
   * Returns: the idx'th child of container
   */
  RenderNode getChild(uint idx)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_container_node_get_child(cast(GskRenderNode*)cPtr, idx);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the number of direct children of node.
   * Returns: the number of children of the `GskRenderNode`
   */
  uint getNChildren()
  {
    uint _retval;
    _retval = gsk_container_node_get_n_children(cast(GskRenderNode*)cPtr);
    return _retval;
  }
}

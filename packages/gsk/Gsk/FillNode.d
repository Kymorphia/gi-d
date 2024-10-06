module Gsk.FillNode;

import Gid.gid;
import Gsk.Path;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node filling the area given by [Gsk.Path]
 * and [Gsk] with the child node.
 */
class FillNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.FillNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will fill the child in the area
   * given by path and fill_rule.
   * Params:
   *   child = The node to fill the area with
   *   path = The path describing the area to fill
   *   fillRule = The fill rule to use
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode child, Path path, FillRule fillRule)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_fill_node_new(child ? cast(GskRenderNode*)child.cPtr(false) : null, path ? cast(GskPath*)path.cPtr(false) : null, fillRule);
    this(_cretval, false);
  }

  /**
   * Gets the child node that is getting drawn by the given node.
   * Returns: The child that is getting drawn
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_fill_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the fill rule used to determine how the path is filled.
   * Returns: a `GskFillRule`
   */
  FillRule getFillRule()
  {
    GskFillRule _cretval;
    _cretval = gsk_fill_node_get_fill_rule(cast(GskRenderNode*)cPtr);
    FillRule _retval = cast(FillRule)_cretval;
    return _retval;
  }

  /**
   * Retrieves the path used to describe the area filled with the contents of
   * the node.
   * Returns: a `GskPath`
   */
  Path getPath()
  {
    GskPath* _cretval;
    _cretval = gsk_fill_node_get_path(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Path(cast(void*)_cretval, false) : null;
    return _retval;
  }
}

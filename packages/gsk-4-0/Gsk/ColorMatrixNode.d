module Gsk.ColorMatrixNode;

import Gid.gid;
import Graphene.Matrix;
import Graphene.Vec4;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node controlling the color matrix of its single child node.
 */
class ColorMatrixNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ColorMatrixNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will drawn the child with
   * color_matrix.
   * In particular, the node will transform colors by applying
   * pixel \= transpose$(LPAREN)color_matrix$(RPAREN) * pixel + color_offset
   * for every pixel. The transformation operates on unpremultiplied
   * colors, with color components ordered R, G, B, A.
   * Params:
   *   child = The node to draw
   *   colorMatrix = The matrix to apply
   *   colorOffset = Values to add to the color
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode child, Matrix colorMatrix, Vec4 colorOffset)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_color_matrix_node_new(child ? cast(GskRenderNode*)child.cPtr(false) : null, colorMatrix ? cast(graphene_matrix_t*)colorMatrix.cPtr(false) : null, colorOffset ? cast(graphene_vec4_t*)colorOffset.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Gets the child node that is getting its colors modified by the given node.
   * Returns: The child that is getting its colors modified
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_color_matrix_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the color matrix used by the node.
   * Returns: a 4x4 color matrix
   */
  Matrix getColorMatrix()
  {
    const(graphene_matrix_t)* _cretval;
    _cretval = gsk_color_matrix_node_get_color_matrix(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the color offset used by the node.
   * Returns: a color vector
   */
  Vec4 getColorOffset()
  {
    const(graphene_vec4_t)* _cretval;
    _cretval = gsk_color_matrix_node_get_color_offset(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Vec4(cast(void*)_cretval, false) : null;
    return _retval;
  }
}

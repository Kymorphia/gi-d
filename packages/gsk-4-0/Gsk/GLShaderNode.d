module Gsk.GLShaderNode;

import GObject.ObjectG;
import Gid.gid;
import Gsk.GLShader;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node using a GL shader when drawing its children nodes.
 */
class GLShaderNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.GLShaderNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Gets one of the children.
   * Params:
   *   idx = the position of the child to get
   * Returns: the idx'th child of node
   */
  RenderNode getChild(uint idx)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_gl_shader_node_get_child(cast(GskRenderNode*)cPtr, idx);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the number of children
   * Returns: The number of children
   */
  uint getNChildren()
  {
    uint _retval;
    _retval = gsk_gl_shader_node_get_n_children(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Gets shader code for the node.
   * Returns: the `GskGLShader` shader
   */
  GLShader getShader()
  {
    GskGLShader* _cretval;
    _cretval = gsk_gl_shader_node_get_shader(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!GLShader(cast(GskGLShader*)_cretval, false) : null;
    return _retval;
  }
}

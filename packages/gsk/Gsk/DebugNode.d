module Gsk.DebugNode;

import Gid.gid;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node that emits a debugging message when drawing its
 * child node.
 */
class DebugNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.DebugNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will add debug information about
   * the given child.
   * Adding this node has no visual effect.
   * Params:
   *   child = The child to add debug info for
   *   message = The debug message
   * Returns: A new `GskRenderNode`
   */
  this(RenderNode child, string message)
  {
    GskRenderNode* _cretval;
    char* _message = message.toCString(true);
    _cretval = gsk_debug_node_new(child ? cast(GskRenderNode*)child.cPtr(false) : null, _message);
    this(_cretval, true);
  }

  /**
   * Gets the child node that is getting drawn by the given node.
   * Returns: the child `GskRenderNode`
   */
  RenderNode getChild()
  {
    GskRenderNode* _cretval;
    _cretval = gsk_debug_node_get_child(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the debug message that was set on this node
   * Returns: The debug message
   */
  string getMessage()
  {
    const(char)* _cretval;
    _cretval = gsk_debug_node_get_message(cast(GskRenderNode*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}

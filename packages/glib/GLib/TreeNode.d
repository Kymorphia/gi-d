module GLib.TreeNode;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque type which identifies a specific node in a #GTree.
 */
class TreeNode
{
  GTreeNode* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TreeNode");

    cInstancePtr = cast(GTreeNode*)ptr;

    this.owned = owned;
  }

  T* cPtr(T)()
  if (is(T == GTreeNode))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * the key at the node.
   */
  void* key()
  {
    void* _retval;
    _retval = g_tree_node_key(cPtr!GTreeNode);
    return _retval;
  }

  /**
   * the next node in the tree
   */
  TreeNode next()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_next(cPtr!GTreeNode);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * the previous node in the tree
   */
  TreeNode previous()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_previous(cPtr!GTreeNode);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * the value at the node.
   */
  void* value()
  {
    void* _retval;
    _retval = g_tree_node_value(cPtr!GTreeNode);
    return _retval;
  }
}

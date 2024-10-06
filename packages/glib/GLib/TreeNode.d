module GLib.TreeNode;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Gets the key stored at a particular tree node.
   * Returns: the key at the node.
   */
  void* key()
  {
    void* _retval;
    _retval = g_tree_node_key(cast(GTreeNode*)cPtr);
    return _retval;
  }

  /**
   * Returns the next in-order node of the tree, or %NULL
   * if the passed node was already the last one.
   * Returns: the next node in the tree
   */
  TreeNode next()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_next(cast(GTreeNode*)cPtr);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the previous in-order node of the tree, or %NULL
   * if the passed node was already the first one.
   * Returns: the previous node in the tree
   */
  TreeNode previous()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_previous(cast(GTreeNode*)cPtr);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the value stored at a particular tree node.
   * Returns: the value at the node.
   */
  void* value()
  {
    void* _retval;
    _retval = g_tree_node_value(cast(GTreeNode*)cPtr);
    return _retval;
  }
}

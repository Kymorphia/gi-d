module GLib.Node;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GNode struct represents one node in a [n-ary tree][glib-N-ary-Trees].
 */
class Node
{
  GNode cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Node");

    cInstance = *cast(GNode*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GNode))
  {
    return cast(T*)&cInstance;
  }

  @property Node next()
  {
    return new Node(cast(GNode*)cPtr!GNode.next);
  }

  @property Node prev()
  {
    return new Node(cast(GNode*)cPtr!GNode.prev);
  }

  @property Node parent()
  {
    return new Node(cast(GNode*)cPtr!GNode.parent);
  }

  @property Node children()
  {
    return new Node(cast(GNode*)cPtr!GNode.children);
  }

  /**
   * the index of the child of @node which contains
   * @data, or -1 if the data is not found
   */
  int childIndex(void* data)
  {
    int _retval;
    _retval = g_node_child_index(cPtr!GNode, data);
    return _retval;
  }

  /**
   * the position of @child with respect to its siblings
   */
  int childPosition(Node child)
  {
    int _retval;
    _retval = g_node_child_position(cPtr!GNode, child ? child.cPtr!GNode : null);
    return _retval;
  }

  /**
   * the depth of the #GNode
   */
  uint depth()
  {
    uint _retval;
    _retval = g_node_depth(cPtr!GNode);
    return _retval;
  }

  /**
   * Removes @root and its children from the tree, freeing any memory
   * allocated.
   */
  void destroy()
  {
    g_node_destroy(cPtr!GNode);
  }

  /**
   * %TRUE if @node is an ancestor of @descendant
   */
  bool isAncestor(Node descendant)
  {
    bool _retval;
    _retval = g_node_is_ancestor(cPtr!GNode, descendant ? descendant.cPtr!GNode : null);
    return _retval;
  }

  /**
   * the maximum height of the tree beneath @root
   */
  uint maxHeight()
  {
    uint _retval;
    _retval = g_node_max_height(cPtr!GNode);
    return _retval;
  }

  /**
   * the number of children of @node
   */
  uint nChildren()
  {
    uint _retval;
    _retval = g_node_n_children(cPtr!GNode);
    return _retval;
  }

  /**
   * the number of nodes in the tree
   */
  uint nNodes(TraverseFlags flags)
  {
    uint _retval;
    _retval = g_node_n_nodes(cPtr!GNode, flags);
    return _retval;
  }

  /**
   * Reverses the order of the children of a #GNode.
   * (It doesn't change the order of the grandchildren.)
   */
  void reverseChildren()
  {
    g_node_reverse_children(cPtr!GNode);
  }

  /**
   * Unlinks a #GNode from a tree, resulting in two separate trees.
   */
  void unlink()
  {
    g_node_unlink(cPtr!GNode);
  }
}

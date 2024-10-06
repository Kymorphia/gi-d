module GLib.Node;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Node next()
  {
    return new Node(cast(GNode*)(cast(GNode*)cPtr).next);
  }

  @property Node prev()
  {
    return new Node(cast(GNode*)(cast(GNode*)cPtr).prev);
  }

  @property Node parent()
  {
    return new Node(cast(GNode*)(cast(GNode*)cPtr).parent);
  }

  @property Node children()
  {
    return new Node(cast(GNode*)(cast(GNode*)cPtr).children);
  }

  /**
   * Gets the position of the first child of a #GNode
   * which contains the given data.
   * Params:
   *   data = the data to find
   * Returns: the index of the child of node which contains
   *   data, or -1 if the data is not found
   */
  int childIndex(void* data)
  {
    int _retval;
    _retval = g_node_child_index(cast(GNode*)cPtr, data);
    return _retval;
  }

  /**
   * Gets the position of a #GNode with respect to its siblings.
   * child must be a child of node. The first child is numbered 0,
   * the second 1, and so on.
   * Params:
   *   child = a child of node
   * Returns: the position of child with respect to its siblings
   */
  int childPosition(Node child)
  {
    int _retval;
    _retval = g_node_child_position(cast(GNode*)cPtr, child ? cast(GNode*)child.cPtr : null);
    return _retval;
  }

  /**
   * Calls a function for each of the children of a #GNode. Note that it
   * doesn't descend beneath the child nodes. func must not do anything
   * that would modify the structure of the tree.
   * Params:
   *   flags = which types of children are to be visited, one of
   *     %G_TRAVERSE_ALL, %G_TRAVERSE_LEAVES and %G_TRAVERSE_NON_LEAVES
   *   func = the function to call for each visited node
   */
  void childrenForeach(TraverseFlags flags, NodeForeachFunc func)
  {
    static NodeForeachFunc _static_func;

    extern(C) void _funcCallback(GNode* node, void* data)
    {
      _static_func(node ? new Node(cast(void*)node, false) : null);
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_node_children_foreach(cast(GNode*)cPtr, flags, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Gets the depth of a #GNode.
   * If node is %NULL the depth is 0. The root node has a depth of 1.
   * For the children of the root node the depth is 2. And so on.
   * Returns: the depth of the #GNode
   */
  uint depth()
  {
    uint _retval;
    _retval = g_node_depth(cast(GNode*)cPtr);
    return _retval;
  }

  /**
   * Removes root and its children from the tree, freeing any memory
   * allocated.
   */
  void destroy()
  {
    g_node_destroy(cast(GNode*)cPtr);
  }

  /**
   * Returns %TRUE if node is an ancestor of descendant.
   * This is true if node is the parent of descendant,
   * or if node is the grandparent of descendant etc.
   * Params:
   *   descendant = a #GNode
   * Returns: %TRUE if node is an ancestor of descendant
   */
  bool isAncestor(Node descendant)
  {
    bool _retval;
    _retval = g_node_is_ancestor(cast(GNode*)cPtr, descendant ? cast(GNode*)descendant.cPtr : null);
    return _retval;
  }

  /**
   * Gets the maximum height of all branches beneath a #GNode.
   * This is the maximum distance from the #GNode to all leaf nodes.
   * If root is %NULL, 0 is returned. If root has no children,
   * 1 is returned. If root has children, 2 is returned. And so on.
   * Returns: the maximum height of the tree beneath root
   */
  uint maxHeight()
  {
    uint _retval;
    _retval = g_node_max_height(cast(GNode*)cPtr);
    return _retval;
  }

  /**
   * Gets the number of children of a #GNode.
   * Returns: the number of children of node
   */
  uint nChildren()
  {
    uint _retval;
    _retval = g_node_n_children(cast(GNode*)cPtr);
    return _retval;
  }

  /**
   * Gets the number of nodes in a tree.
   * Params:
   *   flags = which types of children are to be counted, one of
   *     %G_TRAVERSE_ALL, %G_TRAVERSE_LEAVES and %G_TRAVERSE_NON_LEAVES
   * Returns: the number of nodes in the tree
   */
  uint nNodes(TraverseFlags flags)
  {
    uint _retval;
    _retval = g_node_n_nodes(cast(GNode*)cPtr, flags);
    return _retval;
  }

  /**
   * Reverses the order of the children of a #GNode.
   * $(LPAREN)It doesn't change the order of the grandchildren.$(RPAREN)
   */
  void reverseChildren()
  {
    g_node_reverse_children(cast(GNode*)cPtr);
  }

  /**
   * Traverses a tree starting at the given root #GNode.
   * It calls the given function for each node visited.
   * The traversal can be halted at any point by returning %TRUE from func.
   * func must not do anything that would modify the structure of the tree.
   * Params:
   *   order = the order in which nodes are visited - %G_IN_ORDER,
   *     %G_PRE_ORDER, %G_POST_ORDER, or %G_LEVEL_ORDER.
   *   flags = which types of children are to be visited, one of
   *     %G_TRAVERSE_ALL, %G_TRAVERSE_LEAVES and %G_TRAVERSE_NON_LEAVES
   *   maxDepth = the maximum depth of the traversal. Nodes below this
   *     depth will not be visited. If max_depth is -1 all nodes in
   *     the tree are visited. If depth is 1, only the root is visited.
   *     If depth is 2, the root and its children are visited. And so on.
   *   func = the function to call for each visited #GNode
   */
  void traverse(TraverseType order, TraverseFlags flags, int maxDepth, NodeTraverseFunc func)
  {
    static NodeTraverseFunc _static_func;

    extern(C) bool _funcCallback(GNode* node, void* data)
    {
      bool _retval = _static_func(node ? new Node(cast(void*)node, false) : null);
      return _retval;
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_node_traverse(cast(GNode*)cPtr, order, flags, maxDepth, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Unlinks a #GNode from a tree, resulting in two separate trees.
   */
  void unlink()
  {
    g_node_unlink(cast(GNode*)cPtr);
  }

  static void popAllocator()
  {
    g_node_pop_allocator();
  }

  static void pushAllocator(Allocator allocator)
  {
    g_node_push_allocator(allocator);
  }
}

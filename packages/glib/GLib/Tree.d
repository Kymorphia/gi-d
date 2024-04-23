module GLib.Tree;

import GLib.Boxed;
import GLib.TreeNode;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The GTree struct is an opaque data structure representing a
 * [balanced binary tree][glib-Balanced-Binary-Trees]. It should be
 * accessed only by using the following functions.
 */
class Tree : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GTree))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_tree_get_type();
  }

  /**
   * Removes all keys and values from the #GTree and decreases its
   * reference count by one. If keys and/or values are dynamically
   * allocated, you should either free them first or create the #GTree
   * using g_tree_new_full(). In the latter case the destroy functions
   * you supplied will be called on all keys and values before destroying
   * the #GTree.
   */
  void destroy()
  {
    g_tree_destroy(cPtr!GTree);
  }

  /**
   * the height of @tree
   */
  int height()
  {
    int _retval;
    _retval = g_tree_height(cPtr!GTree);
    return _retval;
  }

  /**
   * Inserts a key/value pair into a #GTree.
   *
   * Inserts a new key and value into a #GTree as g_tree_insert_node() does,
   * only this function does not return the inserted or set node.
   */
  void insert(void* key, void* value)
  {
    g_tree_insert(cPtr!GTree, key, value);
  }

  /**
   * the inserted (or set) node or %NULL
   * if insertion would overflow the tree node counter.
   */
  TreeNode insertNode(void* key, void* value)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_insert_node(cPtr!GTree, key, value);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * the value corresponding to the key, or %NULL
   * if the key was not found
   */
  void* lookup(const(void)* key)
  {
    void* _retval;
    _retval = g_tree_lookup(cPtr!GTree, key);
    return _retval;
  }

  /**
   * %TRUE if the key was found in the #GTree
   */
  bool lookupExtended(const(void)* lookupKey, out void* origKey, out void* value)
  {
    bool _retval;
    _retval = g_tree_lookup_extended(cPtr!GTree, lookupKey, cast(void**)&origKey, cast(void**)&value);
    return _retval;
  }

  /**
   * the tree node corresponding to
   * the key, or %NULL if the key was not found
   */
  TreeNode lookupNode(const(void)* key)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_lookup_node(cPtr!GTree, key);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * the tree node corresponding to
   * the lower bound, or %NULL if the tree is empty or has only
   * keys strictly lower than the searched key.
   */
  TreeNode lowerBound(const(void)* key)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_lower_bound(cPtr!GTree, key);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * the number of nodes in @tree
   *
   * The node counter value type is really a #guint,
   * but it is returned as a #gint due to backward
   * compatibility issues (can be cast back to #guint to
   * support its full range of values).
   */
  int nnodes()
  {
    int _retval;
    _retval = g_tree_nnodes(cPtr!GTree);
    return _retval;
  }

  /**
   * the first node in the tree
   */
  TreeNode nodeFirst()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_first(cPtr!GTree);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * the last node in the tree
   */
  TreeNode nodeLast()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_last(cPtr!GTree);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if the key was found (prior to 2.8, this function
   * returned nothing)
   */
  bool remove(const(void)* key)
  {
    bool _retval;
    _retval = g_tree_remove(cPtr!GTree, key);
    return _retval;
  }

  /**
   * Removes all nodes from a #GTree and destroys their keys and values,
   * then resets the #GTree’s root to %NULL.
   */
  void removeAll()
  {
    g_tree_remove_all(cPtr!GTree);
  }

  /**
   * Inserts a new key and value into a #GTree as g_tree_replace_node() does,
   * only this function does not return the inserted or set node.
   */
  void replace(void* key, void* value)
  {
    g_tree_replace(cPtr!GTree, key, value);
  }

  /**
   * the inserted (or set) node or %NULL
   * if insertion would overflow the tree node counter.
   */
  TreeNode replaceNode(void* key, void* value)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_replace_node(cPtr!GTree, key, value);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if the key was found (prior to 2.8, this function
   * returned nothing)
   */
  bool steal(const(void)* key)
  {
    bool _retval;
    _retval = g_tree_steal(cPtr!GTree, key);
    return _retval;
  }

  /**
   * the tree node corresponding to the
   * upper bound, or %NULL if the tree is empty or has only keys
   * lower than or equal to the searched key.
   */
  TreeNode upperBound(const(void)* key)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_upper_bound(cPtr!GTree, key);
    TreeNode _retval = new TreeNode(cast(GTreeNode*)_cretval, false);
    return _retval;
  }
}

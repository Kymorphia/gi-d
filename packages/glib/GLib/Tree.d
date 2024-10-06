module GLib.Tree;

import GLib.Boxed;
import GLib.TreeNode;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_tree_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Removes all keys and values from the #GTree and decreases its
   * reference count by one. If keys and/or values are dynamically
   * allocated, you should either free them first or create the #GTree
   * using [GLib.Tree.newFull]. In the latter case the destroy functions
   * you supplied will be called on all keys and values before destroying
   * the #GTree.
   */
  void destroy()
  {
    g_tree_destroy(cast(GTree*)cPtr);
  }

  /**
   * Calls the given function for each of the key/value pairs in the #GTree.
   * The function is passed the key and value of each pair, and the given
   * data parameter. The tree is traversed in sorted order.
   * The tree may not be modified while iterating over it $(LPAREN)you can't
   * add/remove items$(RPAREN). To remove all items matching a predicate, you need
   * to add each item to a list in your #GTraverseFunc as you walk over
   * the tree, then walk the list and remove each item.
   * Params:
   *   func = the function to call for each node visited.
   *     If this function returns %TRUE, the traversal is stopped.
   */
  void foreach_(TraverseFunc func)
  {
    static TraverseFunc _static_func;

    extern(C) bool _funcCallback(void* key, void* value, void* data)
    {
      bool _retval = _static_func(key, value);
      return _retval;
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_tree_foreach(cast(GTree*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Calls the given function for each of the nodes in the #GTree.
   * The function is passed the pointer to the particular node, and the given
   * data parameter. The tree traversal happens in-order.
   * The tree may not be modified while iterating over it $(LPAREN)you can't
   * add/remove items$(RPAREN). To remove all items matching a predicate, you need
   * to add each item to a list in your #GTraverseFunc as you walk over
   * the tree, then walk the list and remove each item.
   * Params:
   *   func = the function to call for each node visited.
   *     If this function returns %TRUE, the traversal is stopped.
   */
  void foreachNode(TraverseNodeFunc func)
  {
    static TraverseNodeFunc _static_func;

    extern(C) bool _funcCallback(GTreeNode* node, void* data)
    {
      bool _retval = _static_func(node ? new TreeNode(cast(void*)node, false) : null);
      return _retval;
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_tree_foreach_node(cast(GTree*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Gets the height of a #GTree.
   * If the #GTree contains no nodes, the height is 0.
   * If the #GTree contains only one root node the height is 1.
   * If the root node has children the height is 2, etc.
   * Returns: the height of tree
   */
  int height()
  {
    int _retval;
    _retval = g_tree_height(cast(GTree*)cPtr);
    return _retval;
  }

  /**
   * Inserts a key/value pair into a #GTree.
   * Inserts a new key and value into a #GTree as [GLib.Tree.insertNode] does,
   * only this function does not return the inserted or set node.
   * Params:
   *   key = the key to insert
   *   value = the value corresponding to the key
   */
  void insert(void* key, void* value)
  {
    g_tree_insert(cast(GTree*)cPtr, key, value);
  }

  /**
   * Inserts a key/value pair into a #GTree.
   * If the given key already exists in the #GTree its corresponding value
   * is set to the new value. If you supplied a value_destroy_func when
   * creating the #GTree, the old value is freed using that function. If
   * you supplied a key_destroy_func when creating the #GTree, the passed
   * key is freed using that function.
   * The tree is automatically 'balanced' as new key/value pairs are added,
   * so that the distance from the root to every leaf is as small as possible.
   * The cost of maintaining a balanced tree while inserting new key/value
   * result in a O$(LPAREN)n log$(LPAREN)n$(RPAREN)$(RPAREN) operation where most of the other operations
   * are O$(LPAREN)log$(LPAREN)n$(RPAREN)$(RPAREN).
   * Params:
   *   key = the key to insert
   *   value = the value corresponding to the key
   * Returns: the inserted $(LPAREN)or set$(RPAREN) node or %NULL
   *   if insertion would overflow the tree node counter.
   */
  TreeNode insertNode(void* key, void* value)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_insert_node(cast(GTree*)cPtr, key, value);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the value corresponding to the given key. Since a #GTree is
   * automatically balanced as key/value pairs are added, key lookup
   * is O$(LPAREN)log n$(RPAREN) $(LPAREN)where n is the number of key/value pairs in the tree$(RPAREN).
   * Params:
   *   key = the key to look up
   * Returns: the value corresponding to the key, or %NULL
   *   if the key was not found
   */
  void* lookup(const(void)* key)
  {
    void* _retval;
    _retval = g_tree_lookup(cast(GTree*)cPtr, key);
    return _retval;
  }

  /**
   * Looks up a key in the #GTree, returning the original key and the
   * associated value. This is useful if you need to free the memory
   * allocated for the original key, for example before calling
   * [GLib.Tree.remove].
   * Params:
   *   lookupKey = the key to look up
   *   origKey = returns the original key
   *   value = returns the value associated with the key
   * Returns: %TRUE if the key was found in the #GTree
   */
  bool lookupExtended(const(void)* lookupKey, out void* origKey, out void* value)
  {
    bool _retval;
    _retval = g_tree_lookup_extended(cast(GTree*)cPtr, lookupKey, cast(void**)&origKey, cast(void**)&value);
    return _retval;
  }

  /**
   * Gets the tree node corresponding to the given key. Since a #GTree is
   * automatically balanced as key/value pairs are added, key lookup
   * is O$(LPAREN)log n$(RPAREN) $(LPAREN)where n is the number of key/value pairs in the tree$(RPAREN).
   * Params:
   *   key = the key to look up
   * Returns: the tree node corresponding to
   *   the key, or %NULL if the key was not found
   */
  TreeNode lookupNode(const(void)* key)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_lookup_node(cast(GTree*)cPtr, key);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the lower bound node corresponding to the given key,
   * or %NULL if the tree is empty or all the nodes in the tree
   * have keys that are strictly lower than the searched key.
   * The lower bound is the first node that has its key greater
   * than or equal to the searched key.
   * Params:
   *   key = the key to calculate the lower bound for
   * Returns: the tree node corresponding to
   *   the lower bound, or %NULL if the tree is empty or has only
   *   keys strictly lower than the searched key.
   */
  TreeNode lowerBound(const(void)* key)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_lower_bound(cast(GTree*)cPtr, key);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the number of nodes in a #GTree.
   * Returns: the number of nodes in tree
   *   The node counter value type is really a #guint,
   *   but it is returned as a #gint due to backward
   *   compatibility issues $(LPAREN)can be cast back to #guint to
   *   support its full range of values$(RPAREN).
   */
  int nnodes()
  {
    int _retval;
    _retval = g_tree_nnodes(cast(GTree*)cPtr);
    return _retval;
  }

  /**
   * Returns the first in-order node of the tree, or %NULL
   * for an empty tree.
   * Returns: the first node in the tree
   */
  TreeNode nodeFirst()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_first(cast(GTree*)cPtr);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the last in-order node of the tree, or %NULL
   * for an empty tree.
   * Returns: the last node in the tree
   */
  TreeNode nodeLast()
  {
    GTreeNode* _cretval;
    _cretval = g_tree_node_last(cast(GTree*)cPtr);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Removes a key/value pair from a #GTree.
   * If the #GTree was created using [GLib.Tree.newFull], the key and value
   * are freed using the supplied destroy functions, otherwise you have to
   * make sure that any dynamically allocated values are freed yourself.
   * If the key does not exist in the #GTree, the function does nothing.
   * The cost of maintaining a balanced tree while removing a key/value
   * result in a O$(LPAREN)n log$(LPAREN)n$(RPAREN)$(RPAREN) operation where most of the other operations
   * are O$(LPAREN)log$(LPAREN)n$(RPAREN)$(RPAREN).
   * Params:
   *   key = the key to remove
   * Returns: %TRUE if the key was found $(LPAREN)prior to 2.8, this function
   *   returned nothing$(RPAREN)
   */
  bool remove(const(void)* key)
  {
    bool _retval;
    _retval = g_tree_remove(cast(GTree*)cPtr, key);
    return _retval;
  }

  /**
   * Removes all nodes from a #GTree and destroys their keys and values,
   * then resets the #GTree’s root to %NULL.
   */
  void removeAll()
  {
    g_tree_remove_all(cast(GTree*)cPtr);
  }

  /**
   * Inserts a new key and value into a #GTree as [GLib.Tree.replaceNode] does,
   * only this function does not return the inserted or set node.
   * Params:
   *   key = the key to insert
   *   value = the value corresponding to the key
   */
  void replace(void* key, void* value)
  {
    g_tree_replace(cast(GTree*)cPtr, key, value);
  }

  /**
   * Inserts a new key and value into a #GTree similar to [GLib.Tree.insertNode].
   * The difference is that if the key already exists in the #GTree, it gets
   * replaced by the new key. If you supplied a value_destroy_func when
   * creating the #GTree, the old value is freed using that function. If you
   * supplied a key_destroy_func when creating the #GTree, the old key is
   * freed using that function.
   * The tree is automatically 'balanced' as new key/value pairs are added,
   * so that the distance from the root to every leaf is as small as possible.
   * Params:
   *   key = the key to insert
   *   value = the value corresponding to the key
   * Returns: the inserted $(LPAREN)or set$(RPAREN) node or %NULL
   *   if insertion would overflow the tree node counter.
   */
  TreeNode replaceNode(void* key, void* value)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_replace_node(cast(GTree*)cPtr, key, value);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Removes a key and its associated value from a #GTree without calling
   * the key and value destroy functions.
   * If the key does not exist in the #GTree, the function does nothing.
   * Params:
   *   key = the key to remove
   * Returns: %TRUE if the key was found $(LPAREN)prior to 2.8, this function
   *   returned nothing$(RPAREN)
   */
  bool steal(const(void)* key)
  {
    bool _retval;
    _retval = g_tree_steal(cast(GTree*)cPtr, key);
    return _retval;
  }

  /**
   * Calls the given function for each node in the #GTree.
   * Params:
   *   traverseFunc = the function to call for each node visited. If this
   *     function returns %TRUE, the traversal is stopped.
   *   traverseType = the order in which nodes are visited, one of %G_IN_ORDER,
   *     %G_PRE_ORDER and %G_POST_ORDER

   * Deprecated: The order of a balanced tree is somewhat arbitrary.
   *   If you just want to visit all nodes in sorted order, use
   *   [GLib.Tree.foreach_] instead. If you really need to visit nodes in
   *   a different order, consider using an [n-ary tree][glib-N-ary-Trees].
   */
  void traverse(TraverseFunc traverseFunc, TraverseType traverseType)
  {
    static TraverseFunc _static_traverseFunc;

    extern(C) bool _traverseFuncCallback(void* key, void* value, void* data)
    {
      bool _retval = _static_traverseFunc(key, value);
      return _retval;
    }

    _static_traverseFunc = traverseFunc;
    auto _traverseFunc = freezeDelegate(cast(void*)&traverseFunc);
    g_tree_traverse(cast(GTree*)cPtr, &_traverseFuncCallback, traverseType, _traverseFunc);
    _static_traverseFunc = null;
  }

  /**
   * Gets the upper bound node corresponding to the given key,
   * or %NULL if the tree is empty or all the nodes in the tree
   * have keys that are lower than or equal to the searched key.
   * The upper bound is the first node that has its key strictly greater
   * than the searched key.
   * Params:
   *   key = the key to calculate the upper bound for
   * Returns: the tree node corresponding to the
   *   upper bound, or %NULL if the tree is empty or has only keys
   *   lower than or equal to the searched key.
   */
  TreeNode upperBound(const(void)* key)
  {
    GTreeNode* _cretval;
    _cretval = g_tree_upper_bound(cast(GTree*)cPtr, key);
    auto _retval = _cretval ? new TreeNode(cast(GTreeNode*)_cretval, false) : null;
    return _retval;
  }
}

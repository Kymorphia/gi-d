module Gtk.TreePath;

import GLib.Boxed;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * An opaque structure representing a path to a row in a model.
 */
class TreePath : Boxed
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
    return gtk_tree_path_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkTreePath`
   * This refers to a row.
   * Returns: A newly created `GtkTreePath`.
   */
  this()
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_path_new();
    this(_cretval, true);
  }

  /**
   * Creates a new `GtkTreePath`.
   * The string representation of this path is “0”.
   * Returns: A new `GtkTreePath`
   */
  static TreePath newFirst()
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_path_new_first();
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new path with the given indices array of length.
   * Params:
   *   indices = array of indices
   * Returns: A newly created `GtkTreePath`
   */
  static TreePath newFromIndices(int[] indices)
  {
    GtkTreePath* _cretval;
    size_t _length;
    if (indices)
      _length = cast(size_t)indices.length;

    auto _indices = cast(int*)indices.ptr;
    _cretval = gtk_tree_path_new_from_indicesv(_indices, _length);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkTreePath` initialized to path.
   * path is expected to be a colon separated list of numbers.
   * For example, the string “10:4:0” would create a path of depth
   * 3 pointing to the 11th child of the root node, the 5th
   * child of that 11th child, and the 1st child of that 5th child.
   * If an invalid path string is passed in, %NULL is returned.
   * Params:
   *   path = The string representation of a path
   * Returns: A newly-created `GtkTreePath`
   */
  static TreePath newFromString(string path)
  {
    GtkTreePath* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = gtk_tree_path_new_from_string(_path);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Appends a new index to a path.
   * As a result, the depth of the path is increased.
   * Params:
   *   index = the index
   */
  void appendIndex(int index)
  {
    gtk_tree_path_append_index(cast(GtkTreePath*)cPtr, index);
  }

  /**
   * Compares two paths.
   * If a appears before b in a tree, then -1 is returned.
   * If b appears before a, then 1 is returned.
   * If the two nodes are equal, then 0 is returned.
   * Params:
   *   b = a `GtkTreePath` to compare with
   * Returns: the relative positions of a and b
   */
  int compare(TreePath b)
  {
    int _retval;
    _retval = gtk_tree_path_compare(cast(GtkTreePath*)cPtr, b ? cast(GtkTreePath*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Creates a new `GtkTreePath` as a copy of path.
   * Returns: a new `GtkTreePath`
   */
  TreePath copy()
  {
    GtkTreePath* _cretval;
    _cretval = gtk_tree_path_copy(cast(GtkTreePath*)cPtr);
    auto _retval = _cretval ? new TreePath(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Moves path to point to the first child of the current path.
   */
  void down()
  {
    gtk_tree_path_down(cast(GtkTreePath*)cPtr);
  }

  /**
   * Returns the current depth of path.
   * Returns: The depth of path
   */
  int getDepth()
  {
    int _retval;
    _retval = gtk_tree_path_get_depth(cast(GtkTreePath*)cPtr);
    return _retval;
  }

  /**
   * Returns the current indices of path.
   * This is an array of integers, each representing a node in a tree.
   * It also returns the number of elements in the array.
   * The array should not be freed.
   * Returns: The current
   *   indices
   */
  int[] getIndices()
  {
    int* _cretval;
    int _cretlength;
    _cretval = gtk_tree_path_get_indices_with_depth(cast(GtkTreePath*)cPtr, &_cretlength);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Returns %TRUE if descendant is a descendant of path.
   * Params:
   *   descendant = another `GtkTreePath`
   * Returns: %TRUE if descendant is contained inside path
   */
  bool isAncestor(TreePath descendant)
  {
    bool _retval;
    _retval = gtk_tree_path_is_ancestor(cast(GtkTreePath*)cPtr, descendant ? cast(GtkTreePath*)descendant.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns %TRUE if path is a descendant of ancestor.
   * Params:
   *   ancestor = another `GtkTreePath`
   * Returns: %TRUE if ancestor contains path somewhere below it
   */
  bool isDescendant(TreePath ancestor)
  {
    bool _retval;
    _retval = gtk_tree_path_is_descendant(cast(GtkTreePath*)cPtr, ancestor ? cast(GtkTreePath*)ancestor.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves the path to point to the next node at the current depth.
   */
  void next()
  {
    gtk_tree_path_next(cast(GtkTreePath*)cPtr);
  }

  /**
   * Prepends a new index to a path.
   * As a result, the depth of the path is increased.
   * Params:
   *   index = the index
   */
  void prependIndex(int index)
  {
    gtk_tree_path_prepend_index(cast(GtkTreePath*)cPtr, index);
  }

  /**
   * Moves the path to point to the previous node at the
   * current depth, if it exists.
   * Returns: %TRUE if path has a previous node, and
   *   the move was made
   */
  bool prev()
  {
    bool _retval;
    _retval = gtk_tree_path_prev(cast(GtkTreePath*)cPtr);
    return _retval;
  }

  /**
   * Generates a string representation of the path.
   * This string is a “:” separated list of numbers.
   * For example, “4:10:0:3” would be an acceptable
   * return value for this string. If the path has
   * depth 0, %NULL is returned.
   * Returns: A newly-allocated string
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gtk_tree_path_to_string(cast(GtkTreePath*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Moves the path to point to its parent node, if it has a parent.
   * Returns: %TRUE if path has a parent, and the move was made
   */
  bool up()
  {
    bool _retval;
    _retval = gtk_tree_path_up(cast(GtkTreePath*)cPtr);
    return _retval;
  }
}

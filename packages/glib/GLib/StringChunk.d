module GLib.StringChunk;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GStringChunk` provides efficient storage of groups of strings
 * String chunks are used to store groups of strings. Memory is
 * allocated in blocks, and as strings are added to the `GStringChunk`
 * they are copied into the next free position in a block. When a block
 * is full a new block is allocated.
 * When storing a large number of strings, string chunks are more
 * efficient than using func@GLib.strdup since fewer calls to `malloc$(LPAREN)$(RPAREN)`
 * are needed, and less memory is wasted in memory allocation overheads.
 * By adding strings with [GLib.StringChunk.insertConst] it is also
 * possible to remove duplicates.
 * To create a new `GStringChunk` use [GLib.StringChunk.new_].
 * To add strings to a `GStringChunk` use [GLib.StringChunk.insert].
 * To add strings to a `GStringChunk`, but without duplicating strings
 * which are already in the `GStringChunk`, use [GLib.StringChunk.insertConst].
 * To free the entire `GStringChunk` use [GLib.StringChunk.free].
 * It is not possible to free individual strings.
 */
class StringChunk
{
  GStringChunk* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.StringChunk");

    cInstancePtr = cast(GStringChunk*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_string_chunk_free(cInstancePtr);
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Frees all strings contained within the #GStringChunk.
   * After calling [GLib.StringChunk.clear] it is not safe to
   * access any of the strings which were contained within it.
   */
  void clear()
  {
    g_string_chunk_clear(cast(GStringChunk*)cPtr);
  }

  /**
   * Adds a copy of string to the #GStringChunk.
   * It returns a pointer to the new copy of the string
   * in the #GStringChunk. The characters in the string
   * can be changed, if necessary, though you should not
   * change anything after the end of the string.
   * Unlike [GLib.StringChunk.insertConst], this function
   * does not check for duplicates. Also strings added
   * with [GLib.StringChunk.insert] will not be searched
   * by [GLib.StringChunk.insertConst] when looking for
   * duplicates.
   * Params:
   *   string_ = the string to add
   * Returns: a pointer to the copy of string within
   *   the #GStringChunk
   */
  string insert(string string_)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_string_chunk_insert(cast(GStringChunk*)cPtr, _string_);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Adds a copy of string to the #GStringChunk, unless the same
   * string has already been added to the #GStringChunk with
   * [GLib.StringChunk.insertConst].
   * This function is useful if you need to copy a large number
   * of strings but do not want to waste space storing duplicates.
   * But you must remember that there may be several pointers to
   * the same string, and so any changes made to the strings
   * should be done very carefully.
   * Note that [GLib.StringChunk.insertConst] will not return a
   * pointer to a string added with [GLib.StringChunk.insert], even
   * if they do match.
   * Params:
   *   string_ = the string to add
   * Returns: a pointer to the new or existing copy of string
   *   within the #GStringChunk
   */
  string insertConst(string string_)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_string_chunk_insert_const(cast(GStringChunk*)cPtr, _string_);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Adds a copy of the first len bytes of string to the #GStringChunk.
   * The copy is nul-terminated.
   * Since this function does not stop at nul bytes, it is the caller's
   * responsibility to ensure that string has at least len addressable
   * bytes.
   * The characters in the returned string can be changed, if necessary,
   * though you should not change anything after the end of the string.
   * Params:
   *   string_ = bytes to insert
   *   len = number of bytes of string to insert, or -1 to insert a
   *     nul-terminated string
   * Returns: a pointer to the copy of string within the #GStringChunk
   */
  string insertLen(string string_, ptrdiff_t len)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_string_chunk_insert_len(cast(GStringChunk*)cPtr, _string_, len);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

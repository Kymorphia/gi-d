module GLib.StringChunk;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque data structure representing String Chunks.
 * It should only be accessed by using the following functions.
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

  T* cPtr(T)()
  if (is(T == GStringChunk))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Frees all strings contained within the #GStringChunk.
   * After calling g_string_chunk_clear() it is not safe to
   * access any of the strings which were contained within it.
   */
  void clear()
  {
    g_string_chunk_clear(cPtr!GStringChunk);
  }

  /**
   * a pointer to the copy of @string within
   * the #GStringChunk
   */
  string insert(string string_)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_string_chunk_insert(cPtr!GStringChunk, _string_);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a pointer to the new or existing copy of @string
   * within the #GStringChunk
   */
  string insertConst(string string_)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_string_chunk_insert_const(cPtr!GStringChunk, _string_);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a pointer to the copy of @string within the #GStringChunk
   */
  string insertLen(string string_, ptrdiff_t len)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_string_chunk_insert_len(cPtr!GStringChunk, _string_, len);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

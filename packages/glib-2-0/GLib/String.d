module GLib.String;

import GLib.Boxed;
import GLib.Bytes;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GString` is an object that handles the memory management of a C string.
 * The emphasis of `GString` is on text, typically UTF-8. Crucially, the "str" member
 * of a `GString` is guaranteed to have a trailing nul character, and it is therefore
 * always safe to call functions such as `strchr$(LPAREN)$(RPAREN)` or `strdup$(LPAREN)$(RPAREN)` on it.
 * However, a `GString` can also hold arbitrary binary data, because it has a "len" member,
 * which includes any possible embedded nul characters in the data. Conceptually then,
 * `GString` is like a `GByteArray` with the addition of many convenience methods for
 * text, and a guaranteed nul terminator.
 */
class String : Boxed
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
    return g_gstring_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property string str()
  {
    return (cast(GString*)cPtr).str.fromCString(false);
  }

  @property void str(string propval)
  {
    safeFree(cast(void*)(cast(GString*)cPtr).str);
    (cast(GString*)cPtr).str = propval.toCString(true);
  }

  @property size_t len()
  {
    return (cast(GString*)cPtr).len;
  }

  @property void len(size_t propval)
  {
    (cast(GString*)cPtr).len = propval;
  }

  @property size_t allocatedLen()
  {
    return (cast(GString*)cPtr).allocatedLen;
  }

  @property void allocatedLen(size_t propval)
  {
    (cast(GString*)cPtr).allocatedLen = propval;
  }

  /**
   * Creates a new #GString, initialized with the given string.
   * Params:
   *   init_ = the initial text to copy into the string, or %NULL to
   *     start with an empty string
   * Returns: the new #GString
   */
  this(string init_)
  {
    GString* _cretval;
    const(char)* _init_ = init_.toCString(false);
    _cretval = g_string_new(_init_);
    this(_cretval, true);
  }

  /**
   * Creates a new #GString with len bytes of the init buffer.
   * Because a length is provided, init need not be nul-terminated,
   * and can contain embedded nul bytes.
   * Since this function does not stop at nul bytes, it is the caller's
   * responsibility to ensure that init has at least len addressable
   * bytes.
   * Params:
   *   init_ = initial contents of the string
   *   len = length of init to use
   * Returns: a new #GString
   */
  static String newLen(string init_, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _init_ = init_.toCString(false);
    _cretval = g_string_new_len(_init_, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GString, initialized with the given string.
   * After this call, init belongs to the #GString and may no longer be
   * modified by the caller. The memory of data has to be dynamically
   * allocated and will eventually be freed with [GLib.Global.gfree].
   * Params:
   *   init_ = initial text used as the string.
   *     Ownership of the string is transferred to the #GString.
   *     Passing %NULL creates an empty string.
   * Returns: the new #GString
   */
  static String newTake(string init_)
  {
    GString* _cretval;
    char* _init_ = init_.toCString(true);
    _cretval = g_string_new_take(_init_);
    auto _retval = _cretval ? new String(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GString, with enough space for dfl_size
   * bytes. This is useful if you are going to add a lot of
   * text to the string and don't want it to be reallocated
   * too often.
   * Params:
   *   dflSize = the default size of the space allocated to hold the string
   * Returns: the new #GString
   */
  static String sizedNew(size_t dflSize)
  {
    GString* _cretval;
    _cretval = g_string_sized_new(dflSize);
    auto _retval = _cretval ? new String(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds a string onto the end of a #GString, expanding
   * it if necessary.
   * Params:
   *   val = the string to append onto the end of string
   * Returns: string
   */
  String append(string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_append(cast(GString*)cPtr, _val);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a byte onto the end of a #GString, expanding
   * it if necessary.
   * Params:
   *   c = the byte to append onto the end of string
   * Returns: string
   */
  String appendC(char c)
  {
    GString* _cretval;
    _cretval = g_string_append_c(cast(GString*)cPtr, c);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Appends len bytes of val to string.
   * If len is positive, val may contain embedded nuls and need
   * not be nul-terminated. It is the caller's responsibility to
   * ensure that val has at least len addressable bytes.
   * If len is negative, val must be nul-terminated and len
   * is considered to request the entire string length. This
   * makes [GLib.String.appendLen] equivalent to [GLib.String.append].
   * Params:
   *   val = bytes to append
   *   len = number of bytes of val to use, or -1 for all of val
   * Returns: string
   */
  String appendLen(string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_append_len(cast(GString*)cPtr, _val, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Converts a Unicode character into UTF-8, and appends it
   * to the string.
   * Params:
   *   wc = a Unicode character
   * Returns: string
   */
  String appendUnichar(dchar wc)
  {
    GString* _cretval;
    _cretval = g_string_append_unichar(cast(GString*)cPtr, wc);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Appends unescaped to string, escaping any characters that
   * are reserved in URIs using URI-style escape sequences.
   * Params:
   *   unescaped = a string
   *   reservedCharsAllowed = a string of reserved characters allowed
   *     to be used, or %NULL
   *   allowUtf8 = set %TRUE if the escaped string may include UTF8 characters
   * Returns: string
   */
  String appendUriEscaped(string unescaped, string reservedCharsAllowed, bool allowUtf8)
  {
    GString* _cretval;
    const(char)* _unescaped = unescaped.toCString(false);
    const(char)* _reservedCharsAllowed = reservedCharsAllowed.toCString(false);
    _cretval = g_string_append_uri_escaped(cast(GString*)cPtr, _unescaped, _reservedCharsAllowed, allowUtf8);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Converts all uppercase ASCII letters to lowercase ASCII letters.
   * Returns: passed-in string pointer, with all the
   *   uppercase characters converted to lowercase in place,
   *   with semantics that exactly match [GLib.Global.asciiTolower].
   */
  String asciiDown()
  {
    GString* _cretval;
    _cretval = g_string_ascii_down(cast(GString*)cPtr);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Converts all lowercase ASCII letters to uppercase ASCII letters.
   * Returns: passed-in string pointer, with all the
   *   lowercase characters converted to uppercase in place,
   *   with semantics that exactly match [GLib.Global.asciiToupper].
   */
  String asciiUp()
  {
    GString* _cretval;
    _cretval = g_string_ascii_up(cast(GString*)cPtr);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Copies the bytes from a string into a #GString,
   * destroying any previous contents. It is rather like
   * the standard strcpy$(LPAREN)$(RPAREN) function, except that you do not
   * have to worry about having enough space to copy the string.
   * Params:
   *   rval = the string to copy into string
   * Returns: string
   */
  String assign(string rval)
  {
    GString* _cretval;
    const(char)* _rval = rval.toCString(false);
    _cretval = g_string_assign(cast(GString*)cPtr, _rval);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Converts a #GString to lowercase.
   * Returns: the #GString

   * Deprecated: This function uses the locale-specific
   *   tolower$(LPAREN)$(RPAREN) function, which is almost never the right thing.
   *   Use [GLib.String.asciiDown] or [GLib.Global.utf8Strdown] instead.
   */
  String down()
  {
    GString* _cretval;
    _cretval = g_string_down(cast(GString*)cPtr);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Compares two strings for equality, returning %TRUE if they are equal.
   * For use with #GHashTable.
   * Params:
   *   v2 = another #GString
   * Returns: %TRUE if the strings are the same length and contain the
   *   same bytes
   */
  bool equal(String v2)
  {
    bool _retval;
    _retval = g_string_equal(cast(GString*)cPtr, v2 ? cast(GString*)v2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Removes len bytes from a #GString, starting at position pos.
   * The rest of the #GString is shifted down to fill the gap.
   * Params:
   *   pos = the position of the content to remove
   *   len = the number of bytes to remove, or -1 to remove all
   *     following bytes
   * Returns: string
   */
  String erase(ptrdiff_t pos, ptrdiff_t len)
  {
    GString* _cretval;
    _cretval = g_string_erase(cast(GString*)cPtr, pos, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Frees the memory allocated for the #GString.
   * The caller gains ownership of the buffer and
   * must free it after use with [GLib.Global.gfree].
   * Returns: the character data of string
   */
  string freeAndSteal()
  {
    char* _cretval;
    _cretval = g_string_free_and_steal(cast(GString*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Transfers ownership of the contents of string to a newly allocated
   * #GBytes.  The #GString structure itself is deallocated, and it is
   * therefore invalid to use string after invoking this function.
   * Note that while #GString ensures that its buffer always has a
   * trailing nul character $(LPAREN)not reflected in its "len"$(RPAREN), the returned
   * #GBytes does not include this extra nul; i.e. it has length exactly
   * equal to the "len" member.
   * Returns: A newly allocated #GBytes containing contents of string; string itself is freed
   */
  Bytes freeToBytes()
  {
    GBytes* _cretval;
    _cretval = g_string_free_to_bytes(cast(GString*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a hash code for str; for use with #GHashTable.
   * Returns: hash code for str
   */
  uint hash()
  {
    uint _retval;
    _retval = g_string_hash(cast(GString*)cPtr);
    return _retval;
  }

  /**
   * Inserts a copy of a string into a #GString,
   * expanding it if necessary.
   * Params:
   *   pos = the position to insert the copy of the string
   *   val = the string to insert
   * Returns: string
   */
  String insert(ptrdiff_t pos, string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_insert(cast(GString*)cPtr, pos, _val);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Inserts a byte into a #GString, expanding it if necessary.
   * Params:
   *   pos = the position to insert the byte
   *   c = the byte to insert
   * Returns: string
   */
  String insertC(ptrdiff_t pos, char c)
  {
    GString* _cretval;
    _cretval = g_string_insert_c(cast(GString*)cPtr, pos, c);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Inserts len bytes of val into string at pos.
   * If len is positive, val may contain embedded nuls and need
   * not be nul-terminated. It is the caller's responsibility to
   * ensure that val has at least len addressable bytes.
   * If len is negative, val must be nul-terminated and len
   * is considered to request the entire string length.
   * If pos is -1, bytes are inserted at the end of the string.
   * Params:
   *   pos = position in string where insertion should
   *     happen, or -1 for at the end
   *   val = bytes to insert
   *   len = number of bytes of val to insert, or -1 for all of val
   * Returns: string
   */
  String insertLen(ptrdiff_t pos, string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_insert_len(cast(GString*)cPtr, pos, _val, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Converts a Unicode character into UTF-8, and insert it
   * into the string at the given position.
   * Params:
   *   pos = the position at which to insert character, or -1
   *     to append at the end of the string
   *   wc = a Unicode character
   * Returns: string
   */
  String insertUnichar(ptrdiff_t pos, dchar wc)
  {
    GString* _cretval;
    _cretval = g_string_insert_unichar(cast(GString*)cPtr, pos, wc);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Overwrites part of a string, lengthening it if necessary.
   * Params:
   *   pos = the position at which to start overwriting
   *   val = the string that will overwrite the string starting at pos
   * Returns: string
   */
  String overwrite(size_t pos, string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_overwrite(cast(GString*)cPtr, pos, _val);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Overwrites part of a string, lengthening it if necessary.
   * This function will work with embedded nuls.
   * Params:
   *   pos = the position at which to start overwriting
   *   val = the string that will overwrite the string starting at pos
   *   len = the number of bytes to write from val
   * Returns: string
   */
  String overwriteLen(size_t pos, string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_overwrite_len(cast(GString*)cPtr, pos, _val, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a string on to the start of a #GString,
   * expanding it if necessary.
   * Params:
   *   val = the string to prepend on the start of string
   * Returns: string
   */
  String prepend(string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_prepend(cast(GString*)cPtr, _val);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a byte onto the start of a #GString,
   * expanding it if necessary.
   * Params:
   *   c = the byte to prepend on the start of the #GString
   * Returns: string
   */
  String prependC(char c)
  {
    GString* _cretval;
    _cretval = g_string_prepend_c(cast(GString*)cPtr, c);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Prepends len bytes of val to string.
   * If len is positive, val may contain embedded nuls and need
   * not be nul-terminated. It is the caller's responsibility to
   * ensure that val has at least len addressable bytes.
   * If len is negative, val must be nul-terminated and len
   * is considered to request the entire string length. This
   * makes [GLib.String.prependLen] equivalent to [GLib.String.prepend].
   * Params:
   *   val = bytes to prepend
   *   len = number of bytes in val to prepend, or -1 for all of val
   * Returns: string
   */
  String prependLen(string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_prepend_len(cast(GString*)cPtr, _val, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Converts a Unicode character into UTF-8, and prepends it
   * to the string.
   * Params:
   *   wc = a Unicode character
   * Returns: string
   */
  String prependUnichar(dchar wc)
  {
    GString* _cretval;
    _cretval = g_string_prepend_unichar(cast(GString*)cPtr, wc);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Replaces the string find with the string replace in a #GString up to
   * limit times. If the number of instances of find in the #GString is
   * less than limit, all instances are replaced. If limit is `0`,
   * all instances of find are replaced.
   * If find is the empty string, since versions 2.69.1 and 2.68.4 the
   * replacement will be inserted no more than once per possible position
   * $(LPAREN)beginning of string, end of string and between characters$(RPAREN). This did
   * not work correctly in earlier versions.
   * Params:
   *   find = the string to find in string
   *   replace = the string to insert in place of find
   *   limit = the maximum instances of find to replace with replace, or `0` for
   *     no limit
   * Returns: the number of find and replace operations performed.
   */
  uint replace(string find, string replace, uint limit)
  {
    uint _retval;
    const(char)* _find = find.toCString(false);
    const(char)* _replace = replace.toCString(false);
    _retval = g_string_replace(cast(GString*)cPtr, _find, _replace, limit);
    return _retval;
  }

  /**
   * Sets the length of a #GString. If the length is less than
   * the current length, the string will be truncated. If the
   * length is greater than the current length, the contents
   * of the newly added area are undefined. $(LPAREN)However, as
   * always, string->str[string->len] will be a nul byte.$(RPAREN)
   * Params:
   *   len = the new length
   * Returns: string
   */
  String setSize(size_t len)
  {
    GString* _cretval;
    _cretval = g_string_set_size(cast(GString*)cPtr, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Cuts off the end of the GString, leaving the first len bytes.
   * Params:
   *   len = the new size of string
   * Returns: string
   */
  String truncate(size_t len)
  {
    GString* _cretval;
    _cretval = g_string_truncate(cast(GString*)cPtr, len);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Converts a #GString to uppercase.
   * Returns: string

   * Deprecated: This function uses the locale-specific
   *   toupper$(LPAREN)$(RPAREN) function, which is almost never the right thing.
   *   Use [GLib.String.asciiUp] or [GLib.Global.utf8Strup] instead.
   */
  String up()
  {
    GString* _cretval;
    _cretval = g_string_up(cast(GString*)cPtr);
    auto _retval = _cretval ? new String(cast(void*)_cretval, false) : null;
    return _retval;
  }
}

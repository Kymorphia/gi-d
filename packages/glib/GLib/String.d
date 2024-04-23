module GLib.String;

import GLib.Boxed;
import GLib.Bytes;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The GString struct contains the public fields of a GString.
 */
class String : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GString))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_gstring_get_type();
  }

  @property string str()
  {
    return cPtr!GString.str.fromCString(false);
  }

  @property void str(string propval)
  {
    g_free(cast(void*)cPtr!GString.str);
    cPtr!GString.str = propval.toCString(true);
  }

  @property size_t len()
  {
    return cPtr!GString.len;
  }

  @property void len(size_t propval)
  {
    cPtr!GString.len = propval;
  }

  @property size_t allocatedLen()
  {
    return cPtr!GString.allocatedLen;
  }

  @property void allocatedLen(size_t propval)
  {
    cPtr!GString.allocatedLen = propval;
  }

  /**
   * the new #GString
   */
  this(string init_)
  {
    GString* _cretval;
    const(char)* _init_ = init_.toCString(false);
    _cretval = g_string_new(_init_);
    this(_cretval, true);
  }

  /**
   * a new #GString
   */
  static String newLen(string init_, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _init_ = init_.toCString(false);
    _cretval = g_string_new_len(_init_, len);
    String _retval = new String(cast(GString*)_cretval, true);
    return _retval;
  }

  /**
   * the new #GString
   */
  static String newTake(string init_)
  {
    GString* _cretval;
    char* _init_ = init_.toCString(true);
    _cretval = g_string_new_take(_init_);
    String _retval = new String(cast(GString*)_cretval, true);
    return _retval;
  }

  /**
   * the new #GString
   */
  static String sizedNew(size_t dflSize)
  {
    GString* _cretval;
    _cretval = g_string_sized_new(dflSize);
    String _retval = new String(cast(GString*)_cretval, true);
    return _retval;
  }

  /**
   * @string
   */
  String append(string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_append(cPtr!GString, _val);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String appendC(char c)
  {
    GString* _cretval;
    _cretval = g_string_append_c(cPtr!GString, c);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String appendLen(string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_append_len(cPtr!GString, _val, len);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String appendUnichar(dchar wc)
  {
    GString* _cretval;
    _cretval = g_string_append_unichar(cPtr!GString, wc);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String appendUriEscaped(string unescaped, string reservedCharsAllowed, bool allowUtf8)
  {
    GString* _cretval;
    const(char)* _unescaped = unescaped.toCString(false);
    const(char)* _reservedCharsAllowed = reservedCharsAllowed.toCString(false);
    _cretval = g_string_append_uri_escaped(cPtr!GString, _unescaped, _reservedCharsAllowed, allowUtf8);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * passed-in @string pointer, with all the
   * uppercase characters converted to lowercase in place,
   * with semantics that exactly match g_ascii_tolower().
   */
  String asciiDown()
  {
    GString* _cretval;
    _cretval = g_string_ascii_down(cPtr!GString);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * passed-in @string pointer, with all the
   * lowercase characters converted to uppercase in place,
   * with semantics that exactly match g_ascii_toupper().
   */
  String asciiUp()
  {
    GString* _cretval;
    _cretval = g_string_ascii_up(cPtr!GString);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String assign(string rval)
  {
    GString* _cretval;
    const(char)* _rval = rval.toCString(false);
    _cretval = g_string_assign(cPtr!GString, _rval);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * the #GString
   */
  String down()
  {
    GString* _cretval;
    _cretval = g_string_down(cPtr!GString);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if the strings are the same length and contain the
   * same bytes
   */
  bool equal(String v2)
  {
    bool _retval;
    _retval = g_string_equal(cPtr!GString, v2 ? v2.cPtr!GString : null);
    return _retval;
  }

  /**
   * @string
   */
  String erase(ptrdiff_t pos, ptrdiff_t len)
  {
    GString* _cretval;
    _cretval = g_string_erase(cPtr!GString, pos, len);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * the character data of @string
   */
  string freeAndSteal()
  {
    char* _cretval;
    _cretval = g_string_free_and_steal(cPtr!GString);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * A newly allocated #GBytes containing contents of @string; @string itself is freed
   */
  Bytes freeToBytes()
  {
    GBytes* _cretval;
    _cretval = g_string_free_to_bytes(cPtr!GString);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * hash code for @str
   */
  uint hash()
  {
    uint _retval;
    _retval = g_string_hash(cPtr!GString);
    return _retval;
  }

  /**
   * @string
   */
  String insert(ptrdiff_t pos, string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_insert(cPtr!GString, pos, _val);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String insertC(ptrdiff_t pos, char c)
  {
    GString* _cretval;
    _cretval = g_string_insert_c(cPtr!GString, pos, c);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String insertLen(ptrdiff_t pos, string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_insert_len(cPtr!GString, pos, _val, len);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String insertUnichar(ptrdiff_t pos, dchar wc)
  {
    GString* _cretval;
    _cretval = g_string_insert_unichar(cPtr!GString, pos, wc);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String overwrite(size_t pos, string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_overwrite(cPtr!GString, pos, _val);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String overwriteLen(size_t pos, string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_overwrite_len(cPtr!GString, pos, _val, len);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String prepend(string val)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_prepend(cPtr!GString, _val);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String prependC(char c)
  {
    GString* _cretval;
    _cretval = g_string_prepend_c(cPtr!GString, c);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String prependLen(string val, ptrdiff_t len)
  {
    GString* _cretval;
    const(char)* _val = val.toCString(false);
    _cretval = g_string_prepend_len(cPtr!GString, _val, len);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String prependUnichar(dchar wc)
  {
    GString* _cretval;
    _cretval = g_string_prepend_unichar(cPtr!GString, wc);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * the number of find and replace operations performed.
   */
  uint replace(string find, string replace, uint limit)
  {
    uint _retval;
    const(char)* _find = find.toCString(false);
    const(char)* _replace = replace.toCString(false);
    _retval = g_string_replace(cPtr!GString, _find, _replace, limit);
    return _retval;
  }

  /**
   * @string
   */
  String setSize(size_t len)
  {
    GString* _cretval;
    _cretval = g_string_set_size(cPtr!GString, len);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String truncate(size_t len)
  {
    GString* _cretval;
    _cretval = g_string_truncate(cPtr!GString, len);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }

  /**
   * @string
   */
  String up()
  {
    GString* _cretval;
    _cretval = g_string_up(cPtr!GString);
    String _retval = new String(cast(GString*)_cretval, false);
    return _retval;
  }
}

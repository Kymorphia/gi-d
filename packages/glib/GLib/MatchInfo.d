module GLib.MatchInfo;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Regex;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A GMatchInfo is an opaque struct used to return information about
 * matches.
 */
class MatchInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GMatchInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_match_info_get_type();
  }

  /**
   * the expanded string, or %NULL if an error occurred
   */
  string expandReferences(string stringToExpand)
  {
    char* _cretval;
    const(char)* _stringToExpand = stringToExpand.toCString(false);
    GError *_err;
    _cretval = g_match_info_expand_references(cPtr!GMatchInfo, _stringToExpand, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The matched substring, or %NULL if an error
   * occurred. You have to free the string yourself
   */
  string fetch(int matchNum)
  {
    char* _cretval;
    _cretval = g_match_info_fetch(cPtr!GMatchInfo, matchNum);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a %NULL-terminated array of gchar *
   * pointers.  It must be freed using g_strfreev(). If the previous
   * match failed %NULL is returned
   */
  string[] fetchAll()
  {
    char** _cretval;
    _cretval = g_match_info_fetch_all(cPtr!GMatchInfo);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * The matched substring, or %NULL if an error
   * occurred. You have to free the string yourself
   */
  string fetchNamed(string name)
  {
    char* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_match_info_fetch_named(cPtr!GMatchInfo, _name);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if the position was fetched, %FALSE otherwise.
   * If the position cannot be fetched, @start_pos and @end_pos
   * are left unchanged.
   */
  bool fetchNamedPos(string name, out int startPos, out int endPos)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_match_info_fetch_named_pos(cPtr!GMatchInfo, _name, cast(int*)&startPos, cast(int*)&endPos);
    return _retval;
  }

  /**
   * %TRUE if the position was fetched, %FALSE otherwise. If
   * the position cannot be fetched, @start_pos and @end_pos are left
   * unchanged
   */
  bool fetchPos(int matchNum, out int startPos, out int endPos)
  {
    bool _retval;
    _retval = g_match_info_fetch_pos(cPtr!GMatchInfo, matchNum, cast(int*)&startPos, cast(int*)&endPos);
    return _retval;
  }

  /**
   * Number of matched substrings, or -1 if an error occurred
   */
  int getMatchCount()
  {
    int _retval;
    _retval = g_match_info_get_match_count(cPtr!GMatchInfo);
    return _retval;
  }

  /**
   * #GRegex object used in @match_info
   */
  Regex getRegex()
  {
    GRegex* _cretval;
    _cretval = g_match_info_get_regex(cPtr!GMatchInfo);
    Regex _retval = new Regex(cast(GRegex*)_cretval, false);
    return _retval;
  }

  /**
   * the string searched with @match_info
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_match_info_get_string(cPtr!GMatchInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if the match was partial, %FALSE otherwise
   */
  bool isPartialMatch()
  {
    bool _retval;
    _retval = g_match_info_is_partial_match(cPtr!GMatchInfo);
    return _retval;
  }

  /**
   * %TRUE if the previous match operation succeeded,
   * %FALSE otherwise
   */
  bool matches()
  {
    bool _retval;
    _retval = g_match_info_matches(cPtr!GMatchInfo);
    return _retval;
  }

  /**
   * %TRUE is the string matched, %FALSE otherwise
   */
  bool next()
  {
    bool _retval;
    GError *_err;
    _retval = g_match_info_next(cPtr!GMatchInfo, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

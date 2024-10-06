module GLib.MatchInfo;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Regex;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_match_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a new string containing the text in string_to_expand with
   * references and escape sequences expanded. References refer to the last
   * match done with string against regex and have the same syntax used by
   * [GLib.Regex.replace].
   * The string_to_expand must be UTF-8 encoded even if %G_REGEX_RAW was
   * passed to [GLib.Regex.new_].
   * The backreferences are extracted from the string passed to the match
   * function, so you cannot call this function after freeing the string.
   * match_info may be %NULL in which case string_to_expand must not
   * contain references. For instance "foo\n" does not refer to an actual
   * pattern and '\n' merely will be replaced with \n character,
   * while to expand "\0" $(LPAREN)whole match$(RPAREN) one needs the result of a match.
   * Use [GLib.Regex.checkReplacement] to find out whether string_to_expand
   * contains references.
   * Params:
   *   stringToExpand = the string to expand
   * Returns: the expanded string, or %NULL if an error occurred
   */
  string expandReferences(string stringToExpand)
  {
    char* _cretval;
    const(char)* _stringToExpand = stringToExpand.toCString(false);
    GError *_err;
    _cretval = g_match_info_expand_references(cast(GMatchInfo*)cPtr, _stringToExpand, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Retrieves the text matching the match_num'th capturing
   * parentheses. 0 is the full text of the match, 1 is the first paren
   * set, 2 the second, and so on.
   * If match_num is a valid sub pattern but it didn't match anything
   * $(LPAREN)e.g. sub pattern 1, matching "b" against "$(LPAREN)a$(RPAREN)?b"$(RPAREN) then an empty
   * string is returned.
   * If the match was obtained using the DFA algorithm, that is using
   * [GLib.Regex.matchAll] or [GLib.Regex.matchAllFull], the retrieved
   * string is not that of a set of parentheses but that of a matched
   * substring. Substrings are matched in reverse order of length, so
   * 0 is the longest match.
   * The string is fetched from the string passed to the match function,
   * so you cannot call this function after freeing the string.
   * Params:
   *   matchNum = number of the sub expression
   * Returns: The matched substring, or %NULL if an error
   *   occurred. You have to free the string yourself
   */
  string fetch(int matchNum)
  {
    char* _cretval;
    _cretval = g_match_info_fetch(cast(GMatchInfo*)cPtr, matchNum);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Bundles up pointers to each of the matching substrings from a match
   * and stores them in an array of gchar pointers. The first element in
   * the returned array is the match number 0, i.e. the entire matched
   * text.
   * If a sub pattern didn't match anything $(LPAREN)e.g. sub pattern 1, matching
   * "b" against "$(LPAREN)a$(RPAREN)?b"$(RPAREN) then an empty string is inserted.
   * If the last match was obtained using the DFA algorithm, that is using
   * [GLib.Regex.matchAll] or [GLib.Regex.matchAllFull], the retrieved
   * strings are not that matched by sets of parentheses but that of the
   * matched substring. Substrings are matched in reverse order of length,
   * so the first one is the longest match.
   * The strings are fetched from the string passed to the match function,
   * so you cannot call this function after freeing the string.
   * Returns: a %NULL-terminated array of gchar *
   *   pointers.  It must be freed using [GLib.Global.strfreev]. If the previous
   *   match failed %NULL is returned
   */
  string[] fetchAll()
  {
    char** _cretval;
    _cretval = g_match_info_fetch_all(cast(GMatchInfo*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Retrieves the text matching the capturing parentheses named name.
   * If name is a valid sub pattern name but it didn't match anything
   * $(LPAREN)e.g. sub pattern "X", matching "b" against "$(LPAREN)?P<X>a$(RPAREN)?b"$(RPAREN)
   * then an empty string is returned.
   * The string is fetched from the string passed to the match function,
   * so you cannot call this function after freeing the string.
   * Params:
   *   name = name of the subexpression
   * Returns: The matched substring, or %NULL if an error
   *   occurred. You have to free the string yourself
   */
  string fetchNamed(string name)
  {
    char* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_match_info_fetch_named(cast(GMatchInfo*)cPtr, _name);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Retrieves the position in bytes of the capturing parentheses named name.
   * If name is a valid sub pattern name but it didn't match anything
   * $(LPAREN)e.g. sub pattern "X", matching "b" against "$(LPAREN)?P<X>a$(RPAREN)?b"$(RPAREN)
   * then start_pos and end_pos are set to -1 and %TRUE is returned.
   * Params:
   *   name = name of the subexpression
   *   startPos = pointer to location where to store
   *     the start position, or %NULL
   *   endPos = pointer to location where to store
   *     the end position, or %NULL
   * Returns: %TRUE if the position was fetched, %FALSE otherwise.
   *   If the position cannot be fetched, start_pos and end_pos
   *   are left unchanged.
   */
  bool fetchNamedPos(string name, out int startPos, out int endPos)
  {
    bool _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_match_info_fetch_named_pos(cast(GMatchInfo*)cPtr, _name, cast(int*)&startPos, cast(int*)&endPos);
    return _retval;
  }

  /**
   * Retrieves the position in bytes of the match_num'th capturing
   * parentheses. 0 is the full text of the match, 1 is the first
   * paren set, 2 the second, and so on.
   * If match_num is a valid sub pattern but it didn't match anything
   * $(LPAREN)e.g. sub pattern 1, matching "b" against "$(LPAREN)a$(RPAREN)?b"$(RPAREN) then start_pos
   * and end_pos are set to -1 and %TRUE is returned.
   * If the match was obtained using the DFA algorithm, that is using
   * [GLib.Regex.matchAll] or [GLib.Regex.matchAllFull], the retrieved
   * position is not that of a set of parentheses but that of a matched
   * substring. Substrings are matched in reverse order of length, so
   * 0 is the longest match.
   * Params:
   *   matchNum = number of the sub expression
   *   startPos = pointer to location where to store
   *     the start position, or %NULL
   *   endPos = pointer to location where to store
   *     the end position, or %NULL
   * Returns: %TRUE if the position was fetched, %FALSE otherwise. If
   *   the position cannot be fetched, start_pos and end_pos are left
   *   unchanged
   */
  bool fetchPos(int matchNum, out int startPos, out int endPos)
  {
    bool _retval;
    _retval = g_match_info_fetch_pos(cast(GMatchInfo*)cPtr, matchNum, cast(int*)&startPos, cast(int*)&endPos);
    return _retval;
  }

  /**
   * Retrieves the number of matched substrings $(LPAREN)including substring 0,
   * that is the whole matched text$(RPAREN), so 1 is returned if the pattern
   * has no substrings in it and 0 is returned if the match failed.
   * If the last match was obtained using the DFA algorithm, that is
   * using [GLib.Regex.matchAll] or [GLib.Regex.matchAllFull], the retrieved
   * count is not that of the number of capturing parentheses but that of
   * the number of matched substrings.
   * Returns: Number of matched substrings, or -1 if an error occurred
   */
  int getMatchCount()
  {
    int _retval;
    _retval = g_match_info_get_match_count(cast(GMatchInfo*)cPtr);
    return _retval;
  }

  /**
   * Returns #GRegex object used in match_info. It belongs to Glib
   * and must not be freed. Use [GLib.Regex.ref_] if you need to keep it
   * after you free match_info object.
   * Returns: #GRegex object used in match_info
   */
  Regex getRegex()
  {
    GRegex* _cretval;
    _cretval = g_match_info_get_regex(cast(GMatchInfo*)cPtr);
    auto _retval = _cretval ? new Regex(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the string searched with match_info. This is the
   * string passed to [GLib.Regex.match] or [GLib.Regex.replace] so
   * you may not free it before calling this function.
   * Returns: the string searched with match_info
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_match_info_get_string(cast(GMatchInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Usually if the string passed to g_regex_match*$(LPAREN)$(RPAREN) matches as far as
   * it goes, but is too short to match the entire pattern, %FALSE is
   * returned. There are circumstances where it might be helpful to
   * distinguish this case from other cases in which there is no match.
   * Consider, for example, an application where a human is required to
   * type in data for a field with specific formatting requirements. An
   * example might be a date in the form ddmmmyy, defined by the pattern
   * "^\d?\d$(LPAREN)jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec$(RPAREN)\d\d\$".
   * If the application sees the user’s keystrokes one by one, and can
   * check that what has been typed so far is potentially valid, it is
   * able to raise an error as soon as a mistake is made.
   * GRegex supports the concept of partial matching by means of the
   * %G_REGEX_MATCH_PARTIAL_SOFT and %G_REGEX_MATCH_PARTIAL_HARD flags.
   * When they are used, the return code for
   * [GLib.Regex.match] or [GLib.Regex.matchFull] is, as usual, %TRUE
   * for a complete match, %FALSE otherwise. But, when these functions
   * return %FALSE, you can check if the match was partial calling
   * [GLib.MatchInfo.isPartialMatch].
   * The difference between %G_REGEX_MATCH_PARTIAL_SOFT and
   * %G_REGEX_MATCH_PARTIAL_HARD is that when a partial match is encountered
   * with %G_REGEX_MATCH_PARTIAL_SOFT, matching continues to search for a
   * possible complete match, while with %G_REGEX_MATCH_PARTIAL_HARD matching
   * stops at the partial match.
   * When both %G_REGEX_MATCH_PARTIAL_SOFT and %G_REGEX_MATCH_PARTIAL_HARD
   * are set, the latter takes precedence.
   * There were formerly some restrictions on the pattern for partial matching.
   * The restrictions no longer apply.
   * See pcrepartial$(LPAREN)3$(RPAREN) for more information on partial matching.
   * Returns: %TRUE if the match was partial, %FALSE otherwise
   */
  bool isPartialMatch()
  {
    bool _retval;
    _retval = g_match_info_is_partial_match(cast(GMatchInfo*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the previous match operation succeeded.
   * Returns: %TRUE if the previous match operation succeeded,
   *   %FALSE otherwise
   */
  bool matches()
  {
    bool _retval;
    _retval = g_match_info_matches(cast(GMatchInfo*)cPtr);
    return _retval;
  }

  /**
   * Scans for the next match using the same parameters of the previous
   * call to [GLib.Regex.matchFull] or [GLib.Regex.match] that returned
   * match_info.
   * The match is done on the string passed to the match function, so you
   * cannot free it before calling this function.
   * Returns: %TRUE is the string matched, %FALSE otherwise
   */
  bool next()
  {
    bool _retval;
    GError *_err;
    _retval = g_match_info_next(cast(GMatchInfo*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

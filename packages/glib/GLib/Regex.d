module GLib.Regex;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.MatchInfo;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The g_regex_*() functions implement regular
 * expression pattern matching using syntax and semantics similar to
 * Perl regular expression.
 *
 * Some functions accept a @start_position argument, setting it differs
 * from just passing over a shortened string and setting %G_REGEX_MATCH_NOTBOL
 * in the case of a pattern that begins with any kind of lookbehind assertion.
 * For example, consider the pattern "\Biss\B" which finds occurrences of "iss"
 * in the middle of words. ("\B" matches only if the current position in the
 * subject is not a word boundary.) When applied to the string "Mississipi"
 * from the fourth byte, namely "issipi", it does not match, because "\B" is
 * always false at the start of the subject, which is deemed to be a word
 * boundary. However, if the entire string is passed , but with
 * @start_position set to 4, it finds the second occurrence of "iss" because
 * it is able to look behind the starting point to discover that it is
 * preceded by a letter.
 *
 * Note that, unless you set the %G_REGEX_RAW flag, all the strings passed
 * to these functions must be encoded in UTF-8. The lengths and the positions
 * inside the strings are in bytes and not in characters, so, for instance,
 * "\xc3\xa0" (i.e. "à") is two bytes long but it is treated as a
 * single character. If you set %G_REGEX_RAW the strings can be non-valid
 * UTF-8 strings and a byte is treated as a character, so "\xc3\xa0" is two
 * bytes and two characters long.
 *
 * When matching a pattern, "\n" matches only against a "\n" character in
 * the string, and "\r" matches only a "\r" character. To match any newline
 * sequence use "\R". This particular group matches either the two-character
 * sequence CR + LF ("\r\n"), or one of the single characters LF (linefeed,
 * U+000A, "\n"), VT vertical tab, U+000B, "\v"), FF (formfeed, U+000C, "\f"),
 * CR (carriage return, U+000D, "\r"), NEL (next line, U+0085), LS (line
 * separator, U+2028), or PS (paragraph separator, U+2029).
 *
 * The behaviour of the dot, circumflex, and dollar metacharacters are
 * affected by newline characters, the default is to recognize any newline
 * character (the same characters recognized by "\R"). This can be changed
 * with %G_REGEX_NEWLINE_CR, %G_REGEX_NEWLINE_LF and %G_REGEX_NEWLINE_CRLF
 * compile options, and with %G_REGEX_MATCH_NEWLINE_ANY,
 * %G_REGEX_MATCH_NEWLINE_CR, %G_REGEX_MATCH_NEWLINE_LF and
 * %G_REGEX_MATCH_NEWLINE_CRLF match options. These settings are also
 * relevant when compiling a pattern if %G_REGEX_EXTENDED is set, and an
 * unescaped "#" outside a character class is encountered. This indicates
 * a comment that lasts until after the next newline.
 *
 * Creating and manipulating the same #GRegex structure from different
 * threads is not a problem as #GRegex does not modify its internal
 * state between creation and destruction, on the other hand #GMatchInfo
 * is not threadsafe.
 *
 * The regular expressions low-level functionalities are obtained through
 * the excellent
 * [PCRE](http://www.pcre.org/)
 * library written by Philip Hazel.
 */
class Regex : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GRegex))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_regex_get_type();
  }

  /**
   * a #GRegex structure or %NULL if an error occurred. Call
   * g_regex_unref() when you are done with it
   */
  this(string pattern, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions)
  {
    GRegex* _cretval;
    const(char)* _pattern = pattern.toCString(false);
    GError *_err;
    _cretval = g_regex_new(_pattern, compileOptions, matchOptions, &_err);
    if (_err)
      throw new RegexException(_err);
    this(_cretval, true);
  }

  /**
   * the number of capturing subpatterns
   */
  int getCaptureCount()
  {
    int _retval;
    _retval = g_regex_get_capture_count(cPtr!GRegex);
    return _retval;
  }

  /**
   * flags from #GRegexCompileFlags
   */
  RegexCompileFlags getCompileFlags()
  {
    GRegexCompileFlags _cretval;
    _cretval = g_regex_get_compile_flags(cPtr!GRegex);
    RegexCompileFlags _retval = cast(RegexCompileFlags)_cretval;
    return _retval;
  }

  /**
   * %TRUE if the pattern contains explicit CR or LF references
   */
  bool getHasCrOrLf()
  {
    bool _retval;
    _retval = g_regex_get_has_cr_or_lf(cPtr!GRegex);
    return _retval;
  }

  /**
   * flags from #GRegexMatchFlags
   */
  RegexMatchFlags getMatchFlags()
  {
    GRegexMatchFlags _cretval;
    _cretval = g_regex_get_match_flags(cPtr!GRegex);
    RegexMatchFlags _retval = cast(RegexMatchFlags)_cretval;
    return _retval;
  }

  /**
   * the number of the highest back reference
   */
  int getMaxBackref()
  {
    int _retval;
    _retval = g_regex_get_max_backref(cPtr!GRegex);
    return _retval;
  }

  /**
   * the number of characters in the longest lookbehind assertion.
   */
  int getMaxLookbehind()
  {
    int _retval;
    _retval = g_regex_get_max_lookbehind(cPtr!GRegex);
    return _retval;
  }

  /**
   * the pattern of @regex
   */
  string getPattern()
  {
    const(char)* _cretval;
    _cretval = g_regex_get_pattern(cPtr!GRegex);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The number of the subexpression or -1 if @name
   * does not exists
   */
  int getStringNumber(string name)
  {
    int _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_regex_get_string_number(cPtr!GRegex, _name);
    return _retval;
  }

  /**
   * %TRUE is the string matched, %FALSE otherwise
   */
  bool match(string string_, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    GMatchInfo* _matchInfo;
    _retval = g_regex_match(cPtr!GRegex, _string_, matchOptions, &_matchInfo);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * %TRUE is the string matched, %FALSE otherwise
   */
  bool matchAll(string string_, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    GMatchInfo* _matchInfo;
    _retval = g_regex_match_all(cPtr!GRegex, _string_, matchOptions, &_matchInfo);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * %TRUE is the string matched, %FALSE otherwise
   */
  bool matchAllFull(string string_, int startPosition, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    auto _string_ = cast(const(char)*)string_.ptr;
    GMatchInfo* _matchInfo;
    GError *_err;
    _retval = g_regex_match_all_full(cPtr!GRegex, _string_, string_ ? cast(ptrdiff_t)string_.length : 0, startPosition, matchOptions, &_matchInfo, &_err);
    if (_err)
      throw new RegexException(_err);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * %TRUE is the string matched, %FALSE otherwise
   */
  bool matchFull(string string_, int startPosition, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    auto _string_ = cast(const(char)*)string_.ptr;
    GMatchInfo* _matchInfo;
    GError *_err;
    _retval = g_regex_match_full(cPtr!GRegex, _string_, string_ ? cast(ptrdiff_t)string_.length : 0, startPosition, matchOptions, &_matchInfo, &_err);
    if (_err)
      throw new RegexException(_err);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * a newly allocated string containing the replacements
   */
  string replace(string string_, int startPosition, string replacement, RegexMatchFlags matchOptions)
  {
    char* _cretval;
    auto _string_ = cast(const(char)*)string_.ptr;
    const(char)* _replacement = replacement.toCString(false);
    GError *_err;
    _cretval = g_regex_replace(cPtr!GRegex, _string_, string_ ? cast(ptrdiff_t)string_.length : 0, startPosition, _replacement, matchOptions, &_err);
    if (_err)
      throw new RegexException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated string containing the replacements
   */
  string replaceLiteral(string string_, int startPosition, string replacement, RegexMatchFlags matchOptions)
  {
    char* _cretval;
    auto _string_ = cast(const(char)*)string_.ptr;
    const(char)* _replacement = replacement.toCString(false);
    GError *_err;
    _cretval = g_regex_replace_literal(cPtr!GRegex, _string_, string_ ? cast(ptrdiff_t)string_.length : 0, startPosition, _replacement, matchOptions, &_err);
    if (_err)
      throw new RegexException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a %NULL-terminated gchar ** array. Free
   * it using g_strfreev()
   */
  string[] split(string string_, RegexMatchFlags matchOptions)
  {
    char** _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_regex_split(cPtr!GRegex, _string_, matchOptions);
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
   * a %NULL-terminated gchar ** array. Free
   * it using g_strfreev()
   */
  string[] splitFull(string string_, int startPosition, RegexMatchFlags matchOptions, int maxTokens)
  {
    char** _cretval;
    auto _string_ = cast(const(char)*)string_.ptr;
    GError *_err;
    _cretval = g_regex_split_full(cPtr!GRegex, _string_, string_ ? cast(ptrdiff_t)string_.length : 0, startPosition, matchOptions, maxTokens, &_err);
    if (_err)
      throw new RegexException(_err);
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
   * whether @replacement is a valid replacement string
   */
  static bool checkReplacement(string replacement, out bool hasReferences)
  {
    bool _retval;
    const(char)* _replacement = replacement.toCString(false);
    GError *_err;
    _retval = g_regex_check_replacement(_replacement, cast(bool*)&hasReferences, &_err);
    if (_err)
      throw new RegexException(_err);
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_regex_error_quark();
    return _retval;
  }

  /**
   * a newly-allocated escaped string
   */
  static string escapeNul(string string_, int length)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_regex_escape_nul(_string_, length);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly-allocated escaped string
   */
  static string escapeString(string string_, int length)
  {
    char* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_regex_escape_string(_string_, length);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if the string matched, %FALSE otherwise
   */
  static bool matchSimple(string pattern, string string_, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions)
  {
    bool _retval;
    const(char)* _pattern = pattern.toCString(false);
    const(char)* _string_ = string_.toCString(false);
    _retval = g_regex_match_simple(_pattern, _string_, compileOptions, matchOptions);
    return _retval;
  }

  /**
   * a %NULL-terminated array of strings. Free
   * it using g_strfreev()
   */
  static string[] splitSimple(string pattern, string string_, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions)
  {
    char** _cretval;
    const(char)* _pattern = pattern.toCString(false);
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_regex_split_simple(_pattern, _string_, compileOptions, matchOptions);
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
}

class RegexException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(Regex.errorQuark, cast(int)code, msg);
  }

  alias Code = GRegexError;
}

module GLib.Regex;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.MatchInfo;
import GLib.String;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GRegex` is the "compiled" form of a regular expression pattern.
 * `GRegex` implements regular expression pattern matching using syntax and
 * semantics similar to Perl regular expression. See the
 * [PCRE documentation]$(LPAREN)$(RPAREN)(man:pcrepattern3) for the syntax definition.
 * Some functions accept a @start_position argument, setting it differs
 * from just passing over a shortened string and setting %G_REGEX_MATCH_NOTBOL
 * in the case of a pattern that begins with any kind of lookbehind assertion.
 * For example, consider the pattern "\Biss\B" which finds occurrences of "iss"
 * in the middle of words. $(LPAREN)"\B" matches only if the current position in the
 * subject is not a word boundary.$(RPAREN) When applied to the string "Mississipi"
 * from the fourth byte, namely "issipi", it does not match, because "\B" is
 * always false at the start of the subject, which is deemed to be a word
 * boundary. However, if the entire string is passed , but with
 * @start_position set to 4, it finds the second occurrence of "iss" because
 * it is able to look behind the starting point to discover that it is
 * preceded by a letter.
 * Note that, unless you set the %G_REGEX_RAW flag, all the strings passed
 * to these functions must be encoded in UTF-8. The lengths and the positions
 * inside the strings are in bytes and not in characters, so, for instance,
 * "\xc3\xa0" $(LPAREN)i.e. "à"$(RPAREN) is two bytes long but it is treated as a
 * single character. If you set %G_REGEX_RAW the strings can be non-valid
 * UTF-8 strings and a byte is treated as a character, so "\xc3\xa0" is two
 * bytes and two characters long.
 * When matching a pattern, "\n" matches only against a "\n" character in
 * the string, and "\r" matches only a "\r" character. To match any newline
 * sequence use "\R". This particular group matches either the two-character
 * sequence CR + LF $(LPAREN)"\r\n"$(RPAREN), or one of the single characters LF $(LPAREN)linefeed,
 * U+000A, "\n"$(RPAREN), VT vertical tab, U+000B, "\v"$(RPAREN), FF $(LPAREN)formfeed, U+000C, "\f"$(RPAREN),
 * CR $(LPAREN)carriage return, U+000D, "\r"$(RPAREN), NEL $(LPAREN)next line, U+0085$(RPAREN), LS $(LPAREN)line
 * separator, U+2028$(RPAREN), or PS $(LPAREN)paragraph separator, U+2029$(RPAREN).
 * The behaviour of the dot, circumflex, and dollar metacharacters are
 * affected by newline characters, the default is to recognize any newline
 * character $(LPAREN)the same characters recognized by "\R"$(RPAREN). This can be changed
 * with `G_REGEX_NEWLINE_CR`, `G_REGEX_NEWLINE_LF` and `G_REGEX_NEWLINE_CRLF`
 * compile options, and with `G_REGEX_MATCH_NEWLINE_ANY`,
 * `G_REGEX_MATCH_NEWLINE_CR`, `G_REGEX_MATCH_NEWLINE_LF` and
 * `G_REGEX_MATCH_NEWLINE_CRLF` match options. These settings are also
 * relevant when compiling a pattern if `G_REGEX_EXTENDED` is set, and an
 * unescaped "#" outside a character class is encountered. This indicates
 * a comment that lasts until after the next newline.
 * Creating and manipulating the same `GRegex` structure from different
 * threads is not a problem as `GRegex` does not modify its internal
 * state between creation and destruction, on the other hand `GMatchInfo`
 * is not threadsafe.
 * The regular expressions low-level functionalities are obtained through
 * the excellent [PCRE](http://www.pcre.org/) library written by Philip Hazel.
 */
class Regex : Boxed
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
    return g_regex_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Compiles the regular expression to an internal form, and does
   * the initial setup of the #GRegex structure.
   * Params:
   *   pattern = the regular expression
   *   compileOptions = compile options for the regular expression, or 0
   *   matchOptions = match options for the regular expression, or 0
   * Returns: a #GRegex structure or %NULL if an error occurred. Call
   *   [GLib.Regex.unref] when you are done with it
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
   * Returns the number of capturing subpatterns in the pattern.
   * Returns: the number of capturing subpatterns
   */
  int getCaptureCount()
  {
    int _retval;
    _retval = g_regex_get_capture_count(cast(GRegex*)cPtr);
    return _retval;
  }

  /**
   * Returns the compile options that regex was created with.
   * Depending on the version of PCRE that is used, this may or may not
   * include flags set by option expressions such as `$(LPAREN)?i$(RPAREN)` found at the
   * top-level within the compiled pattern.
   * Returns: flags from #GRegexCompileFlags
   */
  RegexCompileFlags getCompileFlags()
  {
    GRegexCompileFlags _cretval;
    _cretval = g_regex_get_compile_flags(cast(GRegex*)cPtr);
    RegexCompileFlags _retval = cast(RegexCompileFlags)_cretval;
    return _retval;
  }

  /**
   * Checks whether the pattern contains explicit CR or LF references.
   * Returns: %TRUE if the pattern contains explicit CR or LF references
   */
  bool getHasCrOrLf()
  {
    bool _retval;
    _retval = g_regex_get_has_cr_or_lf(cast(GRegex*)cPtr);
    return _retval;
  }

  /**
   * Returns the match options that regex was created with.
   * Returns: flags from #GRegexMatchFlags
   */
  RegexMatchFlags getMatchFlags()
  {
    GRegexMatchFlags _cretval;
    _cretval = g_regex_get_match_flags(cast(GRegex*)cPtr);
    RegexMatchFlags _retval = cast(RegexMatchFlags)_cretval;
    return _retval;
  }

  /**
   * Returns the number of the highest back reference
   * in the pattern, or 0 if the pattern does not contain
   * back references.
   * Returns: the number of the highest back reference
   */
  int getMaxBackref()
  {
    int _retval;
    _retval = g_regex_get_max_backref(cast(GRegex*)cPtr);
    return _retval;
  }

  /**
   * Gets the number of characters in the longest lookbehind assertion in the
   * pattern. This information is useful when doing multi-segment matching using
   * the partial matching facilities.
   * Returns: the number of characters in the longest lookbehind assertion.
   */
  int getMaxLookbehind()
  {
    int _retval;
    _retval = g_regex_get_max_lookbehind(cast(GRegex*)cPtr);
    return _retval;
  }

  /**
   * Gets the pattern string associated with regex, i.e. a copy of
   * the string passed to [GLib.Regex.new_].
   * Returns: the pattern of regex
   */
  string getPattern()
  {
    const(char)* _cretval;
    _cretval = g_regex_get_pattern(cast(GRegex*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the number of the subexpression named name.
   * Params:
   *   name = name of the subexpression
   * Returns: The number of the subexpression or -1 if name
   *   does not exists
   */
  int getStringNumber(string name)
  {
    int _retval;
    const(char)* _name = name.toCString(false);
    _retval = g_regex_get_string_number(cast(GRegex*)cPtr, _name);
    return _retval;
  }

  /**
   * Scans for a match in string for the pattern in regex.
   * The match_options are combined with the match options specified
   * when the regex structure was created, letting you have more
   * flexibility in reusing #GRegex structures.
   * Unless %G_REGEX_RAW is specified in the options, string must be valid UTF-8.
   * A #GMatchInfo structure, used to get information on the match,
   * is stored in match_info if not %NULL. Note that if match_info
   * is not %NULL then it is created even if the function returns %FALSE,
   * i.e. you must free it regardless if regular expression actually matched.
   * To retrieve all the non-overlapping matches of the pattern in
   * string you can use [GLib.MatchInfo.next].
   * |[<!-- language\="C" -->
   * static void
   * print_uppercase_words $(LPAREN)const gchar *string$(RPAREN)
   * {
   * // Print all uppercase-only words.
   * GRegex *regex;
   * GMatchInfo *match_info;
   * regex \= g_regex_new $(LPAREN)"[A-Z]+", G_REGEX_DEFAULT, G_REGEX_MATCH_DEFAULT, NULL$(RPAREN);
   * g_regex_match $(LPAREN)regex, string, 0, &match_info$(RPAREN);
   * while $(LPAREN)g_match_info_matches $(LPAREN)match_info$(RPAREN)$(RPAREN)
   * {
   * gchar *word \= g_match_info_fetch $(LPAREN)match_info, 0$(RPAREN);
   * g_print $(LPAREN)"Found: %s\n", word$(RPAREN);
   * g_free $(LPAREN)word$(RPAREN);
   * g_match_info_next $(LPAREN)match_info, NULL$(RPAREN);
   * }
   * g_match_info_free $(LPAREN)match_info$(RPAREN);
   * g_regex_unref $(LPAREN)regex$(RPAREN);
   * }
   * ]|
   * string is not copied and is used in #GMatchInfo internally. If
   * you use any #GMatchInfo method $(LPAREN)except [GLib.MatchInfo.free]$(RPAREN) after
   * freeing or modifying string then the behaviour is undefined.
   * Params:
   *   string_ = the string to scan for matches
   *   matchOptions = match options
   *   matchInfo = pointer to location where to store
   *     the #GMatchInfo, or %NULL if you do not need it
   * Returns: %TRUE is the string matched, %FALSE otherwise
   */
  bool match(string string_, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    GMatchInfo* _matchInfo;
    _retval = g_regex_match(cast(GRegex*)cPtr, _string_, matchOptions, &_matchInfo);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * Using the standard algorithm for regular expression matching only
   * the longest match in the string is retrieved. This function uses
   * a different algorithm so it can retrieve all the possible matches.
   * For more documentation see [GLib.Regex.matchAllFull].
   * A #GMatchInfo structure, used to get information on the match, is
   * stored in match_info if not %NULL. Note that if match_info is
   * not %NULL then it is created even if the function returns %FALSE,
   * i.e. you must free it regardless if regular expression actually
   * matched.
   * string is not copied and is used in #GMatchInfo internally. If
   * you use any #GMatchInfo method $(LPAREN)except [GLib.MatchInfo.free]$(RPAREN) after
   * freeing or modifying string then the behaviour is undefined.
   * Params:
   *   string_ = the string to scan for matches
   *   matchOptions = match options
   *   matchInfo = pointer to location where to store
   *     the #GMatchInfo, or %NULL if you do not need it
   * Returns: %TRUE is the string matched, %FALSE otherwise
   */
  bool matchAll(string string_, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    GMatchInfo* _matchInfo;
    _retval = g_regex_match_all(cast(GRegex*)cPtr, _string_, matchOptions, &_matchInfo);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * Using the standard algorithm for regular expression matching only
   * the longest match in the string is retrieved, it is not possible
   * to obtain all the available matches. For instance matching
   * "<a> <b> <c>" against the pattern "<.*>"
   * you get "<a> <b> <c>".
   * This function uses a different algorithm $(LPAREN)called DFA, i.e. deterministic
   * finite automaton$(RPAREN), so it can retrieve all the possible matches, all
   * starting at the same point in the string. For instance matching
   * "<a> <b> <c>" against the pattern "<.*>;"
   * you would obtain three matches: "<a> <b> <c>",
   * "<a> <b>" and "<a>".
   * The number of matched strings is retrieved using
   * [GLib.MatchInfo.getMatchCount]. To obtain the matched strings and
   * their position you can use, respectively, [GLib.MatchInfo.fetch] and
   * [GLib.MatchInfo.fetchPos]. Note that the strings are returned in
   * reverse order of length; that is, the longest matching string is
   * given first.
   * Note that the DFA algorithm is slower than the standard one and it
   * is not able to capture substrings, so backreferences do not work.
   * Setting start_position differs from just passing over a shortened
   * string and setting %G_REGEX_MATCH_NOTBOL in the case of a pattern
   * that begins with any kind of lookbehind assertion, such as "\b".
   * Unless %G_REGEX_RAW is specified in the options, string must be valid UTF-8.
   * A #GMatchInfo structure, used to get information on the match, is
   * stored in match_info if not %NULL. Note that if match_info is
   * not %NULL then it is created even if the function returns %FALSE,
   * i.e. you must free it regardless if regular expression actually
   * matched.
   * string is not copied and is used in #GMatchInfo internally. If
   * you use any #GMatchInfo method $(LPAREN)except [GLib.MatchInfo.free]$(RPAREN) after
   * freeing or modifying string then the behaviour is undefined.
   * Params:
   *   string_ = the string to scan for matches
   *   startPosition = starting index of the string to match, in bytes
   *   matchOptions = match options
   *   matchInfo = pointer to location where to store
   *     the #GMatchInfo, or %NULL if you do not need it
   * Returns: %TRUE is the string matched, %FALSE otherwise
   */
  bool matchAllFull(string string_, int startPosition, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    ptrdiff_t _stringLen;
    if (string_)
      _stringLen = cast(ptrdiff_t)string_.length;

    auto _string_ = cast(const(char)*)string_.ptr;
    GMatchInfo* _matchInfo;
    GError *_err;
    _retval = g_regex_match_all_full(cast(GRegex*)cPtr, _string_, _stringLen, startPosition, matchOptions, &_matchInfo, &_err);
    if (_err)
      throw new RegexException(_err);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * Scans for a match in string for the pattern in regex.
   * The match_options are combined with the match options specified
   * when the regex structure was created, letting you have more
   * flexibility in reusing #GRegex structures.
   * Setting start_position differs from just passing over a shortened
   * string and setting %G_REGEX_MATCH_NOTBOL in the case of a pattern
   * that begins with any kind of lookbehind assertion, such as "\b".
   * Unless %G_REGEX_RAW is specified in the options, string must be valid UTF-8.
   * A #GMatchInfo structure, used to get information on the match, is
   * stored in match_info if not %NULL. Note that if match_info is
   * not %NULL then it is created even if the function returns %FALSE,
   * i.e. you must free it regardless if regular expression actually
   * matched.
   * string is not copied and is used in #GMatchInfo internally. If
   * you use any #GMatchInfo method $(LPAREN)except [GLib.MatchInfo.free]$(RPAREN) after
   * freeing or modifying string then the behaviour is undefined.
   * To retrieve all the non-overlapping matches of the pattern in
   * string you can use [GLib.MatchInfo.next].
   * |[<!-- language\="C" -->
   * static void
   * print_uppercase_words $(LPAREN)const gchar *string$(RPAREN)
   * {
   * // Print all uppercase-only words.
   * GRegex *regex;
   * GMatchInfo *match_info;
   * GError *error \= NULL;
   * regex \= g_regex_new $(LPAREN)"[A-Z]+", G_REGEX_DEFAULT, G_REGEX_MATCH_DEFAULT, NULL$(RPAREN);
   * g_regex_match_full $(LPAREN)regex, string, -1, 0, 0, &match_info, &error$(RPAREN);
   * while $(LPAREN)g_match_info_matches $(LPAREN)match_info$(RPAREN)$(RPAREN)
   * {
   * gchar *word \= g_match_info_fetch $(LPAREN)match_info, 0$(RPAREN);
   * g_print $(LPAREN)"Found: %s\n", word$(RPAREN);
   * g_free $(LPAREN)word$(RPAREN);
   * g_match_info_next $(LPAREN)match_info, &error$(RPAREN);
   * }
   * g_match_info_free $(LPAREN)match_info$(RPAREN);
   * g_regex_unref $(LPAREN)regex$(RPAREN);
   * if $(LPAREN)error !\= NULL$(RPAREN)
   * {
   * g_printerr $(LPAREN)"Error while matching: %s\n", error->message$(RPAREN);
   * g_error_free $(LPAREN)error$(RPAREN);
   * }
   * }
   * ]|
   * Params:
   *   string_ = the string to scan for matches
   *   startPosition = starting index of the string to match, in bytes
   *   matchOptions = match options
   *   matchInfo = pointer to location where to store
   *     the #GMatchInfo, or %NULL if you do not need it
   * Returns: %TRUE is the string matched, %FALSE otherwise
   */
  bool matchFull(string string_, int startPosition, RegexMatchFlags matchOptions, out MatchInfo matchInfo)
  {
    bool _retval;
    ptrdiff_t _stringLen;
    if (string_)
      _stringLen = cast(ptrdiff_t)string_.length;

    auto _string_ = cast(const(char)*)string_.ptr;
    GMatchInfo* _matchInfo;
    GError *_err;
    _retval = g_regex_match_full(cast(GRegex*)cPtr, _string_, _stringLen, startPosition, matchOptions, &_matchInfo, &_err);
    if (_err)
      throw new RegexException(_err);
    matchInfo = new MatchInfo(cast(void*)_matchInfo, true);
    return _retval;
  }

  /**
   * Replaces all occurrences of the pattern in regex with the
   * replacement text. Backreferences of the form '\number' or
   * '\g<number>' in the replacement text are interpolated by the
   * number-th captured subexpression of the match, '\g<name>' refers
   * to the captured subexpression with the given name. '\0' refers
   * to the complete match, but '\0' followed by a number is the octal
   * representation of a character. To include a literal '\' in the
   * replacement, write '\\\\'.
   * There are also escapes that changes the case of the following text:
   * - \l: Convert to lower case the next character
   * - \u: Convert to upper case the next character
   * - \L: Convert to lower case till \E
   * - \U: Convert to upper case till \E
   * - \E: End case modification
   * If you do not need to use backreferences use [GLib.Regex.replaceLiteral].
   * The replacement string must be UTF-8 encoded even if %G_REGEX_RAW was
   * passed to [GLib.Regex.new_]. If you want to use not UTF-8 encoded strings
   * you can use [GLib.Regex.replaceLiteral].
   * Setting start_position differs from just passing over a shortened
   * string and setting %G_REGEX_MATCH_NOTBOL in the case of a pattern that
   * begins with any kind of lookbehind assertion, such as "\b".
   * Params:
   *   string_ = the string to perform matches against
   *   startPosition = starting index of the string to match, in bytes
   *   replacement = text to replace each match with
   *   matchOptions = options for the match
   * Returns: a newly allocated string containing the replacements
   */
  string replace(string string_, int startPosition, string replacement, RegexMatchFlags matchOptions)
  {
    char* _cretval;
    ptrdiff_t _stringLen;
    if (string_)
      _stringLen = cast(ptrdiff_t)string_.length;

    auto _string_ = cast(const(char)*)string_.ptr;
    const(char)* _replacement = replacement.toCString(false);
    GError *_err;
    _cretval = g_regex_replace(cast(GRegex*)cPtr, _string_, _stringLen, startPosition, _replacement, matchOptions, &_err);
    if (_err)
      throw new RegexException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Replaces occurrences of the pattern in regex with the output of
   * eval for that occurrence.
   * Setting start_position differs from just passing over a shortened
   * string and setting %G_REGEX_MATCH_NOTBOL in the case of a pattern
   * that begins with any kind of lookbehind assertion, such as "\b".
   * The following example uses [GLib.Regex.replaceEval] to replace multiple
   * strings at once:
   * |[<!-- language\="C" -->
   * static gboolean
   * eval_cb $(LPAREN)const GMatchInfo *info,
   * GString          *res,
   * gpointer          data$(RPAREN)
   * {
   * gchar *match;
   * gchar *r;
   * match \= g_match_info_fetch $(LPAREN)info, 0$(RPAREN);
   * r \= g_hash_table_lookup $(LPAREN)$(LPAREN)GHashTable *$(RPAREN)data, match$(RPAREN);
   * g_string_append $(LPAREN)res, r$(RPAREN);
   * g_free $(LPAREN)match$(RPAREN);
   * return FALSE;
   * }
   * ...
   * GRegex *reg;
   * GHashTable *h;
   * gchar *res;
   * h \= g_hash_table_new $(LPAREN)g_str_hash, g_str_equal$(RPAREN);
   * g_hash_table_insert $(LPAREN)h, "1", "ONE"$(RPAREN);
   * g_hash_table_insert $(LPAREN)h, "2", "TWO"$(RPAREN);
   * g_hash_table_insert $(LPAREN)h, "3", "THREE"$(RPAREN);
   * g_hash_table_insert $(LPAREN)h, "4", "FOUR"$(RPAREN);
   * reg \= g_regex_new $(LPAREN)"1|2|3|4", G_REGEX_DEFAULT, G_REGEX_MATCH_DEFAULT, NULL$(RPAREN);
   * res \= g_regex_replace_eval $(LPAREN)reg, text, -1, 0, 0, eval_cb, h, NULL$(RPAREN);
   * g_hash_table_destroy $(LPAREN)h$(RPAREN);
   * ...
   * ]|
   * Params:
   *   string_ = string to perform matches against
   *   startPosition = starting index of the string to match, in bytes
   *   matchOptions = options for the match
   *   eval = a function to call for each match
   * Returns: a newly allocated string containing the replacements
   */
  string replaceEval(string string_, int startPosition, RegexMatchFlags matchOptions, RegexEvalCallback eval)
  {
    static RegexEvalCallback _static_eval;

    extern(C) bool _evalCallback(const(GMatchInfo)* matchInfo, GString* result, void* userData)
    {
      bool _retval = _static_eval(matchInfo ? new MatchInfo(cast(void*)matchInfo, false) : null, result ? new String(cast(void*)result, false) : null);
      return _retval;
    }

    _static_eval = eval;
    char* _cretval;
    ptrdiff_t _stringLen;
    if (string_)
      _stringLen = cast(ptrdiff_t)string_.length;

    auto _string_ = cast(const(char)*)string_.ptr;
    auto _eval = freezeDelegate(cast(void*)&eval);
    GError *_err;
    _cretval = g_regex_replace_eval(cast(GRegex*)cPtr, _string_, _stringLen, startPosition, matchOptions, &_evalCallback, _eval, &_err);
    if (_err)
      throw new RegexException(_err);
    _static_eval = null;
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Replaces all occurrences of the pattern in regex with the
   * replacement text. replacement is replaced literally, to
   * include backreferences use [GLib.Regex.replace].
   * Setting start_position differs from just passing over a
   * shortened string and setting %G_REGEX_MATCH_NOTBOL in the
   * case of a pattern that begins with any kind of lookbehind
   * assertion, such as "\b".
   * Params:
   *   string_ = the string to perform matches against
   *   startPosition = starting index of the string to match, in bytes
   *   replacement = text to replace each match with
   *   matchOptions = options for the match
   * Returns: a newly allocated string containing the replacements
   */
  string replaceLiteral(string string_, int startPosition, string replacement, RegexMatchFlags matchOptions)
  {
    char* _cretval;
    ptrdiff_t _stringLen;
    if (string_)
      _stringLen = cast(ptrdiff_t)string_.length;

    auto _string_ = cast(const(char)*)string_.ptr;
    const(char)* _replacement = replacement.toCString(false);
    GError *_err;
    _cretval = g_regex_replace_literal(cast(GRegex*)cPtr, _string_, _stringLen, startPosition, _replacement, matchOptions, &_err);
    if (_err)
      throw new RegexException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Breaks the string on the pattern, and returns an array of the tokens.
   * If the pattern contains capturing parentheses, then the text for each
   * of the substrings will also be returned. If the pattern does not match
   * anywhere in the string, then the whole string is returned as the first
   * token.
   * As a special case, the result of splitting the empty string "" is an
   * empty vector, not a vector containing a single string. The reason for
   * this special case is that being able to represent an empty vector is
   * typically more useful than consistent handling of empty elements. If
   * you do need to represent empty elements, you'll need to check for the
   * empty string before calling this function.
   * A pattern that can match empty strings splits string into separate
   * characters wherever it matches the empty string between characters.
   * For example splitting "ab c" using as a separator "\s*", you will get
   * "a", "b" and "c".
   * Params:
   *   string_ = the string to split with the pattern
   *   matchOptions = match time option flags
   * Returns: a %NULL-terminated gchar ** array. Free
   *   it using [GLib.Global.strfreev]
   */
  string[] split(string string_, RegexMatchFlags matchOptions)
  {
    char** _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_regex_split(cast(GRegex*)cPtr, _string_, matchOptions);
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
   * Breaks the string on the pattern, and returns an array of the tokens.
   * If the pattern contains capturing parentheses, then the text for each
   * of the substrings will also be returned. If the pattern does not match
   * anywhere in the string, then the whole string is returned as the first
   * token.
   * As a special case, the result of splitting the empty string "" is an
   * empty vector, not a vector containing a single string. The reason for
   * this special case is that being able to represent an empty vector is
   * typically more useful than consistent handling of empty elements. If
   * you do need to represent empty elements, you'll need to check for the
   * empty string before calling this function.
   * A pattern that can match empty strings splits string into separate
   * characters wherever it matches the empty string between characters.
   * For example splitting "ab c" using as a separator "\s*", you will get
   * "a", "b" and "c".
   * Setting start_position differs from just passing over a shortened
   * string and setting %G_REGEX_MATCH_NOTBOL in the case of a pattern
   * that begins with any kind of lookbehind assertion, such as "\b".
   * Params:
   *   string_ = the string to split with the pattern
   *   startPosition = starting index of the string to match, in bytes
   *   matchOptions = match time option flags
   *   maxTokens = the maximum number of tokens to split string into.
   *     If this is less than 1, the string is split completely
   * Returns: a %NULL-terminated gchar ** array. Free
   *   it using [GLib.Global.strfreev]
   */
  string[] splitFull(string string_, int startPosition, RegexMatchFlags matchOptions, int maxTokens)
  {
    char** _cretval;
    ptrdiff_t _stringLen;
    if (string_)
      _stringLen = cast(ptrdiff_t)string_.length;

    auto _string_ = cast(const(char)*)string_.ptr;
    GError *_err;
    _cretval = g_regex_split_full(cast(GRegex*)cPtr, _string_, _stringLen, startPosition, matchOptions, maxTokens, &_err);
    if (_err)
      throw new RegexException(_err);
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
   * Checks whether replacement is a valid replacement string
   * $(LPAREN)see [GLib.Regex.replace]$(RPAREN), i.e. that all escape sequences in
   * it are valid.
   * If has_references is not %NULL then replacement is checked
   * for pattern references. For instance, replacement text 'foo\n'
   * does not contain references and may be evaluated without information
   * about actual match, but '\0\1' $(LPAREN)whole match followed by first
   * subpattern$(RPAREN) requires valid #GMatchInfo object.
   * Params:
   *   replacement = the replacement string
   *   hasReferences = location to store information about
   *     references in replacement or %NULL
   * Returns: whether replacement is a valid replacement string
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
   * Escapes the nul characters in string to "\x00".  It can be used
   * to compile a regex with embedded nul characters.
   * For completeness, length can be -1 for a nul-terminated string.
   * In this case the output string will be of course equal to string.
   * Params:
   *   string_ = the string to escape
   *   length = the length of string
   * Returns: a newly-allocated escaped string
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
   * Escapes the special characters used for regular expressions
   * in string, for instance "a.b*c" becomes "a\.b\*c". This
   * function is useful to dynamically generate regular expressions.
   * string can contain nul characters that are replaced with "\0",
   * in this case remember to specify the correct length of string
   * in length.
   * Params:
   *   string_ = the string to escape
   *   length = the length of string, in bytes, or -1 if string is nul-terminated
   * Returns: a newly-allocated escaped string
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
   * Scans for a match in string for pattern.
   * This function is equivalent to [GLib.Regex.match] but it does not
   * require to compile the pattern with [GLib.Regex.new_], avoiding some
   * lines of code when you need just to do a match without extracting
   * substrings, capture counts, and so on.
   * If this function is to be called on the same pattern more than
   * once, it's more efficient to compile the pattern once with
   * [GLib.Regex.new_] and then use [GLib.Regex.match].
   * Params:
   *   pattern = the regular expression
   *   string_ = the string to scan for matches
   *   compileOptions = compile options for the regular expression, or 0
   *   matchOptions = match options, or 0
   * Returns: %TRUE if the string matched, %FALSE otherwise
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
   * Breaks the string on the pattern, and returns an array of
   * the tokens. If the pattern contains capturing parentheses,
   * then the text for each of the substrings will also be returned.
   * If the pattern does not match anywhere in the string, then the
   * whole string is returned as the first token.
   * This function is equivalent to [GLib.Regex.split] but it does
   * not require to compile the pattern with [GLib.Regex.new_], avoiding
   * some lines of code when you need just to do a split without
   * extracting substrings, capture counts, and so on.
   * If this function is to be called on the same pattern more than
   * once, it's more efficient to compile the pattern once with
   * [GLib.Regex.new_] and then use [GLib.Regex.split].
   * As a special case, the result of splitting the empty string ""
   * is an empty vector, not a vector containing a single string.
   * The reason for this special case is that being able to represent
   * an empty vector is typically more useful than consistent handling
   * of empty elements. If you do need to represent empty elements,
   * you'll need to check for the empty string before calling this
   * function.
   * A pattern that can match empty strings splits string into
   * separate characters wherever it matches the empty string between
   * characters. For example splitting "ab c" using as a separator
   * "\s*", you will get "a", "b" and "c".
   * Params:
   *   pattern = the regular expression
   *   string_ = the string to scan for matches
   *   compileOptions = compile options for the regular expression, or 0
   *   matchOptions = match options, or 0
   * Returns: a %NULL-terminated array of strings. Free
   *   it using [GLib.Global.strfreev]
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
      for (; _cretval[_cretlength] !is null; _cretlength++)
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

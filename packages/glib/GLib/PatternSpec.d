module GLib.PatternSpec;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GPatternSpec` struct is the 'compiled' form of a glob-style pattern.
 * The func@GLib.pattern_match_simple and [GLib.PatternSpec.match] functions
 * match a string against a pattern containing '*' and '?' wildcards with similar
 * semantics as the standard `glob$(LPAREN)$(RPAREN)` function: '*' matches an arbitrary,
 * possibly empty, string, '?' matches an arbitrary character.
 * Note that in contrast to `glob$(LPAREN)$(RPAREN)`, the '/' character can be matched by
 * the wildcards, there are no '[...]' character ranges and '*' and '?'
 * can not be escaped to include them literally in a pattern.
 * When multiple strings must be matched against the same pattern, it is better
 * to compile the pattern to a [GLib.PatternSpec] using
 * [GLib.PatternSpec.new_] and use [GLib.PatternSpec.matchString]
 * instead of func@GLib.pattern_match_simple. This avoids the overhead of repeated
 * pattern compilation.
 */
class PatternSpec : Boxed
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
    return g_pattern_spec_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Compiles a pattern to a #GPatternSpec.
   * Params:
   *   pattern = a zero-terminated UTF-8 encoded string
   * Returns: a newly-allocated #GPatternSpec
   */
  this(string pattern)
  {
    GPatternSpec* _cretval;
    const(char)* _pattern = pattern.toCString(false);
    _cretval = g_pattern_spec_new(_pattern);
    this(_cretval, true);
  }

  /**
   * Copies pspec in a new #GPatternSpec.
   * Returns: a copy of pspec.
   */
  PatternSpec copy()
  {
    GPatternSpec* _cretval;
    _cretval = g_pattern_spec_copy(cast(GPatternSpec*)cPtr);
    auto _retval = _cretval ? new PatternSpec(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Compares two compiled pattern specs and returns whether they will
   * match the same set of strings.
   * Params:
   *   pspec2 = another #GPatternSpec
   * Returns: Whether the compiled patterns are equal
   */
  bool equal(PatternSpec pspec2)
  {
    bool _retval;
    _retval = g_pattern_spec_equal(cast(GPatternSpec*)cPtr, pspec2 ? cast(GPatternSpec*)pspec2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Matches a string against a compiled pattern. Passing the correct
   * length of the string given is mandatory. The reversed string can be
   * omitted by passing %NULL, this is more efficient if the reversed
   * version of the string to be matched is not at hand, as
   * [GLib.Global.patternMatch] will only construct it if the compiled pattern
   * requires reverse matches.
   * Note that, if the user code will $(LPAREN)possibly$(RPAREN) match a string against a
   * multitude of patterns containing wildcards, chances are high that
   * some patterns will require a reversed string. In this case, it's
   * more efficient to provide the reversed string to avoid multiple
   * constructions thereof in the various calls to [GLib.Global.patternMatch].
   * Note also that the reverse of a UTF-8 encoded string can in general
   * not be obtained by [GLib.Global.strreverse]. This works only if the string
   * does not contain any multibyte characters. GLib offers the
   * [GLib.Global.utf8Strreverse] function to reverse UTF-8 encoded strings.
   * Params:
   *   stringLength = the length of string $(LPAREN)in bytes, i.e. strlen$(LPAREN)$(RPAREN),
   *     not [GLib.Global.utf8Strlen]$(RPAREN)
   *   string_ = the UTF-8 encoded string to match
   *   stringReversed = the reverse of string or %NULL
   * Returns: %TRUE if string matches pspec
   */
  bool match(size_t stringLength, string string_, string stringReversed)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    const(char)* _stringReversed = stringReversed.toCString(false);
    _retval = g_pattern_spec_match(cast(GPatternSpec*)cPtr, stringLength, _string_, _stringReversed);
    return _retval;
  }

  /**
   * Matches a string against a compiled pattern. If the string is to be
   * matched against more than one pattern, consider using
   * [GLib.Global.patternMatch] instead while supplying the reversed string.
   * Params:
   *   string_ = the UTF-8 encoded string to match
   * Returns: %TRUE if string matches pspec
   */
  bool matchString(string string_)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    _retval = g_pattern_spec_match_string(cast(GPatternSpec*)cPtr, _string_);
    return _retval;
  }
}

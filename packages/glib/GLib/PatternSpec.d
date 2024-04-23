module GLib.PatternSpec;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A GPatternSpec struct is the 'compiled' form of a pattern. This
 * structure is opaque and its fields cannot be accessed directly.
 */
class PatternSpec : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GPatternSpec))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_pattern_spec_get_type();
  }

  /**
   * a newly-allocated #GPatternSpec
   */
  this(string pattern)
  {
    GPatternSpec* _cretval;
    const(char)* _pattern = pattern.toCString(false);
    _cretval = g_pattern_spec_new(_pattern);
    this(_cretval, true);
  }

  /**
   * a copy of @pspec.
   */
  PatternSpec copy()
  {
    GPatternSpec* _cretval;
    _cretval = g_pattern_spec_copy(cPtr!GPatternSpec);
    PatternSpec _retval = new PatternSpec(cast(GPatternSpec*)_cretval, true);
    return _retval;
  }

  /**
   * Whether the compiled patterns are equal
   */
  bool equal(PatternSpec pspec2)
  {
    bool _retval;
    _retval = g_pattern_spec_equal(cPtr!GPatternSpec, pspec2 ? pspec2.cPtr!GPatternSpec : null);
    return _retval;
  }

  /**
   * %TRUE if @string matches @pspec
   */
  bool match(size_t stringLength, string string_, string stringReversed)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    const(char)* _stringReversed = stringReversed.toCString(false);
    _retval = g_pattern_spec_match(cPtr!GPatternSpec, stringLength, _string_, _stringReversed);
    return _retval;
  }

  /**
   * %TRUE if @string matches @pspec
   */
  bool matchString(string string_)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    _retval = g_pattern_spec_match_string(cPtr!GPatternSpec, _string_);
    return _retval;
  }
}

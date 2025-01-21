module Pango.PgLanguage;

import GLib.Boxed;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoLanguage` structure is used to
 * represent a language.
 * `PangoLanguage` pointers can be efficiently
 * copied and compared with each other.
 */
class PgLanguage : Boxed
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
    return pango_language_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Get a string that is representative of the characters needed to
   * render a particular language.
   * The sample text may be a pangram, but is not necessarily. It is chosen
   * to be demonstrative of normal text in the language, as well as exposing
   * font feature requirements unique to the language. It is suitable for use
   * as sample text in a font selection dialog.
   * If language is %NULL, the default language as found by
   * [Pango.PgLanguage.getDefault] is used.
   * If Pango does not have a sample string for language, the classic
   * "The quick brown fox..." is returned.  This can be detected by
   * comparing the returned pointer value to that returned for $(LPAREN)non-existent$(RPAREN)
   * language code "xx".  That is, compare to:
   * ```
   * pango_language_get_sample_string $(LPAREN)pango_language_from_string $(LPAREN)"xx"$(RPAREN)$(RPAREN)
   * ```
   * Returns: the sample string
   */
  string getSampleString()
  {
    const(char)* _cretval;
    _cretval = pango_language_get_sample_string(cast(PangoLanguage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Determines the scripts used to to write language.
   * If nothing is known about the language tag language,
   * or if language is %NULL, then %NULL is returned.
   * The list of scripts returned starts with the script that the
   * language uses most and continues to the one it uses least.
   * The value num_script points at will be set to the number
   * of scripts in the returned array $(LPAREN)or zero if %NULL is returned$(RPAREN).
   * Most languages use only one script for writing, but there are
   * some that use two $(LPAREN)Latin and Cyrillic for example$(RPAREN), and a few
   * use three $(LPAREN)Japanese for example$(RPAREN). Applications should not make
   * any assumptions on the maximum number of scripts returned
   * though, except that it is positive if the return value is not
   * %NULL, and it is a small number.
   * The [Pango.PgLanguage.includesScript] function uses this
   * function internally.
   * Note: while the return value is declared as `PangoScript`, the
   * returned values are from the `GUnicodeScript` enumeration, which
   * may have more values. Callers need to handle unknown values.
   * Returns: An array of `PangoScript` values, with the number of entries in
   *   the array stored in num_scripts, or %NULL if Pango does not have
   *   any information about this particular language tag $(LPAREN)also the case
   *   if language is %NULL$(RPAREN).
   */
  Script[] getScripts()
  {
    const(PangoScript)* _cretval;
    int _cretlength;
    _cretval = pango_language_get_scripts(cast(PangoLanguage*)cPtr, &_cretlength);
    Script[] _retval;

    if (_cretval)
    {
      _retval = cast(Script[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Determines if script is one of the scripts used to
   * write language.
   * The returned value is conservative; if nothing is known about
   * the language tag language, %TRUE will be returned, since, as
   * far as Pango knows, script might be used to write language.
   * This routine is used in Pango's itemization process when
   * determining if a supplied language tag is relevant to
   * a particular section of text. It probably is not useful
   * for applications in most circumstances.
   * This function uses [Pango.PgLanguage.getScripts] internally.
   * Params:
   *   script = a `PangoScript`
   * Returns: %TRUE if script is one of the scripts used
   *   to write language or if nothing is known about language
   *   $(LPAREN)including the case that language is %NULL$(RPAREN), %FALSE otherwise.
   */
  bool includesScript(Script script)
  {
    bool _retval;
    _retval = pango_language_includes_script(cast(PangoLanguage*)cPtr, script);
    return _retval;
  }

  /**
   * Checks if a language tag matches one of the elements in a list of
   * language ranges.
   * A language tag is considered to match a range in the list if the
   * range is '*', the range is exactly the tag, or the range is a prefix
   * of the tag, and the character after it in the tag is '-'.
   * Params:
   *   rangeList = a list of language ranges, separated by ';', ':',
   *     ',', or space characters.
   *     Each element must either be '*', or a RFC 3066 language range
   *     canonicalized as by [Pango.PgLanguage.fromString]
   * Returns: %TRUE if a match was found
   */
  bool matches(string rangeList)
  {
    bool _retval;
    const(char)* _rangeList = rangeList.toCString(false);
    _retval = pango_language_matches(cast(PangoLanguage*)cPtr, _rangeList);
    return _retval;
  }

  /**
   * Gets the RFC-3066 format string representing the given language tag.
   * Returns $(LPAREN)transfer none$(RPAREN): a string representing the language tag
   * Returns:
   */
  string toString_()
  {
    const(char)* _cretval;
    _cretval = pango_language_to_string(cast(PangoLanguage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Convert a language tag to a `PangoLanguage`.
   * The language tag must be in a RFC-3066 format. `PangoLanguage` pointers
   * can be efficiently copied $(LPAREN)copy the pointer$(RPAREN) and compared with other
   * language tags $(LPAREN)compare the pointer.$(RPAREN)
   * This function first canonicalizes the string by converting it to
   * lowercase, mapping '_' to '-', and stripping all characters other
   * than letters and '-'.
   * Use [Pango.PgLanguage.getDefault] if you want to get the
   * `PangoLanguage` for the current locale of the process.
   * Params:
   *   language = a string representing a language tag
   * Returns: a `PangoLanguage`
   */
  static PgLanguage fromString(string language)
  {
    PangoLanguage* _cretval;
    const(char)* _language = language.toCString(false);
    _cretval = pango_language_from_string(_language);
    auto _retval = _cretval ? new PgLanguage(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `PangoLanguage` for the current locale of the process.
   * On Unix systems, this is the return value is derived from
   * `setlocale $(LPAREN)LC_CTYPE, NULL$(RPAREN)`, and the user can
   * affect this through the environment variables LC_ALL, LC_CTYPE or
   * LANG $(LPAREN)checked in that order$(RPAREN). The locale string typically is in
   * the form lang_COUNTRY, where lang is an ISO-639 language code, and
   * COUNTRY is an ISO-3166 country code. For instance, sv_FI for
   * Swedish as written in Finland or pt_BR for Portuguese as written in
   * Brazil.
   * On Windows, the C library does not use any such environment
   * variables, and setting them won't affect the behavior of functions
   * like ctime$(LPAREN)$(RPAREN). The user sets the locale through the Regional Options
   * in the Control Panel. The C library $(LPAREN)in the setlocale$(LPAREN)$(RPAREN) function$(RPAREN)
   * does not use country and language codes, but country and language
   * names spelled out in English.
   * However, this function does check the above environment
   * variables, and does return a Unix-style locale string based on
   * either said environment variables or the thread's current locale.
   * Your application should call `setlocale$(LPAREN)LC_ALL, ""$(RPAREN)` for the user
   * settings to take effect. GTK does this in its initialization
   * functions automatically $(LPAREN)by calling gtk_set_locale$(LPAREN)$(RPAREN)$(RPAREN).
   * See the setlocale$(LPAREN)$(RPAREN) manpage for more details.
   * Note that the default language can change over the life of an application.
   * Also note that this function will not do the right thing if you
   * use per-thread locales with uselocale$(LPAREN)$(RPAREN). In that case, you should
   * just call [Pango.PgLanguage.fromString] yourself.
   * Returns: the default language as a `PangoLanguage`
   */
  static PgLanguage getDefault()
  {
    PangoLanguage* _cretval;
    _cretval = pango_language_get_default();
    auto _retval = _cretval ? new PgLanguage(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the list of languages that the user prefers.
   * The list is specified by the `PANGO_LANGUAGE` or `LANGUAGE`
   * environment variables, in order of preference. Note that this
   * list does not necessarily include the language returned by
   * [Pango.PgLanguage.getDefault].
   * When choosing language-specific resources, such as the sample
   * text returned by [Pango.PgLanguage.getSampleString],
   * you should first try the default language, followed by the
   * languages returned by this function.
   * Returns: a %NULL-terminated array
   *   of `PangoLanguage`*
   */
  static PgLanguage[] getPreferred()
  {
    PangoLanguage** _cretval;
    _cretval = pango_language_get_preferred();
    PgLanguage[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new PgLanguage[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new PgLanguage(cast(void*)_cretval[i], false);
    }
    return _retval;
  }
}

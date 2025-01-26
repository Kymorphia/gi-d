module GLib.KeyFile;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GKeyFile` parses .ini-like config files.
 * `GKeyFile` lets you parse, edit or create files containing groups of
 * key-value pairs, which we call "key files" for lack of a better name.
 * Several freedesktop.org specifications use key files now, e.g the
 * [Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec)
 * and the [Icon Theme Specification](http://freedesktop.org/Standards/icon-theme-spec).
 * The syntax of key files is described in detail in the
 * [Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec),
 * here is a quick summary: Key files consists of groups of key-value pairs, interspersed
 * with comments.
 * ```txt
 * # this is just an example
 * # there can be comments before the first group
 * [First Group]
 * Name\=Key File Example\tthis value shows\nescaping
 * # localized strings are stored in multiple key-value pairs
 * Welcome\=Hello
 * Welcome[de]\=Hallo
 * Welcome[fr_FR]\=Bonjour
 * Welcome[it]\=Ciao
 * [Another Group]
 * Numbers\=2;20;-200;0
 * Booleans\=true;false;true;true
 * ```
 * Lines beginning with a '#' and blank lines are considered comments.
 * Groups are started by a header line containing the group name enclosed
 * in '[' and ']', and ended implicitly by the start of the next group or
 * the end of the file. Each key-value pair must be contained in a group.
 * Key-value pairs generally have the form `key\=value`, with the exception
 * of localized strings, which have the form `key[locale]\=value`, with a
 * locale identifier of the form `lang_COUNTRY@MODIFIER` where `COUNTRY`
 * and `MODIFIER` are optional. Space before and after the '\=' character
 * are ignored. Newline, tab, carriage return and backslash characters in
 * value are escaped as `\n`, `\t`, `\r`, and `\\\\`, respectively. To preserve
 * leading spaces in values, these can also be escaped as `\s`.
 * Key files can store strings $(LPAREN)possibly with localized variants$(RPAREN), integers,
 * booleans and lists of these. Lists are separated by a separator character,
 * typically ';' or ','. To use the list separator character in a value in
 * a list, it has to be escaped by prefixing it with a backslash.
 * This syntax is obviously inspired by the .ini files commonly met
 * on Windows, but there are some important differences:
 * - .ini files use the ';' character to begin comments,
 * key files use the '#' character.
 * - Key files do not allow for ungrouped keys meaning only
 * comments can precede the first group.
 * - Key files are always encoded in UTF-8.
 * - Key and Group names are case-sensitive. For example, a group called
 * [GROUP] is a different from [group].
 * - .ini files don't have a strongly typed boolean entry type,
 * they only have GetProfileInt$(LPAREN)$(RPAREN). In key files, only
 * true and false $(LPAREN)in lower case$(RPAREN) are allowed.
 * Note that in contrast to the
 * [Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec),
 * groups in key files may contain the same key multiple times; the last entry wins.
 * Key files may also contain multiple groups with the same name; they are merged
 * together. Another difference is that keys and group names in key files are not
 * restricted to ASCII characters.
 * Here is an example of loading a key file and reading a value:
 * ```c
 * g_autoptr$(LPAREN)GError$(RPAREN) error \= NULL;
 * g_autoptr$(LPAREN)GKeyFile$(RPAREN) key_file \= g_key_file_new $(LPAREN)$(RPAREN);
 * if $(LPAREN)!g_key_file_load_from_file $(LPAREN)key_file, "key-file.ini", flags, &error$(RPAREN)$(RPAREN)
 * {
 * if $(LPAREN)!g_error_matches $(LPAREN)error, G_FILE_ERROR, G_FILE_ERROR_NOENT$(RPAREN)$(RPAREN)
 * g_warning $(LPAREN)"Error loading key file: %s", error->message$(RPAREN);
 * return;
 * }
 * g_autofree gchar *val \= g_key_file_get_string $(LPAREN)key_file, "Group Name", "SomeKey", &error$(RPAREN);
 * if $(LPAREN)val \=\= NULL &&
 * !g_error_matches $(LPAREN)error, G_KEY_FILE_ERROR, G_KEY_FILE_ERROR_KEY_NOT_FOUND$(RPAREN)$(RPAREN)
 * {
 * g_warning $(LPAREN)"Error finding key in key file: %s", error->message$(RPAREN);
 * return;
 * }
 * else if $(LPAREN)val \=\= NULL$(RPAREN)
 * {
 * // Fall back to a default value.
 * val \= g_strdup $(LPAREN)"default-value"$(RPAREN);
 * }
 * ```
 * Here is an example of creating and saving a key file:
 * ```c
 * g_autoptr$(LPAREN)GKeyFile$(RPAREN) key_file \= g_key_file_new $(LPAREN)$(RPAREN);
 * const gchar *val \= …;
 * g_autoptr$(LPAREN)GError$(RPAREN) error \= NULL;
 * g_key_file_set_string $(LPAREN)key_file, "Group Name", "SomeKey", val$(RPAREN);
 * // Save as a file.
 * if $(LPAREN)!g_key_file_save_to_file $(LPAREN)key_file, "key-file.ini", &error$(RPAREN)$(RPAREN)
 * {
 * g_warning $(LPAREN)"Error saving key file: %s", error->message$(RPAREN);
 * return;
 * }
 * // Or store to a GBytes for use elsewhere.
 * gsize data_len;
 * g_autofree guint8 *data \= $(LPAREN)guint8 *$(RPAREN) g_key_file_to_data $(LPAREN)key_file, &data_len, &error$(RPAREN);
 * if $(LPAREN)data \=\= NULL$(RPAREN)
 * {
 * g_warning $(LPAREN)"Error saving key file: %s", error->message$(RPAREN);
 * return;
 * }
 * g_autoptr$(LPAREN)GBytes$(RPAREN) bytes \= g_bytes_new_take $(LPAREN)g_steal_pointer $(LPAREN)&data$(RPAREN), data_len$(RPAREN);
 * ```
 */
class KeyFile : Boxed
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
    return g_key_file_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty #GKeyFile object. Use
   * [GLib.KeyFile.loadFromFile], [GLib.KeyFile.loadFromData],
   * [GLib.KeyFile.loadFromDirs] or [GLib.KeyFile.loadFromDataDirs] to
   * read an existing key file.
   * Returns: an empty #GKeyFile.
   */
  this()
  {
    GKeyFile* _cretval;
    _cretval = g_key_file_new();
    this(_cretval, true);
  }

  /**
   * Returns the value associated with key under group_name as a
   * boolean.
   * If key cannot be found then %FALSE is returned and error is set
   * to %G_KEY_FILE_ERROR_KEY_NOT_FOUND. Likewise, if the value
   * associated with key cannot be interpreted as a boolean then %FALSE
   * is returned and error is set to %G_KEY_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: the value associated with the key as a boolean,
   *   or %FALSE if the key was not found or could not be parsed.
   */
  bool getBoolean(string groupName, string key)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_boolean(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Returns the values associated with key under group_name as
   * booleans.
   * If key cannot be found then %NULL is returned and error is set to
   * %G_KEY_FILE_ERROR_KEY_NOT_FOUND. Likewise, if the values associated
   * with key cannot be interpreted as booleans then %NULL is returned
   * and error is set to %G_KEY_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: the values associated with the key as a list of booleans, or %NULL if the
   *   key was not found or could not be parsed. The returned list of booleans
   *   should be freed with [GLib.Global.gfree] when no longer needed.
   */
  bool[] getBooleanList(string groupName, string key)
  {
    bool* _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_boolean_list(cast(GKeyFile*)cPtr, _groupName, _key, &_cretlength, &_err);
    if (_err)
      throw new KeyFileException(_err);
    bool[] _retval;

    if (_cretval)
    {
      _retval = cast(bool[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Retrieves a comment above key from group_name.
   * If key is %NULL then comment will be read from above
   * group_name. If both key and group_name are %NULL, then
   * comment will be read from above the first group in the file.
   * Note that the returned string does not include the '#' comment markers,
   * but does include any whitespace after them $(LPAREN)on each line$(RPAREN). It includes
   * the line breaks between lines, but does not include the final line break.
   * Params:
   *   groupName = a group name, or %NULL
   *   key = a key
   * Returns: a comment that should be freed with [GLib.Global.gfree]
   */
  string getComment(string groupName, string key)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_comment(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the value associated with key under group_name as a
   * double. If group_name is %NULL, the start_group is used.
   * If key cannot be found then 0.0 is returned and error is set to
   * %G_KEY_FILE_ERROR_KEY_NOT_FOUND. Likewise, if the value associated
   * with key cannot be interpreted as a double then 0.0 is returned
   * and error is set to %G_KEY_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: the value associated with the key as a double, or
   *   0.0 if the key was not found or could not be parsed.
   */
  double getDouble(string groupName, string key)
  {
    double _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_double(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Returns the values associated with key under group_name as
   * doubles.
   * If key cannot be found then %NULL is returned and error is set to
   * %G_KEY_FILE_ERROR_KEY_NOT_FOUND. Likewise, if the values associated
   * with key cannot be interpreted as doubles then %NULL is returned
   * and error is set to %G_KEY_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: the values associated with the key as a list of doubles, or %NULL if the
   *   key was not found or could not be parsed. The returned list of doubles
   *   should be freed with [GLib.Global.gfree] when no longer needed.
   */
  double[] getDoubleList(string groupName, string key)
  {
    double* _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_double_list(cast(GKeyFile*)cPtr, _groupName, _key, &_cretlength, &_err);
    if (_err)
      throw new KeyFileException(_err);
    double[] _retval;

    if (_cretval)
    {
      _retval = cast(double[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Returns all groups in the key file loaded with key_file.
   * The array of returned groups will be %NULL-terminated, so
   * length may optionally be %NULL.
   * Params:
   *   length = return location for the number of returned groups, or %NULL
   * Returns: a newly-allocated %NULL-terminated array of strings.
   *   Use [GLib.Global.strfreev] to free it.
   */
  string[] getGroups(out size_t length)
  {
    char** _cretval;
    _cretval = g_key_file_get_groups(cast(GKeyFile*)cPtr, cast(size_t*)&length);
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
   * Returns the value associated with key under group_name as a signed
   * 64-bit integer. This is similar to [GLib.KeyFile.getInteger] but can return
   * 64-bit results without truncation.
   * Params:
   *   groupName = a non-%NULL group name
   *   key = a non-%NULL key
   * Returns: the value associated with the key as a signed 64-bit integer, or
   *   0 if the key was not found or could not be parsed.
   */
  long getInt64(string groupName, string key)
  {
    long _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_int64(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Returns the value associated with key under group_name as an
   * integer.
   * If key cannot be found then 0 is returned and error is set to
   * %G_KEY_FILE_ERROR_KEY_NOT_FOUND. Likewise, if the value associated
   * with key cannot be interpreted as an integer, or is out of range
   * for a #gint, then 0 is returned
   * and error is set to %G_KEY_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: the value associated with the key as an integer, or
   *   0 if the key was not found or could not be parsed.
   */
  int getInteger(string groupName, string key)
  {
    int _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_integer(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Returns the values associated with key under group_name as
   * integers.
   * If key cannot be found then %NULL is returned and error is set to
   * %G_KEY_FILE_ERROR_KEY_NOT_FOUND. Likewise, if the values associated
   * with key cannot be interpreted as integers, or are out of range for
   * #gint, then %NULL is returned
   * and error is set to %G_KEY_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: the values associated with the key as a list of integers, or %NULL if
   *   the key was not found or could not be parsed. The returned list of
   *   integers should be freed with [GLib.Global.gfree] when no longer needed.
   */
  int[] getIntegerList(string groupName, string key)
  {
    int* _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_integer_list(cast(GKeyFile*)cPtr, _groupName, _key, &_cretlength, &_err);
    if (_err)
      throw new KeyFileException(_err);
    int[] _retval;

    if (_cretval)
    {
      _retval = cast(int[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Returns all keys for the group name group_name.  The array of
   * returned keys will be %NULL-terminated, so length may
   * optionally be %NULL. In the event that the group_name cannot
   * be found, %NULL is returned and error is set to
   * %G_KEY_FILE_ERROR_GROUP_NOT_FOUND.
   * Params:
   *   groupName = a group name
   *   length = return location for the number of keys returned, or %NULL
   * Returns: a newly-allocated %NULL-terminated array of strings.
   *   Use [GLib.Global.strfreev] to free it.
   */
  string[] getKeys(string groupName, out size_t length)
  {
    char** _cretval;
    const(char)* _groupName = groupName.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_keys(cast(GKeyFile*)cPtr, _groupName, cast(size_t*)&length, &_err);
    if (_err)
      throw new KeyFileException(_err);
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
   * Returns the actual locale which the result of
   * [GLib.KeyFile.getLocaleString] or [GLib.KeyFile.getLocaleStringList]
   * came from.
   * If calling [GLib.KeyFile.getLocaleString] or
   * [GLib.KeyFile.getLocaleStringList] with exactly the same key_file,
   * group_name, key and locale, the result of those functions will
   * have originally been tagged with the locale that is the result of
   * this function.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   locale = a locale identifier or %NULL
   * Returns: the locale from the file, or %NULL if the key was not
   *   found or the entry in the file was was untranslated
   */
  string getLocaleForKey(string groupName, string key, string locale)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    _cretval = g_key_file_get_locale_for_key(cast(GKeyFile*)cPtr, _groupName, _key, _locale);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the value associated with key under group_name
   * translated in the given locale if available.  If locale is
   * %NULL then the current locale is assumed.
   * If locale is to be non-%NULL, or if the current locale will change over
   * the lifetime of the #GKeyFile, it must be loaded with
   * %G_KEY_FILE_KEEP_TRANSLATIONS in order to load strings for all locales.
   * If key cannot be found then %NULL is returned and error is set
   * to %G_KEY_FILE_ERROR_KEY_NOT_FOUND. If the value associated
   * with key cannot be interpreted or no suitable translation can
   * be found then the untranslated value is returned.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   locale = a locale identifier or %NULL
   * Returns: a newly allocated string or %NULL if the specified
   *   key cannot be found.
   */
  string getLocaleString(string groupName, string key, string locale)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_locale_string(cast(GKeyFile*)cPtr, _groupName, _key, _locale, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the values associated with key under group_name
   * translated in the given locale if available.  If locale is
   * %NULL then the current locale is assumed.
   * If locale is to be non-%NULL, or if the current locale will change over
   * the lifetime of the #GKeyFile, it must be loaded with
   * %G_KEY_FILE_KEEP_TRANSLATIONS in order to load strings for all locales.
   * If key cannot be found then %NULL is returned and error is set
   * to %G_KEY_FILE_ERROR_KEY_NOT_FOUND. If the values associated
   * with key cannot be interpreted or no suitable translations
   * can be found then the untranslated values are returned. The
   * returned array is %NULL-terminated, so length may optionally
   * be %NULL.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   locale = a locale identifier or %NULL
   * Returns: a newly allocated %NULL-terminated string array
   *   or %NULL if the key isn't found. The string array should be freed
   *   with [GLib.Global.strfreev].
   */
  string[] getLocaleStringList(string groupName, string key, string locale)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_locale_string_list(cast(GKeyFile*)cPtr, _groupName, _key, _locale, &_cretlength, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Returns the name of the start group of the file.
   * Returns: The start group of the key file.
   */
  string getStartGroup()
  {
    char* _cretval;
    _cretval = g_key_file_get_start_group(cast(GKeyFile*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the string value associated with key under group_name.
   * Unlike [GLib.KeyFile.getValue], this function handles escape sequences
   * like \s.
   * In the event the key cannot be found, %NULL is returned and
   * error is set to %G_KEY_FILE_ERROR_KEY_NOT_FOUND.  In the
   * event that the group_name cannot be found, %NULL is returned
   * and error is set to %G_KEY_FILE_ERROR_GROUP_NOT_FOUND.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: a newly allocated string or %NULL if the specified
   *   key cannot be found.
   */
  string getString(string groupName, string key)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_string(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns the values associated with key under group_name.
   * In the event the key cannot be found, %NULL is returned and
   * error is set to %G_KEY_FILE_ERROR_KEY_NOT_FOUND.  In the
   * event that the group_name cannot be found, %NULL is returned
   * and error is set to %G_KEY_FILE_ERROR_GROUP_NOT_FOUND.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: a %NULL-terminated string array or %NULL if the specified
   *   key cannot be found. The array should be freed with [GLib.Global.strfreev].
   */
  string[] getStringList(string groupName, string key)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_string_list(cast(GKeyFile*)cPtr, _groupName, _key, &_cretlength, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Returns the value associated with key under group_name as an unsigned
   * 64-bit integer. This is similar to [GLib.KeyFile.getInteger] but can return
   * large positive results without truncation.
   * Params:
   *   groupName = a non-%NULL group name
   *   key = a non-%NULL key
   * Returns: the value associated with the key as an unsigned 64-bit integer,
   *   or 0 if the key was not found or could not be parsed.
   */
  ulong getUint64(string groupName, string key)
  {
    ulong _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_uint64(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Returns the raw value associated with key under group_name.
   * Use [GLib.KeyFile.getString] to retrieve an unescaped UTF-8 string.
   * In the event the key cannot be found, %NULL is returned and
   * error is set to %G_KEY_FILE_ERROR_KEY_NOT_FOUND.  In the
   * event that the group_name cannot be found, %NULL is returned
   * and error is set to %G_KEY_FILE_ERROR_GROUP_NOT_FOUND.
   * Params:
   *   groupName = a group name
   *   key = a key
   * Returns: a newly allocated string or %NULL if the specified
   *   key cannot be found.
   */
  string getValue(string groupName, string key)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_value(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Looks whether the key file has the group group_name.
   * Params:
   *   groupName = a group name
   * Returns: %TRUE if group_name is a part of key_file, %FALSE
   *   otherwise.
   */
  bool hasGroup(string groupName)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    _retval = g_key_file_has_group(cast(GKeyFile*)cPtr, _groupName);
    return _retval;
  }

  /**
   * Loads a key file from memory into an empty #GKeyFile structure.
   * If the object cannot be created then %error is set to a #GKeyFileError.
   * Params:
   *   data = key file loaded in memory
   *   length = the length of data in bytes $(LPAREN)or $(LPAREN)gsize$(RPAREN)-1 if data is nul-terminated$(RPAREN)
   *   flags = flags from #GKeyFileFlags
   * Returns: %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromData(string data, size_t length, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _data = data.toCString(false);
    GError *_err;
    _retval = g_key_file_load_from_data(cast(GKeyFile*)cPtr, _data, length, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * This function looks for a key file named file in the paths
   * returned from [GLib.Global.getUserDataDir] and [GLib.Global.getSystemDataDirs],
   * loads the file into key_file and returns the file's full path in
   * full_path.  If the file could not be loaded then an %error is
   * set to either a #GFileError or #GKeyFileError.
   * Params:
   *   file = a relative path to a filename to open and parse
   *   fullPath = return location for a string containing the full path
   *     of the file, or %NULL
   *   flags = flags from #GKeyFileFlags
   * Returns: %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromDataDirs(string file, out string fullPath, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    char* _fullPath;
    GError *_err;
    _retval = g_key_file_load_from_data_dirs(cast(GKeyFile*)cPtr, _file, &_fullPath, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    fullPath = _fullPath.fromCString(true);
    return _retval;
  }

  /**
   * This function looks for a key file named file in the paths
   * specified in search_dirs, loads the file into key_file and
   * returns the file's full path in full_path.
   * If the file could not be found in any of the search_dirs,
   * %G_KEY_FILE_ERROR_NOT_FOUND is returned. If
   * the file is found but the OS returns an error when opening or reading the
   * file, a %G_FILE_ERROR is returned. If there is a problem parsing the file, a
   * %G_KEY_FILE_ERROR is returned.
   * Params:
   *   file = a relative path to a filename to open and parse
   *   searchDirs = %NULL-terminated array of directories to search
   *   fullPath = return location for a string containing the full path
   *     of the file, or %NULL
   *   flags = flags from #GKeyFileFlags
   * Returns: %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromDirs(string file, string[] searchDirs, out string fullPath, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    const(char)*[] _tmpsearchDirs;
    foreach (s; searchDirs)
      _tmpsearchDirs ~= s.toCString(false);
    _tmpsearchDirs ~= null;
    const(char*)* _searchDirs = _tmpsearchDirs.ptr;

    char* _fullPath;
    GError *_err;
    _retval = g_key_file_load_from_dirs(cast(GKeyFile*)cPtr, _file, _searchDirs, &_fullPath, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    fullPath = _fullPath.fromCString(true);
    return _retval;
  }

  /**
   * Loads a key file into an empty #GKeyFile structure.
   * If the OS returns an error when opening or reading the file, a
   * %G_FILE_ERROR is returned. If there is a problem parsing the file, a
   * %G_KEY_FILE_ERROR is returned.
   * This function will never return a %G_KEY_FILE_ERROR_NOT_FOUND error. If the
   * file is not found, %G_FILE_ERROR_NOENT is returned.
   * Params:
   *   file = the path of a filename to load, in the GLib filename encoding
   *   flags = flags from #GKeyFileFlags
   * Returns: %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromFile(string file, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    GError *_err;
    _retval = g_key_file_load_from_file(cast(GKeyFile*)cPtr, _file, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Removes a comment above key from group_name.
   * If key is %NULL then comment will be removed above group_name.
   * If both key and group_name are %NULL, then comment will
   * be removed above the first group in the file.
   * Params:
   *   groupName = a group name, or %NULL
   *   key = a key
   * Returns: %TRUE if the comment was removed, %FALSE otherwise
   */
  bool removeComment(string groupName, string key)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_remove_comment(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Removes the specified group, group_name,
   * from the key file.
   * Params:
   *   groupName = a group name
   * Returns: %TRUE if the group was removed, %FALSE otherwise
   */
  bool removeGroup(string groupName)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    GError *_err;
    _retval = g_key_file_remove_group(cast(GKeyFile*)cPtr, _groupName, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Removes key in group_name from the key file.
   * Params:
   *   groupName = a group name
   *   key = a key name to remove
   * Returns: %TRUE if the key was removed, %FALSE otherwise
   */
  bool removeKey(string groupName, string key)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_remove_key(cast(GKeyFile*)cPtr, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Writes the contents of key_file to filename using
   * [GLib.Global.fileSetContents]. If you need stricter guarantees about durability of
   * the written file than are provided by [GLib.Global.fileSetContents], use
   * [GLib.Global.fileSetContentsFull] with the return value of [GLib.KeyFile.toData].
   * This function can fail for any of the reasons that
   * [GLib.Global.fileSetContents] may fail.
   * Params:
   *   filename = the name of the file to write to
   * Returns: %TRUE if successful, else %FALSE with error set
   */
  bool saveToFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = g_key_file_save_to_file(cast(GKeyFile*)cPtr, _filename, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Associates a new boolean value with key under group_name.
   * If key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   value = %TRUE or %FALSE
   */
  void setBoolean(string groupName, string key, bool value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_boolean(cast(GKeyFile*)cPtr, _groupName, _key, value);
  }

  /**
   * Associates a list of boolean values with key under group_name.
   * If key cannot be found then it is created.
   * If group_name is %NULL, the start_group is used.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   list = an array of boolean values
   */
  void setBooleanList(string groupName, string key, bool[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    size_t _length;
    if (list)
      _length = cast(size_t)list.length;

    auto _list = cast(bool*)list.ptr;
    g_key_file_set_boolean_list(cast(GKeyFile*)cPtr, _groupName, _key, _list, _length);
  }

  /**
   * Places a comment above key from group_name.
   * If key is %NULL then comment will be written above group_name.
   * If both key and group_name  are %NULL, then comment will be
   * written above the first group in the file.
   * Note that this function prepends a '#' comment marker to
   * each line of comment.
   * Params:
   *   groupName = a group name, or %NULL
   *   key = a key
   *   comment = a comment
   * Returns: %TRUE if the comment was written, %FALSE otherwise
   */
  bool setComment(string groupName, string key, string comment)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _comment = comment.toCString(false);
    GError *_err;
    _retval = g_key_file_set_comment(cast(GKeyFile*)cPtr, _groupName, _key, _comment, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Associates a new double value with key under group_name.
   * If key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   value = a double value
   */
  void setDouble(string groupName, string key, double value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_double(cast(GKeyFile*)cPtr, _groupName, _key, value);
  }

  /**
   * Associates a list of double values with key under
   * group_name.  If key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   list = an array of double values
   */
  void setDoubleList(string groupName, string key, double[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    size_t _length;
    if (list)
      _length = cast(size_t)list.length;

    auto _list = cast(double*)list.ptr;
    g_key_file_set_double_list(cast(GKeyFile*)cPtr, _groupName, _key, _list, _length);
  }

  /**
   * Associates a new integer value with key under group_name.
   * If key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   value = an integer value
   */
  void setInt64(string groupName, string key, long value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_int64(cast(GKeyFile*)cPtr, _groupName, _key, value);
  }

  /**
   * Associates a new integer value with key under group_name.
   * If key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   value = an integer value
   */
  void setInteger(string groupName, string key, int value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_integer(cast(GKeyFile*)cPtr, _groupName, _key, value);
  }

  /**
   * Associates a list of integer values with key under group_name.
   * If key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   list = an array of integer values
   */
  void setIntegerList(string groupName, string key, int[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    size_t _length;
    if (list)
      _length = cast(size_t)list.length;

    auto _list = cast(int*)list.ptr;
    g_key_file_set_integer_list(cast(GKeyFile*)cPtr, _groupName, _key, _list, _length);
  }

  /**
   * Sets the character which is used to separate
   * values in lists. Typically ';' or ',' are used
   * as separators. The default list separator is ';'.
   * Params:
   *   separator = the separator
   */
  void setListSeparator(char separator)
  {
    g_key_file_set_list_separator(cast(GKeyFile*)cPtr, separator);
  }

  /**
   * Associates a string value for key and locale under group_name.
   * If the translation for key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   locale = a locale identifier
   *   string_ = a string
   */
  void setLocaleString(string groupName, string key, string locale, string string_)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    const(char)* _string_ = string_.toCString(false);
    g_key_file_set_locale_string(cast(GKeyFile*)cPtr, _groupName, _key, _locale, _string_);
  }

  /**
   * Associates a list of string values for key and locale under
   * group_name.  If the translation for key cannot be found then
   * it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   locale = a locale identifier
   *   list = a %NULL-terminated array of locale string values
   */
  void setLocaleStringList(string groupName, string key, string locale, string[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    size_t _length;
    if (list)
      _length = cast(size_t)list.length;

    char*[] _tmplist;
    foreach (s; list)
      _tmplist ~= s.toCString(false);
    _tmplist ~= null;
    const(char*)* _list = _tmplist.ptr;
    g_key_file_set_locale_string_list(cast(GKeyFile*)cPtr, _groupName, _key, _locale, _list, _length);
  }

  /**
   * Associates a new string value with key under group_name.
   * If key cannot be found then it is created.
   * If group_name cannot be found then it is created.
   * Unlike [GLib.KeyFile.setValue], this function handles characters
   * that need escaping, such as newlines.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   string_ = a string
   */
  void setString(string groupName, string key, string string_)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _string_ = string_.toCString(false);
    g_key_file_set_string(cast(GKeyFile*)cPtr, _groupName, _key, _string_);
  }

  /**
   * Associates a list of string values for key under group_name.
   * If key cannot be found then it is created.
   * If group_name cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   list = an array of string values
   */
  void setStringList(string groupName, string key, string[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    size_t _length;
    if (list)
      _length = cast(size_t)list.length;

    const(char)*[] _tmplist;
    foreach (s; list)
      _tmplist ~= s.toCString(false);
    _tmplist ~= null;
    const(char*)* _list = _tmplist.ptr;
    g_key_file_set_string_list(cast(GKeyFile*)cPtr, _groupName, _key, _list, _length);
  }

  /**
   * Associates a new integer value with key under group_name.
   * If key cannot be found then it is created.
   * Params:
   *   groupName = a group name
   *   key = a key
   *   value = an integer value
   */
  void setUint64(string groupName, string key, ulong value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_uint64(cast(GKeyFile*)cPtr, _groupName, _key, value);
  }

  /**
   * Associates a new value with key under group_name.
   * If key cannot be found then it is created. If group_name cannot
   * be found then it is created. To set an UTF-8 string which may contain
   * characters that need escaping $(LPAREN)such as newlines or spaces$(RPAREN), use
   * [GLib.KeyFile.setString].
   * Params:
   *   groupName = a group name
   *   key = a key
   *   value = a string
   */
  void setValue(string groupName, string key, string value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _value = value.toCString(false);
    g_key_file_set_value(cast(GKeyFile*)cPtr, _groupName, _key, _value);
  }

  /**
   * This function outputs key_file as a string.
   * Note that this function never reports an error,
   * so it is safe to pass %NULL as error.
   * Params:
   *   length = return location for the length of the
   *     returned string, or %NULL
   * Returns: a newly allocated string holding
   *   the contents of the #GKeyFile
   */
  string toData(out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_key_file_to_data(cast(GKeyFile*)cPtr, cast(size_t*)&length, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_key_file_error_quark();
    return _retval;
  }
}

class KeyFileException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(KeyFile.errorQuark, cast(int)code, msg);
  }

  alias Code = GKeyFileError;
}

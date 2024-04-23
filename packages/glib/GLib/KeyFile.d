module GLib.KeyFile;

import GLib.Boxed;
import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * #GKeyFile lets you parse, edit or create files containing groups of
 * key-value pairs, which we call "key files" for lack of a better name.
 * Several freedesktop.org specifications use key files now, e.g the
 * [Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec)
 * and the
 * [Icon Theme Specification](http://freedesktop.org/Standards/icon-theme-spec).
 *
 * The syntax of key files is described in detail in the
 * [Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec),
 * here is a quick summary: Key files
 * consists of groups of key-value pairs, interspersed with comments.
 *
 * |[
 * # this is just an example
 * # there can be comments before the first group
 *
 * [First Group]
 *
 * Name=Key File Example\tthis value shows\nescaping
 *
 * # localized strings are stored in multiple key-value pairs
 * Welcome=Hello
 * Welcome[de]=Hallo
 * Welcome[fr_FR]=Bonjour
 * Welcome[it]=Ciao
 * Welcome[be@latin]=Hello
 *
 * [Another Group]
 *
 * Numbers=2;20;-200;0
 *
 * Booleans=true;false;true;true
 * ]|
 *
 * Lines beginning with a '#' and blank lines are considered comments.
 *
 * Groups are started by a header line containing the group name enclosed
 * in '[' and ']', and ended implicitly by the start of the next group or
 * the end of the file. Each key-value pair must be contained in a group.
 *
 * Key-value pairs generally have the form `key=value`, with the
 * exception of localized strings, which have the form
 * `key[locale]=value`, with a locale identifier of the
 * form `lang_COUNTRY@MODIFIER` where `COUNTRY` and `MODIFIER`
 * are optional.
 * Space before and after the '=' character are ignored. Newline, tab,
 * carriage return and backslash characters in value are escaped as \n,
 * \t, \r, and \\\\, respectively. To preserve leading spaces in values,
 * these can also be escaped as \s.
 *
 * Key files can store strings (possibly with localized variants), integers,
 * booleans and lists of these. Lists are separated by a separator character,
 * typically ';' or ','. To use the list separator character in a value in
 * a list, it has to be escaped by prefixing it with a backslash.
 *
 * This syntax is obviously inspired by the .ini files commonly met
 * on Windows, but there are some important differences:
 *
 * - .ini files use the ';' character to begin comments,
 * key files use the '#' character.
 *
 * - Key files do not allow for ungrouped keys meaning only
 * comments can precede the first group.
 *
 * - Key files are always encoded in UTF-8.
 *
 * - Key and Group names are case-sensitive. For example, a group called
 * [GROUP] is a different from [group].
 *
 * - .ini files don't have a strongly typed boolean entry type,
 * they only have GetProfileInt(). In key files, only
 * true and false (in lower case) are allowed.
 *
 * Note that in contrast to the
 * [Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec),
 * groups in key files may contain the same
 * key multiple times; the last entry wins. Key files may also contain
 * multiple groups with the same name; they are merged together.
 * Another difference is that keys and group names in key files are not
 * restricted to ASCII characters.
 *
 * Here is an example of loading a key file and reading a value:
 *
 * |[<!-- language="C" -->
 * g_autoptr(GError) error = NULL;
 * g_autoptr(GKeyFile) key_file = g_key_file_new ();
 *
 * if (!g_key_file_load_from_file (key_file, "key-file.ini", flags, &error))
 * {
 * if (!g_error_matches (error, G_FILE_ERROR, G_FILE_ERROR_NOENT))
 * g_warning ("Error loading key file: %s", error->message);
 * return;
 * }
 *
 * g_autofree gchar *val = g_key_file_get_string (key_file, "Group Name", "SomeKey", &error);
 * if (val == NULL &&
 * !g_error_matches (error, G_KEY_FILE_ERROR, G_KEY_FILE_ERROR_KEY_NOT_FOUND))
 * {
 * g_warning ("Error finding key in key file: %s", error->message);
 * return;
 * }
 * else if (val == NULL)
 * {
 * // Fall back to a default value.
 * val = g_strdup ("default-value");
 * }
 * ]|
 *
 * Here is an example of creating and saving a key file:
 *
 * |[<!-- language="C" -->
 * g_autoptr(GKeyFile) key_file = g_key_file_new ();
 * const gchar *val = …;
 * g_autoptr(GError) error = NULL;
 *
 * g_key_file_set_string (key_file, "Group Name", "SomeKey", val);
 *
 * // Save as a file.
 * if (!g_key_file_save_to_file (key_file, "key-file.ini", &error))
 * {
 * g_warning ("Error saving key file: %s", error->message);
 * return;
 * }
 *
 * // Or store to a GBytes for use elsewhere.
 * gsize data_len;
 * g_autofree guint8 *data = (guint8 *) g_key_file_to_data (key_file, &data_len, &error);
 * if (data == NULL)
 * {
 * g_warning ("Error saving key file: %s", error->message);
 * return;
 * }
 * g_autoptr(GBytes) bytes = g_bytes_new_take (g_steal_pointer (&data), data_len);
 * ]|
 */
class KeyFile : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GKeyFile))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_key_file_get_type();
  }

  /**
   * an empty #GKeyFile.
   */
  this()
  {
    GKeyFile* _cretval;
    _cretval = g_key_file_new();
    this(_cretval, true);
  }

  /**
   * the value associated with the key as a boolean,
   * or %FALSE if the key was not found or could not be parsed.
   */
  bool getBoolean(string groupName, string key)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_boolean(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * the values associated with the key as a list of booleans, or %NULL if the
   * key was not found or could not be parsed. The returned list of booleans
   * should be freed with g_free() when no longer needed.
   */
  bool[] getBooleanList(string groupName, string key)
  {
    bool* _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_boolean_list(cPtr!GKeyFile, _groupName, _key, &_cretlength, &_err);
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
   * a comment that should be freed with g_free()
   */
  string getComment(string groupName, string key)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_comment(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the value associated with the key as a double, or
   * 0.0 if the key was not found or could not be parsed.
   */
  double getDouble(string groupName, string key)
  {
    double _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_double(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * the values associated with the key as a list of doubles, or %NULL if the
   * key was not found or could not be parsed. The returned list of doubles
   * should be freed with g_free() when no longer needed.
   */
  double[] getDoubleList(string groupName, string key)
  {
    double* _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_double_list(cPtr!GKeyFile, _groupName, _key, &_cretlength, &_err);
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
   * a newly-allocated %NULL-terminated array of strings.
   * Use g_strfreev() to free it.
   */
  string[] getGroups(out size_t length)
  {
    char** _cretval;
    _cretval = g_key_file_get_groups(cPtr!GKeyFile, cast(size_t*)&length);
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
   * the value associated with the key as a signed 64-bit integer, or
   * 0 if the key was not found or could not be parsed.
   */
  long getInt64(string groupName, string key)
  {
    long _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_int64(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * the value associated with the key as an integer, or
   * 0 if the key was not found or could not be parsed.
   */
  int getInteger(string groupName, string key)
  {
    int _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_integer(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * the values associated with the key as a list of integers, or %NULL if
   * the key was not found or could not be parsed. The returned list of
   * integers should be freed with g_free() when no longer needed.
   */
  int[] getIntegerList(string groupName, string key)
  {
    int* _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_integer_list(cPtr!GKeyFile, _groupName, _key, &_cretlength, &_err);
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
   * a newly-allocated %NULL-terminated array of strings.
   * Use g_strfreev() to free it.
   */
  string[] getKeys(string groupName, out size_t length)
  {
    char** _cretval;
    const(char)* _groupName = groupName.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_keys(cPtr!GKeyFile, _groupName, cast(size_t*)&length, &_err);
    if (_err)
      throw new KeyFileException(_err);
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
   * the locale from the file, or %NULL if the key was not
   * found or the entry in the file was was untranslated
   */
  string getLocaleForKey(string groupName, string key, string locale)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    _cretval = g_key_file_get_locale_for_key(cPtr!GKeyFile, _groupName, _key, _locale);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated string or %NULL if the specified
   * key cannot be found.
   */
  string getLocaleString(string groupName, string key, string locale)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_locale_string(cPtr!GKeyFile, _groupName, _key, _locale, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated %NULL-terminated string array
   * or %NULL if the key isn't found. The string array should be freed
   * with g_strfreev().
   */
  string[] getLocaleStringList(string groupName, string key, string locale)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_locale_string_list(cPtr!GKeyFile, _groupName, _key, _locale, &_cretlength, &_err);
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
   * The start group of the key file.
   */
  string getStartGroup()
  {
    char* _cretval;
    _cretval = g_key_file_get_start_group(cPtr!GKeyFile);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated string or %NULL if the specified
   * key cannot be found.
   */
  string getString(string groupName, string key)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_string(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a %NULL-terminated string array or %NULL if the specified
   * key cannot be found. The array should be freed with g_strfreev().
   */
  string[] getStringList(string groupName, string key)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_string_list(cPtr!GKeyFile, _groupName, _key, &_cretlength, &_err);
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
   * the value associated with the key as an unsigned 64-bit integer,
   * or 0 if the key was not found or could not be parsed.
   */
  ulong getUint64(string groupName, string key)
  {
    ulong _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_get_uint64(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * a newly allocated string or %NULL if the specified
   * key cannot be found.
   */
  string getValue(string groupName, string key)
  {
    char* _cretval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _cretval = g_key_file_get_value(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if @group_name is a part of @key_file, %FALSE
   * otherwise.
   */
  bool hasGroup(string groupName)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    _retval = g_key_file_has_group(cPtr!GKeyFile, _groupName);
    return _retval;
  }

  /**
   * %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromBytes(Bytes bytes, KeyFileFlags flags)
  {
    bool _retval;
    GError *_err;
    _retval = g_key_file_load_from_bytes(cPtr!GKeyFile, bytes ? bytes.cPtr!GBytes : null, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromData(string data, size_t length, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _data = data.toCString(false);
    GError *_err;
    _retval = g_key_file_load_from_data(cPtr!GKeyFile, _data, length, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromDataDirs(string file, out string fullPath, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    char* _fullPath;
    GError *_err;
    _retval = g_key_file_load_from_data_dirs(cPtr!GKeyFile, _file, &_fullPath, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    fullPath = _fullPath.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromDirs(string file, string[] searchDirs, out string fullPath, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    char*[] _tmpsearchDirs;
    foreach (s; searchDirs)
      _tmpsearchDirs ~= s.toCString(false);
    _tmpsearchDirs ~= null;
    const(char*)* _searchDirs = _tmpsearchDirs.ptr;

    char* _fullPath;
    GError *_err;
    _retval = g_key_file_load_from_dirs(cPtr!GKeyFile, _file, _searchDirs, &_fullPath, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    fullPath = _fullPath.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromFile(string file, KeyFileFlags flags)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    GError *_err;
    _retval = g_key_file_load_from_file(cPtr!GKeyFile, _file, flags, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if the comment was removed, %FALSE otherwise
   */
  bool removeComment(string groupName, string key)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_remove_comment(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if the group was removed, %FALSE otherwise
   */
  bool removeGroup(string groupName)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    GError *_err;
    _retval = g_key_file_remove_group(cPtr!GKeyFile, _groupName, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if the key was removed, %FALSE otherwise
   */
  bool removeKey(string groupName, string key)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    GError *_err;
    _retval = g_key_file_remove_key(cPtr!GKeyFile, _groupName, _key, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if successful, else %FALSE with @error set
   */
  bool saveToFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = g_key_file_save_to_file(cPtr!GKeyFile, _filename, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Associates a new boolean value with @key under @group_name.
   * If @key cannot be found then it is created.
   */
  void setBoolean(string groupName, string key, bool value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_boolean(cPtr!GKeyFile, _groupName, _key, value);
  }

  /**
   * Associates a list of boolean values with @key under @group_name.
   * If @key cannot be found then it is created.
   * If @group_name is %NULL, the start_group is used.
   */
  void setBooleanList(string groupName, string key, bool[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    auto _list = cast(bool*)list.ptr;
    g_key_file_set_boolean_list(cPtr!GKeyFile, _groupName, _key, _list, list ? cast(size_t)list.length : 0);
  }

  /**
   * %TRUE if the comment was written, %FALSE otherwise
   */
  bool setComment(string groupName, string key, string comment)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _comment = comment.toCString(false);
    GError *_err;
    _retval = g_key_file_set_comment(cPtr!GKeyFile, _groupName, _key, _comment, &_err);
    if (_err)
      throw new KeyFileException(_err);
    return _retval;
  }

  /**
   * Associates a new double value with @key under @group_name.
   * If @key cannot be found then it is created.
   */
  void setDouble(string groupName, string key, double value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_double(cPtr!GKeyFile, _groupName, _key, value);
  }

  /**
   * Associates a list of double values with @key under
   * @group_name.  If @key cannot be found then it is created.
   */
  void setDoubleList(string groupName, string key, double[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    auto _list = cast(double*)list.ptr;
    g_key_file_set_double_list(cPtr!GKeyFile, _groupName, _key, _list, list ? cast(size_t)list.length : 0);
  }

  /**
   * Associates a new integer value with @key under @group_name.
   * If @key cannot be found then it is created.
   */
  void setInt64(string groupName, string key, long value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_int64(cPtr!GKeyFile, _groupName, _key, value);
  }

  /**
   * Associates a new integer value with @key under @group_name.
   * If @key cannot be found then it is created.
   */
  void setInteger(string groupName, string key, int value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_integer(cPtr!GKeyFile, _groupName, _key, value);
  }

  /**
   * Associates a list of integer values with @key under @group_name.
   * If @key cannot be found then it is created.
   */
  void setIntegerList(string groupName, string key, int[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    auto _list = cast(int*)list.ptr;
    g_key_file_set_integer_list(cPtr!GKeyFile, _groupName, _key, _list, list ? cast(size_t)list.length : 0);
  }

  /**
   * Sets the character which is used to separate
   * values in lists. Typically ';' or ',' are used
   * as separators. The default list separator is ';'.
   */
  void setListSeparator(char separator)
  {
    g_key_file_set_list_separator(cPtr!GKeyFile, separator);
  }

  /**
   * Associates a string value for @key and @locale under @group_name.
   * If the translation for @key cannot be found then it is created.
   */
  void setLocaleString(string groupName, string key, string locale, string string_)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    const(char)* _string_ = string_.toCString(false);
    g_key_file_set_locale_string(cPtr!GKeyFile, _groupName, _key, _locale, _string_);
  }

  /**
   * Associates a list of string values for @key and @locale under
   * @group_name.  If the translation for @key cannot be found then
   * it is created.
   */
  void setLocaleStringList(string groupName, string key, string locale, string[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _locale = locale.toCString(false);
    char*[] _tmplist;
    foreach (s; list)
      _tmplist ~= s.toCString(false);
    _tmplist ~= null;
    const(char*)* _list = _tmplist.ptr;
    g_key_file_set_locale_string_list(cPtr!GKeyFile, _groupName, _key, _locale, _list, list ? cast(size_t)list.length : 0);
  }

  /**
   * Associates a new string value with @key under @group_name.
   * If @key cannot be found then it is created.
   * If @group_name cannot be found then it is created.
   * Unlike g_key_file_set_value(), this function handles characters
   * that need escaping, such as newlines.
   */
  void setString(string groupName, string key, string string_)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _string_ = string_.toCString(false);
    g_key_file_set_string(cPtr!GKeyFile, _groupName, _key, _string_);
  }

  /**
   * Associates a list of string values for @key under @group_name.
   * If @key cannot be found then it is created.
   * If @group_name cannot be found then it is created.
   */
  void setStringList(string groupName, string key, string[] list)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    char*[] _tmplist;
    foreach (s; list)
      _tmplist ~= s.toCString(false);
    _tmplist ~= null;
    const(char*)* _list = _tmplist.ptr;
    g_key_file_set_string_list(cPtr!GKeyFile, _groupName, _key, _list, list ? cast(size_t)list.length : 0);
  }

  /**
   * Associates a new integer value with @key under @group_name.
   * If @key cannot be found then it is created.
   */
  void setUint64(string groupName, string key, ulong value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    g_key_file_set_uint64(cPtr!GKeyFile, _groupName, _key, value);
  }

  /**
   * Associates a new value with @key under @group_name.
   *
   * If @key cannot be found then it is created. If @group_name cannot
   * be found then it is created. To set an UTF-8 string which may contain
   * characters that need escaping (such as newlines or spaces), use
   * g_key_file_set_string().
   */
  void setValue(string groupName, string key, string value)
  {
    const(char)* _groupName = groupName.toCString(false);
    const(char)* _key = key.toCString(false);
    const(char)* _value = value.toCString(false);
    g_key_file_set_value(cPtr!GKeyFile, _groupName, _key, _value);
  }

  /**
   * a newly allocated string holding
   * the contents of the #GKeyFile
   */
  string toData(out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_key_file_to_data(cPtr!GKeyFile, cast(size_t*)&length, &_err);
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

module GLib.Dir;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * An opaque structure representing an opened directory.
 */
class Dir : Boxed
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
    return g_dir_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Opens a directory for reading. The names of the files in the
   * directory can then be retrieved using [GLib.Dir.readName].  Note
   * that the ordering is not defined.
   * Params:
   *   path = the path to the directory you are interested in. On Unix
   *     in the on-disk encoding. On Windows in UTF-8
   *   flags = Currently must be set to 0. Reserved for future use.
   * Returns: a newly allocated #GDir on success, %NULL on failure.
   *   If non-%NULL, you must free the result with [GLib.Dir.close]
   *   when you are finished with it.
   */
  static Dir open(string path, uint flags)
  {
    GDir* _cretval;
    const(char)* _path = path.toCString(false);
    GError *_err;
    _cretval = g_dir_open(_path, flags, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Dir(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves the name of another entry in the directory, or %NULL.
   * The order of entries returned from this function is not defined,
   * and may vary by file system or other operating-system dependent
   * factors.
   * %NULL may also be returned in case of errors. On Unix, you can
   * check `errno` to find out if %NULL was returned because of an error.
   * On Unix, the '.' and '..' entries are omitted, and the returned
   * name is in the on-disk encoding.
   * On Windows, as is true of all GLib functions which operate on
   * filenames, the returned name is in UTF-8.
   * Returns: The entry's name or %NULL if there are no
   *   more entries. The return value is owned by GLib and
   *   must not be modified or freed.
   */
  string readName()
  {
    const(char)* _cretval;
    _cretval = g_dir_read_name(cast(GDir*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Resets the given directory. The next call to [GLib.Dir.readName]
   * will return the first entry again.
   */
  void rewind()
  {
    g_dir_rewind(cast(GDir*)cPtr);
  }

  /**
   * Creates a subdirectory in the preferred directory for temporary
   * files $(LPAREN)as returned by [GLib.Global.getTmpDir]$(RPAREN).
   * tmpl should be a string in the GLib file name encoding containing
   * a sequence of six 'X' characters, as the parameter to [GLib.Global.mkstemp].
   * However, unlike these functions, the template should only be a
   * basename, no directory components are allowed. If template is
   * %NULL, a default template is used.
   * Note that in contrast to [GLib.Global.mkdtemp] $(LPAREN)$(RPAREN)(and mkdtemp) tmpl is not
   * modified, and might thus be a read-only literal string.
   * Params:
   *   tmpl = Template for directory name,
   *     as in [GLib.Global.mkdtemp], basename only, or %NULL for a default template
   * Returns: The actual name used. This string
   *   should be freed with [GLib.Global.gfree] when not needed any longer and is
   *   is in the GLib file name encoding. In case of errors, %NULL is
   *   returned and error will be set.
   */
  static string makeTmp(string tmpl)
  {
    char* _cretval;
    const(char)* _tmpl = tmpl.toCString(false);
    GError *_err;
    _cretval = g_dir_make_tmp(_tmpl, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}

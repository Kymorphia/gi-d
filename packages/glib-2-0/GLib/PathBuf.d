module GLib.PathBuf;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GPathBuf` is a helper type that allows you to easily build paths from
 * individual elements, using the platform specific conventions for path
 * separators.
 * ```c
 * g_auto $(LPAREN)GPathBuf$(RPAREN) path;
 * g_path_buf_init $(LPAREN)&path$(RPAREN);
 * g_path_buf_push $(LPAREN)&path, "usr"$(RPAREN);
 * g_path_buf_push $(LPAREN)&path, "bin"$(RPAREN);
 * g_path_buf_push $(LPAREN)&path, "echo"$(RPAREN);
 * g_autofree char *echo \= g_path_buf_to_path $(LPAREN)&path$(RPAREN);
 * g_assert_cmpstr $(LPAREN)echo, \=\=, "/usr/bin/echo"$(RPAREN);
 * ```
 * You can also load a full path and then operate on its components:
 * ```c
 * g_auto $(LPAREN)GPathBuf$(RPAREN) path;
 * g_path_buf_init_from_path $(LPAREN)&path, "/usr/bin/echo"$(RPAREN);
 * g_path_buf_pop $(LPAREN)&path$(RPAREN);
 * g_path_buf_push $(LPAREN)&path, "sh"$(RPAREN);
 * g_autofree char *sh \= g_path_buf_to_path $(LPAREN)&path$(RPAREN);
 * g_assert_cmpstr $(LPAREN)sh, \=\=, "/usr/bin/sh"$(RPAREN);
 * ```
 */
class PathBuf
{
  GPathBuf cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.PathBuf");

    cInstance = *cast(GPathBuf*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Clears the contents of the path buffer.
   * This function should be use to free the resources in a stack-allocated
   * `GPathBuf` initialized using [GLib.PathBuf.init_] or
   * [GLib.PathBuf.initFromPath].
   */
  void clear()
  {
    g_path_buf_clear(cast(GPathBuf*)cPtr);
  }

  /**
   * Clears the contents of the path buffer and returns the built path.
   * This function returns `NULL` if the `GPathBuf` is empty.
   * See also: [GLib.PathBuf.toPath]
   * Returns: the built path
   */
  string clearToPath()
  {
    char* _cretval;
    _cretval = g_path_buf_clear_to_path(cast(GPathBuf*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Frees a `GPathBuf` allocated by [GLib.PathBuf.new_], and
   * returns the path inside the buffer.
   * This function returns `NULL` if the `GPathBuf` is empty.
   * See also: [GLib.PathBuf.toPath]
   * Returns: the path
   */
  string freeToPath()
  {
    char* _cretval;
    _cretval = g_path_buf_free_to_path(cast(GPathBuf*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Initializes a `GPathBuf` instance.
   * Returns: the initialized path builder
   */
  PathBuf init_()
  {
    GPathBuf* _cretval;
    _cretval = g_path_buf_init(cast(GPathBuf*)cPtr);
    auto _retval = _cretval ? new PathBuf(cast(GPathBuf*)_cretval) : null;
    return _retval;
  }

  /**
   * Initializes a `GPathBuf` instance with the given path.
   * Params:
   *   path = a file system path
   * Returns: the initialized path builder
   */
  PathBuf initFromPath(string path)
  {
    GPathBuf* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_path_buf_init_from_path(cast(GPathBuf*)cPtr, _path);
    auto _retval = _cretval ? new PathBuf(cast(GPathBuf*)_cretval) : null;
    return _retval;
  }

  /**
   * Removes the last element of the path buffer.
   * If there is only one element in the path buffer $(LPAREN)for example, `/` on
   * Unix-like operating systems or the drive on Windows systems$(RPAREN), it will
   * not be removed and %FALSE will be returned instead.
   * |[<!-- language\="C" -->
   * GPathBuf buf, cmp;
   * g_path_buf_init_from_path $(LPAREN)&buf, "/bin/sh"$(RPAREN);
   * g_path_buf_pop $(LPAREN)&buf$(RPAREN);
   * g_path_buf_init_from_path $(LPAREN)&cmp, "/bin"$(RPAREN);
   * g_assert_true $(LPAREN)g_path_buf_equal $(LPAREN)&buf, &cmp$(RPAREN)$(RPAREN);
   * g_path_buf_clear $(LPAREN)&cmp$(RPAREN);
   * g_path_buf_pop $(LPAREN)&buf$(RPAREN);
   * g_path_buf_init_from_path $(LPAREN)&cmp, "/"$(RPAREN);
   * g_assert_true $(LPAREN)g_path_buf_equal $(LPAREN)&buf, &cmp$(RPAREN)$(RPAREN);
   * g_path_buf_clear $(LPAREN)&cmp$(RPAREN);
   * g_path_buf_clear $(LPAREN)&buf$(RPAREN);
   * ]|
   * Returns: `TRUE` if the buffer was modified and `FALSE` otherwise
   */
  bool pop()
  {
    bool _retval;
    _retval = g_path_buf_pop(cast(GPathBuf*)cPtr);
    return _retval;
  }

  /**
   * Extends the given path buffer with path.
   * If path is absolute, it replaces the current path.
   * If path contains a directory separator, the buffer is extended by
   * as many elements the path provides.
   * On Windows, both forward slashes and backslashes are treated as
   * directory separators. On other platforms, %G_DIR_SEPARATOR_S is the
   * only directory separator.
   * |[<!-- language\="C" -->
   * GPathBuf buf, cmp;
   * g_path_buf_init_from_path $(LPAREN)&buf, "/tmp"$(RPAREN);
   * g_path_buf_push $(LPAREN)&buf, ".X11-unix/X0"$(RPAREN);
   * g_path_buf_init_from_path $(LPAREN)&cmp, "/tmp/.X11-unix/X0"$(RPAREN);
   * g_assert_true $(LPAREN)g_path_buf_equal $(LPAREN)&buf, &cmp$(RPAREN)$(RPAREN);
   * g_path_buf_clear $(LPAREN)&cmp$(RPAREN);
   * g_path_buf_push $(LPAREN)&buf, "/etc/locale.conf"$(RPAREN);
   * g_path_buf_init_from_path $(LPAREN)&cmp, "/etc/locale.conf"$(RPAREN);
   * g_assert_true $(LPAREN)g_path_buf_equal $(LPAREN)&buf, &cmp$(RPAREN)$(RPAREN);
   * g_path_buf_clear $(LPAREN)&cmp$(RPAREN);
   * g_path_buf_clear $(LPAREN)&buf$(RPAREN);
   * ]|
   * Params:
   *   path = a path
   * Returns: the same pointer to buf, for convenience
   */
  PathBuf push(string path)
  {
    GPathBuf* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_path_buf_push(cast(GPathBuf*)cPtr, _path);
    auto _retval = _cretval ? new PathBuf(cast(GPathBuf*)_cretval) : null;
    return _retval;
  }

  /**
   * Adds an extension to the file name in the path buffer.
   * If extension is `NULL`, the extension will be unset.
   * If the path buffer does not have a file name set, this function returns
   * `FALSE` and leaves the path buffer unmodified.
   * Params:
   *   extension = the file extension
   * Returns: `TRUE` if the extension was replaced, and `FALSE` otherwise
   */
  bool setExtension(string extension)
  {
    bool _retval;
    const(char)* _extension = extension.toCString(false);
    _retval = g_path_buf_set_extension(cast(GPathBuf*)cPtr, _extension);
    return _retval;
  }

  /**
   * Sets the file name of the path.
   * If the path buffer is empty, the filename is left unset and this
   * function returns `FALSE`.
   * If the path buffer only contains the root element $(LPAREN)on Unix-like operating
   * systems$(RPAREN) or the drive $(LPAREN)on Windows$(RPAREN), this is the equivalent of pushing
   * the new file_name.
   * If the path buffer contains a path, this is the equivalent of
   * popping the path buffer and pushing file_name, creating a
   * sibling of the original path.
   * |[<!-- language\="C" -->
   * GPathBuf buf, cmp;
   * g_path_buf_init_from_path $(LPAREN)&buf, "/"$(RPAREN);
   * g_path_buf_set_filename $(LPAREN)&buf, "bar"$(RPAREN);
   * g_path_buf_init_from_path $(LPAREN)&cmp, "/bar"$(RPAREN);
   * g_assert_true $(LPAREN)g_path_buf_equal $(LPAREN)&buf, &cmp$(RPAREN)$(RPAREN);
   * g_path_buf_clear $(LPAREN)&cmp$(RPAREN);
   * g_path_buf_set_filename $(LPAREN)&buf, "baz.txt"$(RPAREN);
   * g_path_buf_init_from_path $(LPAREN)&cmp, "/baz.txt"$(RPAREN);
   * g_assert_true $(LPAREN)g_path_buf_equal $(LPAREN)&buf, &cmp$(RPAREN);
   * g_path_buf_clear $(LPAREN)&cmp$(RPAREN);
   * g_path_buf_clear $(LPAREN)&buf$(RPAREN);
   * ]|
   * Params:
   *   fileName = the file name in the path
   * Returns: `TRUE` if the file name was replaced, and `FALSE` otherwise
   */
  bool setFilename(string fileName)
  {
    bool _retval;
    const(char)* _fileName = fileName.toCString(false);
    _retval = g_path_buf_set_filename(cast(GPathBuf*)cPtr, _fileName);
    return _retval;
  }

  /**
   * Retrieves the built path from the path buffer.
   * On Windows, the result contains backslashes as directory separators,
   * even if forward slashes were used in input.
   * If the path buffer is empty, this function returns `NULL`.
   * Returns: the path
   */
  string toPath()
  {
    char* _cretval;
    _cretval = g_path_buf_to_path(cast(GPathBuf*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Compares two path buffers for equality and returns `TRUE`
   * if they are equal.
   * The path inside the paths buffers are not going to be normalized,
   * so `X/Y/Z/A/..`, `X/./Y/Z` and `X/Y/Z` are not going to be considered
   * equal.
   * This function can be passed to [GLib.HashTable.new_] as the
   * `key_equal_func` parameter.
   * Params:
   *   v1 = a path buffer to compare
   *   v2 = a path buffer to compare
   * Returns: `TRUE` if the two path buffers are equal,
   *   and `FALSE` otherwise
   */
  static bool equal(const(void)* v1, const(void)* v2)
  {
    bool _retval;
    _retval = g_path_buf_equal(v1, v2);
    return _retval;
  }
}

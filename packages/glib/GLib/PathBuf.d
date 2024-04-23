module GLib.PathBuf;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * `GPathBuf` is a helper type that allows you to easily build paths from
 * individual elements, using the platform specific conventions for path
 * separators.
 *
 * |[<!-- language="C" -->
 * g_auto (GPathBuf) path;
 *
 * g_path_buf_init (&path);
 *
 * g_path_buf_push (&path, "usr");
 * g_path_buf_push (&path, "bin");
 * g_path_buf_push (&path, "echo");
 *
 * g_autofree char *echo = g_path_buf_to_path (&path);
 * g_assert_cmpstr (echo, ==, "/usr/bin/echo");
 * ]|
 *
 * You can also load a full path and then operate on its components:
 *
 * |[<!-- language="C" -->
 * g_auto (GPathBuf) path;
 *
 * g_path_buf_init_from_path (&path, "/usr/bin/echo");
 *
 * g_path_buf_pop (&path);
 * g_path_buf_push (&path, "sh");
 *
 * g_autofree char *sh = g_path_buf_to_path (&path);
 * g_assert_cmpstr (sh, ==, "/usr/bin/sh");
 * ]|
 *
 * `GPathBuf` is available since GLib 2.76.
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
      g_free(ptr);
  }

  ~this()
  {
    g_path_buf_free(&cInstance);
  }

  T* cPtr(T)()
  if (is(T == GPathBuf))
  {
    return cast(T*)&cInstance;
  }

  /**
   * Clears the contents of the path buffer.
   *
   * This function should be use to free the resources in a stack-allocated
   * `GPathBuf` initialized using g_path_buf_init() or
   * g_path_buf_init_from_path().
   */
  void clear()
  {
    g_path_buf_clear(cPtr!GPathBuf);
  }

  /**
   * the built path
   */
  string clearToPath()
  {
    char* _cretval;
    _cretval = g_path_buf_clear_to_path(cPtr!GPathBuf);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the path
   */
  string freeToPath()
  {
    char* _cretval;
    _cretval = g_path_buf_free_to_path(cPtr!GPathBuf);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the initialized path builder
   */
  PathBuf init_()
  {
    GPathBuf* _cretval;
    _cretval = g_path_buf_init(cPtr!GPathBuf);
    PathBuf _retval = new PathBuf(cast(GPathBuf*)_cretval);
    return _retval;
  }

  /**
   * the initialized path builder
   */
  PathBuf initFromPath(string path)
  {
    GPathBuf* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_path_buf_init_from_path(cPtr!GPathBuf, _path);
    PathBuf _retval = new PathBuf(cast(GPathBuf*)_cretval);
    return _retval;
  }

  /**
   * `TRUE` if the buffer was modified and `FALSE` otherwise
   */
  bool pop()
  {
    bool _retval;
    _retval = g_path_buf_pop(cPtr!GPathBuf);
    return _retval;
  }

  /**
   * the same pointer to @buf, for convenience
   */
  PathBuf push(string path)
  {
    GPathBuf* _cretval;
    const(char)* _path = path.toCString(false);
    _cretval = g_path_buf_push(cPtr!GPathBuf, _path);
    PathBuf _retval = new PathBuf(cast(GPathBuf*)_cretval);
    return _retval;
  }

  /**
   * `TRUE` if the extension was replaced, and `FALSE` otherwise
   */
  bool setExtension(string extension)
  {
    bool _retval;
    const(char)* _extension = extension.toCString(false);
    _retval = g_path_buf_set_extension(cPtr!GPathBuf, _extension);
    return _retval;
  }

  /**
   * `TRUE` if the file name was replaced, and `FALSE` otherwise
   */
  bool setFilename(string fileName)
  {
    bool _retval;
    const(char)* _fileName = fileName.toCString(false);
    _retval = g_path_buf_set_filename(cPtr!GPathBuf, _fileName);
    return _retval;
  }

  /**
   * the path
   */
  string toPath()
  {
    char* _cretval;
    _cretval = g_path_buf_to_path(cPtr!GPathBuf);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * `TRUE` if the two path buffers are equal,
   * and `FALSE` otherwise
   */
  static bool equal(const(void)* v1, const(void)* v2)
  {
    bool _retval;
    _retval = g_path_buf_equal(v1, v2);
    return _retval;
  }
}

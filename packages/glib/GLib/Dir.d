module GLib.Dir;

import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque structure representing an opened directory.
 */
class Dir
{
  GDir* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Dir");

    cInstancePtr = cast(GDir*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_dir_close(cInstancePtr);
  }

  T* cPtr(T)()
  if (is(T == GDir))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * The entry's name or %NULL if there are no
   * more entries. The return value is owned by GLib and
   * must not be modified or freed.
   */
  string readName()
  {
    const(char)* _cretval;
    _cretval = g_dir_read_name(cPtr!GDir);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Resets the given directory. The next call to g_dir_read_name()
   * will return the first entry again.
   */
  void rewind()
  {
    g_dir_rewind(cPtr!GDir);
  }

  /**
   * The actual name used. This string
   * should be freed with g_free() when not needed any longer and is
   * is in the GLib file name encoding. In case of errors, %NULL is
   * returned and @error will be set.
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

  /**
   * a newly allocated #GDir on success, %NULL on failure.
   * If non-%NULL, you must free the result with g_dir_close()
   * when you are finished with it.
   */
  static Dir open(string path, uint flags)
  {
    GDir* _cretval;
    const(char)* _path = path.toCString(false);
    GError *_err;
    _cretval = g_dir_open(_path, flags, &_err);
    if (_err)
      throw new ErrorG(_err);
    Dir _retval = new Dir(cast(GDir*)_cretval, true);
    return _retval;
  }
}

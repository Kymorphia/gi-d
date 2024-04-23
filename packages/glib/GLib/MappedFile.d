module GLib.MappedFile;

import GLib.Boxed;
import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GMappedFile represents a file mapping created with
 * g_mapped_file_new(). It has only private members and should
 * not be accessed directly.
 */
class MappedFile : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GMappedFile))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_mapped_file_get_type();
  }

  /**
   * a newly allocated #GMappedFile which must be unref'd
   * with g_mapped_file_unref(), or %NULL if the mapping failed.
   */
  this(string filename, bool writable)
  {
    GMappedFile* _cretval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _cretval = g_mapped_file_new(_filename, writable, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, true);
  }

  /**
   * a newly allocated #GMappedFile which must be unref'd
   * with g_mapped_file_unref(), or %NULL if the mapping failed.
   */
  static MappedFile newFromFd(int fd, bool writable)
  {
    GMappedFile* _cretval;
    GError *_err;
    _cretval = g_mapped_file_new_from_fd(fd, writable, &_err);
    if (_err)
      throw new ErrorG(_err);
    MappedFile _retval = new MappedFile(cast(GMappedFile*)_cretval, true);
    return _retval;
  }

  /**
   * A newly allocated #GBytes referencing data
   * from @file
   */
  Bytes getBytes()
  {
    GBytes* _cretval;
    _cretval = g_mapped_file_get_bytes(cPtr!GMappedFile);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * the contents of @file, or %NULL.
   */
  string getContents()
  {
    char* _cretval;
    _cretval = g_mapped_file_get_contents(cPtr!GMappedFile);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the length of the contents of @file.
   */
  size_t getLength()
  {
    size_t _retval;
    _retval = g_mapped_file_get_length(cPtr!GMappedFile);
    return _retval;
  }
}

module Gio.FileIOStream;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.FileInfo;
import Gio.IOStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * GFileIOStream provides io streams that both read and write to the same
 * file handle.
 *
 * GFileIOStream implements #GSeekable, which allows the io
 * stream to jump to arbitrary positions in the file and to truncate
 * the file, provided the filesystem of the file supports these
 * operations.
 *
 * To find the position of a file io stream, use
 * g_seekable_tell().
 *
 * To find out if a file io stream supports seeking, use g_seekable_can_seek().
 * To position a file io stream, use g_seekable_seek().
 * To find out if a file io stream supports truncating, use
 * g_seekable_can_truncate(). To truncate a file io
 * stream, use g_seekable_truncate().
 *
 * The default implementation of all the #GFileIOStream operations
 * and the implementation of #GSeekable just call into the same operations
 * on the output stream.
 */
class FileIOStream : IOStream, Seekable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_file_io_stream_get_type();
  }

  mixin SeekableT!GFileIOStream;

  /**
   * the entity tag for the stream.
   */
  string getEtag()
  {
    char* _cretval;
    _cretval = g_file_io_stream_get_etag(cPtr!GFileIOStream);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a #GFileInfo for the @stream, or %NULL on error.
   */
  FileInfo queryInfo(string attributes, Cancellable cancellable)
  {
    GFileInfo* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    GError *_err;
    _cretval = g_file_io_stream_query_info(cPtr!GFileIOStream, _attributes, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously queries the @stream for a #GFileInfo. When completed,
   * @callback will be called with a #GAsyncResult which can be used to
   * finish the operation with g_file_io_stream_query_info_finish().
   *
   * For the synchronous version of this function, see
   * g_file_io_stream_query_info().
   */
  void queryInfoAsync(string attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _attributes = attributes.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_file_io_stream_query_info_async(cPtr!GFileIOStream, _attributes, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * A #GFileInfo for the finished query.
   */
  FileInfo queryInfoFinish(AsyncResult result)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_io_stream_query_info_finish(cPtr!GFileIOStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }
}

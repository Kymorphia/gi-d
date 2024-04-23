module Gio.FileInputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.FileInfo;
import Gio.InputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * GFileInputStream provides input streams that take their
 * content from a file.
 *
 * GFileInputStream implements #GSeekable, which allows the input
 * stream to jump to arbitrary positions in the file, provided the
 * filesystem of the file allows it. To find the position of a file
 * input stream, use g_seekable_tell(). To find out if a file input
 * stream supports seeking, use g_seekable_can_seek().
 * To position a file input stream, use g_seekable_seek().
 */
class FileInputStream : InputStream, Seekable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_file_input_stream_get_type();
  }

  mixin SeekableT!GFileInputStream;

  /**
   * a #GFileInfo, or %NULL on error.
   */
  FileInfo queryInfo(string attributes, Cancellable cancellable)
  {
    GFileInfo* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    GError *_err;
    _cretval = g_file_input_stream_query_info(cPtr!GFileInputStream, _attributes, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Queries the stream information asynchronously.
   * When the operation is finished @callback will be called.
   * You can then call g_file_input_stream_query_info_finish()
   * to get the result of the operation.
   *
   * For the synchronous version of this function,
   * see g_file_input_stream_query_info().
   *
   * If @cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be set
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
    g_file_input_stream_query_info_async(cPtr!GFileInputStream, _attributes, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * #GFileInfo.
   */
  FileInfo queryInfoFinish(AsyncResult result)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_input_stream_query_info_finish(cPtr!GFileInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true);
    return _retval;
  }
}

module Gio.FileIOStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.FileInfo;
import Gio.IOStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GFileIOStream` provides I/O streams that both read and write to the same
 * file handle.
 * `GFileIOStream` implements [Gio.Seekable], which allows the I/O
 * stream to jump to arbitrary positions in the file and to truncate
 * the file, provided the filesystem of the file supports these
 * operations.
 * To find the position of a file I/O stream, use [Gio.Seekable.tell].
 * To find out if a file I/O stream supports seeking, use
 * [Gio.Seekable.canSeek]. To position a file I/O stream, use
 * [Gio.Seekable.seek]. To find out if a file I/O stream supports
 * truncating, use [Gio.Seekable.canTruncate]. To truncate a file I/O
 * stream, use [Gio.Seekable.truncate].
 * The default implementation of all the `GFileIOStream` operations
 * and the implementation of [Gio.Seekable] just call into the same
 * operations on the output stream.
 */
class FileIOStream : IOStream, Seekable
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_file_io_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SeekableT!GFileIOStream;

  /**
   * Gets the entity tag for the file when it has been written.
   * This must be called after the stream has been written
   * and closed, as the etag can change while writing.
   * Returns: the entity tag for the stream.
   */
  string getEtag()
  {
    char* _cretval;
    _cretval = g_file_io_stream_get_etag(cast(GFileIOStream*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Queries a file io stream for the given attributes.
   * This function blocks while querying the stream. For the asynchronous
   * version of this function, see [Gio.FileIOStream.queryInfoAsync].
   * While the stream is blocked, the stream will set the pending flag
   * internally, and any other operations on the stream will fail with
   * %G_IO_ERROR_PENDING.
   * Can fail if the stream was already closed $(LPAREN)with error being set to
   * %G_IO_ERROR_CLOSED$(RPAREN), the stream has pending operations $(LPAREN)with error being
   * set to %G_IO_ERROR_PENDING$(RPAREN), or if querying info is not supported for
   * the stream's interface $(LPAREN)with error being set to %G_IO_ERROR_NOT_SUPPORTED$(RPAREN). I
   * all cases of failure, %NULL will be returned.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be set, and %NULL will
   * be returned.
   * Params:
   *   attributes = a file attribute query string.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a #GFileInfo for the stream, or %NULL on error.
   */
  FileInfo queryInfo(string attributes, Cancellable cancellable)
  {
    GFileInfo* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    GError *_err;
    _cretval = g_file_io_stream_query_info(cast(GFileIOStream*)cPtr, _attributes, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asynchronously queries the stream for a #GFileInfo. When completed,
   * callback will be called with a #GAsyncResult which can be used to
   * finish the operation with [Gio.FileIOStream.queryInfoFinish].
   * For the synchronous version of this function, see
   * [Gio.FileIOStream.queryInfo].
   * Params:
   *   attributes = a file attribute query string.
   *   ioPriority = the [I/O priority](iface.AsyncResult.html#io-priority) of the
   *     request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void queryInfoAsync(string attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _attributes = attributes.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_file_io_stream_query_info_async(cast(GFileIOStream*)cPtr, _attributes, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finalizes the asynchronous query started
   * by [Gio.FileIOStream.queryInfoAsync].
   * Params:
   *   result = a #GAsyncResult.
   * Returns: A #GFileInfo for the finished query.
   */
  FileInfo queryInfoFinish(AsyncResult result)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_io_stream_query_info_finish(cast(GFileIOStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true) : null;
    return _retval;
  }
}

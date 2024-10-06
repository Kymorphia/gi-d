module Gio.FileInputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.FileInfo;
import Gio.InputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GFileInputStream` provides input streams that take their
 * content from a file.
 * `GFileInputStream` implements [Gio.Seekable], which allows the input
 * stream to jump to arbitrary positions in the file, provided the
 * filesystem of the file allows it. To find the position of a file
 * input stream, use [Gio.Seekable.tell]. To find out if a file input
 * stream supports seeking, use vfunc@Gio.Seekable.can_seek.
 * To position a file input stream, use vfunc@Gio.Seekable.seek.
 */
class FileInputStream : InputStream, Seekable
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
    return g_file_input_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SeekableT!GFileInputStream;

  /**
   * Queries a file input stream the given attributes. This function blocks
   * while querying the stream. For the asynchronous $(LPAREN)non-blocking$(RPAREN) version
   * of this function, see [Gio.FileInputStream.queryInfoAsync]. While the
   * stream is blocked, the stream will set the pending flag internally, and
   * any other operations on the stream will fail with %G_IO_ERROR_PENDING.
   * Params:
   *   attributes = a file attribute query string.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a #GFileInfo, or %NULL on error.
   */
  FileInfo queryInfo(string attributes, Cancellable cancellable)
  {
    GFileInfo* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    GError *_err;
    _cretval = g_file_input_stream_query_info(cast(GFileInputStream*)cPtr, _attributes, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Queries the stream information asynchronously.
   * When the operation is finished callback will be called.
   * You can then call [Gio.FileInputStream.queryInfoFinish]
   * to get the result of the operation.
   * For the synchronous version of this function,
   * see [Gio.FileInputStream.queryInfo].
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be set
   * Params:
   *   attributes = a file attribute query string.
   *   ioPriority = the [I/O priority][io-priority] of the request
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
    g_file_input_stream_query_info_async(cast(GFileInputStream*)cPtr, _attributes, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous info query operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: #GFileInfo.
   */
  FileInfo queryInfoFinish(AsyncResult result)
  {
    GFileInfo* _cretval;
    GError *_err;
    _cretval = g_file_input_stream_query_info_finish(cast(GFileInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, true) : null;
    return _retval;
  }
}

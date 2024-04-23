module Gio.OutputStream;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GOutputStream has functions to write to a stream (g_output_stream_write()),
 * to close a stream (g_output_stream_close()) and to flush pending writes
 * (g_output_stream_flush()).
 *
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use g_output_stream_splice().
 *
 * See the documentation for #GIOStream for details of thread safety of
 * streaming APIs.
 *
 * All of these functions have async variants too.
 */
class OutputStream : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_output_stream_get_type();
  }

  /**
   * Clears the pending flag on @stream.
   */
  void clearPending()
  {
    g_output_stream_clear_pending(cPtr!GOutputStream);
  }

  /**
   * %TRUE on success, %FALSE on failure
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_close(cPtr!GOutputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Requests an asynchronous close of the stream, releasing resources
   * related to it. When the operation is finished @callback will be
   * called. You can then call g_output_stream_close_finish() to get
   * the result of the operation.
   *
   * For behaviour details see g_output_stream_close().
   *
   * The asynchronous methods have a default fallback that uses threads
   * to implement asynchronicity, so they are optional for inheriting
   * classes. However, if you override one you must override all.
   */
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_close_async(cPtr!GOutputStream, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if stream was successfully closed, %FALSE otherwise.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_close_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error
   */
  bool flush(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_flush(cPtr!GOutputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Forces an asynchronous write of all user-space buffered data for
   * the given @stream.
   * For behaviour details see g_output_stream_flush().
   *
   * When the operation is finished @callback will be
   * called. You can then call g_output_stream_flush_finish() to get the
   * result of the operation.
   */
  void flushAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_flush_async(cPtr!GOutputStream, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if flush operation succeeded, %FALSE otherwise.
   */
  bool flushFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_flush_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @stream has pending actions.
   */
  bool hasPending()
  {
    bool _retval;
    _retval = g_output_stream_has_pending(cPtr!GOutputStream);
    return _retval;
  }

  /**
   * %TRUE if @stream is closed. %FALSE otherwise.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_output_stream_is_closed(cPtr!GOutputStream);
    return _retval;
  }

  /**
   * %TRUE if @stream is being closed. %FALSE otherwise.
   */
  bool isClosing()
  {
    bool _retval;
    _retval = g_output_stream_is_closing(cPtr!GOutputStream);
    return _retval;
  }

  /**
   * %TRUE if pending was previously unset and is now set.
   */
  bool setPending()
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_set_pending(cPtr!GOutputStream, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #gssize containing the size of the data spliced, or
   * -1 if an error occurred. Note that if the number of bytes
   * spliced is greater than %G_MAXSSIZE, then that will be
   * returned, and there is no way to determine the actual number
   * of bytes spliced.
   */
  ptrdiff_t splice(InputStream source, OutputStreamSpliceFlags flags, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_splice(cPtr!GOutputStream, source ? source.cPtr!GInputStream : null, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Splices a stream asynchronously.
   * When the operation is finished @callback will be called.
   * You can then call g_output_stream_splice_finish() to get the
   * result of the operation.
   *
   * For the synchronous, blocking version of this function, see
   * g_output_stream_splice().
   */
  void spliceAsync(InputStream source, OutputStreamSpliceFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_splice_async(cPtr!GOutputStream, source ? source.cPtr!GInputStream : null, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #gssize of the number of bytes spliced. Note that if the
   * number of bytes spliced is greater than %G_MAXSSIZE, then that
   * will be returned, and there is no way to determine the actual
   * number of bytes spliced.
   */
  ptrdiff_t spliceFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_splice_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes written, or -1 on error
   */
  ptrdiff_t write(ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    auto _buffer = cast(void*)buffer.ptr;
    GError *_err;
    _retval = g_output_stream_write(cPtr!GOutputStream, _buffer, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool writeAll(ubyte[] buffer, out size_t bytesWritten, Cancellable cancellable)
  {
    bool _retval;
    auto _buffer = cast(void*)buffer.ptr;
    GError *_err;
    _retval = g_output_stream_write_all(cPtr!GOutputStream, _buffer, buffer ? cast(size_t)buffer.length : 0, cast(size_t*)&bytesWritten, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of @count bytes from @buffer into
   * the stream. When the operation is finished @callback will be called.
   * You can then call g_output_stream_write_all_finish() to get the result of the
   * operation.
   *
   * This is the asynchronous version of g_output_stream_write_all().
   *
   * Call g_output_stream_write_all_finish() to collect the result.
   *
   * Any outstanding I/O request with higher priority (lower numerical
   * value) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   *
   * Note that no copy of @buffer will be made, so it must stay valid
   * until @callback is called.
   */
  void writeAllAsync(ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    auto _buffer = cast(void*)buffer.ptr;
    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_write_all_async(cPtr!GOutputStream, _buffer, buffer ? cast(size_t)buffer.length : 0, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool writeAllFinish(AsyncResult result, out size_t bytesWritten)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_write_all_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of @count bytes from @buffer into
   * the stream. When the operation is finished @callback will be called.
   * You can then call g_output_stream_write_finish() to get the result of the
   * operation.
   *
   * During an async request no other sync and async calls are allowed,
   * and will result in %G_IO_ERROR_PENDING errors.
   *
   * A value of @count larger than %G_MAXSSIZE will cause a
   * %G_IO_ERROR_INVALID_ARGUMENT error.
   *
   * On success, the number of bytes written will be passed to the
   * @callback. It is not an error if this is not the same as the
   * requested size, as it can happen e.g. on a partial I/O error,
   * but generally we try to write as many bytes as requested.
   *
   * You are guaranteed that this method will never fail with
   * %G_IO_ERROR_WOULD_BLOCK - if @stream can't accept more data, the
   * method will just wait until this changes.
   *
   * Any outstanding I/O request with higher priority (lower numerical
   * value) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   *
   * The asynchronous methods have a default fallback that uses threads
   * to implement asynchronicity, so they are optional for inheriting
   * classes. However, if you override one you must override all.
   *
   * For the synchronous, blocking version of this function, see
   * g_output_stream_write().
   *
   * Note that no copy of @buffer will be made, so it must stay valid
   * until @callback is called. See g_output_stream_write_bytes_async()
   * for a #GBytes version that will automatically hold a reference to
   * the contents (without copying) for the duration of the call.
   */
  void writeAsync(ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    auto _buffer = cast(void*)buffer.ptr;
    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_write_async(cPtr!GOutputStream, _buffer, buffer ? cast(size_t)buffer.length : 0, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Number of bytes written, or -1 on error
   */
  ptrdiff_t writeBytes(Bytes bytes, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_write_bytes(cPtr!GOutputStream, bytes ? bytes.cPtr!GBytes : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * This function is similar to g_output_stream_write_async(), but
   * takes a #GBytes as input.  Due to the refcounted nature of #GBytes,
   * this allows the stream to avoid taking a copy of the data.
   *
   * However, note that this function may still perform partial writes,
   * just like g_output_stream_write_async(). If that occurs, to continue
   * writing, you will need to create a new #GBytes containing just the
   * remaining bytes, using g_bytes_new_from_bytes(). Passing the same
   * #GBytes instance multiple times potentially can result in duplicated
   * data in the output stream.
   *
   * For the synchronous, blocking version of this function, see
   * g_output_stream_write_bytes().
   */
  void writeBytesAsync(Bytes bytes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_write_bytes_async(cPtr!GOutputStream, bytes ? bytes.cPtr!GBytes : null, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #gssize containing the number of bytes written to the stream.
   */
  ptrdiff_t writeBytesFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_write_bytes_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #gssize containing the number of bytes written to the stream.
   */
  ptrdiff_t writeFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_write_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool writev(OutputVector[] vectors, out size_t bytesWritten, Cancellable cancellable)
  {
    bool _retval;
    auto _vectors = cast(const(GOutputVector)*)vectors.ptr;
    GError *_err;
    _retval = g_output_stream_writev(cPtr!GOutputStream, _vectors, vectors ? cast(size_t)vectors.length : 0, cast(size_t*)&bytesWritten, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool writevAll(OutputVector[] vectors, out size_t bytesWritten, Cancellable cancellable)
  {
    bool _retval;
    auto _vectors = cast(GOutputVector*)vectors.ptr;
    GError *_err;
    _retval = g_output_stream_writev_all(cPtr!GOutputStream, _vectors, vectors ? cast(size_t)vectors.length : 0, cast(size_t*)&bytesWritten, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of the bytes contained in the @n_vectors @vectors into
   * the stream. When the operation is finished @callback will be called.
   * You can then call g_output_stream_writev_all_finish() to get the result of the
   * operation.
   *
   * This is the asynchronous version of g_output_stream_writev_all().
   *
   * Call g_output_stream_writev_all_finish() to collect the result.
   *
   * Any outstanding I/O request with higher priority (lower numerical
   * value) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   *
   * Note that no copy of @vectors will be made, so it must stay valid
   * until @callback is called. The content of the individual elements
   * of @vectors might be changed by this function.
   */
  void writevAllAsync(OutputVector[] vectors, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    auto _vectors = cast(GOutputVector*)vectors.ptr;
    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_writev_all_async(cPtr!GOutputStream, _vectors, vectors ? cast(size_t)vectors.length : 0, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool writevAllFinish(AsyncResult result, out size_t bytesWritten)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_writev_all_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of the bytes contained in @n_vectors @vectors into
   * the stream. When the operation is finished @callback will be called.
   * You can then call g_output_stream_writev_finish() to get the result of the
   * operation.
   *
   * During an async request no other sync and async calls are allowed,
   * and will result in %G_IO_ERROR_PENDING errors.
   *
   * On success, the number of bytes written will be passed to the
   * @callback. It is not an error if this is not the same as the
   * requested size, as it can happen e.g. on a partial I/O error,
   * but generally we try to write as many bytes as requested.
   *
   * You are guaranteed that this method will never fail with
   * %G_IO_ERROR_WOULD_BLOCK — if @stream can't accept more data, the
   * method will just wait until this changes.
   *
   * Any outstanding I/O request with higher priority (lower numerical
   * value) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   *
   * The asynchronous methods have a default fallback that uses threads
   * to implement asynchronicity, so they are optional for inheriting
   * classes. However, if you override one you must override all.
   *
   * For the synchronous, blocking version of this function, see
   * g_output_stream_writev().
   *
   * Note that no copy of @vectors will be made, so it must stay valid
   * until @callback is called.
   */
  void writevAsync(OutputVector[] vectors, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    auto _vectors = cast(const(GOutputVector)*)vectors.ptr;
    ptrFreezeGC(cast(void*)&callback);
    g_output_stream_writev_async(cPtr!GOutputStream, _vectors, vectors ? cast(size_t)vectors.length : 0, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool writevFinish(AsyncResult result, out size_t bytesWritten)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_writev_finish(cPtr!GOutputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

module Gio.OutputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GOutputStream` is a base class for implementing streaming output.
 * It has functions to write to a stream $(LPAREN)[Gio.OutputStream.write]$(RPAREN),
 * to close a stream $(LPAREN)[Gio.OutputStream.close]$(RPAREN) and to flush pending
 * writes $(LPAREN)[Gio.OutputStream.flush]$(RPAREN).
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use [Gio.OutputStream.splice].
 * See the documentation for [Gio.IOStream] for details of thread safety
 * of streaming APIs.
 * All of these functions have async variants too.
 * All classes derived from `GOutputStream` *should* implement synchronous
 * writing, splicing, flushing and closing streams, but *may* implement
 * asynchronous versions.
 */
class OutputStream : ObjectG
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
    return g_output_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Clears the pending flag on stream.
   */
  void clearPending()
  {
    g_output_stream_clear_pending(cast(GOutputStream*)cPtr);
  }

  /**
   * Closes the stream, releasing resources related to it.
   * Once the stream is closed, all other operations will return %G_IO_ERROR_CLOSED.
   * Closing a stream multiple times will not return an error.
   * Closing a stream will automatically flush any outstanding buffers in the
   * stream.
   * Streams will be automatically closed when the last reference
   * is dropped, but you might want to call this function to make sure
   * resources are released as early as possible.
   * Some streams might keep the backing store of the stream $(LPAREN)e.g. a file descriptor$(RPAREN)
   * open after the stream is closed. See the documentation for the individual
   * stream for details.
   * On failure the first error that happened will be reported, but the close
   * operation will finish as much as possible. A stream that failed to
   * close will still return %G_IO_ERROR_CLOSED for all operations. Still, it
   * is important to check and report the error to the user, otherwise
   * there might be a loss of data as all data might not be written.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Cancelling a close will still leave the stream closed, but there some streams
   * can use a faster close that doesn't block to e.g. check errors. On
   * cancellation $(LPAREN)as with any error$(RPAREN) there is no guarantee that all written
   * data will reach the target.
   * Params:
   *   cancellable = optional cancellable object
   * Returns: %TRUE on success, %FALSE on failure
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_close(cast(GOutputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Requests an asynchronous close of the stream, releasing resources
   * related to it. When the operation is finished callback will be
   * called. You can then call [Gio.OutputStream.closeFinish] to get
   * the result of the operation.
   * For behaviour details see [Gio.OutputStream.close].
   * The asynchronous methods have a default fallback that uses threads
   * to implement asynchronicity, so they are optional for inheriting
   * classes. However, if you override one you must override all.
   * Params:
   *   ioPriority = the io priority of the request.
   *   cancellable = optional cancellable object
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_output_stream_close_async(cast(GOutputStream*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Closes an output stream.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if stream was successfully closed, %FALSE otherwise.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_close_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Forces a write of all user-space buffered data for the given
   * stream. Will block during the operation. Closing the stream will
   * implicitly cause a flush.
   * This function is optional for inherited classes.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   cancellable = optional cancellable object
   * Returns: %TRUE on success, %FALSE on error
   */
  bool flush(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_flush(cast(GOutputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Forces an asynchronous write of all user-space buffered data for
   * the given stream.
   * For behaviour details see [Gio.OutputStream.flush].
   * When the operation is finished callback will be
   * called. You can then call [Gio.OutputStream.flushFinish] to get the
   * result of the operation.
   * Params:
   *   ioPriority = the io priority of the request.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void flushAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_output_stream_flush_async(cast(GOutputStream*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes flushing an output stream.
   * Params:
   *   result = a GAsyncResult.
   * Returns: %TRUE if flush operation succeeded, %FALSE otherwise.
   */
  bool flushFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_flush_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Checks if an output stream has pending actions.
   * Returns: %TRUE if stream has pending actions.
   */
  bool hasPending()
  {
    bool _retval;
    _retval = g_output_stream_has_pending(cast(GOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Checks if an output stream has already been closed.
   * Returns: %TRUE if stream is closed. %FALSE otherwise.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_output_stream_is_closed(cast(GOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Checks if an output stream is being closed. This can be
   * used inside e.g. a flush implementation to see if the
   * flush $(LPAREN)or other i/o operation$(RPAREN) is called from within
   * the closing operation.
   * Returns: %TRUE if stream is being closed. %FALSE otherwise.
   */
  bool isClosing()
  {
    bool _retval;
    _retval = g_output_stream_is_closing(cast(GOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Sets stream to have actions pending. If the pending flag is
   * already set or stream is closed, it will return %FALSE and set
   * error.
   * Returns: %TRUE if pending was previously unset and is now set.
   */
  bool setPending()
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_set_pending(cast(GOutputStream*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Splices an input stream into an output stream.
   * Params:
   *   source = a #GInputStream.
   *   flags = a set of #GOutputStreamSpliceFlags.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a #gssize containing the size of the data spliced, or
   *   -1 if an error occurred. Note that if the number of bytes
   *   spliced is greater than %G_MAXSSIZE, then that will be
   *   returned, and there is no way to determine the actual number
   *   of bytes spliced.
   */
  ptrdiff_t splice(InputStream source, OutputStreamSpliceFlags flags, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_splice(cast(GOutputStream*)cPtr, source ? cast(GInputStream*)source.cPtr(false) : null, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Splices a stream asynchronously.
   * When the operation is finished callback will be called.
   * You can then call [Gio.OutputStream.spliceFinish] to get the
   * result of the operation.
   * For the synchronous, blocking version of this function, see
   * [Gio.OutputStream.splice].
   * Params:
   *   source = a #GInputStream.
   *   flags = a set of #GOutputStreamSpliceFlags.
   *   ioPriority = the io priority of the request.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void spliceAsync(InputStream source, OutputStreamSpliceFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_output_stream_splice_async(cast(GOutputStream*)cPtr, source ? cast(GInputStream*)source.cPtr(false) : null, flags, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous stream splice operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #gssize of the number of bytes spliced. Note that if the
   *   number of bytes spliced is greater than %G_MAXSSIZE, then that
   *   will be returned, and there is no way to determine the actual
   *   number of bytes spliced.
   */
  ptrdiff_t spliceFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_splice_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to write count bytes from buffer into the stream. Will block
   * during the operation.
   * If count is 0, returns 0 and does nothing. A value of count
   * larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, the number of bytes written to the stream is returned.
   * It is not an error if this is not the same as the requested size, as it
   * can happen e.g. on a partial I/O error, or if there is not enough
   * storage in the stream. All writes block until at least one byte
   * is written or an error occurs; 0 is never returned $(LPAREN)unless
   * count is 0$(RPAREN).
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * On error -1 is returned and error is set accordingly.
   * Params:
   *   buffer = the buffer containing the data to write.
   *   cancellable = optional cancellable object
   * Returns: Number of bytes written, or -1 on error
   */
  ptrdiff_t write(ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _count;
    if (buffer)
      _count = cast(size_t)buffer.length;

    auto _buffer = cast(void*)buffer.ptr;
    GError *_err;
    _retval = g_output_stream_write(cast(GOutputStream*)cPtr, _buffer, _count, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to write count bytes from buffer into the stream. Will block
   * during the operation.
   * This function is similar to [Gio.OutputStream.write], except it tries to
   * write as many bytes as requested, only stopping on an error.
   * On a successful write of count bytes, %TRUE is returned, and bytes_written
   * is set to count.
   * If there is an error during the operation %FALSE is returned and error
   * is set to indicate the error status.
   * As a special exception to the normal conventions for functions that
   * use #GError, if this function returns %FALSE $(LPAREN)and sets error$(RPAREN) then
   * bytes_written will be set to the number of bytes that were
   * successfully written before the error was encountered.  This
   * functionality is only available from C.  If you need it from another
   * language then you must write your own loop around
   * [Gio.OutputStream.write].
   * Params:
   *   buffer = the buffer containing the data to write.
   *   bytesWritten = location to store the number of bytes that was
   *     written to the stream
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool writeAll(ubyte[] buffer, out size_t bytesWritten, Cancellable cancellable)
  {
    bool _retval;
    size_t _count;
    if (buffer)
      _count = cast(size_t)buffer.length;

    auto _buffer = cast(void*)buffer.ptr;
    GError *_err;
    _retval = g_output_stream_write_all(cast(GOutputStream*)cPtr, _buffer, _count, cast(size_t*)&bytesWritten, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of count bytes from buffer into
   * the stream. When the operation is finished callback will be called.
   * You can then call [Gio.OutputStream.writeAllFinish] to get the result of the
   * operation.
   * This is the asynchronous version of [Gio.OutputStream.writeAll].
   * Call [Gio.OutputStream.writeAllFinish] to collect the result.
   * Any outstanding I/O request with higher priority $(LPAREN)lower numerical
   * value$(RPAREN) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   * Note that no copy of buffer will be made, so it must stay valid
   * until callback is called.
   * Params:
   *   buffer = the buffer containing the data to write
   *   ioPriority = the io priority of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void writeAllAsync(ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    size_t _count;
    if (buffer)
      _count = cast(size_t)buffer.length;

    auto _buffer = cast(void*)buffer.ptr;
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_output_stream_write_all_async(cast(GOutputStream*)cPtr, _buffer, _count, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous stream write operation started with
   * [Gio.OutputStream.writeAllAsync].
   * As a special exception to the normal conventions for functions that
   * use #GError, if this function returns %FALSE $(LPAREN)and sets error$(RPAREN) then
   * bytes_written will be set to the number of bytes that were
   * successfully written before the error was encountered.  This
   * functionality is only available from C.  If you need it from another
   * language then you must write your own loop around
   * [Gio.OutputStream.writeAsync].
   * Params:
   *   result = a #GAsyncResult
   *   bytesWritten = location to store the number of bytes that was written to the stream
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool writeAllFinish(AsyncResult result, out size_t bytesWritten)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_write_all_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of count bytes from buffer into
   * the stream. When the operation is finished callback will be called.
   * You can then call [Gio.OutputStream.writeFinish] to get the result of the
   * operation.
   * During an async request no other sync and async calls are allowed,
   * and will result in %G_IO_ERROR_PENDING errors.
   * A value of count larger than %G_MAXSSIZE will cause a
   * %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, the number of bytes written will be passed to the
   * callback. It is not an error if this is not the same as the
   * requested size, as it can happen e.g. on a partial I/O error,
   * but generally we try to write as many bytes as requested.
   * You are guaranteed that this method will never fail with
   * %G_IO_ERROR_WOULD_BLOCK - if stream can't accept more data, the
   * method will just wait until this changes.
   * Any outstanding I/O request with higher priority $(LPAREN)lower numerical
   * value$(RPAREN) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   * The asynchronous methods have a default fallback that uses threads
   * to implement asynchronicity, so they are optional for inheriting
   * classes. However, if you override one you must override all.
   * For the synchronous, blocking version of this function, see
   * [Gio.OutputStream.write].
   * Note that no copy of buffer will be made, so it must stay valid
   * until callback is called. See [Gio.OutputStream.writeBytesAsync]
   * for a #GBytes version that will automatically hold a reference to
   * the contents $(LPAREN)without copying$(RPAREN) for the duration of the call.
   * Params:
   *   buffer = the buffer containing the data to write.
   *   ioPriority = the io priority of the request.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void writeAsync(ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    size_t _count;
    if (buffer)
      _count = cast(size_t)buffer.length;

    auto _buffer = cast(void*)buffer.ptr;
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_output_stream_write_async(cast(GOutputStream*)cPtr, _buffer, _count, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes a stream write-from-#GBytes operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #gssize containing the number of bytes written to the stream.
   */
  ptrdiff_t writeBytesFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_write_bytes_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Finishes a stream write operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: a #gssize containing the number of bytes written to the stream.
   */
  ptrdiff_t writeFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_output_stream_write_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to write the bytes contained in the n_vectors vectors into the
   * stream. Will block during the operation.
   * If n_vectors is 0 or the sum of all bytes in vectors is 0, returns 0 and
   * does nothing.
   * On success, the number of bytes written to the stream is returned.
   * It is not an error if this is not the same as the requested size, as it
   * can happen e.g. on a partial I/O error, or if there is not enough
   * storage in the stream. All writes block until at least one byte
   * is written or an error occurs; 0 is never returned $(LPAREN)unless
   * n_vectors is 0 or the sum of all bytes in vectors is 0$(RPAREN).
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * Some implementations of [Gio.OutputStream.writev] may have limitations on the
   * aggregate buffer size, and will return %G_IO_ERROR_INVALID_ARGUMENT if these
   * are exceeded. For example, when writing to a local file on UNIX platforms,
   * the aggregate buffer size must not exceed %G_MAXSSIZE bytes.
   * Params:
   *   vectors = the buffer containing the #GOutputVectors to write.
   *   bytesWritten = location to store the number of bytes that were
   *     written to the stream
   *   cancellable = optional cancellable object
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool writev(OutputVector[] vectors, out size_t bytesWritten, Cancellable cancellable)
  {
    bool _retval;
    size_t _nVectors;
    if (vectors)
      _nVectors = cast(size_t)vectors.length;

    auto _vectors = cast(const(GOutputVector)*)vectors.ptr;
    GError *_err;
    _retval = g_output_stream_writev(cast(GOutputStream*)cPtr, _vectors, _nVectors, cast(size_t*)&bytesWritten, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to write the bytes contained in the n_vectors vectors into the
   * stream. Will block during the operation.
   * This function is similar to [Gio.OutputStream.writev], except it tries to
   * write as many bytes as requested, only stopping on an error.
   * On a successful write of all n_vectors vectors, %TRUE is returned, and
   * bytes_written is set to the sum of all the sizes of vectors.
   * If there is an error during the operation %FALSE is returned and error
   * is set to indicate the error status.
   * As a special exception to the normal conventions for functions that
   * use #GError, if this function returns %FALSE $(LPAREN)and sets error$(RPAREN) then
   * bytes_written will be set to the number of bytes that were
   * successfully written before the error was encountered.  This
   * functionality is only available from C. If you need it from another
   * language then you must write your own loop around
   * [Gio.OutputStream.write].
   * The content of the individual elements of vectors might be changed by this
   * function.
   * Params:
   *   vectors = the buffer containing the #GOutputVectors to write.
   *   bytesWritten = location to store the number of bytes that were
   *     written to the stream
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool writevAll(OutputVector[] vectors, out size_t bytesWritten, Cancellable cancellable)
  {
    bool _retval;
    size_t _nVectors;
    if (vectors)
      _nVectors = cast(size_t)vectors.length;

    auto _vectors = cast(GOutputVector*)vectors.ptr;
    GError *_err;
    _retval = g_output_stream_writev_all(cast(GOutputStream*)cPtr, _vectors, _nVectors, cast(size_t*)&bytesWritten, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of the bytes contained in the n_vectors vectors into
   * the stream. When the operation is finished callback will be called.
   * You can then call [Gio.OutputStream.writevAllFinish] to get the result of the
   * operation.
   * This is the asynchronous version of [Gio.OutputStream.writevAll].
   * Call [Gio.OutputStream.writevAllFinish] to collect the result.
   * Any outstanding I/O request with higher priority $(LPAREN)lower numerical
   * value$(RPAREN) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   * Note that no copy of vectors will be made, so it must stay valid
   * until callback is called. The content of the individual elements
   * of vectors might be changed by this function.
   * Params:
   *   vectors = the buffer containing the #GOutputVectors to write.
   *   ioPriority = the I/O priority of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void writevAllAsync(OutputVector[] vectors, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    size_t _nVectors;
    if (vectors)
      _nVectors = cast(size_t)vectors.length;

    auto _vectors = cast(GOutputVector*)vectors.ptr;
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_output_stream_writev_all_async(cast(GOutputStream*)cPtr, _vectors, _nVectors, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous stream write operation started with
   * [Gio.OutputStream.writevAllAsync].
   * As a special exception to the normal conventions for functions that
   * use #GError, if this function returns %FALSE $(LPAREN)and sets error$(RPAREN) then
   * bytes_written will be set to the number of bytes that were
   * successfully written before the error was encountered.  This
   * functionality is only available from C.  If you need it from another
   * language then you must write your own loop around
   * [Gio.OutputStream.writevAsync].
   * Params:
   *   result = a #GAsyncResult
   *   bytesWritten = location to store the number of bytes that were written to the stream
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool writevAllFinish(AsyncResult result, out size_t bytesWritten)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_writev_all_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous write of the bytes contained in n_vectors vectors into
   * the stream. When the operation is finished callback will be called.
   * You can then call [Gio.OutputStream.writevFinish] to get the result of the
   * operation.
   * During an async request no other sync and async calls are allowed,
   * and will result in %G_IO_ERROR_PENDING errors.
   * On success, the number of bytes written will be passed to the
   * callback. It is not an error if this is not the same as the
   * requested size, as it can happen e.g. on a partial I/O error,
   * but generally we try to write as many bytes as requested.
   * You are guaranteed that this method will never fail with
   * %G_IO_ERROR_WOULD_BLOCK — if stream can't accept more data, the
   * method will just wait until this changes.
   * Any outstanding I/O request with higher priority $(LPAREN)lower numerical
   * value$(RPAREN) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   * The asynchronous methods have a default fallback that uses threads
   * to implement asynchronicity, so they are optional for inheriting
   * classes. However, if you override one you must override all.
   * For the synchronous, blocking version of this function, see
   * [Gio.OutputStream.writev].
   * Note that no copy of vectors will be made, so it must stay valid
   * until callback is called.
   * Params:
   *   vectors = the buffer containing the #GOutputVectors to write.
   *   ioPriority = the I/O priority of the request.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void writevAsync(OutputVector[] vectors, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    size_t _nVectors;
    if (vectors)
      _nVectors = cast(size_t)vectors.length;

    auto _vectors = cast(const(GOutputVector)*)vectors.ptr;
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_output_stream_writev_async(cast(GOutputStream*)cPtr, _vectors, _nVectors, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes a stream writev operation.
   * Params:
   *   result = a #GAsyncResult.
   *   bytesWritten = location to store the number of bytes that were written to the stream
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool writevFinish(AsyncResult result, out size_t bytesWritten)
  {
    bool _retval;
    GError *_err;
    _retval = g_output_stream_writev_finish(cast(GOutputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

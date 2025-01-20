module Gio.InputStream;

import GLib.Bytes;
import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GInputStream` is a base class for implementing streaming input.
 * It has functions to read from a stream $(LPAREN)[Gio.InputStream.read]$(RPAREN),
 * to close a stream $(LPAREN)[Gio.InputStream.close]$(RPAREN) and to skip some content
 * $(LPAREN)[Gio.InputStream.skip]$(RPAREN).
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use [Gio.OutputStream.splice].
 * See the documentation for [Gio.IOStream] for details of thread safety
 * of streaming APIs.
 * All of these functions have async variants too.
 */
class InputStream : ObjectG
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
    return g_input_stream_get_type();
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
    g_input_stream_clear_pending(cast(GInputStream*)cPtr);
  }

  /**
   * Closes the stream, releasing resources related to it.
   * Once the stream is closed, all other operations will return %G_IO_ERROR_CLOSED.
   * Closing a stream multiple times will not return an error.
   * Streams will be automatically closed when the last reference
   * is dropped, but you might want to call this function to make sure
   * resources are released as early as possible.
   * Some streams might keep the backing store of the stream $(LPAREN)e.g. a file descriptor$(RPAREN)
   * open after the stream is closed. See the documentation for the individual
   * stream for details.
   * On failure the first error that happened will be reported, but the close
   * operation will finish as much as possible. A stream that failed to
   * close will still return %G_IO_ERROR_CLOSED for all operations. Still, it
   * is important to check and report the error to the user.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Cancelling a close will still leave the stream closed, but some streams
   * can use a faster close that doesn't block to e.g. check errors.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE on success, %FALSE on failure
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_close(cast(GInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Requests an asynchronous closes of the stream, releasing resources related to it.
   * When the operation is finished callback will be called.
   * You can then call [Gio.InputStream.closeFinish] to get the result of the
   * operation.
   * For behaviour details see [Gio.InputStream.close].
   * The asynchronous methods have a default fallback that uses threads to implement
   * asynchronicity, so they are optional for inheriting classes. However, if you
   * override one you must override all.
   * Params:
   *   ioPriority = the [I/O priority][io-priority] of the request
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
    g_input_stream_close_async(cast(GInputStream*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes closing a stream asynchronously, started from [Gio.InputStream.closeAsync].
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the stream was closed successfully.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_close_finish(cast(GInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Checks if an input stream has pending actions.
   * Returns: %TRUE if stream has pending actions.
   */
  bool hasPending()
  {
    bool _retval;
    _retval = g_input_stream_has_pending(cast(GInputStream*)cPtr);
    return _retval;
  }

  /**
   * Checks if an input stream is closed.
   * Returns: %TRUE if the stream is closed.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_input_stream_is_closed(cast(GInputStream*)cPtr);
    return _retval;
  }

  /**
   * Tries to read count bytes from the stream into the buffer starting at
   * buffer. Will block during this read.
   * If count is zero returns zero and does nothing. A value of count
   * larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, the number of bytes read into the buffer is returned.
   * It is not an error if this is not the same as the requested size, as it
   * can happen e.g. near the end of a file. Zero is returned on end of file
   * $(LPAREN)or if count is zero$(RPAREN),  but never otherwise.
   * The returned buffer is not a nul-terminated string, it can contain nul bytes
   * at any position, and this function doesn't nul-terminate the buffer.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * On error -1 is returned and error is set accordingly.
   * Params:
   *   buffer = a buffer to read data into $(LPAREN)which should be at least count bytes long$(RPAREN).
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: Number of bytes read, or -1 on error, or 0 on end of file.
   */
  ptrdiff_t read(ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    size_t _count;
    GError *_err;
    _retval = g_input_stream_read(cast(GInputStream*)cPtr, buffer.ptr, _count, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to read count bytes from the stream into the buffer starting at
   * buffer. Will block during this read.
   * This function is similar to [Gio.InputStream.read], except it tries to
   * read as many bytes as requested, only stopping on an error or end of stream.
   * On a successful read of count bytes, or if we reached the end of the
   * stream,  %TRUE is returned, and bytes_read is set to the number of bytes
   * read into buffer.
   * If there is an error during the operation %FALSE is returned and error
   * is set to indicate the error status.
   * As a special exception to the normal conventions for functions that
   * use #GError, if this function returns %FALSE $(LPAREN)and sets error$(RPAREN) then
   * bytes_read will be set to the number of bytes that were successfully
   * read before the error was encountered.  This functionality is only
   * available from C.  If you need it from another language then you must
   * write your own loop around [Gio.InputStream.read].
   * Params:
   *   buffer = a buffer to read data into $(LPAREN)which should be at least count bytes long$(RPAREN).
   *   bytesRead = location to store the number of bytes that was read from the stream
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool readAll(ref ubyte[] buffer, out size_t bytesRead, Cancellable cancellable)
  {
    bool _retval;
    size_t _count;
    GError *_err;
    _retval = g_input_stream_read_all(cast(GInputStream*)cPtr, buffer.ptr, _count, cast(size_t*)&bytesRead, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous read of count bytes from the stream into the
   * buffer starting at buffer.
   * This is the asynchronous equivalent of [Gio.InputStream.readAll].
   * Call [Gio.InputStream.readAllFinish] to collect the result.
   * Any outstanding I/O request with higher priority $(LPAREN)lower numerical
   * value$(RPAREN) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   * Params:
   *   buffer = a buffer to read data into $(LPAREN)which should be at least count bytes long$(RPAREN)
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void readAllAsync(ref ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    size_t _count;
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_input_stream_read_all_async(cast(GInputStream*)cPtr, buffer.ptr, _count, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous stream read operation started with
   * [Gio.InputStream.readAllAsync].
   * As a special exception to the normal conventions for functions that
   * use #GError, if this function returns %FALSE $(LPAREN)and sets error$(RPAREN) then
   * bytes_read will be set to the number of bytes that were successfully
   * read before the error was encountered.  This functionality is only
   * available from C.  If you need it from another language then you must
   * write your own loop around [Gio.InputStream.readAsync].
   * Params:
   *   result = a #GAsyncResult
   *   bytesRead = location to store the number of bytes that was read from the stream
   * Returns: %TRUE on success, %FALSE if there was an error
   */
  bool readAllFinish(AsyncResult result, out size_t bytesRead)
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_read_all_finish(cast(GInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, cast(size_t*)&bytesRead, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous read of count bytes from the stream into the buffer
   * starting at buffer. When the operation is finished callback will be called.
   * You can then call [Gio.InputStream.readFinish] to get the result of the
   * operation.
   * During an async request no other sync and async calls are allowed on stream, and will
   * result in %G_IO_ERROR_PENDING errors.
   * A value of count larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, the number of bytes read into the buffer will be passed to the
   * callback. It is not an error if this is not the same as the requested size, as it
   * can happen e.g. near the end of a file, but generally we try to read
   * as many bytes as requested. Zero is returned on end of file
   * $(LPAREN)or if count is zero$(RPAREN),  but never otherwise.
   * Any outstanding i/o request with higher priority $(LPAREN)lower numerical value$(RPAREN) will
   * be executed before an outstanding request with lower priority. Default
   * priority is %G_PRIORITY_DEFAULT.
   * The asynchronous methods have a default fallback that uses threads to implement
   * asynchronicity, so they are optional for inheriting classes. However, if you
   * override one you must override all.
   * Params:
   *   buffer = a buffer to read data into $(LPAREN)which should be at least count bytes long$(RPAREN).
   *   ioPriority = the [I/O priority][io-priority]
   *     of the request.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void readAsync(ref ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    size_t _count;
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_input_stream_read_async(cast(GInputStream*)cPtr, buffer.ptr, _count, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Like [Gio.InputStream.read], this tries to read count bytes from
   * the stream in a blocking fashion. However, rather than reading into
   * a user-supplied buffer, this will create a new #GBytes containing
   * the data that was read. This may be easier to use from language
   * bindings.
   * If count is zero, returns a zero-length #GBytes and does nothing. A
   * value of count larger than %G_MAXSSIZE will cause a
   * %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, a new #GBytes is returned. It is not an error if the
   * size of this object is not the same as the requested size, as it
   * can happen e.g. near the end of a file. A zero-length #GBytes is
   * returned on end of file $(LPAREN)or if count is zero$(RPAREN), but never
   * otherwise.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * On error %NULL is returned and error is set accordingly.
   * Params:
   *   count = maximum number of bytes that will be read from the stream. Common
   *     values include 4096 and 8192.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a new #GBytes, or %NULL on error
   */
  Bytes readBytes(size_t count, Cancellable cancellable)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = g_input_stream_read_bytes(cast(GInputStream*)cPtr, count, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Request an asynchronous read of count bytes from the stream into a
   * new #GBytes. When the operation is finished callback will be
   * called. You can then call [Gio.InputStream.readBytesFinish] to get the
   * result of the operation.
   * During an async request no other sync and async calls are allowed
   * on stream, and will result in %G_IO_ERROR_PENDING errors.
   * A value of count larger than %G_MAXSSIZE will cause a
   * %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, the new #GBytes will be passed to the callback. It is
   * not an error if this is smaller than the requested size, as it can
   * happen e.g. near the end of a file, but generally we try to read as
   * many bytes as requested. Zero is returned on end of file $(LPAREN)or if
   * count is zero$(RPAREN), but never otherwise.
   * Any outstanding I/O request with higher priority $(LPAREN)lower numerical
   * value$(RPAREN) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   * Params:
   *   count = the number of bytes that will be read from the stream
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void readBytesAsync(size_t count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_input_stream_read_bytes_async(cast(GInputStream*)cPtr, count, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous stream read-into-#GBytes operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: the newly-allocated #GBytes, or %NULL on error
   */
  Bytes readBytesFinish(AsyncResult result)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = g_input_stream_read_bytes_finish(cast(GInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Finishes an asynchronous stream read operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: number of bytes read in, or -1 on error, or 0 on end of file.
   */
  ptrdiff_t readFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_input_stream_read_finish(cast(GInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
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
    _retval = g_input_stream_set_pending(cast(GInputStream*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Tries to skip count bytes from the stream. Will block during the operation.
   * This is identical to [Gio.InputStream.read], from a behaviour standpoint,
   * but the bytes that are skipped are not returned to the user. Some
   * streams have an implementation that is more efficient than reading the data.
   * This function is optional for inherited classes, as the default implementation
   * emulates it using read.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * Params:
   *   count = the number of bytes that will be skipped from the stream
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: Number of bytes skipped, or -1 on error
   */
  ptrdiff_t skip(size_t count, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_input_stream_skip(cast(GInputStream*)cPtr, count, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous skip of count bytes from the stream.
   * When the operation is finished callback will be called.
   * You can then call [Gio.InputStream.skipFinish] to get the result
   * of the operation.
   * During an async request no other sync and async calls are allowed,
   * and will result in %G_IO_ERROR_PENDING errors.
   * A value of count larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, the number of bytes skipped will be passed to the callback.
   * It is not an error if this is not the same as the requested size, as it
   * can happen e.g. near the end of a file, but generally we try to skip
   * as many bytes as requested. Zero is returned on end of file
   * $(LPAREN)or if count is zero$(RPAREN), but never otherwise.
   * Any outstanding i/o request with higher priority $(LPAREN)lower numerical value$(RPAREN)
   * will be executed before an outstanding request with lower priority.
   * Default priority is %G_PRIORITY_DEFAULT.
   * The asynchronous methods have a default fallback that uses threads to
   * implement asynchronicity, so they are optional for inheriting classes.
   * However, if you override one, you must override all.
   * Params:
   *   count = the number of bytes that will be skipped from the stream
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void skipAsync(size_t count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_input_stream_skip_async(cast(GInputStream*)cPtr, count, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes a stream skip operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: the size of the bytes skipped, or `-1` on error.
   */
  ptrdiff_t skipFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_input_stream_skip_finish(cast(GInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

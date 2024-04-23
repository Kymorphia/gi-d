module Gio.InputStream;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GInputStream has functions to read from a stream (g_input_stream_read()),
 * to close a stream (g_input_stream_close()) and to skip some content
 * (g_input_stream_skip()).
 *
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use g_output_stream_splice().
 *
 * See the documentation for #GIOStream for details of thread safety of
 * streaming APIs.
 *
 * All of these functions have async variants too.
 */
class InputStream : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_input_stream_get_type();
  }

  /**
   * Clears the pending flag on @stream.
   */
  void clearPending()
  {
    g_input_stream_clear_pending(cPtr!GInputStream);
  }

  /**
   * %TRUE on success, %FALSE on failure
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_close(cPtr!GInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Requests an asynchronous closes of the stream, releasing resources related to it.
   * When the operation is finished @callback will be called.
   * You can then call g_input_stream_close_finish() to get the result of the
   * operation.
   *
   * For behaviour details see g_input_stream_close().
   *
   * The asynchronous methods have a default fallback that uses threads to implement
   * asynchronicity, so they are optional for inheriting classes. However, if you
   * override one you must override all.
   */
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_input_stream_close_async(cPtr!GInputStream, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the stream was closed successfully.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_close_finish(cPtr!GInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
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
    _retval = g_input_stream_has_pending(cPtr!GInputStream);
    return _retval;
  }

  /**
   * %TRUE if the stream is closed.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_input_stream_is_closed(cPtr!GInputStream);
    return _retval;
  }

  /**
   * Number of bytes read, or -1 on error, or 0 on end of file.
   */
  ptrdiff_t read(ref ubyte[] buffer, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_input_stream_read(cPtr!GInputStream, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool readAll(ref ubyte[] buffer, out size_t bytesRead, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_read_all(cPtr!GInputStream, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, cast(size_t*)&bytesRead, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous read of @count bytes from the stream into the
   * buffer starting at @buffer.
   *
   * This is the asynchronous equivalent of g_input_stream_read_all().
   *
   * Call g_input_stream_read_all_finish() to collect the result.
   *
   * Any outstanding I/O request with higher priority (lower numerical
   * value) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   */
  void readAllAsync(ref ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_input_stream_read_all_async(cPtr!GInputStream, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE if there was an error
   */
  bool readAllFinish(AsyncResult result, out size_t bytesRead)
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_read_all_finish(cPtr!GInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(size_t*)&bytesRead, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous read of @count bytes from the stream into the buffer
   * starting at @buffer. When the operation is finished @callback will be called.
   * You can then call g_input_stream_read_finish() to get the result of the
   * operation.
   *
   * During an async request no other sync and async calls are allowed on @stream, and will
   * result in %G_IO_ERROR_PENDING errors.
   *
   * A value of @count larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
   *
   * On success, the number of bytes read into the buffer will be passed to the
   * callback. It is not an error if this is not the same as the requested size, as it
   * can happen e.g. near the end of a file, but generally we try to read
   * as many bytes as requested. Zero is returned on end of file
   * (or if @count is zero),  but never otherwise.
   *
   * Any outstanding i/o request with higher priority (lower numerical value) will
   * be executed before an outstanding request with lower priority. Default
   * priority is %G_PRIORITY_DEFAULT.
   *
   * The asynchronous methods have a default fallback that uses threads to implement
   * asynchronicity, so they are optional for inheriting classes. However, if you
   * override one you must override all.
   */
  void readAsync(ref ubyte[] buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_input_stream_read_async(cPtr!GInputStream, buffer.ptr, buffer ? cast(size_t)buffer.length : 0, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a new #GBytes, or %NULL on error
   */
  Bytes readBytes(size_t count, Cancellable cancellable)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = g_input_stream_read_bytes(cPtr!GInputStream, count, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * Request an asynchronous read of @count bytes from the stream into a
   * new #GBytes. When the operation is finished @callback will be
   * called. You can then call g_input_stream_read_bytes_finish() to get the
   * result of the operation.
   *
   * During an async request no other sync and async calls are allowed
   * on @stream, and will result in %G_IO_ERROR_PENDING errors.
   *
   * A value of @count larger than %G_MAXSSIZE will cause a
   * %G_IO_ERROR_INVALID_ARGUMENT error.
   *
   * On success, the new #GBytes will be passed to the callback. It is
   * not an error if this is smaller than the requested size, as it can
   * happen e.g. near the end of a file, but generally we try to read as
   * many bytes as requested. Zero is returned on end of file (or if
   * @count is zero), but never otherwise.
   *
   * Any outstanding I/O request with higher priority (lower numerical
   * value) will be executed before an outstanding request with lower
   * priority. Default priority is %G_PRIORITY_DEFAULT.
   */
  void readBytesAsync(size_t count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_input_stream_read_bytes_async(cPtr!GInputStream, count, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * the newly-allocated #GBytes, or %NULL on error
   */
  Bytes readBytesFinish(AsyncResult result)
  {
    GBytes* _cretval;
    GError *_err;
    _cretval = g_input_stream_read_bytes_finish(cPtr!GInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * number of bytes read in, or -1 on error, or 0 on end of file.
   */
  ptrdiff_t readFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_input_stream_read_finish(cPtr!GInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if pending was previously unset and is now set.
   */
  bool setPending()
  {
    bool _retval;
    GError *_err;
    _retval = g_input_stream_set_pending(cPtr!GInputStream, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Number of bytes skipped, or -1 on error
   */
  ptrdiff_t skip(size_t count, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_input_stream_skip(cPtr!GInputStream, count, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Request an asynchronous skip of @count bytes from the stream.
   * When the operation is finished @callback will be called.
   * You can then call g_input_stream_skip_finish() to get the result
   * of the operation.
   *
   * During an async request no other sync and async calls are allowed,
   * and will result in %G_IO_ERROR_PENDING errors.
   *
   * A value of @count larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
   *
   * On success, the number of bytes skipped will be passed to the callback.
   * It is not an error if this is not the same as the requested size, as it
   * can happen e.g. near the end of a file, but generally we try to skip
   * as many bytes as requested. Zero is returned on end of file
   * (or if @count is zero), but never otherwise.
   *
   * Any outstanding i/o request with higher priority (lower numerical value)
   * will be executed before an outstanding request with lower priority.
   * Default priority is %G_PRIORITY_DEFAULT.
   *
   * The asynchronous methods have a default fallback that uses threads to
   * implement asynchronicity, so they are optional for inheriting classes.
   * However, if you override one, you must override all.
   */
  void skipAsync(size_t count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_input_stream_skip_async(cPtr!GInputStream, count, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * the size of the bytes skipped, or `-1` on error.
   */
  ptrdiff_t skipFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_input_stream_skip_finish(cPtr!GInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}

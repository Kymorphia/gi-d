module Gio.IOStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.OutputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GIOStream` represents an object that has both read and write streams.
 * Generally the two streams act as separate input and output streams,
 * but they share some common resources and state. For instance, for
 * seekable streams, both streams may use the same position.
 * Examples of `GIOStream` objects are [Gio.SocketConnection], which represents
 * a two-way network connection; and [Gio.FileIOStream], which represents a
 * file handle opened in read-write mode.
 * To do the actual reading and writing you need to get the substreams
 * with [Gio.IOStream.getInputStream] and
 * [Gio.IOStream.getOutputStream].
 * The `GIOStream` object owns the input and the output streams, not the other
 * way around, so keeping the substreams alive will not keep the `GIOStream`
 * object alive. If the `GIOStream` object is freed it will be closed, thus
 * closing the substreams, so even if the substreams stay alive they will
 * always return `G_IO_ERROR_CLOSED` for all operations.
 * To close a stream use [Gio.IOStream.close] which will close the common
 * stream object and also the individual substreams. You can also close
 * the substreams themselves. In most cases this only marks the
 * substream as closed, so further I/O on it fails but common state in the
 * `GIOStream` may still be open. However, some streams may support
 * ‘half-closed’ states where one direction of the stream is actually shut down.
 * Operations on `GIOStream`s cannot be started while another operation on the
 * `GIOStream` or its substreams is in progress. Specifically, an application can
 * read from the [Gio.InputStream] and write to the
 * [Gio.OutputStream] simultaneously $(LPAREN)either in separate threads, or as
 * asynchronous operations in the same thread$(RPAREN), but an application cannot start
 * any `GIOStream` operation while there is a `GIOStream`, `GInputStream` or
 * `GOutputStream` operation in progress, and an application can’t start any
 * `GInputStream` or `GOutputStream` operation while there is a `GIOStream`
 * operation in progress.
 * This is a product of individual stream operations being associated with a
 * given [GLib.MainContext] $(LPAREN)the thread-default context at the time the
 * operation was started$(RPAREN), rather than entire streams being associated with a
 * single `GMainContext`.
 * GIO may run operations on `GIOStream`s from other $(LPAREN)worker$(RPAREN) threads, and this
 * may be exposed to application code in the behaviour of wrapper streams, such
 * as [Gio.BufferedInputStream] or [Gio.TlsConnection]. With such
 * wrapper APIs, application code may only run operations on the base $(LPAREN)wrapped$(RPAREN)
 * stream when the wrapper stream is idle. Note that the semantics of such
 * operations may not be well-defined due to the state the wrapper stream leaves
 * the base stream in $(LPAREN)though they are guaranteed not to crash$(RPAREN).
 */
class IOStream : ObjectG
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
    return g_io_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Finishes an asynchronous io stream splice operation.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE on success, %FALSE otherwise.
   */
  static bool spliceFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_io_stream_splice_finish(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Clears the pending flag on stream.
   */
  void clearPending()
  {
    g_io_stream_clear_pending(cast(GIOStream*)cPtr);
  }

  /**
   * Closes the stream, releasing resources related to it. This will also
   * close the individual input and output streams, if they are not already
   * closed.
   * Once the stream is closed, all other operations will return
   * %G_IO_ERROR_CLOSED. Closing a stream multiple times will not
   * return an error.
   * Closing a stream will automatically flush any outstanding buffers
   * in the stream.
   * Streams will be automatically closed when the last reference
   * is dropped, but you might want to call this function to make sure
   * resources are released as early as possible.
   * Some streams might keep the backing store of the stream $(LPAREN)e.g. a file
   * descriptor$(RPAREN) open after the stream is closed. See the documentation for
   * the individual stream for details.
   * On failure the first error that happened will be reported, but the
   * close operation will finish as much as possible. A stream that failed
   * to close will still return %G_IO_ERROR_CLOSED for all operations.
   * Still, it is important to check and report the error to the user,
   * otherwise there might be a loss of data as all data might not be written.
   * If cancellable is not NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Cancelling a close will still leave the stream closed, but some streams
   * can use a faster close that doesn't block to e.g. check errors.
   * The default implementation of this method just calls close on the
   * individual input/output streams.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore
   * Returns: %TRUE on success, %FALSE on failure
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_io_stream_close(cast(GIOStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Requests an asynchronous close of the stream, releasing resources
   * related to it. When the operation is finished callback will be
   * called. You can then call [Gio.IOStream.closeFinish] to get
   * the result of the operation.
   * For behaviour details see [Gio.IOStream.close].
   * The asynchronous methods have a default fallback that uses threads
   * to implement asynchronicity, so they are optional for inheriting
   * classes. However, if you override one you must override all.
   * Params:
   *   ioPriority = the io priority of the request
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
    g_io_stream_close_async(cast(GIOStream*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Closes a stream.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE if stream was successfully closed, %FALSE otherwise.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_io_stream_close_finish(cast(GIOStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the input stream for this object. This is used
   * for reading.
   * Returns: a #GInputStream, owned by the #GIOStream.
   *   Do not free.
   */
  InputStream getInputStream()
  {
    GInputStream* _cretval;
    _cretval = g_io_stream_get_input_stream(cast(GIOStream*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the output stream for this object. This is used for
   * writing.
   * Returns: a #GOutputStream, owned by the #GIOStream.
   *   Do not free.
   */
  OutputStream getOutputStream()
  {
    GOutputStream* _cretval;
    _cretval = g_io_stream_get_output_stream(cast(GIOStream*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if a stream has pending actions.
   * Returns: %TRUE if stream has pending actions.
   */
  bool hasPending()
  {
    bool _retval;
    _retval = g_io_stream_has_pending(cast(GIOStream*)cPtr);
    return _retval;
  }

  /**
   * Checks if a stream is closed.
   * Returns: %TRUE if the stream is closed.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_io_stream_is_closed(cast(GIOStream*)cPtr);
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
    _retval = g_io_stream_set_pending(cast(GIOStream*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously splice the output stream of stream1 to the input stream of
   * stream2, and splice the output stream of stream2 to the input stream of
   * stream1.
   * When the operation is finished callback will be called.
   * You can then call [Gio.IOStream.spliceFinish] to get the
   * result of the operation.
   * Params:
   *   stream2 = a #GIOStream.
   *   flags = a set of #GIOStreamSpliceFlags.
   *   ioPriority = the io priority of the request.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback
   *     to call when the request is satisfied
   */
  void spliceAsync(IOStream stream2, IOStreamSpliceFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_io_stream_splice_async(cast(GIOStream*)cPtr, stream2 ? cast(GIOStream*)stream2.cPtr(false) : null, flags, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }
}

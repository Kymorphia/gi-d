module Gio.IOStream;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.OutputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * GIOStream represents an object that has both read and write streams.
 * Generally the two streams act as separate input and output streams,
 * but they share some common resources and state. For instance, for
 * seekable streams, both streams may use the same position.
 *
 * Examples of #GIOStream objects are #GSocketConnection, which represents
 * a two-way network connection; and #GFileIOStream, which represents a
 * file handle opened in read-write mode.
 *
 * To do the actual reading and writing you need to get the substreams
 * with g_io_stream_get_input_stream() and g_io_stream_get_output_stream().
 *
 * The #GIOStream object owns the input and the output streams, not the other
 * way around, so keeping the substreams alive will not keep the #GIOStream
 * object alive. If the #GIOStream object is freed it will be closed, thus
 * closing the substreams, so even if the substreams stay alive they will
 * always return %G_IO_ERROR_CLOSED for all operations.
 *
 * To close a stream use g_io_stream_close() which will close the common
 * stream object and also the individual substreams. You can also close
 * the substreams themselves. In most cases this only marks the
 * substream as closed, so further I/O on it fails but common state in the
 * #GIOStream may still be open. However, some streams may support
 * "half-closed" states where one direction of the stream is actually shut down.
 *
 * Operations on #GIOStreams cannot be started while another operation on the
 * #GIOStream or its substreams is in progress. Specifically, an application can
 * read from the #GInputStream and write to the #GOutputStream simultaneously
 * (either in separate threads, or as asynchronous operations in the same
 * thread), but an application cannot start any #GIOStream operation while there
 * is a #GIOStream, #GInputStream or #GOutputStream operation in progress, and
 * an application can’t start any #GInputStream or #GOutputStream operation
 * while there is a #GIOStream operation in progress.
 *
 * This is a product of individual stream operations being associated with a
 * given #GMainContext (the thread-default context at the time the operation was
 * started), rather than entire streams being associated with a single
 * #GMainContext.
 *
 * GIO may run operations on #GIOStreams from other (worker) threads, and this
 * may be exposed to application code in the behaviour of wrapper streams, such
 * as #GBufferedInputStream or #GTlsConnection. With such wrapper APIs,
 * application code may only run operations on the base (wrapped) stream when
 * the wrapper stream is idle. Note that the semantics of such operations may
 * not be well-defined due to the state the wrapper stream leaves the base
 * stream in (though they are guaranteed not to crash).
 */
class IOStream : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_io_stream_get_type();
  }

  /**
   * %TRUE on success, %FALSE otherwise.
   */
  static bool spliceFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_io_stream_splice_finish(result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Clears the pending flag on @stream.
   */
  void clearPending()
  {
    g_io_stream_clear_pending(cPtr!GIOStream);
  }

  /**
   * %TRUE on success, %FALSE on failure
   */
  bool close(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_io_stream_close(cPtr!GIOStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Requests an asynchronous close of the stream, releasing resources
   * related to it. When the operation is finished @callback will be
   * called. You can then call g_io_stream_close_finish() to get
   * the result of the operation.
   *
   * For behaviour details see g_io_stream_close().
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
    g_io_stream_close_async(cPtr!GIOStream, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if stream was successfully closed, %FALSE otherwise.
   */
  bool closeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_io_stream_close_finish(cPtr!GIOStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GInputStream, owned by the #GIOStream.
   * Do not free.
   */
  InputStream getInputStream()
  {
    GInputStream* _cretval;
    _cretval = g_io_stream_get_input_stream(cPtr!GIOStream);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, false);
    return _retval;
  }

  /**
   * a #GOutputStream, owned by the #GIOStream.
   * Do not free.
   */
  OutputStream getOutputStream()
  {
    GOutputStream* _cretval;
    _cretval = g_io_stream_get_output_stream(cPtr!GIOStream);
    OutputStream _retval = ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if @stream has pending actions.
   */
  bool hasPending()
  {
    bool _retval;
    _retval = g_io_stream_has_pending(cPtr!GIOStream);
    return _retval;
  }

  /**
   * %TRUE if the stream is closed.
   */
  bool isClosed()
  {
    bool _retval;
    _retval = g_io_stream_is_closed(cPtr!GIOStream);
    return _retval;
  }

  /**
   * %TRUE if pending was previously unset and is now set.
   */
  bool setPending()
  {
    bool _retval;
    GError *_err;
    _retval = g_io_stream_set_pending(cPtr!GIOStream, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously splice the output stream of @stream1 to the input stream of
   * @stream2, and splice the output stream of @stream2 to the input stream of
   * @stream1.
   *
   * When the operation is finished @callback will be called.
   * You can then call g_io_stream_splice_finish() to get the
   * result of the operation.
   */
  void spliceAsync(IOStream stream2, IOStreamSpliceFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_io_stream_splice_async(cPtr!GIOStream, stream2 ? stream2.cPtr!GIOStream : null, flags, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }
}

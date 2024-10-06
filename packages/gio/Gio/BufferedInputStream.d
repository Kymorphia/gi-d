module Gio.BufferedInputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.FilterInputStream;
import Gio.InputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Buffered input stream implements #GFilterInputStream and provides
 * for buffered reads.
 * By default, `GBufferedInputStream`'s buffer size is set at 4 kilobytes.
 * To create a buffered input stream, use [Gio.BufferedInputStream.new_],
 * or [Gio.BufferedInputStream.newSized] to specify the buffer's size at
 * construction.
 * To get the size of a buffer within a buffered input stream, use
 * [Gio.BufferedInputStream.getBufferSize]. To change the size of a
 * buffered input stream's buffer, use [Gio.BufferedInputStream.setBufferSize].
 * Note that the buffer's size cannot be reduced below the size of the data within the buffer.
 */
class BufferedInputStream : FilterInputStream, Seekable
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
    return g_buffered_input_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SeekableT!GBufferedInputStream;

  /**
   * Creates a new #GInputStream from the given base_stream, with
   * a buffer set to the default size $(LPAREN)4 kilobytes$(RPAREN).
   * Params:
   *   baseStream = a #GInputStream
   * Returns: a #GInputStream for the given base_stream.
   */
  this(InputStream baseStream)
  {
    GInputStream* _cretval;
    _cretval = g_buffered_input_stream_new(baseStream ? cast(GInputStream*)baseStream.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Creates a new #GBufferedInputStream from the given base_stream,
   * with a buffer set to size.
   * Params:
   *   baseStream = a #GInputStream
   *   size = a #gsize
   * Returns: a #GInputStream.
   */
  static BufferedInputStream newSized(InputStream baseStream, size_t size)
  {
    GInputStream* _cretval;
    _cretval = g_buffered_input_stream_new_sized(baseStream ? cast(GInputStream*)baseStream.cPtr(false) : null, size);
    auto _retval = _cretval ? ObjectG.getDObject!BufferedInputStream(cast(GInputStream*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Tries to read count bytes from the stream into the buffer.
   * Will block during this read.
   * If count is zero, returns zero and does nothing. A value of count
   * larger than %G_MAXSSIZE will cause a %G_IO_ERROR_INVALID_ARGUMENT error.
   * On success, the number of bytes read into the buffer is returned.
   * It is not an error if this is not the same as the requested size, as it
   * can happen e.g. near the end of a file. Zero is returned on end of file
   * $(LPAREN)or if count is zero$(RPAREN),  but never otherwise.
   * If count is -1 then the attempted read size is equal to the number of
   * bytes that are required to fill the buffer.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * On error -1 is returned and error is set accordingly.
   * For the asynchronous, non-blocking, version of this function, see
   * [Gio.BufferedInputStream.fillAsync].
   * Params:
   *   count = the number of bytes that will be read from the stream
   *   cancellable = optional #GCancellable object, %NULL to ignore
   * Returns: the number of bytes read into stream's buffer, up to count,
   *   or -1 on error.
   */
  ptrdiff_t fill(ptrdiff_t count, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_buffered_input_stream_fill(cast(GBufferedInputStream*)cPtr, count, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads data into stream's buffer asynchronously, up to count size.
   * io_priority can be used to prioritize reads. For the synchronous
   * version of this function, see [Gio.BufferedInputStream.fill].
   * If count is -1 then the attempted read size is equal to the number
   * of bytes that are required to fill the buffer.
   * Params:
   *   count = the number of bytes that will be read from the stream
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object
   *   callback = a #GAsyncReadyCallback
   */
  void fillAsync(ptrdiff_t count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_buffered_input_stream_fill_async(cast(GBufferedInputStream*)cPtr, count, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous read.
   * Params:
   *   result = a #GAsyncResult
   * Returns: a #gssize of the read stream, or `-1` on an error.
   */
  ptrdiff_t fillFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_buffered_input_stream_fill_finish(cast(GBufferedInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the size of the available data within the stream.
   * Returns: size of the available stream.
   */
  size_t getAvailable()
  {
    size_t _retval;
    _retval = g_buffered_input_stream_get_available(cast(GBufferedInputStream*)cPtr);
    return _retval;
  }

  /**
   * Gets the size of the input buffer.
   * Returns: the current buffer size.
   */
  size_t getBufferSize()
  {
    size_t _retval;
    _retval = g_buffered_input_stream_get_buffer_size(cast(GBufferedInputStream*)cPtr);
    return _retval;
  }

  /**
   * Peeks in the buffer, copying data of size count into buffer,
   * offset offset bytes.
   * Params:
   *   buffer = a pointer to
   *     an allocated chunk of memory
   *   offset = a #gsize
   * Returns: a #gsize of the number of bytes peeked, or -1 on error.
   */
  size_t peek(ubyte[] buffer, size_t offset)
  {
    size_t _retval;
    size_t _count;
    if (buffer)
      _count = cast(size_t)buffer.length;

    auto _buffer = cast(void*)buffer.ptr;
    _retval = g_buffered_input_stream_peek(cast(GBufferedInputStream*)cPtr, _buffer, offset, _count);
    return _retval;
  }

  /**
   * Returns the buffer with the currently available bytes. The returned
   * buffer must not be modified and will become invalid when reading from
   * the stream or filling the buffer.
   * Returns: read-only buffer
   */
  ubyte[] peekBuffer()
  {
    void* _cretval;
    size_t _cretlength;
    _cretval = g_buffered_input_stream_peek_buffer(cast(GBufferedInputStream*)cPtr, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Tries to read a single byte from the stream or the buffer. Will block
   * during this read.
   * On success, the byte read from the stream is returned. On end of stream
   * -1 is returned but it's not an exceptional error and error is not set.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * On error -1 is returned and error is set accordingly.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore
   * Returns: the byte read from the stream, or -1 on end of stream or error.
   */
  int readByte(Cancellable cancellable)
  {
    int _retval;
    GError *_err;
    _retval = g_buffered_input_stream_read_byte(cast(GBufferedInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the size of the internal buffer of stream to size, or to the
   * size of the contents of the buffer. The buffer can never be resized
   * smaller than its current contents.
   * Params:
   *   size = a #gsize
   */
  void setBufferSize(size_t size)
  {
    g_buffered_input_stream_set_buffer_size(cast(GBufferedInputStream*)cPtr, size);
  }
}

module Gio.BufferedInputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
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
 *
 * By default, #GBufferedInputStream's buffer size is set at 4 kilobytes.
 *
 * To create a buffered input stream, use g_buffered_input_stream_new(),
 * or g_buffered_input_stream_new_sized() to specify the buffer's size at
 * construction.
 *
 * To get the size of a buffer within a buffered input stream, use
 * g_buffered_input_stream_get_buffer_size(). To change the size of a
 * buffered input stream's buffer, use
 * g_buffered_input_stream_set_buffer_size(). Note that the buffer's size
 * cannot be reduced below the size of the data within the buffer.
 */
class BufferedInputStream : FilterInputStream, Seekable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_buffered_input_stream_get_type();
  }

  mixin SeekableT!GBufferedInputStream;

  /**
   * a #GInputStream for the given @base_stream.
   */
  this(InputStream baseStream)
  {
    GInputStream* _cretval;
    _cretval = g_buffered_input_stream_new(baseStream ? baseStream.cPtr!GInputStream : null);
    this(_cretval, true);
  }

  /**
   * a #GInputStream.
   */
  static InputStream newSized(InputStream baseStream, size_t size)
  {
    GInputStream* _cretval;
    _cretval = g_buffered_input_stream_new_sized(baseStream ? baseStream.cPtr!GInputStream : null, size);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true);
    return _retval;
  }

  /**
   * the number of bytes read into @stream's buffer, up to @count,
   * or -1 on error.
   */
  ptrdiff_t fill(ptrdiff_t count, Cancellable cancellable)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_buffered_input_stream_fill(cPtr!GBufferedInputStream, count, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads data into @stream's buffer asynchronously, up to @count size.
   * @io_priority can be used to prioritize reads. For the synchronous
   * version of this function, see g_buffered_input_stream_fill().
   *
   * If @count is -1 then the attempted read size is equal to the number
   * of bytes that are required to fill the buffer.
   */
  void fillAsync(ptrdiff_t count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_buffered_input_stream_fill_async(cPtr!GBufferedInputStream, count, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #gssize of the read stream, or `-1` on an error.
   */
  ptrdiff_t fillFinish(AsyncResult result)
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_buffered_input_stream_fill_finish(cPtr!GBufferedInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * size of the available stream.
   */
  size_t getAvailable()
  {
    size_t _retval;
    _retval = g_buffered_input_stream_get_available(cPtr!GBufferedInputStream);
    return _retval;
  }

  /**
   * the current buffer size.
   */
  size_t getBufferSize()
  {
    size_t _retval;
    _retval = g_buffered_input_stream_get_buffer_size(cPtr!GBufferedInputStream);
    return _retval;
  }

  /**
   * a #gsize of the number of bytes peeked, or -1 on error.
   */
  size_t peek(ubyte[] buffer, size_t offset)
  {
    size_t _retval;
    auto _buffer = cast(void*)buffer.ptr;
    _retval = g_buffered_input_stream_peek(cPtr!GBufferedInputStream, _buffer, offset, buffer ? cast(size_t)buffer.length : 0);
    return _retval;
  }

  /**
   * read-only buffer
   */
  ubyte[] peekBuffer()
  {
    void* _cretval;
    size_t _cretlength;
    _cretval = g_buffered_input_stream_peek_buffer(cPtr!GBufferedInputStream, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * the byte read from the @stream, or -1 on end of stream or error.
   */
  int readByte(Cancellable cancellable)
  {
    int _retval;
    GError *_err;
    _retval = g_buffered_input_stream_read_byte(cPtr!GBufferedInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the size of the internal buffer of @stream to @size, or to the
   * size of the contents of the buffer. The buffer can never be resized
   * smaller than its current contents.
   */
  void setBufferSize(size_t size)
  {
    g_buffered_input_stream_set_buffer_size(cPtr!GBufferedInputStream, size);
  }
}

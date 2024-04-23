module Gio.BufferedOutputStream;

import GObject.ObjectG;
import Gid.Gid;
import Gio.FilterOutputStream;
import Gio.OutputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Buffered output stream implements #GFilterOutputStream and provides
 * for buffered writes.
 *
 * By default, #GBufferedOutputStream's buffer size is set at 4 kilobytes.
 *
 * To create a buffered output stream, use g_buffered_output_stream_new(),
 * or g_buffered_output_stream_new_sized() to specify the buffer's size
 * at construction.
 *
 * To get the size of a buffer within a buffered input stream, use
 * g_buffered_output_stream_get_buffer_size(). To change the size of a
 * buffered output stream's buffer, use
 * g_buffered_output_stream_set_buffer_size(). Note that the buffer's
 * size cannot be reduced below the size of the data within the buffer.
 */
class BufferedOutputStream : FilterOutputStream, Seekable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_buffered_output_stream_get_type();
  }

  mixin SeekableT!GBufferedOutputStream;

  /**
   * a #GOutputStream for the given @base_stream.
   */
  this(OutputStream baseStream)
  {
    GOutputStream* _cretval;
    _cretval = g_buffered_output_stream_new(baseStream ? baseStream.cPtr!GOutputStream : null);
    this(_cretval, true);
  }

  /**
   * a #GOutputStream with an internal buffer set to @size.
   */
  static OutputStream newSized(OutputStream baseStream, size_t size)
  {
    GOutputStream* _cretval;
    _cretval = g_buffered_output_stream_new_sized(baseStream ? baseStream.cPtr!GOutputStream : null, size);
    OutputStream _retval = ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the @stream's buffer automatically grows,
   * %FALSE otherwise.
   */
  bool getAutoGrow()
  {
    bool _retval;
    _retval = g_buffered_output_stream_get_auto_grow(cPtr!GBufferedOutputStream);
    return _retval;
  }

  /**
   * the current size of the buffer.
   */
  size_t getBufferSize()
  {
    size_t _retval;
    _retval = g_buffered_output_stream_get_buffer_size(cPtr!GBufferedOutputStream);
    return _retval;
  }

  /**
   * Sets whether or not the @stream's buffer should automatically grow.
   * If @auto_grow is true, then each write will just make the buffer
   * larger, and you must manually flush the buffer to actually write out
   * the data to the underlying stream.
   */
  void setAutoGrow(bool autoGrow)
  {
    g_buffered_output_stream_set_auto_grow(cPtr!GBufferedOutputStream, autoGrow);
  }

  /**
   * Sets the size of the internal buffer to @size.
   */
  void setBufferSize(size_t size)
  {
    g_buffered_output_stream_set_buffer_size(cPtr!GBufferedOutputStream, size);
  }
}

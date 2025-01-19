module Gio.BufferedOutputStream;

import GObject.ObjectG;
import Gid.gid;
import Gio.FilterOutputStream;
import Gio.OutputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Buffered output stream implements [Gio.FilterOutputStream] and provides
 * for buffered writes.
 * By default, `GBufferedOutputStream`'s buffer size is set at 4 kilobytes.
 * To create a buffered output stream, use [Gio.BufferedOutputStream.new_],
 * or [Gio.BufferedOutputStream.newSized] to specify the buffer's size
 * at construction.
 * To get the size of a buffer within a buffered input stream, use
 * [Gio.BufferedOutputStream.getBufferSize]. To change the size of a
 * buffered output stream's buffer, use [Gio.BufferedOutputStream.setBufferSize].
 * Note that the buffer's size cannot be reduced below the size of the data within the buffer.
 */
class BufferedOutputStream : FilterOutputStream, Seekable
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
    return g_buffered_output_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SeekableT!();

  /**
   * Creates a new buffered output stream for a base stream.
   * Params:
   *   baseStream = a #GOutputStream.
   * Returns: a #GOutputStream for the given base_stream.
   */
  this(OutputStream baseStream)
  {
    GOutputStream* _cretval;
    _cretval = g_buffered_output_stream_new(baseStream ? cast(GOutputStream*)baseStream.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Creates a new buffered output stream with a given buffer size.
   * Params:
   *   baseStream = a #GOutputStream.
   *   size = a #gsize.
   * Returns: a #GOutputStream with an internal buffer set to size.
   */
  static BufferedOutputStream newSized(OutputStream baseStream, size_t size)
  {
    GOutputStream* _cretval;
    _cretval = g_buffered_output_stream_new_sized(baseStream ? cast(GOutputStream*)baseStream.cPtr(false) : null, size);
    auto _retval = _cretval ? ObjectG.getDObject!BufferedOutputStream(cast(GOutputStream*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if the buffer automatically grows as data is added.
   * Returns: %TRUE if the stream's buffer automatically grows,
   *   %FALSE otherwise.
   */
  bool getAutoGrow()
  {
    bool _retval;
    _retval = g_buffered_output_stream_get_auto_grow(cast(GBufferedOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Gets the size of the buffer in the stream.
   * Returns: the current size of the buffer.
   */
  size_t getBufferSize()
  {
    size_t _retval;
    _retval = g_buffered_output_stream_get_buffer_size(cast(GBufferedOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Sets whether or not the stream's buffer should automatically grow.
   * If auto_grow is true, then each write will just make the buffer
   * larger, and you must manually flush the buffer to actually write out
   * the data to the underlying stream.
   * Params:
   *   autoGrow = a #gboolean.
   */
  void setAutoGrow(bool autoGrow)
  {
    g_buffered_output_stream_set_auto_grow(cast(GBufferedOutputStream*)cPtr, autoGrow);
  }

  /**
   * Sets the size of the internal buffer to size.
   * Params:
   *   size = a #gsize.
   */
  void setBufferSize(size_t size)
  {
    g_buffered_output_stream_set_buffer_size(cast(GBufferedOutputStream*)cPtr, size);
  }
}

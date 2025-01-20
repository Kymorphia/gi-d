module Gio.MemoryOutputStream;

import GLib.Bytes;
import GObject.ObjectG;
import Gid.gid;
import Gio.OutputStream;
import Gio.PollableOutputStream;
import Gio.PollableOutputStreamT;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GMemoryOutputStream` is a class for using arbitrary
 * memory chunks as output for GIO streaming output operations.
 * As of GLib 2.34, `GMemoryOutputStream` trivially implements
 * [Gio.PollableOutputStream]: it always polls as ready.
 */
class MemoryOutputStream : OutputStream, PollableOutputStream, Seekable
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
    return g_memory_output_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin PollableOutputStreamT!();
  mixin SeekableT!();

  /**
   * Creates a new #GMemoryOutputStream, using [GLib.Global.realloc] and [GLib.Global.gfree]
   * for memory allocation.
   * Returns:
   */
  static MemoryOutputStream newResizable()
  {
    GOutputStream* _cretval;
    _cretval = g_memory_output_stream_new_resizable();
    auto _retval = _cretval ? ObjectG.getDObject!MemoryOutputStream(cast(GOutputStream*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets any loaded data from the ostream.
   * Note that the returned pointer may become invalid on the next
   * write or truncate operation on the stream.
   * Returns: pointer to the stream's data, or %NULL if the data
   *   has been stolen
   */
  void* getData()
  {
    void* _retval;
    _retval = g_memory_output_stream_get_data(cast(GMemoryOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Returns the number of bytes from the start up to including the last
   * byte written in the stream that has not been truncated away.
   * Returns: the number of bytes written to the stream
   */
  size_t getDataSize()
  {
    size_t _retval;
    _retval = g_memory_output_stream_get_data_size(cast(GMemoryOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Gets the size of the currently allocated data area $(LPAREN)available from
   * [Gio.MemoryOutputStream.getData]$(RPAREN).
   * You probably don't want to use this function on resizable streams.
   * See [Gio.MemoryOutputStream.getDataSize] instead.  For resizable
   * streams the size returned by this function is an implementation
   * detail and may be change at any time in response to operations on the
   * stream.
   * If the stream is fixed-sized $(LPAREN)ie: no realloc was passed to
   * [Gio.MemoryOutputStream.new_]$(RPAREN) then this is the maximum size of the
   * stream and further writes will return %G_IO_ERROR_NO_SPACE.
   * In any case, if you want the number of bytes currently written to the
   * stream, use [Gio.MemoryOutputStream.getDataSize].
   * Returns: the number of bytes allocated for the data buffer
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_memory_output_stream_get_size(cast(GMemoryOutputStream*)cPtr);
    return _retval;
  }

  /**
   * Returns data from the ostream as a #GBytes. ostream must be
   * closed before calling this function.
   * Returns: the stream's data
   */
  Bytes stealAsBytes()
  {
    GBytes* _cretval;
    _cretval = g_memory_output_stream_steal_as_bytes(cast(GMemoryOutputStream*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets any loaded data from the ostream. Ownership of the data
   * is transferred to the caller; when no longer needed it must be
   * freed using the free function set in ostream's
   * #GMemoryOutputStream:destroy-function property.
   * ostream must be closed before calling this function.
   * Returns: the stream's data, or %NULL if it has previously
   *   been stolen
   */
  void* stealData()
  {
    void* _retval;
    _retval = g_memory_output_stream_steal_data(cast(GMemoryOutputStream*)cPtr);
    return _retval;
  }
}

module Gio.MemoryOutputStream;

import GLib.Bytes;
import GLib.Types;
import GObject.ObjectG;
import Gid.Gid;
import Gio.OutputStream;
import Gio.PollableOutputStream;
import Gio.PollableOutputStreamT;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMemoryOutputStream is a class for using arbitrary
 * memory chunks as output for GIO streaming output operations.
 *
 * As of GLib 2.34, #GMemoryOutputStream trivially implements
 * #GPollableOutputStream: it always polls as ready.
 */
class MemoryOutputStream : OutputStream, PollableOutputStream, Seekable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_memory_output_stream_get_type();
  }

  mixin PollableOutputStreamT!GMemoryOutputStream;
  mixin SeekableT!GMemoryOutputStream;

  /**
   * Creates a new #GMemoryOutputStream, using g_realloc() and g_free()
   * for memory allocation.
   */
  static OutputStream newResizable()
  {
    GOutputStream* _cretval;
    _cretval = g_memory_output_stream_new_resizable();
    OutputStream _retval = ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, true);
    return _retval;
  }

  /**
   * pointer to the stream's data, or %NULL if the data
   * has been stolen
   */
  void* getData()
  {
    void* _retval;
    _retval = g_memory_output_stream_get_data(cPtr!GMemoryOutputStream);
    return _retval;
  }

  /**
   * the number of bytes written to the stream
   */
  size_t getDataSize()
  {
    size_t _retval;
    _retval = g_memory_output_stream_get_data_size(cPtr!GMemoryOutputStream);
    return _retval;
  }

  /**
   * the number of bytes allocated for the data buffer
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_memory_output_stream_get_size(cPtr!GMemoryOutputStream);
    return _retval;
  }

  /**
   * the stream's data
   */
  Bytes stealAsBytes()
  {
    GBytes* _cretval;
    _cretval = g_memory_output_stream_steal_as_bytes(cPtr!GMemoryOutputStream);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * the stream's data, or %NULL if it has previously
   * been stolen
   */
  void* stealData()
  {
    void* _retval;
    _retval = g_memory_output_stream_steal_data(cPtr!GMemoryOutputStream);
    return _retval;
  }
}

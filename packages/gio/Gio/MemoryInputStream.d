module Gio.MemoryInputStream;

import GLib.Bytes;
import GLib.Types;
import GObject.ObjectG;
import Gid.Gid;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GMemoryInputStream is a class for using arbitrary
 * memory chunks as input for GIO streaming input operations.
 *
 * As of GLib 2.34, #GMemoryInputStream implements
 * #GPollableInputStream.
 */
class MemoryInputStream : InputStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_memory_input_stream_get_type();
  }

  /**
   * a new #GInputStream
   */
  this()
  {
    GInputStream* _cretval;
    _cretval = g_memory_input_stream_new();
    this(_cretval, true);
  }

  /**
   * new #GInputStream read from @bytes
   */
  static InputStream newFromBytes(Bytes bytes)
  {
    GInputStream* _cretval;
    _cretval = g_memory_input_stream_new_from_bytes(bytes ? bytes.cPtr!GBytes : null);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true);
    return _retval;
  }

  /**
   * Appends @bytes to data that can be read from the input stream.
   */
  void addBytes(Bytes bytes)
  {
    g_memory_input_stream_add_bytes(cPtr!GMemoryInputStream, bytes ? bytes.cPtr!GBytes : null);
  }
}

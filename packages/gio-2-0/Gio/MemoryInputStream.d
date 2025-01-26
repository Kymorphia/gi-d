module Gio.MemoryInputStream;

import Gid.gid;
import Gio.InputStream;
import Gio.PollableInputStream;
import Gio.PollableInputStreamT;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GMemoryInputStream` is a class for using arbitrary
 * memory chunks as input for GIO streaming input operations.
 * As of GLib 2.34, `GMemoryInputStream` implements
 * [Gio.PollableInputStream].
 */
class MemoryInputStream : InputStream, PollableInputStream, Seekable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_memory_input_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin PollableInputStreamT!();
  mixin SeekableT!();

  /**
   * Creates a new empty #GMemoryInputStream.
   * Returns: a new #GInputStream
   */
  this()
  {
    GInputStream* _cretval;
    _cretval = g_memory_input_stream_new();
    this(_cretval, true);
  }
}

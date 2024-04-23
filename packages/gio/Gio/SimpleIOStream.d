module Gio.SimpleIOStream;

import GObject.ObjectG;
import Gid.Gid;
import Gio.IOStream;
import Gio.InputStream;
import Gio.OutputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * GSimpleIOStream creates a #GIOStream from an arbitrary #GInputStream and
 * #GOutputStream. This allows any pair of input and output streams to be used
 * with #GIOStream methods.
 *
 * This is useful when you obtained a #GInputStream and a #GOutputStream
 * by other means, for instance creating them with platform specific methods as
 * g_unix_input_stream_new() or g_win32_input_stream_new(), and you want
 * to take advantage of the methods provided by #GIOStream.
 */
class SimpleIOStream : IOStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_simple_io_stream_get_type();
  }

  /**
   * a new #GSimpleIOStream instance.
   */
  this(InputStream inputStream, OutputStream outputStream)
  {
    GIOStream* _cretval;
    _cretval = g_simple_io_stream_new(inputStream ? inputStream.cPtr!GInputStream : null, outputStream ? outputStream.cPtr!GOutputStream : null);
    this(_cretval, true);
  }
}

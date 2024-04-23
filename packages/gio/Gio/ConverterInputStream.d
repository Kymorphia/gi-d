module Gio.ConverterInputStream;

import GObject.ObjectG;
import Gid.Gid;
import Gio.Converter;
import Gio.FilterInputStream;
import Gio.InputStream;
import Gio.PollableInputStream;
import Gio.PollableInputStreamT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Converter input stream implements #GInputStream and allows
 * conversion of data of various types during reading.
 *
 * As of GLib 2.34, #GConverterInputStream implements
 * #GPollableInputStream.
 */
class ConverterInputStream : FilterInputStream, PollableInputStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_converter_input_stream_get_type();
  }

  mixin PollableInputStreamT!GConverterInputStream;

  /**
   * a new #GInputStream.
   */
  this(InputStream baseStream, Converter converter)
  {
    GInputStream* _cretval;
    _cretval = g_converter_input_stream_new(baseStream ? baseStream.cPtr!GInputStream : null, converter ? (cast(ObjectG)converter).cPtr!GConverter : null);
    this(_cretval, true);
  }

  /**
   * the converter of the converter input stream
   */
  Converter getConverter()
  {
    GConverter* _cretval;
    _cretval = g_converter_input_stream_get_converter(cPtr!GConverterInputStream);
    Converter _retval = ObjectG.getDObject!Converter(cast(GConverter*)_cretval, false);
    return _retval;
  }
}

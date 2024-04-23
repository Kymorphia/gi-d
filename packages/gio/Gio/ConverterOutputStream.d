module Gio.ConverterOutputStream;

import GObject.ObjectG;
import Gid.Gid;
import Gio.Converter;
import Gio.FilterOutputStream;
import Gio.OutputStream;
import Gio.PollableOutputStream;
import Gio.PollableOutputStreamT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Converter output stream implements #GOutputStream and allows
 * conversion of data of various types during reading.
 *
 * As of GLib 2.34, #GConverterOutputStream implements
 * #GPollableOutputStream.
 */
class ConverterOutputStream : FilterOutputStream, PollableOutputStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_converter_output_stream_get_type();
  }

  mixin PollableOutputStreamT!GConverterOutputStream;

  /**
   * a new #GOutputStream.
   */
  this(OutputStream baseStream, Converter converter)
  {
    GOutputStream* _cretval;
    _cretval = g_converter_output_stream_new(baseStream ? baseStream.cPtr!GOutputStream : null, converter ? (cast(ObjectG)converter).cPtr!GConverter : null);
    this(_cretval, true);
  }

  /**
   * the converter of the converter output stream
   */
  Converter getConverter()
  {
    GConverter* _cretval;
    _cretval = g_converter_output_stream_get_converter(cPtr!GConverterOutputStream);
    Converter _retval = ObjectG.getDObject!Converter(cast(GConverter*)_cretval, false);
    return _retval;
  }
}

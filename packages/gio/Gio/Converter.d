module Gio.Converter;

import GLib.ErrorG;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GConverter is implemented by objects that convert
 * binary data in various ways. The conversion can be
 * stateful and may fail at any place.
 *
 * Some example conversions are: character set conversion,
 * compression, decompression and regular expression
 * replace.
 */
interface Converter
{

  static GType getType()
  {
    return g_converter_get_type();
  }

  /**
   * a #GConverterResult, %G_CONVERTER_ERROR on error.
   */
  ConverterResult convert(ubyte[] inbuf, ubyte[] outbuf, ConverterFlags flags, out size_t bytesRead, out size_t bytesWritten);

  /**
   * Resets all internal state in the converter, making it behave
   * as if it was just created. If the converter has any internal
   * state that would produce output then that output is lost.
   */
  void reset();
}

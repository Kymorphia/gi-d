module Gio.ConverterT;

public import GLib.ErrorG;
public import Gid.Gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GConverter is implemented by objects that convert
 * binary data in various ways. The conversion can be
 * stateful and may fail at any place.
 *
 * Some example conversions are: character set conversion,
 * compression, decompression and regular expression
 * replace.
 */
template ConverterT(TStruct)
{

  /**
   * a #GConverterResult, %G_CONVERTER_ERROR on error.
   */
  override ConverterResult convert(ubyte[] inbuf, ubyte[] outbuf, ConverterFlags flags, out size_t bytesRead, out size_t bytesWritten)
  {
    GConverterResult _cretval;
    auto _inbuf = cast(void*)inbuf.ptr;
    auto _outbuf = cast(void*)outbuf.ptr;
    GError *_err;
    _cretval = g_converter_convert(cPtr!GConverter, _inbuf, inbuf ? cast(size_t)inbuf.length : 0, _outbuf, outbuf ? cast(size_t)outbuf.length : 0, flags, cast(size_t*)&bytesRead, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new ErrorG(_err);
    ConverterResult _retval = cast(ConverterResult)_cretval;
    return _retval;
  }

  /**
   * Resets all internal state in the converter, making it behave
   * as if it was just created. If the converter has any internal
   * state that would produce output then that output is lost.
   */
  override void reset()
  {
    g_converter_reset(cPtr!GConverter);
  }
}

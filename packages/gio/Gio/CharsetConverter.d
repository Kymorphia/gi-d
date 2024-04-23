module Gio.CharsetConverter;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GCharsetConverter is an implementation of #GConverter based on
 * GIConv.
 */
class CharsetConverter : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_charset_converter_get_type();
  }

  /**
   * a new #GCharsetConverter or %NULL on error.
   */
  this(string toCharset, string fromCharset)
  {
    GCharsetConverter* _cretval;
    const(char)* _toCharset = toCharset.toCString(false);
    const(char)* _fromCharset = fromCharset.toCString(false);
    GError *_err;
    _cretval = g_charset_converter_new(_toCharset, _fromCharset, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, true);
  }

  /**
   * the number of fallbacks that @converter has applied
   */
  uint getNumFallbacks()
  {
    uint _retval;
    _retval = g_charset_converter_get_num_fallbacks(cPtr!GCharsetConverter);
    return _retval;
  }

  /**
   * %TRUE if fallbacks are used by @converter
   */
  bool getUseFallback()
  {
    bool _retval;
    _retval = g_charset_converter_get_use_fallback(cPtr!GCharsetConverter);
    return _retval;
  }

  /**
   * Sets the #GCharsetConverter:use-fallback property.
   */
  void setUseFallback(bool useFallback)
  {
    g_charset_converter_set_use_fallback(cPtr!GCharsetConverter, useFallback);
  }
}

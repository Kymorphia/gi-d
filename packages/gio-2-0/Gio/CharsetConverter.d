module Gio.CharsetConverter;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.Converter;
import Gio.ConverterT;
import Gio.Initable;
import Gio.InitableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GCharsetConverter` is an implementation of [Gio.Converter] based on
 * [GLib.IConv].
 */
class CharsetConverter : ObjectG, Converter, Initable
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
    return g_charset_converter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ConverterT!();
  mixin InitableT!();

  /**
   * Creates a new #GCharsetConverter.
   * Params:
   *   toCharset = destination charset
   *   fromCharset = source charset
   * Returns: a new #GCharsetConverter or %NULL on error.
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
   * Gets the number of fallbacks that converter has applied so far.
   * Returns: the number of fallbacks that converter has applied
   */
  uint getNumFallbacks()
  {
    uint _retval;
    _retval = g_charset_converter_get_num_fallbacks(cast(GCharsetConverter*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GCharsetConverter:use-fallback property.
   * Returns: %TRUE if fallbacks are used by converter
   */
  bool getUseFallback()
  {
    bool _retval;
    _retval = g_charset_converter_get_use_fallback(cast(GCharsetConverter*)cPtr);
    return _retval;
  }

  /**
   * Sets the #GCharsetConverter:use-fallback property.
   * Params:
   *   useFallback = %TRUE to use fallbacks
   */
  void setUseFallback(bool useFallback)
  {
    g_charset_converter_set_use_fallback(cast(GCharsetConverter*)cPtr, useFallback);
  }
}

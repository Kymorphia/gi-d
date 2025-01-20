module Gio.ZlibDecompressor;

import GObject.ObjectG;
import Gid.gid;
import Gio.Converter;
import Gio.ConverterT;
import Gio.FileInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GZlibDecompressor` is an implementation of [Gio.Converter] that
 * decompresses data compressed with zlib.
 */
class ZlibDecompressor : ObjectG, Converter
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
    return g_zlib_decompressor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ConverterT!();

  /**
   * Creates a new #GZlibDecompressor.
   * Params:
   *   format = The format to use for the compressed data
   * Returns: a new #GZlibDecompressor
   */
  this(ZlibCompressorFormat format)
  {
    GZlibDecompressor* _cretval;
    _cretval = g_zlib_decompressor_new(format);
    this(_cretval, true);
  }

  /**
   * Retrieves the #GFileInfo constructed from the GZIP header data
   * of compressed data processed by compressor, or %NULL if decompressor's
   * #GZlibDecompressor:format property is not %G_ZLIB_COMPRESSOR_FORMAT_GZIP,
   * or the header data was not fully processed yet, or it not present in the
   * data stream at all.
   * Returns: a #GFileInfo, or %NULL
   */
  FileInfo getFileInfo()
  {
    GFileInfo* _cretval;
    _cretval = g_zlib_decompressor_get_file_info(cast(GZlibDecompressor*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, false) : null;
    return _retval;
  }
}

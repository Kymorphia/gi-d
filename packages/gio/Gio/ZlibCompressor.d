module Gio.ZlibCompressor;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Converter;
import Gio.ConverterT;
import Gio.FileInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GZlibCompressor is an implementation of #GConverter that
 * compresses data using zlib.
 */
class ZlibCompressor : ObjectG, Converter
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_zlib_compressor_get_type();
  }

  mixin ConverterT!GZlibCompressor;

  /**
   * a new #GZlibCompressor
   */
  this(ZlibCompressorFormat format, int level)
  {
    GZlibCompressor* _cretval;
    _cretval = g_zlib_compressor_new(format, level);
    this(_cretval, true);
  }

  /**
   * a #GFileInfo, or %NULL
   */
  FileInfo getFileInfo()
  {
    GFileInfo* _cretval;
    _cretval = g_zlib_compressor_get_file_info(cPtr!GZlibCompressor);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, false);
    return _retval;
  }

  /**
   * Sets @file_info in @compressor. If non-%NULL, and @compressor's
   * #GZlibCompressor:format property is %G_ZLIB_COMPRESSOR_FORMAT_GZIP,
   * it will be used to set the file name and modification time in
   * the GZIP header of the compressed data.
   *
   * Note: it is an error to call this function while a compression is in
   * progress; it may only be called immediately after creation of @compressor,
   * or after resetting it with g_converter_reset().
   */
  void setFileInfo(FileInfo fileInfo)
  {
    g_zlib_compressor_set_file_info(cPtr!GZlibCompressor, fileInfo ? fileInfo.cPtr!GFileInfo : null);
  }
}

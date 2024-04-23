module Gio.ZlibDecompressor;

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
 * #GZlibDecompressor is an implementation of #GConverter that
 * decompresses data compressed with zlib.
 */
class ZlibDecompressor : ObjectG, Converter
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_zlib_decompressor_get_type();
  }

  mixin ConverterT!GZlibDecompressor;

  /**
   * a new #GZlibDecompressor
   */
  this(ZlibCompressorFormat format)
  {
    GZlibDecompressor* _cretval;
    _cretval = g_zlib_decompressor_new(format);
    this(_cretval, true);
  }

  /**
   * a #GFileInfo, or %NULL
   */
  FileInfo getFileInfo()
  {
    GFileInfo* _cretval;
    _cretval = g_zlib_decompressor_get_file_info(cPtr!GZlibDecompressor);
    FileInfo _retval = ObjectG.getDObject!FileInfo(cast(GFileInfo*)_cretval, false);
    return _retval;
  }
}

module Gdk.TextureDownloader;

import GLib.Boxed;
import GLib.Bytes;
import GObject.ObjectG;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The `GdkTextureDownloader` is used to download the contents of a
 * [Gdk.Texture].
 * It is intended to be created as a short-term object for a single download,
 * but can be used for multiple downloads of different textures or with different
 * settings.
 * `GdkTextureDownloader` can be used to convert data between different formats.
 * Create a `GdkTexture` for the existing format and then download it in a
 * different format.
 */
class TextureDownloader : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gdk_texture_downloader_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new texture downloader for texture.
   * Params:
   *   texture = texture to download
   * Returns: A new texture downloader
   */
  this(Texture texture)
  {
    GdkTextureDownloader* _cretval;
    _cretval = gdk_texture_downloader_new(texture ? cast(GdkTexture*)texture.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Creates a copy of the downloader.
   * This function is meant for language bindings.
   * Returns: A copy of the downloader
   */
  TextureDownloader copy()
  {
    GdkTextureDownloader* _cretval;
    _cretval = gdk_texture_downloader_copy(cast(GdkTextureDownloader*)cPtr);
    auto _retval = _cretval ? new TextureDownloader(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Downloads the given texture pixels into a `GBytes`. The rowstride will
   * be stored in the stride value.
   * This function will abort if it tries to download a large texture and
   * fails to allocate memory. If you think that may happen, you should handle
   * memory allocation yourself and use [Gdk.TextureDownloader.downloadInto]
   * once allocation succeeded.
   * Params:
   *   outStride = The stride of the resulting data in bytes
   * Returns: The downloaded pixels
   */
  Bytes downloadBytes(out size_t outStride)
  {
    GBytes* _cretval;
    _cretval = gdk_texture_downloader_download_bytes(cast(GdkTextureDownloader*)cPtr, cast(size_t*)&outStride);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the format that the data will be downloaded in.
   * Returns: The format of the download
   */
  MemoryFormat getFormat()
  {
    GdkMemoryFormat _cretval;
    _cretval = gdk_texture_downloader_get_format(cast(GdkTextureDownloader*)cPtr);
    MemoryFormat _retval = cast(MemoryFormat)_cretval;
    return _retval;
  }

  /**
   * Gets the texture that the downloader will download.
   * Returns: The texture to download
   */
  Texture getTexture()
  {
    GdkTexture* _cretval;
    _cretval = gdk_texture_downloader_get_texture(cast(GdkTextureDownloader*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the format the downloader will download.
   * By default, GDK_MEMORY_DEFAULT is set.
   * Params:
   *   format = the format to use
   */
  void setFormat(MemoryFormat format)
  {
    gdk_texture_downloader_set_format(cast(GdkTextureDownloader*)cPtr, format);
  }

  /**
   * Changes the texture the downloader will download.
   * Params:
   *   texture = the new texture to download
   */
  void setTexture(Texture texture)
  {
    gdk_texture_downloader_set_texture(cast(GdkTextureDownloader*)cPtr, texture ? cast(GdkTexture*)texture.cPtr(false) : null);
  }
}

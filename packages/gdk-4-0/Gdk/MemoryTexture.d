module Gdk.MemoryTexture;

import GLib.Bytes;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.Icon;
import Gio.IconT;
import Gio.LoadableIcon;
import Gio.LoadableIconT;

/**
 * A `GdkTexture` representing image data in memory.
 */
class MemoryTexture : Texture
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
    return gdk_memory_texture_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new texture for a blob of image data.
   * The `GBytes` must contain stride × height pixels
   * in the given format.
   * Params:
   *   width = the width of the texture
   *   height = the height of the texture
   *   format = the format of the data
   *   bytes = the `GBytes` containing the pixel data
   *   stride = rowstride for the data
   * Returns: A newly-created `GdkTexture`
   */
  this(int width, int height, MemoryFormat format, Bytes bytes, size_t stride)
  {
    GdkTexture* _cretval;
    _cretval = gdk_memory_texture_new(width, height, format, bytes ? cast(GBytes*)bytes.cPtr(false) : null, stride);
    this(_cretval, true);
  }
}

module Gdk.GLTexture;

import GLib.Types;
import Gdk.GLContext;
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
 * A GdkTexture representing a GL texture object.
 */
class GLTexture : Texture
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
    return gdk_gl_texture_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new texture for an existing GL texture.
   * Note that the GL texture must not be modified until destroy is called,
   * which will happen when the GdkTexture object is finalized, or due to
   * an explicit call of [Gdk.GLTexture.release].
   * Params:
   *   context = a `GdkGLContext`
   *   id = the ID of a texture that was created with context
   *   width = the nominal width of the texture
   *   height = the nominal height of the texture
   *   destroy = a destroy notify that will be called when the GL resources
   *     are released
   *   data = data that gets passed to destroy
   * Returns: A newly-created
   *   `GdkTexture`

   * Deprecated: [Gdk.GLTextureBuilder] supersedes this function
   *   and provides extended functionality for creating GL textures.
   */
  this(GLContext context, uint id, int width, int height, DestroyNotify destroy, void* data)
  {
    extern(C) void _destroyCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(DestroyNotify*)data;

      (*_dlg)();
    }

    GdkTexture* _cretval;
    _cretval = gdk_gl_texture_new(context ? cast(GdkGLContext*)context.cPtr(false) : null, id, width, height, &_destroyCallback, data);
    this(_cretval, true);
  }

  /**
   * Releases the GL resources held by a `GdkGLTexture`.
   * The texture contents are still available via the
   * [Gdk.Texture.download] function, after this
   * function has been called.
   */
  void release()
  {
    gdk_gl_texture_release(cast(GdkGLTexture*)cPtr);
  }
}

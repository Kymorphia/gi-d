module Gdk.GLTextureBuilder;

import GLib.Types;
import GObject.ObjectG;
import Gdk.GLContext;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import cairo.Region;

/**
 * `GdkGLTextureBuilder` is a builder used to construct [Gdk.Texture] objects from
 * GL textures.
 * The operation is quite simple: Create a texture builder, set all the necessary
 * properties - keep in mind that the properties [Gdk.GLTextureBuilder.context],
 * [Gdk.GLTextureBuilder.id], [Gdk.GLTextureBuilder.width], and
 * [Gdk.GLTextureBuilder.height] are mandatory - and then call
 * [Gdk.GLTextureBuilder.build] to create the new texture.
 * `GdkGLTextureBuilder` can be used for quick one-shot construction of
 * textures as well as kept around and reused to construct multiple textures.
 */
class GLTextureBuilder : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gdk_gl_texture_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new texture builder.
   * Returns: the new `GdkTextureBuilder`
   */
  this()
  {
    GdkGLTextureBuilder* _cretval;
    _cretval = gdk_gl_texture_builder_new();
    this(_cretval, true);
  }

  /**
   * Builds a new `GdkTexture` with the values set up in the builder.
   * The `destroy` function gets called when the returned texture gets released;
   * either when the texture is finalized or by an explicit call to
   * [Gdk.GLTexture.release]. It should release all GL resources associated
   * with the texture, such as the [Gdk.GLTextureBuilder.id] and the
   * [Gdk.GLTextureBuilder.sync].
   * Note that it is a programming error to call this function if any mandatory
   * property has not been set.
   * It is possible to call this function multiple times to create multiple textures,
   * possibly with changing properties in between.
   * Params:
   *   destroy = destroy function to be called when the texture is
   *     released
   *   data = user data to pass to the destroy function
   * Returns: a newly built `GdkTexture`
   */
  Texture build(DestroyNotify destroy, void* data)
  {
    extern(C) void _destroyCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(DestroyNotify*)data;

      (*_dlg)();
    }

    GdkTexture* _cretval;
    _cretval = gdk_gl_texture_builder_build(cast(GdkGLTextureBuilder*)cPtr, &_destroyCallback, data);
    auto _retval = _cretval ? ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the context previously set via [Gdk.GLTextureBuilder.setContext] or
   * %NULL if none was set.
   * Returns: The context
   */
  GLContext getContext()
  {
    GdkGLContext* _cretval;
    _cretval = gdk_gl_texture_builder_get_context(cast(GdkGLTextureBuilder*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!GLContext(cast(GdkGLContext*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the format previously set via [Gdk.GLTextureBuilder.setFormat].
   * Returns: The format
   */
  MemoryFormat getFormat()
  {
    GdkMemoryFormat _cretval;
    _cretval = gdk_gl_texture_builder_get_format(cast(GdkGLTextureBuilder*)cPtr);
    MemoryFormat _retval = cast(MemoryFormat)_cretval;
    return _retval;
  }

  /**
   * Gets whether the texture has a mipmap.
   * Returns: Whether the texture has a mipmap
   */
  bool getHasMipmap()
  {
    bool _retval;
    _retval = gdk_gl_texture_builder_get_has_mipmap(cast(GdkGLTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the height previously set via [Gdk.GLTextureBuilder.setHeight] or
   * 0 if the height wasn't set.
   * Returns: The height
   */
  int getHeight()
  {
    int _retval;
    _retval = gdk_gl_texture_builder_get_height(cast(GdkGLTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the texture id previously set via [Gdk.GLTextureBuilder.setId] or
   * 0 if the id wasn't set.
   * Returns: The id
   */
  uint getId()
  {
    uint _retval;
    _retval = gdk_gl_texture_builder_get_id(cast(GdkGLTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GLsync` previously set via [Gdk.GLTextureBuilder.setSync].
   * Returns: the `GLSync`
   */
  void* getSync()
  {
    void* _retval;
    _retval = gdk_gl_texture_builder_get_sync(cast(GdkGLTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the region previously set via [Gdk.GLTextureBuilder.setUpdateRegion] or
   * %NULL if none was set.
   * Returns: The region
   */
  Region getUpdateRegion()
  {
    cairo_region_t* _cretval;
    _cretval = gdk_gl_texture_builder_get_update_region(cast(GdkGLTextureBuilder*)cPtr);
    auto _retval = _cretval ? new Region(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the texture previously set via [Gdk.GLTextureBuilder.setUpdateTexture] or
   * %NULL if none was set.
   * Returns: The texture
   */
  Texture getUpdateTexture()
  {
    GdkTexture* _cretval;
    _cretval = gdk_gl_texture_builder_get_update_texture(cast(GdkGLTextureBuilder*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the width previously set via [Gdk.GLTextureBuilder.setWidth] or
   * 0 if the width wasn't set.
   * Returns: The width
   */
  int getWidth()
  {
    int _retval;
    _retval = gdk_gl_texture_builder_get_width(cast(GdkGLTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Sets the context to be used for the texture. This is the context that owns
   * the texture.
   * The context must be set before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   context = The context the texture beongs to or %NULL to unset
   */
  void setContext(GLContext context)
  {
    gdk_gl_texture_builder_set_context(cast(GdkGLTextureBuilder*)cPtr, context ? cast(GdkGLContext*)context.cPtr(false) : null);
  }

  /**
   * Sets the format of the texture. The default is `GDK_MEMORY_R8G8B8A8_PREMULTIPLIED`.
   * The format is the preferred format the texture data should be downloaded to. The
   * format must be supported by the GL version of [Gdk.GLTextureBuilder.context].
   * GDK's texture download code assumes that the format corresponds to the storage
   * parameters of the GL texture in an obvious way. For example, a format of
   * `GDK_MEMORY_R16G16B16A16_PREMULTIPLIED` is expected to be stored as `GL_RGBA16`
   * texture, and `GDK_MEMORY_G8A8` is expected to be stored as `GL_RG8` texture.
   * Setting the right format is particularly useful when using high bit depth textures
   * to preserve the bit depth, to set the correct value for unpremultiplied textures
   * and to make sure opaque textures are treated as such.
   * Non-RGBA textures need to have swizzling parameters set up properly to be usable
   * in GSK's shaders.
   * Params:
   *   format = The texture's format
   */
  void setFormat(MemoryFormat format)
  {
    gdk_gl_texture_builder_set_format(cast(GdkGLTextureBuilder*)cPtr, format);
  }

  /**
   * Sets whether the texture has a mipmap. This allows the renderer and other users of the
   * generated texture to use a higher quality downscaling.
   * Typically, the `glGenerateMipmap` function is used to generate a mimap.
   * Params:
   *   hasMipmap = Whether the texture has a mipmap
   */
  void setHasMipmap(bool hasMipmap)
  {
    gdk_gl_texture_builder_set_has_mipmap(cast(GdkGLTextureBuilder*)cPtr, hasMipmap);
  }

  /**
   * Sets the height of the texture.
   * The height must be set before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   height = The texture's height or 0 to unset
   */
  void setHeight(int height)
  {
    gdk_gl_texture_builder_set_height(cast(GdkGLTextureBuilder*)cPtr, height);
  }

  /**
   * Sets the texture id of the texture. The texture id must remain unmodified
   * until the texture was finalized. See [Gdk.GLTextureBuilder.build]
   * for a longer discussion.
   * The id must be set before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   id = The texture id to be used for creating the texture
   */
  void setId(uint id)
  {
    gdk_gl_texture_builder_set_id(cast(GdkGLTextureBuilder*)cPtr, id);
  }

  /**
   * Sets the GLSync object to use for the texture.
   * GTK will wait on this object before using the created `GdkTexture`.
   * The `destroy` function that is passed to [Gdk.GLTextureBuilder.build]
   * is responsible for freeing the sync object when it is no longer needed.
   * The texture builder does not destroy it and it is the callers
   * responsibility to make sure it doesn't leak.
   * Params:
   *   sync = the GLSync object
   */
  void setSync(void* sync)
  {
    gdk_gl_texture_builder_set_sync(cast(GdkGLTextureBuilder*)cPtr, sync);
  }

  /**
   * Sets the region to be updated by this texture. Together with
   * propertyGdk.GLTextureBuilder:update-texture this describes an
   * update of a previous texture.
   * When rendering animations of large textures, it is possible that
   * consecutive textures are only updating contents in parts of the texture.
   * It is then possible to describe this update via these two properties,
   * so that GTK can avoid rerendering parts that did not change.
   * An example would be a screen recording where only the mouse pointer moves.
   * Params:
   *   region = the region to update
   */
  void setUpdateRegion(Region region)
  {
    gdk_gl_texture_builder_set_update_region(cast(GdkGLTextureBuilder*)cPtr, region ? cast(cairo_region_t*)region.cPtr(false) : null);
  }

  /**
   * Sets the texture to be updated by this texture. See
   * [Gdk.GLTextureBuilder.setUpdateRegion] for an explanation.
   * Params:
   *   texture = the texture to update
   */
  void setUpdateTexture(Texture texture)
  {
    gdk_gl_texture_builder_set_update_texture(cast(GdkGLTextureBuilder*)cPtr, texture ? cast(GdkTexture*)texture.cPtr(false) : null);
  }

  /**
   * Sets the width of the texture.
   * The width must be set before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   width = The texture's width or 0 to unset
   */
  void setWidth(int width)
  {
    gdk_gl_texture_builder_set_width(cast(GdkGLTextureBuilder*)cPtr, width);
  }
}

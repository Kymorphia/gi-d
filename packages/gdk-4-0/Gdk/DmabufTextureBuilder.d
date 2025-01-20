module Gdk.DmabufTextureBuilder;

import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import Gdk.Display;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import cairo.Region;

/**
 * `GdkDmabufTextureBuilder` is a builder used to construct [Gdk.Texture]
 * objects from DMA buffers.
 * DMA buffers are commonly called **_dma-bufs_**.
 * DMA buffers are a feature of the Linux kernel to enable efficient buffer and
 * memory sharing between hardware such as codecs, GPUs, displays, cameras and the
 * kernel drivers controlling them. For example, a decoder may want its output to
 * be directly shared with the display server for rendering without a copy.
 * Any device driver which participates in DMA buffer sharing, can do so as either
 * the exporter or importer of buffers $(LPAREN)or both$(RPAREN).
 * The memory that is shared via DMA buffers is usually stored in non-system memory
 * $(LPAREN)maybe in device's local memory or something else not directly accessible by the
 * CPU$(RPAREN), and accessing this memory from the CPU may have higher-than-usual overhead.
 * In particular for graphics data, it is not uncommon that data consists of multiple
 * separate blocks of memory, for example one block for each of the red, green and
 * blue channels. These blocks are called **_planes_**. DMA buffers can have up to
 * four planes. Even if the memory is a single block, the data can be organized in
 * multiple planes, by specifying offsets from the beginning of the data.
 * DMA buffers are exposed to user-space as file descriptors allowing to pass them
 * between processes. If a DMA buffer has multiple planes, there is one file
 * descriptor per plane.
 * The format of the data $(LPAREN)for graphics data, essentially its colorspace$(RPAREN) is described
 * by a 32-bit integer. These format identifiers are defined in the header file `drm_fourcc.h`
 * and commonly referred to as **_fourcc_** values, since they are identified by 4 ASCII
 * characters. Additionally, each DMA buffer has a **_modifier_**, which is a 64-bit integer
 * that describes driver-specific details of the memory layout, such as tiling or compression.
 * For historical reasons, some producers of dma-bufs don't provide an explicit modifier, but
 * instead return `DMA_FORMAT_MOD_INVALID` to indicate that their modifier is **_implicit_**.
 * GTK tries to accommodate this situation by accepting `DMA_FORMAT_MOD_INVALID` as modifier.
 * The operation of `GdkDmabufTextureBuilder` is quite simple: Create a texture builder,
 * set all the necessary properties, and then call [Gdk.DmabufTextureBuilder.build]
 * to create the new texture.
 * The required properties for a dma-buf texture are
 * * The width and height in pixels
 * * The `fourcc` code and `modifier` which identify the format and memory layout of the dma-buf
 * * The file descriptor, offset and stride for each of the planes
 * `GdkDmabufTextureBuilder` can be used for quick one-shot construction of
 * textures as well as kept around and reused to construct multiple textures.
 * For further information, see
 * * The Linux kernel [documentation](https://docs.kernel.org/driver-api/dma-buf.html)
 * * The header file [drm_fourcc.h](https://gitlab.freedesktop.org/mesa/drm/-/blob/main/include/drm/drm_fourcc.h)
 */
class DmabufTextureBuilder : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gdk_dmabuf_texture_builder_get_type();
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
    GdkDmabufTextureBuilder* _cretval;
    _cretval = gdk_dmabuf_texture_builder_new();
    this(_cretval, true);
  }

  /**
   * Builds a new `GdkTexture` with the values set up in the builder.
   * It is a programming error to call this function if any mandatory
   * property has not been set.
   * If the dmabuf is not supported by GTK, %NULL will be returned and error will be set.
   * The `destroy` function gets called when the returned texture gets released.
   * It is possible to call this function multiple times to create multiple textures,
   * possibly with changing properties in between.
   * It is the responsibility of the caller to keep the file descriptors for the planes
   * open until the created texture is no longer used, and close them afterwards $(LPAREN)possibly
   * using the destroy notify$(RPAREN).
   * Not all formats defined in the `drm_fourcc.h` header are supported. You can use
   * [Gdk.Display.getDmabufFormats] to get a list of supported formats.
   * Params:
   *   destroy = destroy function to be called when the texture is
   *     released
   *   data = user data to pass to the destroy function
   * Returns: a newly built `GdkTexture` or `NULL`
   *   if the format is not supported
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
    GError *_err;
    _cretval = gdk_dmabuf_texture_builder_build(cast(GdkDmabufTextureBuilder*)cPtr, &_destroyCallback, data, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the display that this texture builder is
   * associated with.
   * Returns: the display
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_dmabuf_texture_builder_get_display(cast(GdkDmabufTextureBuilder*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the file descriptor for a plane.
   * Params:
   *   plane = the plane to get the fd for
   * Returns: the file descriptor
   */
  int getFd(uint plane)
  {
    int _retval;
    _retval = gdk_dmabuf_texture_builder_get_fd(cast(GdkDmabufTextureBuilder*)cPtr, plane);
    return _retval;
  }

  /**
   * Gets the format previously set via [Gdk.DmabufTextureBuilder.setFourcc]
   * or 0 if the format wasn't set.
   * The format is specified as a fourcc code.
   * Returns: The format
   */
  uint getFourcc()
  {
    uint _retval;
    _retval = gdk_dmabuf_texture_builder_get_fourcc(cast(GdkDmabufTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the height previously set via [Gdk.DmabufTextureBuilder.setHeight] or
   * 0 if the height wasn't set.
   * Returns: The height
   */
  uint getHeight()
  {
    uint _retval;
    _retval = gdk_dmabuf_texture_builder_get_height(cast(GdkDmabufTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the modifier value.
   * Returns: the modifier
   */
  ulong getModifier()
  {
    ulong _retval;
    _retval = gdk_dmabuf_texture_builder_get_modifier(cast(GdkDmabufTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the number of planes.
   * Returns: The number of planes
   */
  uint getNPlanes()
  {
    uint _retval;
    _retval = gdk_dmabuf_texture_builder_get_n_planes(cast(GdkDmabufTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the offset value for a plane.
   * Params:
   *   plane = the plane to get the offset for
   * Returns: the offset
   */
  uint getOffset(uint plane)
  {
    uint _retval;
    _retval = gdk_dmabuf_texture_builder_get_offset(cast(GdkDmabufTextureBuilder*)cPtr, plane);
    return _retval;
  }

  /**
   * Whether the data is premultiplied.
   * Returns: whether the data is premultiplied
   */
  bool getPremultiplied()
  {
    bool _retval;
    _retval = gdk_dmabuf_texture_builder_get_premultiplied(cast(GdkDmabufTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Gets the stride value for a plane.
   * Params:
   *   plane = the plane to get the stride for
   * Returns: the stride
   */
  uint getStride(uint plane)
  {
    uint _retval;
    _retval = gdk_dmabuf_texture_builder_get_stride(cast(GdkDmabufTextureBuilder*)cPtr, plane);
    return _retval;
  }

  /**
   * Gets the region previously set via [Gdk.DmabufTextureBuilder.setUpdateRegion] or
   * %NULL if none was set.
   * Returns: The region
   */
  Region getUpdateRegion()
  {
    cairo_region_t* _cretval;
    _cretval = gdk_dmabuf_texture_builder_get_update_region(cast(GdkDmabufTextureBuilder*)cPtr);
    auto _retval = _cretval ? new Region(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the texture previously set via [Gdk.DmabufTextureBuilder.setUpdateTexture] or
   * %NULL if none was set.
   * Returns: The texture
   */
  Texture getUpdateTexture()
  {
    GdkTexture* _cretval;
    _cretval = gdk_dmabuf_texture_builder_get_update_texture(cast(GdkDmabufTextureBuilder*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the width previously set via [Gdk.DmabufTextureBuilder.setWidth] or
   * 0 if the width wasn't set.
   * Returns: The width
   */
  uint getWidth()
  {
    uint _retval;
    _retval = gdk_dmabuf_texture_builder_get_width(cast(GdkDmabufTextureBuilder*)cPtr);
    return _retval;
  }

  /**
   * Sets the display that this texture builder is
   * associated with.
   * The display is used to determine the supported
   * dma-buf formats.
   * Params:
   *   display = the display
   */
  void setDisplay(Display display)
  {
    gdk_dmabuf_texture_builder_set_display(cast(GdkDmabufTextureBuilder*)cPtr, display ? cast(GdkDisplay*)display.cPtr(false) : null);
  }

  /**
   * Sets the file descriptor for a plane.
   * Params:
   *   plane = the plane to set the fd for
   *   fd = the file descriptor
   */
  void setFd(uint plane, int fd)
  {
    gdk_dmabuf_texture_builder_set_fd(cast(GdkDmabufTextureBuilder*)cPtr, plane, fd);
  }

  /**
   * Sets the format of the texture.
   * The format is specified as a fourcc code.
   * The format must be set before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   fourcc = the texture's format or 0 to unset
   */
  void setFourcc(uint fourcc)
  {
    gdk_dmabuf_texture_builder_set_fourcc(cast(GdkDmabufTextureBuilder*)cPtr, fourcc);
  }

  /**
   * Sets the height of the texture.
   * The height must be set before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   height = the texture's height or 0 to unset
   */
  void setHeight(uint height)
  {
    gdk_dmabuf_texture_builder_set_height(cast(GdkDmabufTextureBuilder*)cPtr, height);
  }

  /**
   * Sets the modifier.
   * Params:
   *   modifier = the modifier value
   */
  void setModifier(ulong modifier)
  {
    gdk_dmabuf_texture_builder_set_modifier(cast(GdkDmabufTextureBuilder*)cPtr, modifier);
  }

  /**
   * Sets the number of planes of the texture.
   * Params:
   *   nPlanes = the number of planes
   */
  void setNPlanes(uint nPlanes)
  {
    gdk_dmabuf_texture_builder_set_n_planes(cast(GdkDmabufTextureBuilder*)cPtr, nPlanes);
  }

  /**
   * Sets the offset for a plane.
   * Params:
   *   plane = the plane to set the offset for
   *   offset = the offset value
   */
  void setOffset(uint plane, uint offset)
  {
    gdk_dmabuf_texture_builder_set_offset(cast(GdkDmabufTextureBuilder*)cPtr, plane, offset);
  }

  /**
   * Sets whether the data is premultiplied.
   * Unless otherwise specified, all formats including alpha channels are assumed
   * to be premultiplied.
   * Params:
   *   premultiplied = whether the data is premultiplied
   */
  void setPremultiplied(bool premultiplied)
  {
    gdk_dmabuf_texture_builder_set_premultiplied(cast(GdkDmabufTextureBuilder*)cPtr, premultiplied);
  }

  /**
   * Sets the stride for a plane.
   * The stride must be set for all planes before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   plane = the plane to set the stride for
   *   stride = the stride value
   */
  void setStride(uint plane, uint stride)
  {
    gdk_dmabuf_texture_builder_set_stride(cast(GdkDmabufTextureBuilder*)cPtr, plane, stride);
  }

  /**
   * Sets the region to be updated by this texture. Together with
   * propertyGdk.DmabufTextureBuilder:update-texture this describes an
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
    gdk_dmabuf_texture_builder_set_update_region(cast(GdkDmabufTextureBuilder*)cPtr, region ? cast(cairo_region_t*)region.cPtr(false) : null);
  }

  /**
   * Sets the texture to be updated by this texture. See
   * [Gdk.DmabufTextureBuilder.setUpdateRegion] for an explanation.
   * Params:
   *   texture = the texture to update
   */
  void setUpdateTexture(Texture texture)
  {
    gdk_dmabuf_texture_builder_set_update_texture(cast(GdkDmabufTextureBuilder*)cPtr, texture ? cast(GdkTexture*)texture.cPtr(false) : null);
  }

  /**
   * Sets the width of the texture.
   * The width must be set before calling [Gdk.GLTextureBuilder.build].
   * Params:
   *   width = The texture's width or 0 to unset
   */
  void setWidth(uint width)
  {
    gdk_dmabuf_texture_builder_set_width(cast(GdkDmabufTextureBuilder*)cPtr, width);
  }
}

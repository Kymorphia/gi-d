module GdkPixbuf.PixbufLoader;

import GLib.Bytes;
import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GdkPixbuf.Pixbuf;
import GdkPixbuf.PixbufAnimation;
import GdkPixbuf.PixbufFormat;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

/**
 * Incremental image loader.
 * `GdkPixbufLoader` provides a way for applications to drive the
 * process of loading an image, by letting them send the image data
 * directly to the loader instead of having the loader read the data
 * from a file. Applications can use this functionality instead of
 * `[GdkPixbuf.Pixbuf.newFromFile]` or `[GdkPixbuf.PixbufAnimation.newFromFile]`
 * when they need to parse image data in small chunks. For example,
 * it should be used when reading an image from a $(LPAREN)potentially$(RPAREN) slow
 * network connection, or when loading an extremely large file.
 * To use `GdkPixbufLoader` to load an image, create a new instance,
 * and call [GdkPixbuf.PixbufLoader.write] to send the data
 * to it. When done, [GdkPixbuf.PixbufLoader.close] should be
 * called to end the stream and finalize everything.
 * The loader will emit three important signals throughout the process:
 * - signal@GdkPixbuf.PixbufLoader::size-prepared will be emitted as
 * soon as the image has enough information to determine the size of
 * the image to be used. If you want to scale the image while loading
 * it, you can call [GdkPixbuf.PixbufLoader.setSize] in
 * response to this signal.
 * - signal@GdkPixbuf.PixbufLoader::area-prepared will be emitted as
 * soon as the pixbuf of the desired has been allocated. You can obtain
 * the `GdkPixbuf` instance by calling [GdkPixbuf.PixbufLoader.getPixbuf].
 * If you want to use it, simply acquire a reference to it. You can
 * also call `[GdkPixbuf.PixbufLoader.getPixbuf]` later to get the same
 * pixbuf.
 * - signal@GdkPixbuf.PixbufLoader::area-updated will be emitted every
 * time a region is updated. This way you can update a partially
 * completed image. Note that you do not know anything about the
 * completeness of an image from the updated area. For example, in an
 * interlaced image you will need to make several passes before the
 * image is done loading.
 * ## Loading an animation
 * Loading an animation is almost as easy as loading an image. Once the
 * first signal@GdkPixbuf.PixbufLoader::area-prepared signal has been
 * emitted, you can call [GdkPixbuf.PixbufLoader.getAnimation] to
 * get the [GdkPixbuf.PixbufAnimation] instance, and then call
 * and [GdkPixbuf.PixbufAnimation.getIter] to get a
 * [GdkPixbuf.PixbufAnimationIter] to retrieve the pixbuf for the
 * desired time stamp.
 */
class PixbufLoader : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gdk_pixbuf_loader_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new pixbuf loader object.
   * Returns: A newly-created pixbuf loader.
   */
  this()
  {
    GdkPixbufLoader* _cretval;
    _cretval = gdk_pixbuf_loader_new();
    this(_cretval, true);
  }

  /**
   * Creates a new pixbuf loader object that always attempts to parse
   * image data as if it were an image of MIME type mime_type, instead of
   * identifying the type automatically.
   * This function is useful if you want an error if the image isn't the
   * expected MIME type; for loading image formats that can't be reliably
   * identified by looking at the data; or if the user manually forces a
   * specific MIME type.
   * The list of supported mime types depends on what image loaders
   * are installed, but typically "image/png", "image/jpeg", "image/gif",
   * "image/tiff" and "image/x-xpixmap" are among the supported mime types.
   * To obtain the full list of supported mime types, call
   * [GdkPixbuf.PixbufFormat.getMimeTypes] on each of the #GdkPixbufFormat
   * structs returned by [GdkPixbuf.Pixbuf.getFormats].
   * Params:
   *   mimeType = the mime type to be loaded
   * Returns: A newly-created pixbuf loader.
   */
  static PixbufLoader newWithMimeType(string mimeType)
  {
    GdkPixbufLoader* _cretval;
    const(char)* _mimeType = mimeType.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_loader_new_with_mime_type(_mimeType, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufLoader(cast(GdkPixbufLoader*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf loader object that always attempts to parse
   * image data as if it were an image of type image_type, instead of
   * identifying the type automatically.
   * This function is useful if you want an error if the image isn't the
   * expected type; for loading image formats that can't be reliably
   * identified by looking at the data; or if the user manually forces
   * a specific type.
   * The list of supported image formats depends on what image loaders
   * are installed, but typically "png", "jpeg", "gif", "tiff" and
   * "xpm" are among the supported formats. To obtain the full list of
   * supported image formats, call [GdkPixbuf.PixbufFormat.getName] on each
   * of the #GdkPixbufFormat structs returned by [GdkPixbuf.Pixbuf.getFormats].
   * Params:
   *   imageType = name of the image format to be loaded with the image
   * Returns: A newly-created pixbuf loader.
   */
  static PixbufLoader newWithType(string imageType)
  {
    GdkPixbufLoader* _cretval;
    const(char)* _imageType = imageType.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_loader_new_with_type(_imageType, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufLoader(cast(GdkPixbufLoader*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Informs a pixbuf loader that no further writes with
   * [GdkPixbuf.PixbufLoader.write] will occur, so that it can free its
   * internal loading structures.
   * This function also tries to parse any data that hasn't yet been parsed;
   * if the remaining data is partial or corrupt, an error will be returned.
   * If `FALSE` is returned, `error` will be set to an error from the
   * `GDK_PIXBUF_ERROR` or `G_FILE_ERROR` domains.
   * If you're just cancelling a load rather than expecting it to be finished,
   * passing `NULL` for `error` to ignore it is reasonable.
   * Remember that this function does not release a reference on the loader, so
   * you will need to explicitly release any reference you hold.
   * Returns: `TRUE` if all image data written so far was successfully
   *   passed out via the update_area signal
   */
  bool close()
  {
    bool _retval;
    GError *_err;
    _retval = gdk_pixbuf_loader_close(cast(GdkPixbufLoader*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Queries the #GdkPixbufAnimation that a pixbuf loader is currently creating.
   * In general it only makes sense to call this function after the
   * signalGdkPixbuf.PixbufLoader::area-prepared signal has been emitted by
   * the loader.
   * If the loader doesn't have enough bytes yet, and hasn't emitted the `area-prepared`
   * signal, this function will return `NULL`.
   * Returns: The animation that the loader is
   *   currently loading
   */
  PixbufAnimation getAnimation()
  {
    GdkPixbufAnimation* _cretval;
    _cretval = gdk_pixbuf_loader_get_animation(cast(GdkPixbufLoader*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufAnimation(cast(GdkPixbufAnimation*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the available information about the format of the
   * currently loading image file.
   * Returns: A #GdkPixbufFormat
   */
  PixbufFormat getFormat()
  {
    GdkPixbufFormat* _cretval;
    _cretval = gdk_pixbuf_loader_get_format(cast(GdkPixbufLoader*)cPtr);
    auto _retval = _cretval ? new PixbufFormat(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Queries the #GdkPixbuf that a pixbuf loader is currently creating.
   * In general it only makes sense to call this function after the
   * signalGdkPixbuf.PixbufLoader::area-prepared signal has been
   * emitted by the loader; this means that enough data has been read
   * to know the size of the image that will be allocated.
   * If the loader has not received enough data via [GdkPixbuf.PixbufLoader.write],
   * then this function returns `NULL`.
   * The returned pixbuf will be the same in all future calls to the loader,
   * so if you want to keep using it, you should acquire a reference to it.
   * Additionally, if the loader is an animation, it will return the "static
   * image" of the animation $(LPAREN)see [GdkPixbuf.PixbufAnimation.getStaticImage]$(RPAREN).
   * Returns: The pixbuf that the loader is
   *   creating
   */
  Pixbuf getPixbuf()
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_loader_get_pixbuf(cast(GdkPixbufLoader*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Causes the image to be scaled while it is loaded.
   * The desired image size can be determined relative to the original
   * size of the image by calling [GdkPixbuf.PixbufLoader.setSize] from a
   * signal handler for the ::size-prepared signal.
   * Attempts to set the desired image size  are ignored after the
   * emission of the ::size-prepared signal.
   * Params:
   *   width = The desired width of the image being loaded.
   *   height = The desired height of the image being loaded.
   */
  void setSize(int width, int height)
  {
    gdk_pixbuf_loader_set_size(cast(GdkPixbufLoader*)cPtr, width, height);
  }

  /**
   * Parses the next `count` bytes in the given image buffer.
   * Params:
   *   buf = Pointer to image data.
   * Returns: `TRUE` if the write was successful, or
   *   `FALSE` if the loader cannot parse the buffer
   */
  bool write(ubyte[] buf)
  {
    bool _retval;
    size_t _count;
    if (buf)
      _count = cast(size_t)buf.length;

    auto _buf = cast(const(ubyte)*)buf.ptr;
    GError *_err;
    _retval = gdk_pixbuf_loader_write(cast(GdkPixbufLoader*)cPtr, _buf, _count, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Parses the next contents of the given image buffer.
   * Params:
   *   buffer = The image data as a `GBytes` buffer.
   * Returns: `TRUE` if the write was successful, or `FALSE` if
   *   the loader cannot parse the buffer
   */
  bool writeBytes(Bytes buffer)
  {
    bool _retval;
    GError *_err;
    _retval = gdk_pixbuf_loader_write_bytes(cast(GdkPixbufLoader*)cPtr, buffer ? cast(GBytes*)buffer.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * This signal is emitted when the pixbuf loader has allocated the
   * pixbuf in the desired size.
   * After this signal is emitted, applications can call
   * [GdkPixbuf.PixbufLoader.getPixbuf] to fetch the partially-loaded
   * pixbuf.
   *   pixbufLoader = the instance the signal is connected to
   */
  alias AreaPreparedCallback = void delegate(PixbufLoader pixbufLoader);

  /**
   * Connect to AreaPrepared signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectAreaPrepared(AreaPreparedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto pixbufLoader = getVal!PixbufLoader(_paramVals);
      _dgClosure.dlg(pixbufLoader);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("area-prepared", closure, after);
  }

  /**
   * This signal is emitted when a significant area of the image being
   * loaded has been updated.
   * Normally it means that a complete scanline has been read in, but
   * it could be a different area as well.
   * Applications can use this signal to know when to repaint
   * areas of an image that is being loaded.
   * Params
   *   x = X offset of upper-left corner of the updated area.
   *   y = Y offset of upper-left corner of the updated area.
   *   width = Width of updated area.
   *   height = Height of updated area.
   *   pixbufLoader = the instance the signal is connected to
   */
  alias AreaUpdatedCallback = void delegate(int x, int y, int width, int height, PixbufLoader pixbufLoader);

  /**
   * Connect to AreaUpdated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectAreaUpdated(AreaUpdatedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto pixbufLoader = getVal!PixbufLoader(_paramVals);
      auto x = getVal!int(&_paramVals[1]);
      auto y = getVal!int(&_paramVals[2]);
      auto width = getVal!int(&_paramVals[3]);
      auto height = getVal!int(&_paramVals[4]);
      _dgClosure.dlg(x, y, width, height, pixbufLoader);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("area-updated", closure, after);
  }

  /**
   * This signal is emitted when [GdkPixbuf.PixbufLoader.close] is called.
   * It can be used by different parts of an application to receive
   * notification when an image loader is closed by the code that
   * drives it.
   *   pixbufLoader = the instance the signal is connected to
   */
  alias ClosedCallback = void delegate(PixbufLoader pixbufLoader);

  /**
   * Connect to Closed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectClosed(ClosedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto pixbufLoader = getVal!PixbufLoader(_paramVals);
      _dgClosure.dlg(pixbufLoader);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("closed", closure, after);
  }

  /**
   * This signal is emitted when the pixbuf loader has been fed the
   * initial amount of data that is required to figure out the size
   * of the image that it will create.
   * Applications can call [GdkPixbuf.PixbufLoader.setSize] in response
   * to this signal to set the desired size to which the image
   * should be scaled.
   * Params
   *   width = the original width of the image
   *   height = the original height of the image
   *   pixbufLoader = the instance the signal is connected to
   */
  alias SizePreparedCallback = void delegate(int width, int height, PixbufLoader pixbufLoader);

  /**
   * Connect to SizePrepared signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSizePrepared(SizePreparedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto pixbufLoader = getVal!PixbufLoader(_paramVals);
      auto width = getVal!int(&_paramVals[1]);
      auto height = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(width, height, pixbufLoader);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("size-prepared", closure, after);
  }
}

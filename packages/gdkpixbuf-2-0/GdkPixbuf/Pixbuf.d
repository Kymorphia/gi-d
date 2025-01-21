module GdkPixbuf.Pixbuf;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.SList;
import GObject.ObjectG;
import GdkPixbuf.PixbufFormat;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Icon;
import Gio.IconT;
import Gio.InputStream;
import Gio.LoadableIcon;
import Gio.LoadableIconT;
import Gio.OutputStream;
import Gio.Types;

/**
 * A pixel buffer.
 * `GdkPixbuf` contains information about an image's pixel data,
 * its color space, bits per sample, width and height, and the
 * rowstride $(LPAREN)the number of bytes between the start of one row
 * and the start of the next$(RPAREN).
 * ## Creating new `GdkPixbuf`
 * The most basic way to create a pixbuf is to wrap an existing pixel
 * buffer with a [GdkPixbuf.Pixbuf] instance. You can use the
 * [GdkPixbuf.Pixbuf.newFromData] function to do this.
 * Every time you create a new `GdkPixbuf` instance for some data, you
 * will need to specify the destroy notification function that will be
 * called when the data buffer needs to be freed; this will happen when
 * a `GdkPixbuf` is finalized by the reference counting functions. If
 * you have a chunk of static data compiled into your application, you
 * can pass in `NULL` as the destroy notification function so that the
 * data will not be freed.
 * The [GdkPixbuf.Pixbuf.new_] constructor function can be used
 * as a convenience to create a pixbuf with an empty buffer; this is
 * equivalent to allocating a data buffer using `malloc$(LPAREN)$(RPAREN)` and then
 * wrapping it with `[GdkPixbuf.Pixbuf.newFromData]`. The `[GdkPixbuf.Pixbuf.new_]`
 * function will compute an optimal rowstride so that rendering can be
 * performed with an efficient algorithm.
 * As a special case, you can use the [GdkPixbuf.Pixbuf.newFromXpmData]
 * function to create a pixbuf from inline XPM image data.
 * You can also copy an existing pixbuf with the [GdkPixbuf.Pixbuf.copy]
 * function. This is not the same as just acquiring a reference to
 * the old pixbuf instance: the copy function will actually duplicate
 * the pixel data in memory and create a new class@Pixbuf instance
 * for it.
 * ## Reference counting
 * `GdkPixbuf` structures are reference counted. This means that an
 * application can share a single pixbuf among many parts of the
 * code. When a piece of the program needs to use a pixbuf, it should
 * acquire a reference to it by calling `[GObject.ObjectG.ref_]`; when it no
 * longer needs the pixbuf, it should release the reference it acquired
 * by calling `[GObject.ObjectG.unref]`. The resources associated with a
 * `GdkPixbuf` will be freed when its reference count drops to zero.
 * Newly-created `GdkPixbuf` instances start with a reference count
 * of one.
 * ## Image Data
 * Image data in a pixbuf is stored in memory in an uncompressed,
 * packed format. Rows in the image are stored top to bottom, and
 * in each row pixels are stored from left to right.
 * There may be padding at the end of a row.
 * The "rowstride" value of a pixbuf, as returned by [GdkPixbuf.Pixbuf.getRowstride],
 * indicates the number of bytes between rows.
 * **NOTE**: If you are copying raw pixbuf data with `memcpy$(LPAREN)$(RPAREN)` note that the
 * last row in the pixbuf may not be as wide as the full rowstride, but rather
 * just as wide as the pixel data needs to be; that is: it is unsafe to do
 * `memcpy $(LPAREN)dest, pixels, rowstride * height$(RPAREN)` to copy a whole pixbuf. Use
 * [GdkPixbuf.Pixbuf.copy] instead, or compute the width in bytes of the
 * last row as:
 * ```c
 * last_row \= width * $(LPAREN)$(LPAREN)n_channels * bits_per_sample + 7$(RPAREN) / 8$(RPAREN);
 * ```
 * The same rule applies when iterating over each row of a `GdkPixbuf` pixels
 * array.
 * The following code illustrates a simple `put_pixel$(LPAREN)$(RPAREN)`
 * function for RGB pixbufs with 8 bits per channel with an alpha
 * channel.
 * ```c
 * static void
 * put_pixel $(LPAREN)GdkPixbuf *pixbuf,
 * int x,
 * int y,
 * guchar red,
 * guchar green,
 * guchar blue,
 * guchar alpha$(RPAREN)
 * {
 * int n_channels \= gdk_pixbuf_get_n_channels $(LPAREN)pixbuf$(RPAREN);
 * // Ensure that the pixbuf is valid
 * g_assert $(LPAREN)gdk_pixbuf_get_colorspace $(LPAREN)pixbuf$(RPAREN) \=\= GDK_COLORSPACE_RGB$(RPAREN);
 * g_assert $(LPAREN)gdk_pixbuf_get_bits_per_sample $(LPAREN)pixbuf$(RPAREN) \=\= 8$(RPAREN);
 * g_assert $(LPAREN)gdk_pixbuf_get_has_alpha $(LPAREN)pixbuf$(RPAREN)$(RPAREN);
 * g_assert $(LPAREN)n_channels \=\= 4$(RPAREN);
 * int width \= gdk_pixbuf_get_width $(LPAREN)pixbuf$(RPAREN);
 * int height \= gdk_pixbuf_get_height $(LPAREN)pixbuf$(RPAREN);
 * // Ensure that the coordinates are in a valid range
 * g_assert $(LPAREN)x >\= 0 && x < width$(RPAREN);
 * g_assert $(LPAREN)y >\= 0 && y < height$(RPAREN);
 * int rowstride \= gdk_pixbuf_get_rowstride $(LPAREN)pixbuf$(RPAREN);
 * // The pixel buffer in the GdkPixbuf instance
 * guchar *pixels \= gdk_pixbuf_get_pixels $(LPAREN)pixbuf$(RPAREN);
 * // The pixel we wish to modify
 * guchar *p \= pixels + y * rowstride + x * n_channels;
 * p[0] \= red;
 * p[1] \= green;
 * p[2] \= blue;
 * p[3] \= alpha;
 * }
 * ```
 * ## Loading images
 * The `GdkPixBuf` class provides a simple mechanism for loading
 * an image from a file in synchronous and asynchronous fashion.
 * For GUI applications, it is recommended to use the asynchronous
 * stream API to avoid blocking the control flow of the application.
 * Additionally, `GdkPixbuf` provides the [GdkPixbuf.PixbufLoader]
 * API for progressive image loading.
 * ## Saving images
 * The `GdkPixbuf` class provides methods for saving image data in
 * a number of file formats. The formatted data can be written to a
 * file or to a memory buffer. `GdkPixbuf` can also call a user-defined
 * callback on the data, which allows to e.g. write the image
 * to a socket or store it in a database.
 */
class Pixbuf : ObjectG, Icon, LoadableIcon
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
    return gdk_pixbuf_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin IconT!();
  mixin LoadableIconT!();

  /**
   * Creates a new `GdkPixbuf` structure and allocates a buffer for it.
   * If the allocation of the buffer failed, this function will return `NULL`.
   * The buffer has an optimal rowstride. Note that the buffer is not cleared;
   * you will have to fill it completely yourself.
   * Params:
   *   colorspace = Color space for image
   *   hasAlpha = Whether the image should have transparency information
   *   bitsPerSample = Number of bits per color sample
   *   width = Width of image in pixels, must be > 0
   *   height = Height of image in pixels, must be > 0
   * Returns: A newly-created pixel buffer
   */
  this(Colorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_new(colorspace, hasAlpha, bitsPerSample, width, height);
    this(_cretval, true);
  }

  /**
   * Creates a new #GdkPixbuf out of in-memory readonly image data.
   * Currently only RGB images with 8 bits per sample are supported.
   * This is the `GBytes` variant of [GdkPixbuf.Pixbuf.newFromData], useful
   * for language bindings.
   * Params:
   *   data = Image data in 8-bit/sample packed format inside a #GBytes
   *   colorspace = Colorspace for the image data
   *   hasAlpha = Whether the data has an opacity channel
   *   bitsPerSample = Number of bits per sample
   *   width = Width of the image in pixels, must be > 0
   *   height = Height of the image in pixels, must be > 0
   *   rowstride = Distance in bytes between row starts
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromBytes(Bytes data, Colorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height, int rowstride)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_new_from_bytes(data ? cast(GBytes*)data.cPtr(false) : null, colorspace, hasAlpha, bitsPerSample, width, height, rowstride);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by loading an image from a file.
   * The file format is detected automatically.
   * If `NULL` is returned, then error will be set. Possible errors are:
   * - the file could not be opened
   * - there is no loader for the file's format
   * - there is not enough memory to allocate the image buffer
   * - the image buffer contains invalid data
   * The error domains are `GDK_PIXBUF_ERROR` and `G_FILE_ERROR`.
   * Params:
   *   filename = Name of file to load, in the GLib file
   *     name encoding
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromFile(string filename)
  {
    PixbufC* _cretval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_new_from_file(_filename, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by loading an image from a file.
   * The file format is detected automatically.
   * If `NULL` is returned, then error will be set. Possible errors are:
   * - the file could not be opened
   * - there is no loader for the file's format
   * - there is not enough memory to allocate the image buffer
   * - the image buffer contains invalid data
   * The error domains are `GDK_PIXBUF_ERROR` and `G_FILE_ERROR`.
   * The image will be scaled to fit in the requested size, optionally preserving
   * the image's aspect ratio.
   * When preserving the aspect ratio, a `width` of -1 will cause the image
   * to be scaled to the exact given height, and a `height` of -1 will cause
   * the image to be scaled to the exact given width. When not preserving
   * aspect ratio, a `width` or `height` of -1 means to not scale the image
   * at all in that dimension. Negative values for `width` and `height` are
   * allowed since 2.8.
   * Params:
   *   filename = Name of file to load, in the GLib file
   *     name encoding
   *   width = The width the image should have or -1 to not constrain the width
   *   height = The height the image should have or -1 to not constrain the height
   *   preserveAspectRatio = `TRUE` to preserve the image's aspect ratio
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromFileAtScale(string filename, int width, int height, bool preserveAspectRatio)
  {
    PixbufC* _cretval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_new_from_file_at_scale(_filename, width, height, preserveAspectRatio, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by loading an image from a file.
   * The file format is detected automatically.
   * If `NULL` is returned, then error will be set. Possible errors are:
   * - the file could not be opened
   * - there is no loader for the file's format
   * - there is not enough memory to allocate the image buffer
   * - the image buffer contains invalid data
   * The error domains are `GDK_PIXBUF_ERROR` and `G_FILE_ERROR`.
   * The image will be scaled to fit in the requested size, preserving
   * the image's aspect ratio. Note that the returned pixbuf may be smaller
   * than `width` x `height`, if the aspect ratio requires it. To load
   * and image at the requested size, regardless of aspect ratio, use
   * [GdkPixbuf.Pixbuf.newFromFileAtScale].
   * Params:
   *   filename = Name of file to load, in the GLib file
   *     name encoding
   *   width = The width the image should have or -1 to not constrain the width
   *   height = The height the image should have or -1 to not constrain the height
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromFileAtSize(string filename, int width, int height)
  {
    PixbufC* _cretval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_new_from_file_at_size(_filename, width, height, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a `GdkPixbuf` from a flat representation that is suitable for
   * storing as inline data in a program.
   * This is useful if you want to ship a program with images, but don't want
   * to depend on any external files.
   * GdkPixbuf ships with a program called `gdk-pixbuf-csource`, which allows
   * for conversion of `GdkPixbuf`s into such a inline representation.
   * In almost all cases, you should pass the `--raw` option to
   * `gdk-pixbuf-csource`. A sample invocation would be:
   * ```
   * gdk-pixbuf-csource --raw --name\=myimage_inline myimage.png
   * ```
   * For the typical case where the inline pixbuf is read-only static data,
   * you don't need to copy the pixel data unless you intend to write to
   * it, so you can pass `FALSE` for `copy_pixels`. If you pass `--rle` to
   * `gdk-pixbuf-csource`, a copy will be made even if `copy_pixels` is `FALSE`,
   * so using this option is generally a bad idea.
   * If you create a pixbuf from const inline data compiled into your
   * program, it's probably safe to ignore errors and disable length checks,
   * since things will always succeed:
   * ```c
   * pixbuf \= gdk_pixbuf_new_from_inline $(LPAREN)-1, myimage_inline, FALSE, NULL$(RPAREN);
   * ```
   * For non-const inline data, you could get out of memory. For untrusted
   * inline data located at runtime, you could have corrupt inline data in
   * addition.
   * Params:
   *   data = Byte data containing a
   *     serialized `GdkPixdata` structure
   *   copyPixels = Whether to copy the pixel data, or use direct pointers
   *     `data` for the resulting pixbuf
   * Returns: A newly-created pixbuf

   * Deprecated: Use `GResource` instead.
   */
  static Pixbuf newFromInline(ubyte[] data, bool copyPixels)
  {
    PixbufC* _cretval;
    int _dataLength;
    if (data)
      _dataLength = cast(int)data.length;

    auto _data = cast(const(ubyte)*)data.ptr;
    GError *_err;
    _cretval = gdk_pixbuf_new_from_inline(_dataLength, _data, copyPixels, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by loading an image from an resource.
   * The file format is detected automatically. If `NULL` is returned, then
   * error will be set.
   * Params:
   *   resourcePath = the path of the resource file
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromResource(string resourcePath)
  {
    PixbufC* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_new_from_resource(_resourcePath, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by loading an image from an resource.
   * The file format is detected automatically. If `NULL` is returned, then
   * error will be set.
   * The image will be scaled to fit in the requested size, optionally
   * preserving the image's aspect ratio. When preserving the aspect ratio,
   * a width of -1 will cause the image to be scaled to the exact given
   * height, and a height of -1 will cause the image to be scaled to the
   * exact given width. When not preserving aspect ratio, a width or
   * height of -1 means to not scale the image at all in that dimension.
   * The stream is not closed.
   * Params:
   *   resourcePath = the path of the resource file
   *   width = The width the image should have or -1 to not constrain the width
   *   height = The height the image should have or -1 to not constrain the height
   *   preserveAspectRatio = `TRUE` to preserve the image's aspect ratio
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromResourceAtScale(string resourcePath, int width, int height, bool preserveAspectRatio)
  {
    PixbufC* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_new_from_resource_at_scale(_resourcePath, width, height, preserveAspectRatio, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by loading an image from an input stream.
   * The file format is detected automatically.
   * If `NULL` is returned, then `error` will be set.
   * The `cancellable` can be used to abort the operation from another thread.
   * If the operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
   * returned. Other possible errors are in the `GDK_PIXBUF_ERROR` and
   * `G_IO_ERROR` domains.
   * The stream is not closed.
   * Params:
   *   stream = a `GInputStream` to load the pixbuf from
   *   cancellable = optional `GCancellable` object, `NULL` to ignore
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromStream(InputStream stream, Cancellable cancellable)
  {
    PixbufC* _cretval;
    GError *_err;
    _cretval = gdk_pixbuf_new_from_stream(stream ? cast(GInputStream*)stream.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by loading an image from an input stream.
   * The file format is detected automatically. If `NULL` is returned, then
   * error will be set. The cancellable can be used to abort the operation
   * from another thread. If the operation was cancelled, the error
   * `G_IO_ERROR_CANCELLED` will be returned. Other possible errors are in
   * the `GDK_PIXBUF_ERROR` and `G_IO_ERROR` domains.
   * The image will be scaled to fit in the requested size, optionally
   * preserving the image's aspect ratio.
   * When preserving the aspect ratio, a `width` of -1 will cause the image to be
   * scaled to the exact given height, and a `height` of -1 will cause the image
   * to be scaled to the exact given width. If both `width` and `height` are
   * given, this function will behave as if the smaller of the two values
   * is passed as -1.
   * When not preserving aspect ratio, a `width` or `height` of -1 means to not
   * scale the image at all in that dimension.
   * The stream is not closed.
   * Params:
   *   stream = a `GInputStream` to load the pixbuf from
   *   width = The width the image should have or -1 to not constrain the width
   *   height = The height the image should have or -1 to not constrain the height
   *   preserveAspectRatio = `TRUE` to preserve the image's aspect ratio
   *   cancellable = optional `GCancellable` object, `NULL` to ignore
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromStreamAtScale(InputStream stream, int width, int height, bool preserveAspectRatio, Cancellable cancellable)
  {
    PixbufC* _cretval;
    GError *_err;
    _cretval = gdk_pixbuf_new_from_stream_at_scale(stream ? cast(GInputStream*)stream.cPtr(false) : null, width, height, preserveAspectRatio, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Finishes an asynchronous pixbuf creation operation started with
   * [GdkPixbuf.Pixbuf.newFromStreamAsync].
   * Params:
   *   asyncResult = a `GAsyncResult`
   * Returns: the newly created pixbuf
   */
  static Pixbuf newFromStreamFinish(AsyncResult asyncResult)
  {
    PixbufC* _cretval;
    GError *_err;
    _cretval = gdk_pixbuf_new_from_stream_finish(asyncResult ? cast(GAsyncResult*)(cast(ObjectG)asyncResult).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf by parsing XPM data in memory.
   * This data is commonly the result of including an XPM file into a
   * program's C source.
   * Params:
   *   data = Pointer to inline XPM data.
   * Returns: A newly-created pixbuf
   */
  static Pixbuf newFromXpmData(string[] data)
  {
    PixbufC* _cretval;
    char*[] _tmpdata;
    foreach (s; data)
      _tmpdata ~= s.toCString(false);
    _tmpdata ~= null;
    const(char*)* _data = _tmpdata.ptr;
    _cretval = gdk_pixbuf_new_from_xpm_data(_data);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Calculates the rowstride that an image created with those values would
   * have.
   * This function is useful for front-ends and backends that want to check
   * image values without needing to create a `GdkPixbuf`.
   * Params:
   *   colorspace = Color space for image
   *   hasAlpha = Whether the image should have transparency information
   *   bitsPerSample = Number of bits per color sample
   *   width = Width of image in pixels, must be > 0
   *   height = Height of image in pixels, must be > 0
   * Returns: the rowstride for the given values, or -1 in case of error.
   */
  static int calculateRowstride(Colorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height)
  {
    int _retval;
    _retval = gdk_pixbuf_calculate_rowstride(colorspace, hasAlpha, bitsPerSample, width, height);
    return _retval;
  }

  /**
   * Parses an image file far enough to determine its format and size.
   * Params:
   *   filename = The name of the file to identify.
   *   width = Return location for the width of the image
   *   height = Return location for the height of the image
   * Returns: A `GdkPixbufFormat` describing
   *   the image format of the file
   */
  static PixbufFormat getFileInfo(string filename, out int width, out int height)
  {
    GdkPixbufFormat* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = gdk_pixbuf_get_file_info(_filename, cast(int*)&width, cast(int*)&height);
    auto _retval = _cretval ? new PixbufFormat(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Asynchronously parses an image file far enough to determine its
   * format and size.
   * For more details see [GdkPixbuf.Pixbuf.getFileInfo], which is the synchronous
   * version of this function.
   * When the operation is finished, callback will be called in the
   * main thread. You can then call [GdkPixbuf.Pixbuf.getFileInfoFinish] to
   * get the result of the operation.
   * Params:
   *   filename = The name of the file to identify
   *   cancellable = optional `GCancellable` object, `NULL` to ignore
   *   callback = a `GAsyncReadyCallback` to call when the file info is available
   */
  static void getFileInfoAsync(string filename, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _filename = filename.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_pixbuf_get_file_info_async(_filename, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous pixbuf parsing operation started with
   * [GdkPixbuf.Pixbuf.getFileInfoAsync].
   * Params:
   *   asyncResult = a `GAsyncResult`
   *   width = Return location for the width of the image, or `NULL`
   *   height = Return location for the height of the image, or `NULL`
   * Returns: A `GdkPixbufFormat` describing the
   *   image format of the file
   */
  static PixbufFormat getFileInfoFinish(AsyncResult asyncResult, out int width, out int height)
  {
    GdkPixbufFormat* _cretval;
    GError *_err;
    _cretval = gdk_pixbuf_get_file_info_finish(asyncResult ? cast(GAsyncResult*)(cast(ObjectG)asyncResult).cPtr(false) : null, cast(int*)&width, cast(int*)&height, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new PixbufFormat(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the available information about the image formats supported
   * by GdkPixbuf.
   * Returns: A list of
   *   support image formats.
   */
  static SList!(PixbufFormat) getFormats()
  {
    GSList* _cretval;
    _cretval = gdk_pixbuf_get_formats();
    SList!(PixbufFormat) _retval = new SList!(PixbufFormat)(cast(GSList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Initalizes the gdk-pixbuf loader modules referenced by the `loaders.cache`
   * file present inside that directory.
   * This is to be used by applications that want to ship certain loaders
   * in a different location from the system ones.
   * This is needed when the OS or runtime ships a minimal number of loaders
   * so as to reduce the potential attack surface of carefully crafted image
   * files, especially for uncommon file types. Applications that require
   * broader image file types coverage, such as image viewers, would be
   * expected to ship the gdk-pixbuf modules in a separate location, bundled
   * with the application in a separate directory from the OS or runtime-
   * provided modules.
   * Params:
   *   path = Path to directory where the `loaders.cache` is installed
   * Returns:
   */
  static bool initModules(string path)
  {
    bool _retval;
    const(char)* _path = path.toCString(false);
    GError *_err;
    _retval = gdk_pixbuf_init_modules(_path, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Creates a new pixbuf by asynchronously loading an image from an input stream.
   * For more details see [GdkPixbuf.Pixbuf.newFromStream], which is the synchronous
   * version of this function.
   * When the operation is finished, callback will be called in the main thread.
   * You can then call [GdkPixbuf.Pixbuf.newFromStreamFinish] to get the result of
   * the operation.
   * Params:
   *   stream = a `GInputStream` from which to load the pixbuf
   *   cancellable = optional `GCancellable` object, `NULL` to ignore
   *   callback = a `GAsyncReadyCallback` to call when the pixbuf is loaded
   */
  static void newFromStreamAsync(InputStream stream, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_pixbuf_new_from_stream_async(stream ? cast(GInputStream*)stream.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Creates a new pixbuf by asynchronously loading an image from an input stream.
   * For more details see [GdkPixbuf.Pixbuf.newFromStreamAtScale], which is the synchronous
   * version of this function.
   * When the operation is finished, callback will be called in the main thread.
   * You can then call [GdkPixbuf.Pixbuf.newFromStreamFinish] to get the result of the operation.
   * Params:
   *   stream = a `GInputStream` from which to load the pixbuf
   *   width = the width the image should have or -1 to not constrain the width
   *   height = the height the image should have or -1 to not constrain the height
   *   preserveAspectRatio = `TRUE` to preserve the image's aspect ratio
   *   cancellable = optional `GCancellable` object, `NULL` to ignore
   *   callback = a `GAsyncReadyCallback` to call when the pixbuf is loaded
   */
  static void newFromStreamAtScaleAsync(InputStream stream, int width, int height, bool preserveAspectRatio, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_pixbuf_new_from_stream_at_scale_async(stream ? cast(GInputStream*)stream.cPtr(false) : null, width, height, preserveAspectRatio, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous pixbuf save operation started with
   * [GdkPixbuf.Pixbuf.saveToStreamAsync].
   * Params:
   *   asyncResult = a `GAsyncResult`
   * Returns: `TRUE` if the pixbuf was saved successfully, `FALSE` if an error was set.
   */
  static bool saveToStreamFinish(AsyncResult asyncResult)
  {
    bool _retval;
    GError *_err;
    _retval = gdk_pixbuf_save_to_stream_finish(asyncResult ? cast(GAsyncResult*)(cast(ObjectG)asyncResult).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Takes an existing pixbuf and adds an alpha channel to it.
   * If the existing pixbuf already had an alpha channel, the channel
   * values are copied from the original; otherwise, the alpha channel
   * is initialized to 255 $(LPAREN)full opacity$(RPAREN).
   * If `substitute_color` is `TRUE`, then the color specified by the
   * $(LPAREN)`r`, `g`, `b`$(RPAREN) arguments will be assigned zero opacity. That is,
   * if you pass `$(LPAREN)255, 255, 255$(RPAREN)` for the substitute color, all white
   * pixels will become fully transparent.
   * If `substitute_color` is `FALSE`, then the $(LPAREN)`r`, `g`, `b`$(RPAREN) arguments
   * will be ignored.
   * Params:
   *   substituteColor = Whether to set a color to zero opacity.
   *   r = Red value to substitute.
   *   g = Green value to substitute.
   *   b = Blue value to substitute.
   * Returns: A newly-created pixbuf
   */
  Pixbuf addAlpha(bool substituteColor, ubyte r, ubyte g, ubyte b)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_add_alpha(cast(PixbufC*)cPtr, substituteColor, r, g, b);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Takes an existing pixbuf and checks for the presence of an
   * associated "orientation" option.
   * The orientation option may be provided by the JPEG loader $(LPAREN)which
   * reads the exif orientation tag$(RPAREN) or the TIFF loader $(LPAREN)which reads
   * the TIFF orientation tag, and compensates it for the partial
   * transforms performed by libtiff$(RPAREN).
   * If an orientation option/tag is present, the appropriate transform
   * will be performed so that the pixbuf is oriented correctly.
   * Returns: A newly-created pixbuf
   */
  Pixbuf applyEmbeddedOrientation()
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_apply_embedded_orientation(cast(PixbufC*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a transformation of the source image src by scaling by
   * scale_x and scale_y then translating by offset_x and offset_y.
   * This gives an image in the coordinates of the destination pixbuf.
   * The rectangle $(LPAREN)dest_x, dest_y, dest_width, dest_height$(RPAREN)
   * is then alpha blended onto the corresponding rectangle of the
   * original destination image.
   * When the destination rectangle contains parts not in the source
   * image, the data at the edges of the source image is replicated
   * to infinity.
   * ![](composite.png)
   * Params:
   *   dest = the #GdkPixbuf into which to render the results
   *   destX = the left coordinate for region to render
   *   destY = the top coordinate for region to render
   *   destWidth = the width of the region to render
   *   destHeight = the height of the region to render
   *   offsetX = the offset in the X direction $(LPAREN)currently rounded to an integer$(RPAREN)
   *   offsetY = the offset in the Y direction $(LPAREN)currently rounded to an integer$(RPAREN)
   *   scaleX = the scale factor in the X direction
   *   scaleY = the scale factor in the Y direction
   *   interpType = the interpolation type for the transformation.
   *   overallAlpha = overall alpha for source image $(LPAREN)0..255$(RPAREN)
   */
  void composite(Pixbuf dest, int destX, int destY, int destWidth, int destHeight, double offsetX, double offsetY, double scaleX, double scaleY, InterpType interpType, int overallAlpha)
  {
    gdk_pixbuf_composite(cast(PixbufC*)cPtr, dest ? cast(PixbufC*)dest.cPtr(false) : null, destX, destY, destWidth, destHeight, offsetX, offsetY, scaleX, scaleY, interpType, overallAlpha);
  }

  /**
   * Creates a transformation of the source image src by scaling by
   * scale_x and scale_y then translating by offset_x and offset_y,
   * then alpha blends the rectangle $(LPAREN)dest_x ,dest_y, dest_width,
   * dest_height$(RPAREN) of the resulting image with a checkboard of the
   * colors color1 and color2 and renders it onto the destination
   * image.
   * If the source image has no alpha channel, and overall_alpha is 255, a fast
   * path is used which omits the alpha blending and just performs the scaling.
   * See [GdkPixbuf.Pixbuf.compositeColorSimple] for a simpler variant of this
   * function suitable for many tasks.
   * Params:
   *   dest = the #GdkPixbuf into which to render the results
   *   destX = the left coordinate for region to render
   *   destY = the top coordinate for region to render
   *   destWidth = the width of the region to render
   *   destHeight = the height of the region to render
   *   offsetX = the offset in the X direction $(LPAREN)currently rounded to an integer$(RPAREN)
   *   offsetY = the offset in the Y direction $(LPAREN)currently rounded to an integer$(RPAREN)
   *   scaleX = the scale factor in the X direction
   *   scaleY = the scale factor in the Y direction
   *   interpType = the interpolation type for the transformation.
   *   overallAlpha = overall alpha for source image $(LPAREN)0..255$(RPAREN)
   *   checkX = the X offset for the checkboard $(LPAREN)origin of checkboard is at -check_x, -check_y$(RPAREN)
   *   checkY = the Y offset for the checkboard
   *   checkSize = the size of checks in the checkboard $(LPAREN)must be a power of two$(RPAREN)
   *   color1 = the color of check at upper left
   *   color2 = the color of the other check
   */
  void compositeColor(Pixbuf dest, int destX, int destY, int destWidth, int destHeight, double offsetX, double offsetY, double scaleX, double scaleY, InterpType interpType, int overallAlpha, int checkX, int checkY, int checkSize, uint color1, uint color2)
  {
    gdk_pixbuf_composite_color(cast(PixbufC*)cPtr, dest ? cast(PixbufC*)dest.cPtr(false) : null, destX, destY, destWidth, destHeight, offsetX, offsetY, scaleX, scaleY, interpType, overallAlpha, checkX, checkY, checkSize, color1, color2);
  }

  /**
   * Creates a new pixbuf by scaling `src` to `dest_width` x `dest_height`
   * and alpha blending the result with a checkboard of colors `color1`
   * and `color2`.
   * Params:
   *   destWidth = the width of destination image
   *   destHeight = the height of destination image
   *   interpType = the interpolation type for the transformation.
   *   overallAlpha = overall alpha for source image $(LPAREN)0..255$(RPAREN)
   *   checkSize = the size of checks in the checkboard $(LPAREN)must be a power of two$(RPAREN)
   *   color1 = the color of check at upper left
   *   color2 = the color of the other check
   * Returns: the new pixbuf
   */
  Pixbuf compositeColorSimple(int destWidth, int destHeight, InterpType interpType, int overallAlpha, int checkSize, uint color1, uint color2)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_composite_color_simple(cast(PixbufC*)cPtr, destWidth, destHeight, interpType, overallAlpha, checkSize, color1, color2);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new `GdkPixbuf` with a copy of the information in the specified
   * `pixbuf`.
   * Note that this does not copy the options set on the original `GdkPixbuf`,
   * use [GdkPixbuf.Pixbuf.copyOptions] for this.
   * Returns: A newly-created pixbuf
   */
  Pixbuf copy()
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_copy(cast(PixbufC*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Copies a rectangular area from `src_pixbuf` to `dest_pixbuf`.
   * Conversion of pixbuf formats is done automatically.
   * If the source rectangle overlaps the destination rectangle on the
   * same pixbuf, it will be overwritten during the copy operation.
   * Therefore, you can not use this function to scroll a pixbuf.
   * Params:
   *   srcX = Source X coordinate within src_pixbuf.
   *   srcY = Source Y coordinate within src_pixbuf.
   *   width = Width of the area to copy.
   *   height = Height of the area to copy.
   *   destPixbuf = Destination pixbuf.
   *   destX = X coordinate within dest_pixbuf.
   *   destY = Y coordinate within dest_pixbuf.
   */
  void copyArea(int srcX, int srcY, int width, int height, Pixbuf destPixbuf, int destX, int destY)
  {
    gdk_pixbuf_copy_area(cast(PixbufC*)cPtr, srcX, srcY, width, height, destPixbuf ? cast(PixbufC*)destPixbuf.cPtr(false) : null, destX, destY);
  }

  /**
   * Copies the key/value pair options attached to a `GdkPixbuf` to another
   * `GdkPixbuf`.
   * This is useful to keep original metadata after having manipulated
   * a file. However be careful to remove metadata which you've already
   * applied, such as the "orientation" option after rotating the image.
   * Params:
   *   destPixbuf = the destination pixbuf
   * Returns: `TRUE` on success.
   */
  bool copyOptions(Pixbuf destPixbuf)
  {
    bool _retval;
    _retval = gdk_pixbuf_copy_options(cast(PixbufC*)cPtr, destPixbuf ? cast(PixbufC*)destPixbuf.cPtr(false) : null);
    return _retval;
  }

  /**
   * Clears a pixbuf to the given RGBA value, converting the RGBA value into
   * the pixbuf's pixel format.
   * The alpha component will be ignored if the pixbuf doesn't have an alpha
   * channel.
   * Params:
   *   pixel = RGBA pixel to used to clear $(LPAREN)`0xffffffff` is opaque white,
   *     `0x00000000` transparent black$(RPAREN)
   */
  void fill(uint pixel)
  {
    gdk_pixbuf_fill(cast(PixbufC*)cPtr, pixel);
  }

  /**
   * Flips a pixbuf horizontally or vertically and returns the
   * result in a new pixbuf.
   * Params:
   *   horizontal = `TRUE` to flip horizontally, `FALSE` to flip vertically
   * Returns: the new pixbuf
   */
  Pixbuf flip(bool horizontal)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_flip(cast(PixbufC*)cPtr, horizontal);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Queries the number of bits per color sample in a pixbuf.
   * Returns: Number of bits per color sample.
   */
  int getBitsPerSample()
  {
    int _retval;
    _retval = gdk_pixbuf_get_bits_per_sample(cast(PixbufC*)cPtr);
    return _retval;
  }

  /**
   * Returns the length of the pixel data, in bytes.
   * Returns: The length of the pixel data.
   */
  size_t getByteLength()
  {
    size_t _retval;
    _retval = gdk_pixbuf_get_byte_length(cast(PixbufC*)cPtr);
    return _retval;
  }

  /**
   * Queries the color space of a pixbuf.
   * Returns: Color space.
   */
  Colorspace getColorspace()
  {
    GdkColorspace _cretval;
    _cretval = gdk_pixbuf_get_colorspace(cast(PixbufC*)cPtr);
    Colorspace _retval = cast(Colorspace)_cretval;
    return _retval;
  }

  /**
   * Queries whether a pixbuf has an alpha channel $(LPAREN)opacity information$(RPAREN).
   * Returns: `TRUE` if it has an alpha channel, `FALSE` otherwise.
   */
  bool getHasAlpha()
  {
    bool _retval;
    _retval = gdk_pixbuf_get_has_alpha(cast(PixbufC*)cPtr);
    return _retval;
  }

  /**
   * Queries the height of a pixbuf.
   * Returns: Height in pixels.
   */
  int getHeight()
  {
    int _retval;
    _retval = gdk_pixbuf_get_height(cast(PixbufC*)cPtr);
    return _retval;
  }

  /**
   * Queries the number of channels of a pixbuf.
   * Returns: Number of channels.
   */
  int getNChannels()
  {
    int _retval;
    _retval = gdk_pixbuf_get_n_channels(cast(PixbufC*)cPtr);
    return _retval;
  }

  /**
   * Looks up key in the list of options that may have been attached to the
   * pixbuf when it was loaded, or that may have been attached by another
   * function using [GdkPixbuf.Pixbuf.setOption].
   * For instance, the ANI loader provides "Title" and "Artist" options.
   * The ICO, XBM, and XPM loaders provide "x_hot" and "y_hot" hot-spot
   * options for cursor definitions. The PNG loader provides the tEXt ancillary
   * chunk key/value pairs as options. Since 2.12, the TIFF and JPEG loaders
   * return an "orientation" option string that corresponds to the embedded
   * TIFF/Exif orientation tag $(LPAREN)if present$(RPAREN). Since 2.32, the TIFF loader sets
   * the "multipage" option string to "yes" when a multi-page TIFF is loaded.
   * Since 2.32 the JPEG and PNG loaders set "x-dpi" and "y-dpi" if the file
   * contains image density information in dots per inch.
   * Since 2.36.6, the JPEG loader sets the "comment" option with the comment
   * EXIF tag.
   * Params:
   *   key = a nul-terminated string.
   * Returns: the value associated with `key`
   */
  string getOption(string key)
  {
    const(char)* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = gdk_pixbuf_get_option(cast(PixbufC*)cPtr, _key);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns a `GHashTable` with a list of all the options that may have been
   * attached to the `pixbuf` when it was loaded, or that may have been
   * attached by another function using [GdkPixbuf.Pixbuf.setOption].
   * Returns: a #GHashTable
   *   of key/values pairs
   */
  string[string] getOptions()
  {
    GHashTable* _cretval;
    _cretval = gdk_pixbuf_get_options(cast(PixbufC*)cPtr);
    string[string] _retval = _cretval ? hashTableToMap!(string, string, false)(_cretval) : null;
    return _retval;
  }

  /**
   * Queries a pointer to the pixel data of a pixbuf.
   * This function will cause an implicit copy of the pixbuf data if the
   * pixbuf was created from read-only data.
   * Please see the section on [image data](class.Pixbuf.html#image-data) for information
   * about how the pixel data is stored in memory.
   * Returns: A pointer to the pixbuf's
   *   pixel data.
   */
  ubyte[] getPixels()
  {
    ubyte* _cretval;
    uint _cretlength;
    _cretval = gdk_pixbuf_get_pixels_with_length(cast(PixbufC*)cPtr, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Queries the rowstride of a pixbuf, which is the number of bytes between
   * the start of a row and the start of the next row.
   * Returns: Distance between row starts.
   */
  int getRowstride()
  {
    int _retval;
    _retval = gdk_pixbuf_get_rowstride(cast(PixbufC*)cPtr);
    return _retval;
  }

  /**
   * Queries the width of a pixbuf.
   * Returns: Width in pixels.
   */
  int getWidth()
  {
    int _retval;
    _retval = gdk_pixbuf_get_width(cast(PixbufC*)cPtr);
    return _retval;
  }

  /**
   * Creates a new pixbuf which represents a sub-region of `src_pixbuf`.
   * The new pixbuf shares its pixels with the original pixbuf, so
   * writing to one affects both.  The new pixbuf holds a reference to
   * `src_pixbuf`, so `src_pixbuf` will not be finalized until the new
   * pixbuf is finalized.
   * Note that if `src_pixbuf` is read-only, this function will force it
   * to be mutable.
   * Params:
   *   srcX = X coord in src_pixbuf
   *   srcY = Y coord in src_pixbuf
   *   width = width of region in src_pixbuf
   *   height = height of region in src_pixbuf
   * Returns: a new pixbuf
   */
  Pixbuf newSubpixbuf(int srcX, int srcY, int width, int height)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_new_subpixbuf(cast(PixbufC*)cPtr, srcX, srcY, width, height);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Provides a #GBytes buffer containing the raw pixel data; the data
   * must not be modified.
   * This function allows skipping the implicit copy that must be made
   * if [GdkPixbuf.Pixbuf.getPixels] is called on a read-only pixbuf.
   * Returns: A new reference to a read-only copy of
   *   the pixel data.  Note that for mutable pixbufs, this function will
   *   incur a one-time copy of the pixel data for conversion into the
   *   returned #GBytes.
   */
  Bytes readPixelBytes()
  {
    GBytes* _cretval;
    _cretval = gdk_pixbuf_read_pixel_bytes(cast(PixbufC*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Removes the key/value pair option attached to a `GdkPixbuf`.
   * Params:
   *   key = a nul-terminated string representing the key to remove.
   * Returns: `TRUE` if an option was removed, `FALSE` if not.
   */
  bool removeOption(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = gdk_pixbuf_remove_option(cast(PixbufC*)cPtr, _key);
    return _retval;
  }

  /**
   * Rotates a pixbuf by a multiple of 90 degrees, and returns the
   * result in a new pixbuf.
   * If `angle` is 0, this function will return a copy of `src`.
   * Params:
   *   angle = the angle to rotate by
   * Returns: the new pixbuf
   */
  Pixbuf rotateSimple(PixbufRotation angle)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_rotate_simple(cast(PixbufC*)cPtr, angle);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Modifies saturation and optionally pixelates `src`, placing the result in
   * `dest`.
   * The `src` and `dest` pixbufs must have the same image format, size, and
   * rowstride.
   * The `src` and `dest` arguments may be the same pixbuf with no ill effects.
   * If `saturation` is 1.0 then saturation is not changed. If it's less than 1.0,
   * saturation is reduced $(LPAREN)the image turns toward grayscale$(RPAREN); if greater than
   * 1.0, saturation is increased $(LPAREN)the image gets more vivid colors$(RPAREN).
   * If `pixelate` is `TRUE`, then pixels are faded in a checkerboard pattern to
   * create a pixelated image.
   * Params:
   *   dest = place to write modified version of src
   *   saturation = saturation factor
   *   pixelate = whether to pixelate
   */
  void saturateAndPixelate(Pixbuf dest, float saturation, bool pixelate)
  {
    gdk_pixbuf_saturate_and_pixelate(cast(PixbufC*)cPtr, dest ? cast(PixbufC*)dest.cPtr(false) : null, saturation, pixelate);
  }

  /**
   * Vector version of `[GdkPixbuf.Pixbuf.saveToBuffer]`.
   * Saves pixbuf to a new buffer in format type, which is currently "jpeg",
   * "tiff", "png", "ico" or "bmp".
   * See [GdkPixbuf.Pixbuf.saveToBuffer] for more details.
   * Params:
   *   buffer = location to receive a pointer to the new buffer.
   *   type = name of file format.
   *   optionKeys = name of options to set
   *   optionValues = values for named options
   * Returns: whether an error was set
   */
  bool saveToBufferv(out ubyte[] buffer, string type, string[] optionKeys, string[] optionValues)
  {
    bool _retval;
    size_t _bufferSize;
    ubyte* _buffer;
    const(char)* _type = type.toCString(false);
    char*[] _tmpoptionKeys;
    foreach (s; optionKeys)
      _tmpoptionKeys ~= s.toCString(false);
    _tmpoptionKeys ~= null;
    char** _optionKeys = _tmpoptionKeys.ptr;

    char*[] _tmpoptionValues;
    foreach (s; optionValues)
      _tmpoptionValues ~= s.toCString(false);
    _tmpoptionValues ~= null;
    char** _optionValues = _tmpoptionValues.ptr;

    GError *_err;
    _retval = gdk_pixbuf_save_to_bufferv(cast(PixbufC*)cPtr, &_buffer, &_bufferSize, _type, _optionKeys, _optionValues, &_err);
    if (_err)
      throw new ErrorG(_err);
    buffer.length = _bufferSize;
    buffer[0 .. $] = _buffer[0 .. _bufferSize];
    safeFree(cast(void*)_buffer);
    return _retval;
  }

  /**
   * Vector version of `[GdkPixbuf.Pixbuf.saveToCallback]`.
   * Saves pixbuf to a callback in format type, which is currently "jpeg",
   * "png", "tiff", "ico" or "bmp".
   * If error is set, `FALSE` will be returned.
   * See [GdkPixbuf.Pixbuf.saveToCallback] for more details.
   * Params:
   *   saveFunc = a function that is called to save each block of data that
   *     the save routine generates.
   *   type = name of file format.
   *   optionKeys = name of options to set
   *   optionValues = values for named options
   * Returns: whether an error was set
   */
  bool saveToCallbackv(PixbufSaveFunc saveFunc, string type, string[] optionKeys, string[] optionValues)
  {
    extern(C) bool _saveFuncCallback(const(ubyte)* buf, size_t count, GError** error, void* data)
    {
      auto _dlg = cast(PixbufSaveFunc*)data;
      ubyte[] _buf;
      _buf.length = count;
      _buf[0 .. count] = buf[0 .. count];
      auto _error = new ErrorG(error, false);

      bool _retval = (*_dlg)(_buf, _error);
       *error = *cast(GError**)_error.cPtr;

      return _retval;
    }

    bool _retval;
    auto _saveFunc = cast(void*)&saveFunc;
    const(char)* _type = type.toCString(false);
    char*[] _tmpoptionKeys;
    foreach (s; optionKeys)
      _tmpoptionKeys ~= s.toCString(false);
    _tmpoptionKeys ~= null;
    char** _optionKeys = _tmpoptionKeys.ptr;

    char*[] _tmpoptionValues;
    foreach (s; optionValues)
      _tmpoptionValues ~= s.toCString(false);
    _tmpoptionValues ~= null;
    char** _optionValues = _tmpoptionValues.ptr;

    GError *_err;
    _retval = gdk_pixbuf_save_to_callbackv(cast(PixbufC*)cPtr, &_saveFuncCallback, _saveFunc, _type, _optionKeys, _optionValues, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Saves `pixbuf` to an output stream.
   * Supported file formats are currently "jpeg", "tiff", "png", "ico" or
   * "bmp".
   * See [GdkPixbuf.Pixbuf.saveToStream] for more details.
   * Params:
   *   stream = a `GOutputStream` to save the pixbuf to
   *   type = name of file format
   *   optionKeys = name of options to set
   *   optionValues = values for named options
   *   cancellable = optional `GCancellable` object, `NULL` to ignore
   * Returns: `TRUE` if the pixbuf was saved successfully, `FALSE` if an
   *   error was set.
   */
  bool saveToStreamv(OutputStream stream, string type, string[] optionKeys, string[] optionValues, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _type = type.toCString(false);
    char*[] _tmpoptionKeys;
    foreach (s; optionKeys)
      _tmpoptionKeys ~= s.toCString(false);
    _tmpoptionKeys ~= null;
    char** _optionKeys = _tmpoptionKeys.ptr;

    char*[] _tmpoptionValues;
    foreach (s; optionValues)
      _tmpoptionValues ~= s.toCString(false);
    _tmpoptionValues ~= null;
    char** _optionValues = _tmpoptionValues.ptr;

    GError *_err;
    _retval = gdk_pixbuf_save_to_streamv(cast(PixbufC*)cPtr, stream ? cast(GOutputStream*)stream.cPtr(false) : null, _type, _optionKeys, _optionValues, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Saves `pixbuf` to an output stream asynchronously.
   * For more details see [GdkPixbuf.Pixbuf.saveToStreamv], which is the synchronous
   * version of this function.
   * When the operation is finished, `callback` will be called in the main thread.
   * You can then call [GdkPixbuf.Pixbuf.saveToStreamFinish] to get the result of
   * the operation.
   * Params:
   *   stream = a `GOutputStream` to which to save the pixbuf
   *   type = name of file format
   *   optionKeys = name of options to set
   *   optionValues = values for named options
   *   cancellable = optional `GCancellable` object, `NULL` to ignore
   *   callback = a `GAsyncReadyCallback` to call when the pixbuf is saved
   */
  void saveToStreamvAsync(OutputStream stream, string type, string[] optionKeys, string[] optionValues, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _type = type.toCString(false);
    char*[] _tmpoptionKeys;
    foreach (s; optionKeys)
      _tmpoptionKeys ~= s.toCString(false);
    _tmpoptionKeys ~= null;
    char** _optionKeys = _tmpoptionKeys.ptr;

    char*[] _tmpoptionValues;
    foreach (s; optionValues)
      _tmpoptionValues ~= s.toCString(false);
    _tmpoptionValues ~= null;
    char** _optionValues = _tmpoptionValues.ptr;

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_pixbuf_save_to_streamv_async(cast(PixbufC*)cPtr, stream ? cast(GOutputStream*)stream.cPtr(false) : null, _type, _optionKeys, _optionValues, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Vector version of `[GdkPixbuf.Pixbuf.save]`.
   * Saves pixbuf to a file in `type`, which is currently "jpeg", "png", "tiff", "ico" or "bmp".
   * If error is set, `FALSE` will be returned.
   * See [GdkPixbuf.Pixbuf.save] for more details.
   * Params:
   *   filename = name of file to save.
   *   type = name of file format.
   *   optionKeys = name of options to set
   *   optionValues = values for named options
   * Returns: whether an error was set
   */
  bool savev(string filename, string type, string[] optionKeys, string[] optionValues)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    const(char)* _type = type.toCString(false);
    char*[] _tmpoptionKeys;
    foreach (s; optionKeys)
      _tmpoptionKeys ~= s.toCString(false);
    _tmpoptionKeys ~= null;
    char** _optionKeys = _tmpoptionKeys.ptr;

    char*[] _tmpoptionValues;
    foreach (s; optionValues)
      _tmpoptionValues ~= s.toCString(false);
    _tmpoptionValues ~= null;
    char** _optionValues = _tmpoptionValues.ptr;

    GError *_err;
    _retval = gdk_pixbuf_savev(cast(PixbufC*)cPtr, _filename, _type, _optionKeys, _optionValues, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Creates a transformation of the source image src by scaling by
   * scale_x and scale_y then translating by offset_x and offset_y,
   * then renders the rectangle $(LPAREN)dest_x, dest_y, dest_width,
   * dest_height$(RPAREN) of the resulting image onto the destination image
   * replacing the previous contents.
   * Try to use [GdkPixbuf.Pixbuf.scaleSimple] first; this function is
   * the industrial-strength power tool you can fall back to, if
   * [GdkPixbuf.Pixbuf.scaleSimple] isn't powerful enough.
   * If the source rectangle overlaps the destination rectangle on the
   * same pixbuf, it will be overwritten during the scaling which
   * results in rendering artifacts.
   * Params:
   *   dest = the #GdkPixbuf into which to render the results
   *   destX = the left coordinate for region to render
   *   destY = the top coordinate for region to render
   *   destWidth = the width of the region to render
   *   destHeight = the height of the region to render
   *   offsetX = the offset in the X direction $(LPAREN)currently rounded to an integer$(RPAREN)
   *   offsetY = the offset in the Y direction $(LPAREN)currently rounded to an integer$(RPAREN)
   *   scaleX = the scale factor in the X direction
   *   scaleY = the scale factor in the Y direction
   *   interpType = the interpolation type for the transformation.
   */
  void scale(Pixbuf dest, int destX, int destY, int destWidth, int destHeight, double offsetX, double offsetY, double scaleX, double scaleY, InterpType interpType)
  {
    gdk_pixbuf_scale(cast(PixbufC*)cPtr, dest ? cast(PixbufC*)dest.cPtr(false) : null, destX, destY, destWidth, destHeight, offsetX, offsetY, scaleX, scaleY, interpType);
  }

  /**
   * Create a new pixbuf containing a copy of `src` scaled to
   * `dest_width` x `dest_height`.
   * This function leaves `src` unaffected.
   * The `interp_type` should be `GDK_INTERP_NEAREST` if you want maximum
   * speed $(LPAREN)but when scaling down `GDK_INTERP_NEAREST` is usually unusably
   * ugly$(RPAREN). The default `interp_type` should be `GDK_INTERP_BILINEAR` which
   * offers reasonable quality and speed.
   * You can scale a sub-portion of `src` by creating a sub-pixbuf
   * pointing into `src`; see [GdkPixbuf.Pixbuf.newSubpixbuf].
   * If `dest_width` and `dest_height` are equal to the width and height of
   * `src`, this function will return an unscaled copy of `src`.
   * For more complicated scaling/alpha blending see [GdkPixbuf.Pixbuf.scale]
   * and [GdkPixbuf.Pixbuf.composite].
   * Params:
   *   destWidth = the width of destination image
   *   destHeight = the height of destination image
   *   interpType = the interpolation type for the transformation.
   * Returns: the new pixbuf
   */
  Pixbuf scaleSimple(int destWidth, int destHeight, InterpType interpType)
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_scale_simple(cast(PixbufC*)cPtr, destWidth, destHeight, interpType);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Attaches a key/value pair as an option to a `GdkPixbuf`.
   * If `key` already exists in the list of options attached to the `pixbuf`,
   * the new value is ignored and `FALSE` is returned.
   * Params:
   *   key = a nul-terminated string.
   *   value = a nul-terminated string.
   * Returns: `TRUE` on success
   */
  bool setOption(string key, string value)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    const(char)* _value = value.toCString(false);
    _retval = gdk_pixbuf_set_option(cast(PixbufC*)cPtr, _key, _value);
    return _retval;
  }
}

module GdkPixbuf.c.types;

public import GModule.c.types;
public import Gio.c.types;

/**
 * This enumeration defines the color spaces that are supported by
 * the gdk-pixbuf library.
 * Currently only RGB is supported.
 */
enum GdkColorspace
{
  /**
   * Indicates a red/green/blue additive color space.
   */
  Rgb = 0,
}

/**
 * Interpolation modes for scaling functions.
 * The `GDK_INTERP_NEAREST` mode is the fastest scaling method, but has
 * horrible quality when scaling down; `GDK_INTERP_BILINEAR` is the best
 * choice if you aren't sure what to choose, it has a good speed/quality
 * balance.
 * **Note**: Cubic filtering is missing from the list; hyperbolic
 * interpolation is just as fast and results in higher quality.
 */
enum GdkInterpType
{
  /**
   * Nearest neighbor sampling; this is the fastest
   * and lowest quality mode. Quality is normally unacceptable when scaling
   * down, but may be OK when scaling up.
   */
  Nearest = 0,

  /**
   * This is an accurate simulation of the PostScript
   * image operator without any interpolation enabled.  Each pixel is
   * rendered as a tiny parallelogram of solid color, the edges of which
   * are implemented with antialiasing.  It resembles nearest neighbor for
   * enlargement, and bilinear for reduction.
   */
  Tiles = 1,

  /**
   * Best quality/speed balance; use this mode by
   * default. Bilinear interpolation.  For enlargement, it is
   * equivalent to point-sampling the ideal bilinear-interpolated image.
   * For reduction, it is equivalent to laying down small tiles and
   * integrating over the coverage area.
   */
  Bilinear = 2,

  /**
   * This is the slowest and highest quality
   * reconstruction function. It is derived from the hyperbolic filters in
   * Wolberg's "Digital Image Warping", and is formally defined as the
   * hyperbolic-filter sampling the ideal hyperbolic-filter interpolated
   * image $(LPAREN)the filter is designed to be idempotent for 1:1 pixel mapping$(RPAREN).
   * **Deprecated**: this interpolation filter is deprecated, as in reality
   * it has a lower quality than the @GDK_INTERP_BILINEAR filter
   * $(LPAREN)Since: 2.38$(RPAREN)
   */
  Hyper = 3,
}

/**
 * Control the alpha channel for drawables.
 * These values can be passed to gdk_pixbuf_xlib_render_to_drawable_alpha$(LPAREN)$(RPAREN)
 * in gdk-pixbuf-xlib to control how the alpha channel of an image should
 * be handled.
 * This function can create a bilevel clipping mask $(LPAREN)black and white$(RPAREN) and use
 * it while painting the image.
 * In the future, when the X Window System gets an alpha channel extension,
 * it will be possible to do full alpha compositing onto arbitrary drawables.
 * For now both cases fall back to a bilevel clipping mask.

 * Deprecated: There is no user of GdkPixbufAlphaMode in GdkPixbuf,
 *   and the Xlib utility functions have been split out to their own
 *   library, gdk-pixbuf-xlib
 */
enum GdkPixbufAlphaMode
{
  /**
   * A bilevel clipping mask $(LPAREN)black and white$(RPAREN)
   * will be created and used to draw the image.  Pixels below 0.5 opacity
   * will be considered fully transparent, and all others will be
   * considered fully opaque.
   */
  Bilevel = 0,

  /**
   * For now falls back to #GDK_PIXBUF_ALPHA_BILEVEL.
   * In the future it will do full alpha compositing.
   */
  Full = 1,
}

/**
 * An error code in the `GDK_PIXBUF_ERROR` domain.
 * Many gdk-pixbuf operations can cause errors in this domain, or in
 * the `G_FILE_ERROR` domain.
 */
enum GdkPixbufError
{
  /**
   * An image file was broken somehow.
   */
  CorruptImage = 0,

  /**
   * Not enough memory.
   */
  InsufficientMemory = 1,

  /**
   * A bad option was passed to a pixbuf save module.
   */
  BadOption = 2,

  /**
   * Unknown image type.
   */
  UnknownType = 3,

  /**
   * Don't know how to perform the
   * given operation on the type of image at hand.
   */
  UnsupportedOperation = 4,

  /**
   * Generic failure code, something went wrong.
   */
  Failed = 5,

  /**
   * Only part of the animation was loaded.
   */
  IncompleteAnimation = 6,
}

/**
 * Flags which allow a module to specify further details about the supported
 * operations.
 */
enum GdkPixbufFormatFlags : uint
{
  /**
   * the module can write out images in the format.
   */
  Writable = 1,

  /**
   * the image format is scalable
   */
  Scalable = 2,

  /**
   * the module is threadsafe. gdk-pixbuf
   * ignores modules that are not marked as threadsafe. $(LPAREN)Since 2.28$(RPAREN).
   */
  Threadsafe = 4,
}

/**
 * The possible rotations which can be passed to [GdkPixbuf.Pixbuf.rotateSimple].
 * To make them easier to use, their numerical values are the actual degrees.
 */
enum GdkPixbufRotation
{
  /**
   * No rotation.
   */
  None = 0,

  /**
   * Rotate by 90 degrees.
   */
  Counterclockwise = 90,

  /**
   * Rotate by 180 degrees.
   */
  Upsidedown = 180,

  /**
   * Rotate by 270 degrees.
   */
  Clockwise = 270,
}

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
struct PixbufC;

/**
 * An opaque object representing an animation.
 * The GdkPixBuf library provides a simple mechanism to load and
 * represent animations. An animation is conceptually a series of
 * frames to be displayed over time.
 * The animation may not be represented as a series of frames
 * internally; for example, it may be stored as a sprite and
 * instructions for moving the sprite around a background.
 * To display an animation you don't need to understand its
 * representation, however; you just ask `GdkPixbuf` what should
 * be displayed at a given point in time.
 */
struct GdkPixbufAnimation
{
  ObjectC parentInstance;
}

/**
 * Modules supporting animations must derive a type from
 * #GdkPixbufAnimation, providing suitable implementations of the
 * virtual functions.
 */
struct GdkPixbufAnimationClass
{
  /**
   * the parent class
   */
  GObjectClass parentClass;

  /**
   * returns whether the given animation is just a static image.
   */
  extern(C) bool function(GdkPixbufAnimation* animation) isStaticImage;

  /**
   * returns a static image representing the given animation.
   */
  extern(C) PixbufC* function(GdkPixbufAnimation* animation) getStaticImage;

  /**
   * fills @width and @height with the frame size of the animation.
   */
  extern(C) void function(GdkPixbufAnimation* animation, int* width, int* height) getSize;

  /**
   * returns an iterator for the given animation.
   */
  extern(C) GdkPixbufAnimationIter* function(GdkPixbufAnimation* animation, const(GTimeVal)* startTime) getIter;
}

/**
 * An opaque object representing an iterator which points to a
 * certain position in an animation.
 */
struct GdkPixbufAnimationIter
{
  ObjectC parentInstance;
}

/**
 * Modules supporting animations must derive a type from
 * #GdkPixbufAnimationIter, providing suitable implementations of the
 * virtual functions.
 */
struct GdkPixbufAnimationIterClass
{
  /**
   * the parent class
   */
  GObjectClass parentClass;

  /**
   * returns the time in milliseconds that the current frame
   * should be shown.
   */
  extern(C) int function(GdkPixbufAnimationIter* iter) getDelayTime;

  /**
   * returns the current frame.
   */
  extern(C) PixbufC* function(GdkPixbufAnimationIter* iter) getPixbuf;

  /**
   * returns whether the current frame of @iter is
   * being loaded.
   */
  extern(C) bool function(GdkPixbufAnimationIter* iter) onCurrentlyLoadingFrame;

  /**
   * advances the iterator to @current_time, possibly changing the
   * current frame.
   */
  extern(C) bool function(GdkPixbufAnimationIter* iter, const(GTimeVal)* currentTime) advance;
}

/**
 * A `GdkPixbufFormat` contains information about the image format accepted
 * by a module.
 * Only modules should access the fields directly, applications should
 * use the `gdk_pixbuf_format_*` family of functions.
 */
struct GdkPixbufFormat
{
  /**
   * the name of the image format
   */
  char* name;

  /**
   * the signature of the module
   */
  GdkPixbufModulePattern* signature;

  /**
   * the message domain for the `description`
   */
  char* domain;

  /**
   * a description of the image format
   */
  char* description;

  /**
   * the MIME types for the image format
   */
  char** mimeTypes;

  /**
   * typical filename extensions for the
   * image format
   */
  char** extensions;

  /**
   * a combination of `GdkPixbufFormatFlags`
   */
  uint flags;

  /**
   * a boolean determining whether the loader is disabled`
   */
  bool disabled;

  /**
   * a string containing license information, typically set to
   * shorthands like "GPL", "LGPL", etc.
   */
  char* license;
}

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
struct GdkPixbufLoader
{
  ObjectC parentInstance;

  void* priv;
}

struct GdkPixbufLoaderClass
{
  GObjectClass parentClass;

  extern(C) void function(GdkPixbufLoader* loader, int width, int height) sizePrepared;

  extern(C) void function(GdkPixbufLoader* loader) areaPrepared;

  extern(C) void function(GdkPixbufLoader* loader, int x, int y, int width, int height) areaUpdated;

  extern(C) void function(GdkPixbufLoader* loader) closed;
}

/**
 * A `GdkPixbufModule` contains the necessary functions to load and save
 * images in a certain file format.
 * If `GdkPixbuf` has been compiled with `GModule` support, it can be extended
 * by modules which can load $(LPAREN)and perhaps also save$(RPAREN) new image and animation
 * formats.
 * ## Implementing modules
 * The `GdkPixbuf` interfaces needed for implementing modules are contained in
 * `gdk-pixbuf-io.h` $(LPAREN)and `gdk-pixbuf-animation.h` if the module supports
 * animations$(RPAREN). They are not covered by the same stability guarantees as the
 * regular GdkPixbuf API. To underline this fact, they are protected by the
 * `GDK_PIXBUF_ENABLE_BACKEND` pre-processor symbol.
 * Each loadable module must contain a `GdkPixbufModuleFillVtableFunc` function
 * named `fill_vtable`, which will get called when the module
 * is loaded and must set the function pointers of the `GdkPixbufModule`.
 * In order to make format-checking work before actually loading the modules
 * $(LPAREN)which may require calling `dlopen` to load image libraries$(RPAREN), modules export
 * their signatures $(LPAREN)and other information$(RPAREN) via the `fill_info` function. An
 * external utility, `gdk-pixbuf-query-loaders`, uses this to create a text
 * file containing a list of all available loaders and  their signatures.
 * This file is then read at runtime by `GdkPixbuf` to obtain the list of
 * available loaders and their signatures.
 * Modules may only implement a subset of the functionality available via
 * `GdkPixbufModule`. If a particular functionality is not implemented, the
 * `fill_vtable` function will simply not set the corresponding
 * function pointers of the `GdkPixbufModule` structure. If a module supports
 * incremental loading $(LPAREN)i.e. provides `begin_load`, `stop_load` and
 * `load_increment`$(RPAREN), it doesn't have to implement `load`, since `GdkPixbuf`
 * can supply a generic `load` implementation wrapping the incremental loading.
 * ## Installing modules
 * Installing a module is a two-step process:
 * - copy the module file$(LPAREN)s$(RPAREN) to the loader directory $(LPAREN)normally
 * `\$libdir/gdk-pixbuf-2.0/\$version/loaders`, unless overridden by the
 * environment variable `GDK_PIXBUF_MODULEDIR`$(RPAREN)
 * - call `gdk-pixbuf-query-loaders` to update the module file $(LPAREN)normally
 * `\$libdir/gdk-pixbuf-2.0/\$version/loaders.cache`, unless overridden
 * by the environment variable `GDK_PIXBUF_MODULE_FILE`$(RPAREN)
 */
struct GdkPixbufModule
{
  /**
   * the name of the module, usually the same as the
   * usual file extension for images of this type, eg. "xpm", "jpeg" or "png".
   */
  char* moduleName;

  /**
   * the path from which the module is loaded.
   */
  char* modulePath;

  /**
   * the loaded `GModule`.
   */
  ModuleC* module_;

  /**
   * a `GdkPixbufFormat` holding information about the module.
   */
  GdkPixbufFormat* info;

  /**
   * loads an image from a file.
   */
  GdkPixbufModuleLoadFunc load;

  /**
   * loads an image from data in memory.
   */
  GdkPixbufModuleLoadXpmDataFunc loadXpmData;

  /**
   * begins an incremental load.
   */
  GdkPixbufModuleBeginLoadFunc beginLoad;

  /**
   * stops an incremental load.
   */
  GdkPixbufModuleStopLoadFunc stopLoad;

  /**
   * continues an incremental load.
   */
  GdkPixbufModuleIncrementLoadFunc loadIncrement;

  /**
   * loads an animation from a file.
   */
  GdkPixbufModuleLoadAnimationFunc loadAnimation;

  /**
   * saves a `GdkPixbuf` to a file.
   */
  GdkPixbufModuleSaveFunc save;

  /**
   * saves a `GdkPixbuf` by calling the given `GdkPixbufSaveFunc`.
   */
  GdkPixbufModuleSaveCallbackFunc saveToCallback;

  /**
   * returns whether a save option key is supported by the module
   */
  GdkPixbufModuleSaveOptionSupportedFunc isSaveOptionSupported;

  extern(C) void function() Reserved1;

  extern(C) void function() Reserved2;

  extern(C) void function() Reserved3;

  extern(C) void function() Reserved4;
}

/**
 * The signature prefix for a module.
 * The signature of a module is a set of prefixes. Prefixes are encoded as
 * pairs of ordinary strings, where the second string, called the mask, if
 * not `NULL`, must be of the same length as the first one and may contain
 * ' ', '!', 'x', 'z', and 'n' to indicate bytes that must be matched,
 * not matched, "don't-care"-bytes, zeros and non-zeros, respectively.
 * Each prefix has an associated integer that describes the relevance of
 * the prefix, with 0 meaning a mismatch and 100 a "perfect match".
 * Starting with gdk-pixbuf 2.8, the first byte of the mask may be '*',
 * indicating an unanchored pattern that matches not only at the beginning,
 * but also in the middle. Versions prior to 2.8 will interpret the '*'
 * like an 'x'.
 * The signature of a module is stored as an array of
 * `GdkPixbufModulePatterns`. The array is terminated by a pattern
 * where the `prefix` is `NULL`.
 * ```c
 * GdkPixbufModulePattern *signature[] \= {
 * { "abcdx", " !x z", 100 },
 * { "bla", NULL,  90 },
 * { NULL, NULL, 0 }
 * };
 * ```
 * In the example above, the signature matches e.g. "auud\0" with
 * relevance 100, and "blau" with relevance 90.
 */
struct GdkPixbufModulePattern
{
  /**
   * the prefix for this pattern
   */
  char* prefix;

  /**
   * mask containing bytes which modify how the prefix is matched against
   * test data
   */
  char* mask;

  /**
   * relevance of this pattern
   */
  int relevance;
}

/**
 * An opaque struct representing a simple animation.
 */
struct GdkPixbufSimpleAnim;

struct GdkPixbufSimpleAnimClass;

alias extern(C) void function(ubyte* pixels, void* data) GdkPixbufDestroyNotify;

alias extern(C) void* function(GdkPixbufModuleSizeFunc sizeFunc, GdkPixbufModulePreparedFunc preparedFunc, GdkPixbufModuleUpdatedFunc updatedFunc, void* userData, GError** _err) GdkPixbufModuleBeginLoadFunc;

alias extern(C) void function(GdkPixbufFormat* info) GdkPixbufModuleFillInfoFunc;

alias extern(C) void function(GdkPixbufModule* module_) GdkPixbufModuleFillVtableFunc;

alias extern(C) bool function(void* context, const(ubyte)* buf, uint size, GError** _err) GdkPixbufModuleIncrementLoadFunc;

alias extern(C) GdkPixbufAnimation* function(void* f, GError** _err) GdkPixbufModuleLoadAnimationFunc;

alias extern(C) PixbufC* function(void* f, GError** _err) GdkPixbufModuleLoadFunc;

alias extern(C) PixbufC* function(const(char*)* data) GdkPixbufModuleLoadXpmDataFunc;

alias extern(C) void function(PixbufC* pixbuf, GdkPixbufAnimation* anim, void* userData) GdkPixbufModulePreparedFunc;

alias extern(C) bool function(GdkPixbufSaveFunc saveFunc, void* userData, PixbufC* pixbuf, char** optionKeys, char** optionValues, GError** _err) GdkPixbufModuleSaveCallbackFunc;

alias extern(C) bool function(void* f, PixbufC* pixbuf, char** paramKeys, char** paramValues, GError** _err) GdkPixbufModuleSaveFunc;

alias extern(C) bool function(const(char)* optionKey) GdkPixbufModuleSaveOptionSupportedFunc;

alias extern(C) void function(int* width, int* height, void* userData) GdkPixbufModuleSizeFunc;

alias extern(C) bool function(void* context, GError** _err) GdkPixbufModuleStopLoadFunc;

alias extern(C) void function(PixbufC* pixbuf, int x, int y, int width, int height, void* userData) GdkPixbufModuleUpdatedFunc;

alias extern(C) bool function(const(ubyte)* buf, size_t count, GError** error, void* data) GdkPixbufSaveFunc;


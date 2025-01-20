module GdkPixbuf.PixbufAnimation;

import GLib.ErrorG;
import GLib.TimeVal;
import GObject.ObjectG;
import GdkPixbuf.Pixbuf;
import GdkPixbuf.PixbufAnimationIter;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Types;

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
class PixbufAnimation : ObjectG
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
    return gdk_pixbuf_animation_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new animation by loading it from a file.
   * The file format is detected automatically.
   * If the file's format does not support multi-frame images, then an animation
   * with a single frame will be created.
   * Possible errors are in the `GDK_PIXBUF_ERROR` and `G_FILE_ERROR` domains.
   * Params:
   *   filename = Name of file to load, in the GLib file
   *     name encoding
   * Returns: A newly-created animation
   */
  static PixbufAnimation newFromFile(string filename)
  {
    GdkPixbufAnimation* _cretval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_animation_new_from_file(_filename, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufAnimation(cast(GdkPixbufAnimation*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new pixbuf animation by loading an image from an resource.
   * The file format is detected automatically. If `NULL` is returned, then
   * error will be set.
   * Params:
   *   resourcePath = the path of the resource file
   * Returns: A newly-created animation
   */
  static PixbufAnimation newFromResource(string resourcePath)
  {
    GdkPixbufAnimation* _cretval;
    const(char)* _resourcePath = resourcePath.toCString(false);
    GError *_err;
    _cretval = gdk_pixbuf_animation_new_from_resource(_resourcePath, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufAnimation(cast(GdkPixbufAnimation*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new animation by loading it from an input stream.
   * The file format is detected automatically.
   * If `NULL` is returned, then error will be set.
   * The cancellable can be used to abort the operation from another thread.
   * If the operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
   * returned. Other possible errors are in the `GDK_PIXBUF_ERROR` and
   * `G_IO_ERROR` domains.
   * The stream is not closed.
   * Params:
   *   stream = a `GInputStream` to load the pixbuf from
   *   cancellable = optional `GCancellable` object
   * Returns: A newly-created animation
   */
  static PixbufAnimation newFromStream(InputStream stream, Cancellable cancellable)
  {
    GdkPixbufAnimation* _cretval;
    GError *_err;
    _cretval = gdk_pixbuf_animation_new_from_stream(stream ? cast(GInputStream*)stream.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufAnimation(cast(GdkPixbufAnimation*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Finishes an asynchronous pixbuf animation creation operation started with
   * [GdkPixbuf.PixbufAnimation.newFromStreamAsync].
   * Params:
   *   asyncResult = a #GAsyncResult
   * Returns: the newly created animation
   */
  static PixbufAnimation newFromStreamFinish(AsyncResult asyncResult)
  {
    GdkPixbufAnimation* _cretval;
    GError *_err;
    _cretval = gdk_pixbuf_animation_new_from_stream_finish(asyncResult ? cast(GAsyncResult*)(cast(ObjectG)asyncResult).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufAnimation(cast(GdkPixbufAnimation*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new animation by asynchronously loading an image from an input stream.
   * For more details see [GdkPixbuf.Pixbuf.newFromStream], which is the synchronous
   * version of this function.
   * When the operation is finished, `callback` will be called in the main thread.
   * You can then call [GdkPixbuf.PixbufAnimation.newFromStreamFinish] to get the
   * result of the operation.
   * Params:
   *   stream = a #GInputStream from which to load the animation
   *   cancellable = optional #GCancellable object
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
    gdk_pixbuf_animation_new_from_stream_async(stream ? cast(GInputStream*)stream.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Queries the height of the bounding box of a pixbuf animation.
   * Returns: Height of the bounding box of the animation.
   */
  int getHeight()
  {
    int _retval;
    _retval = gdk_pixbuf_animation_get_height(cast(GdkPixbufAnimation*)cPtr);
    return _retval;
  }

  /**
   * Get an iterator for displaying an animation.
   * The iterator provides the frames that should be displayed at a
   * given time.
   * start_time would normally come from [GLib.Global.getCurrentTime], and marks
   * the beginning of animation playback. After creating an iterator, you
   * should immediately display the pixbuf returned by
   * [GdkPixbuf.PixbufAnimationIter.getPixbuf]. Then, you should install
   * a timeout $(LPAREN)with [GLib.Global.timeoutAdd]$(RPAREN) or by some other mechanism ensure
   * that you'll update the image after
   * [GdkPixbuf.PixbufAnimationIter.getDelayTime] milliseconds. Each time
   * the image is updated, you should reinstall the timeout with the new,
   * possibly-changed delay time.
   * As a shortcut, if start_time is `NULL`, the result of
   * [GLib.Global.getCurrentTime] will be used automatically.
   * To update the image $(LPAREN)i.e. possibly change the result of
   * [GdkPixbuf.PixbufAnimationIter.getPixbuf] to a new frame of the animation$(RPAREN),
   * call [GdkPixbuf.PixbufAnimationIter.advance].
   * If you're using #GdkPixbufLoader, in addition to updating the image
   * after the delay time, you should also update it whenever you
   * receive the area_updated signal and
   * [GdkPixbuf.PixbufAnimationIter.onCurrentlyLoadingFrame] returns
   * `TRUE`. In this case, the frame currently being fed into the loader
   * has received new data, so needs to be refreshed. The delay time for
   * a frame may also be modified after an area_updated signal, for
   * example if the delay time for a frame is encoded in the data after
   * the frame itself. So your timeout should be reinstalled after any
   * area_updated signal.
   * A delay time of -1 is possible, indicating "infinite".
   * Params:
   *   startTime = time when the animation starts playing
   * Returns: an iterator to move over the animation
   */
  PixbufAnimationIter getIter(TimeVal startTime)
  {
    GdkPixbufAnimationIter* _cretval;
    _cretval = gdk_pixbuf_animation_get_iter(cast(GdkPixbufAnimation*)cPtr, startTime ? cast(GTimeVal*)startTime.cPtr : null);
    auto _retval = _cretval ? ObjectG.getDObject!PixbufAnimationIter(cast(GdkPixbufAnimationIter*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves a static image for the animation.
   * If an animation is really just a plain image $(LPAREN)has only one frame$(RPAREN),
   * this function returns that image.
   * If the animation is an animation, this function returns a reasonable
   * image to use as a static unanimated image, which might be the first
   * frame, or something more sophisticated depending on the file format.
   * If an animation hasn't loaded any frames yet, this function will
   * return `NULL`.
   * Returns: unanimated image representing the animation
   */
  Pixbuf getStaticImage()
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_animation_get_static_image(cast(GdkPixbufAnimation*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Queries the width of the bounding box of a pixbuf animation.
   * Returns: Width of the bounding box of the animation.
   */
  int getWidth()
  {
    int _retval;
    _retval = gdk_pixbuf_animation_get_width(cast(GdkPixbufAnimation*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the animation is a static image.
   * If you load a file with [GdkPixbuf.PixbufAnimation.newFromFile] and it
   * turns out to be a plain, unanimated image, then this function will
   * return `TRUE`. Use [GdkPixbuf.PixbufAnimation.getStaticImage] to retrieve
   * the image.
   * Returns: `TRUE` if the "animation" was really just an image
   */
  bool isStaticImage()
  {
    bool _retval;
    _retval = gdk_pixbuf_animation_is_static_image(cast(GdkPixbufAnimation*)cPtr);
    return _retval;
  }
}

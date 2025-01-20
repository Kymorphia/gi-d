module GdkPixbuf.PixbufAnimationIter;

import GLib.TimeVal;
import GObject.ObjectG;
import GdkPixbuf.Pixbuf;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

/**
 * An opaque object representing an iterator which points to a
 * certain position in an animation.
 */
class PixbufAnimationIter : ObjectG
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
    return gdk_pixbuf_animation_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Possibly advances an animation to a new frame.
   * Chooses the frame based on the start time passed to
   * [GdkPixbuf.PixbufAnimation.getIter].
   * current_time would normally come from [GLib.Global.getCurrentTime], and
   * must be greater than or equal to the time passed to
   * [GdkPixbuf.PixbufAnimation.getIter], and must increase or remain
   * unchanged each time [GdkPixbuf.PixbufAnimationIter.getPixbuf] is
   * called. That is, you can't go backward in time; animations only
   * play forward.
   * As a shortcut, pass `NULL` for the current time and [GLib.Global.getCurrentTime]
   * will be invoked on your behalf. So you only need to explicitly pass
   * current_time if you're doing something odd like playing the animation
   * at double speed.
   * If this function returns `FALSE`, there's no need to update the animation
   * display, assuming the display had been rendered prior to advancing;
   * if `TRUE`, you need to call [GdkPixbuf.PixbufAnimationIter.getPixbuf]
   * and update the display with the new pixbuf.
   * Params:
   *   currentTime = current time
   * Returns: `TRUE` if the image may need updating
   */
  bool advance(TimeVal currentTime)
  {
    bool _retval;
    _retval = gdk_pixbuf_animation_iter_advance(cast(GdkPixbufAnimationIter*)cPtr, currentTime ? cast(GTimeVal*)currentTime.cPtr : null);
    return _retval;
  }

  /**
   * Gets the number of milliseconds the current pixbuf should be displayed,
   * or -1 if the current pixbuf should be displayed forever.
   * The `[GLib.Global.timeoutAdd]` function conveniently takes a timeout in milliseconds,
   * so you can use a timeout to schedule the next update.
   * Note that some formats, like GIF, might clamp the timeout values in the
   * image file to avoid updates that are just too quick. The minimum timeout
   * for GIF images is currently 20 milliseconds.
   * Returns: delay time in milliseconds $(LPAREN)thousandths of a second$(RPAREN)
   */
  int getDelayTime()
  {
    int _retval;
    _retval = gdk_pixbuf_animation_iter_get_delay_time(cast(GdkPixbufAnimationIter*)cPtr);
    return _retval;
  }

  /**
   * Gets the current pixbuf which should be displayed.
   * The pixbuf might not be the same size as the animation itself
   * $(LPAREN)[GdkPixbuf.PixbufAnimation.getWidth], [GdkPixbuf.PixbufAnimation.getHeight]$(RPAREN).
   * This pixbuf should be displayed for [GdkPixbuf.PixbufAnimationIter.getDelayTime]
   * milliseconds.
   * The caller of this function does not own a reference to the returned
   * pixbuf; the returned pixbuf will become invalid when the iterator
   * advances to the next frame, which may happen anytime you call
   * [GdkPixbuf.PixbufAnimationIter.advance].
   * Copy the pixbuf to keep it $(LPAREN)don't just add a reference$(RPAREN), as it may get
   * recycled as you advance the iterator.
   * Returns: the pixbuf to be displayed
   */
  Pixbuf getPixbuf()
  {
    PixbufC* _cretval;
    _cretval = gdk_pixbuf_animation_iter_get_pixbuf(cast(GdkPixbufAnimationIter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Pixbuf(cast(PixbufC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Used to determine how to respond to the area_updated signal on
   * #GdkPixbufLoader when loading an animation.
   * The `::area_updated` signal is emitted for an area of the frame currently
   * streaming in to the loader. So if you're on the currently loading frame,
   * you will need to redraw the screen for the updated area.
   * Returns: `TRUE` if the frame we're on is partially loaded, or the last frame
   */
  bool onCurrentlyLoadingFrame()
  {
    bool _retval;
    _retval = gdk_pixbuf_animation_iter_on_currently_loading_frame(cast(GdkPixbufAnimationIter*)cPtr);
    return _retval;
  }
}

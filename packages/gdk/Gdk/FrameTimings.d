module Gdk.FrameTimings;

import GLib.Boxed;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * A `GdkFrameTimings` object holds timing information for a single frame
 * of the application’s displays.
 * To retrieve `GdkFrameTimings` objects, use [Gdk.FrameClock.getTimings]
 * or [Gdk.FrameClock.getCurrentTimings]. The information in
 * `GdkFrameTimings` is useful for precise synchronization of video with
 * the event or audio streams, and for measuring quality metrics for the
 * application’s display, such as latency and jitter.
 */
class FrameTimings : Boxed
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
    return gdk_frame_timings_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns whether timings are complete.
   * The timing information in a `GdkFrameTimings` is filled in
   * incrementally as the frame as drawn and passed off to the
   * window system for processing and display to the user. The
   * accessor functions for `GdkFrameTimings` can return 0 to
   * indicate an unavailable value for two reasons: either because
   * the information is not yet available, or because it isn't
   * available at all.
   * Once this function returns %TRUE for a frame, you can be
   * certain that no further values will become available and be
   * stored in the `GdkFrameTimings`.
   * Returns: %TRUE if all information that will be available
   *   for the frame has been filled in.
   */
  bool getComplete()
  {
    bool _retval;
    _retval = gdk_frame_timings_get_complete(cast(GdkFrameTimings*)cPtr);
    return _retval;
  }

  /**
   * Gets the frame counter value of the `GdkFrameClock` when
   * this frame was drawn.
   * Returns: the frame counter value for this frame
   */
  long getFrameCounter()
  {
    long _retval;
    _retval = gdk_frame_timings_get_frame_counter(cast(GdkFrameTimings*)cPtr);
    return _retval;
  }

  /**
   * Returns the frame time for the frame.
   * This is the time value that is typically used to time
   * animations for the frame. See [Gdk.FrameClock.getFrameTime].
   * Returns: the frame time for the frame, in the timescale
   *   of [GLib.Global.getMonotonicTime]
   */
  long getFrameTime()
  {
    long _retval;
    _retval = gdk_frame_timings_get_frame_time(cast(GdkFrameTimings*)cPtr);
    return _retval;
  }

  /**
   * Gets the predicted time at which this frame will be displayed.
   * Although no predicted time may be available, if one is available,
   * it will be available while the frame is being generated, in contrast
   * to [Gdk.FrameTimings.getPresentationTime], which is only
   * available after the frame has been presented.
   * In general, if you are simply animating, you should use
   * [Gdk.FrameClock.getFrameTime] rather than this function,
   * but this function is useful for applications that want exact control
   * over latency. For example, a movie player may want this information
   * for Audio/Video synchronization.
   * Returns: The predicted time at which the frame will be presented,
   *   in the timescale of [GLib.Global.getMonotonicTime], or 0 if no predicted
   *   presentation time is available.
   */
  long getPredictedPresentationTime()
  {
    long _retval;
    _retval = gdk_frame_timings_get_predicted_presentation_time(cast(GdkFrameTimings*)cPtr);
    return _retval;
  }

  /**
   * Reurns the presentation time.
   * This is the time at which the frame became visible to the user.
   * Returns: the time the frame was displayed to the user, in the
   *   timescale of [GLib.Global.getMonotonicTime], or 0 if no presentation
   *   time is available. See [Gdk.FrameTimings.getComplete]
   */
  long getPresentationTime()
  {
    long _retval;
    _retval = gdk_frame_timings_get_presentation_time(cast(GdkFrameTimings*)cPtr);
    return _retval;
  }

  /**
   * Gets the natural interval between presentation times for
   * the display that this frame was displayed on.
   * Frame presentation usually happens during the “vertical
   * blanking interval”.
   * Returns: the refresh interval of the display, in microseconds,
   *   or 0 if the refresh interval is not available.
   *   See [Gdk.FrameTimings.getComplete].
   */
  long getRefreshInterval()
  {
    long _retval;
    _retval = gdk_frame_timings_get_refresh_interval(cast(GdkFrameTimings*)cPtr);
    return _retval;
  }
}

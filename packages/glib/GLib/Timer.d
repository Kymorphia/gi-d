module GLib.Timer;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GTimer` records a start time, and counts microseconds elapsed since
 * that time.
 * This is done somewhat differently on different platforms, and can be
 * tricky to get exactly right, so `GTimer` provides a portable/convenient interface.
 */
class Timer
{
  GTimer* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Timer");

    cInstancePtr = cast(GTimer*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * If timer has been started but not stopped, obtains the time since
   * the timer was started. If timer has been stopped, obtains the
   * elapsed time between the time it was started and the time it was
   * stopped. The return value is the number of seconds elapsed,
   * including any fractional part.
   * Returns: seconds elapsed as a floating point value, including any
   *   fractional part.
   */
  double elapsed()
  {
    double _retval;
    _retval = g_timer_elapsed(cast(GTimer*)cPtr, null);
    return _retval;
  }

  /**
   * Resumes a timer that has previously been stopped with
   * [GLib.Timer.stop]. [GLib.Timer.stop] must be called before using this
   * function.
   */
  void continue_()
  {
    g_timer_continue(cast(GTimer*)cPtr);
  }

  /**
   * Destroys a timer, freeing associated resources.
   */
  void destroy()
  {
    g_timer_destroy(cast(GTimer*)cPtr);
  }

  /**
   * If timer has been started but not stopped, obtains the time since
   * the timer was started. If timer has been stopped, obtains the
   * elapsed time between the time it was started and the time it was
   * stopped. The return value is the number of seconds elapsed,
   * including any fractional part. The microseconds out parameter is
   * essentially useless.
   * Params:
   *   microseconds = return location for the fractional part of seconds
   *     elapsed, in microseconds $(LPAREN)that is, the total number
   *     of microseconds elapsed, modulo 1000000$(RPAREN), or %NULL
   * Returns: seconds elapsed as a floating point value, including any
   *   fractional part.
   */
  double elapsed(out ulong microseconds)
  {
    double _retval;
    _retval = g_timer_elapsed(cast(GTimer*)cPtr, cast(ulong*)&microseconds);
    return _retval;
  }

  /**
   * Exposes whether the timer is currently active.
   * Returns: %TRUE if the timer is running, %FALSE otherwise
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_timer_is_active(cast(GTimer*)cPtr);
    return _retval;
  }

  /**
   * This function is useless; it's fine to call [GLib.Timer.start] on an
   * already-started timer to reset the start time, so [GLib.Timer.reset]
   * serves no purpose.
   */
  void reset()
  {
    g_timer_reset(cast(GTimer*)cPtr);
  }

  /**
   * Marks a start time, so that future calls to [GLib.Timer.elapsed] will
   * report the time since [GLib.Timer.start] was called. [GLib.Timer.new_]
   * automatically marks the start time, so no need to call
   * [GLib.Timer.start] immediately after creating the timer.
   */
  void start()
  {
    g_timer_start(cast(GTimer*)cPtr);
  }

  /**
   * Marks an end time, so calls to [GLib.Timer.elapsed] will return the
   * difference between this end time and the start time.
   */
  void stop()
  {
    g_timer_stop(cast(GTimer*)cPtr);
  }

  /**
   * Creates a new timer, and starts timing $(LPAREN)i.e. [GLib.Timer.start] is
   * implicitly called for you$(RPAREN).
   * Returns: a new #GTimer.
   */
  this()
  {
    GTimer* _cretval;
    _cretval = g_timer_new();
    this(_cretval, true);
  }
}

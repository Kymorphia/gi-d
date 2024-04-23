module GLib.Timer;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * Opaque datatype that records a start time.
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

  T* cPtr(T)()
  if (is(T == GTimer))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Resumes a timer that has previously been stopped with
   * g_timer_stop(). g_timer_stop() must be called before using this
   * function.
   */
  void continue_()
  {
    g_timer_continue(cPtr!GTimer);
  }

  /**
   * Destroys a timer, freeing associated resources.
   */
  void destroy()
  {
    g_timer_destroy(cPtr!GTimer);
  }

  /**
   * seconds elapsed as a floating point value, including any
   * fractional part.
   */
  double elapsed(out ulong microseconds)
  {
    double _retval;
    _retval = g_timer_elapsed(cPtr!GTimer, cast(ulong*)&microseconds);
    return _retval;
  }

  /**
   * %TRUE if the timer is running, %FALSE otherwise
   */
  bool isActive()
  {
    bool _retval;
    _retval = g_timer_is_active(cPtr!GTimer);
    return _retval;
  }

  /**
   * This function is useless; it's fine to call g_timer_start() on an
   * already-started timer to reset the start time, so g_timer_reset()
   * serves no purpose.
   */
  void reset()
  {
    g_timer_reset(cPtr!GTimer);
  }

  /**
   * Marks a start time, so that future calls to g_timer_elapsed() will
   * report the time since g_timer_start() was called. g_timer_new()
   * automatically marks the start time, so no need to call
   * g_timer_start() immediately after creating the timer.
   */
  void start()
  {
    g_timer_start(cPtr!GTimer);
  }

  /**
   * Marks an end time, so calls to g_timer_elapsed() will return the
   * difference between this end time and the start time.
   */
  void stop()
  {
    g_timer_stop(cPtr!GTimer);
  }
}

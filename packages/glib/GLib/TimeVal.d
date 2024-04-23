module GLib.TimeVal;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * Represents a precise time, with seconds and microseconds.
 *
 * Similar to the struct timeval returned by the `gettimeofday()`
 * UNIX system call.
 *
 * GLib is attempting to unify around the use of 64-bit integers to
 * represent microsecond-precision time. As such, this type will be
 * removed from a future version of GLib. A consequence of using `glong` for
 * `tv_sec` is that on 32-bit systems `GTimeVal` is subject to the year 2038
 * problem.
 */
class TimeVal
{
  GTimeVal cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TimeVal");

    cInstance = *cast(GTimeVal*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTimeVal))
  {
    return cast(T*)&cInstance;
  }

  @property long tvSec()
  {
    return cPtr!GTimeVal.tvSec;
  }

  @property void tvSec(long propval)
  {
    cPtr!GTimeVal.tvSec = propval;
  }

  @property long tvUsec()
  {
    return cPtr!GTimeVal.tvUsec;
  }

  @property void tvUsec(long propval)
  {
    cPtr!GTimeVal.tvUsec = propval;
  }

  /**
   * Adds the given number of microseconds to @time_. @microseconds can
   * also be negative to decrease the value of @time_.
   */
  void add(long microseconds)
  {
    g_time_val_add(cPtr!GTimeVal, microseconds);
  }

  /**
   * a newly allocated string containing an ISO 8601 date,
   * or %NULL if @time_ was too large
   */
  string toIso8601()
  {
    char* _cretval;
    _cretval = g_time_val_to_iso8601(cPtr!GTimeVal);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if the conversion was successful.
   */
  static bool fromIso8601(string isoDate, out TimeVal time)
  {
    bool _retval;
    const(char)* _isoDate = isoDate.toCString(false);
    GTimeVal _time;
    _retval = g_time_val_from_iso8601(_isoDate, &_time);
    time = new TimeVal(cast(void*)&_time);
    return _retval;
  }
}

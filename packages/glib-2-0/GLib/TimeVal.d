module GLib.TimeVal;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * Represents a precise time, with seconds and microseconds.
 * Similar to the struct timeval returned by the `gettimeofday$(LPAREN)$(RPAREN)`
 * UNIX system call.
 * GLib is attempting to unify around the use of 64-bit integers to
 * represent microsecond-precision time. As such, this type will be
 * removed from a future version of GLib. A consequence of using `glong` for
 * `tv_sec` is that on 32-bit systems `GTimeVal` is subject to the year 2038
 * problem.

 * Deprecated: Use #GDateTime or #guint64 instead.
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property long tvSec()
  {
    return (cast(GTimeVal*)cPtr).tvSec;
  }

  @property void tvSec(long propval)
  {
    (cast(GTimeVal*)cPtr).tvSec = propval;
  }

  @property long tvUsec()
  {
    return (cast(GTimeVal*)cPtr).tvUsec;
  }

  @property void tvUsec(long propval)
  {
    (cast(GTimeVal*)cPtr).tvUsec = propval;
  }

  /**
   * Adds the given number of microseconds to time_. microseconds can
   * also be negative to decrease the value of time_.
   * Params:
   *   microseconds = number of microseconds to add to time

   * Deprecated: #GTimeVal is not year-2038-safe. Use `guint64` for
   *   representing microseconds since the epoch, or use #GDateTime.
   */
  void add(long microseconds)
  {
    g_time_val_add(cast(GTimeVal*)cPtr, microseconds);
  }

  /**
   * Converts time_ into an RFC 3339 encoded string, relative to the
   * Coordinated Universal Time $(LPAREN)UTC$(RPAREN). This is one of the many formats
   * allowed by ISO 8601.
   * ISO 8601 allows a large number of date/time formats, with or without
   * punctuation and optional elements. The format returned by this function
   * is a complete date and time, with optional punctuation included, the
   * UTC time zone represented as "Z", and the tv_usec part included if
   * and only if it is nonzero, i.e. either
   * "YYYY-MM-DDTHH:MM:SSZ" or "YYYY-MM-DDTHH:MM:SS.fffffZ".
   * This corresponds to the Internet date/time format defined by
   * [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt),
   * and to either of the two most-precise formats defined by
   * the W3C Note
   * [Date and Time Formats](http://www.w3.org/TR/NOTE-datetime-19980827).
   * Both of these documents are profiles of ISO 8601.
   * Use [GLib.DateTime.format] or [GLib.Global.strdupPrintf] if a different
   * variation of ISO 8601 format is required.
   * If time_ represents a date which is too large to fit into a `struct tm`,
   * %NULL will be returned. This is platform dependent. Note also that since
   * `GTimeVal` stores the number of seconds as a `glong`, on 32-bit systems it
   * is subject to the year 2038 problem. Accordingly, since GLib 2.62, this
   * function has been deprecated. Equivalent functionality is available using:
   * |[
   * GDateTime *dt \= g_date_time_new_from_unix_utc $(LPAREN)time_val$(RPAREN);
   * iso8601_string \= g_date_time_format_iso8601 $(LPAREN)dt$(RPAREN);
   * g_date_time_unref $(LPAREN)dt$(RPAREN);
   * ]|
   * The return value of [GLib.TimeVal.toIso8601] has been nullable since GLib
   * 2.54; before then, GLib would crash under the same conditions.
   * Returns: a newly allocated string containing an ISO 8601 date,
   *   or %NULL if time_ was too large

   * Deprecated: #GTimeVal is not year-2038-safe. Use
   *   g_date_time_format_iso8601$(LPAREN)dt$(RPAREN) instead.
   */
  string toIso8601()
  {
    char* _cretval;
    _cretval = g_time_val_to_iso8601(cast(GTimeVal*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Converts a string containing an ISO 8601 encoded date and time
   * to a #GTimeVal and puts it into time_.
   * iso_date must include year, month, day, hours, minutes, and
   * seconds. It can optionally include fractions of a second and a time
   * zone indicator. $(LPAREN)In the absence of any time zone indication, the
   * timestamp is assumed to be in local time.$(RPAREN)
   * Any leading or trailing space in iso_date is ignored.
   * This function was deprecated, along with #GTimeVal itself, in GLib 2.62.
   * Equivalent functionality is available using code like:
   * |[
   * GDateTime *dt \= g_date_time_new_from_iso8601 $(LPAREN)iso8601_string, NULL$(RPAREN);
   * gint64 time_val \= g_date_time_to_unix $(LPAREN)dt$(RPAREN);
   * g_date_time_unref $(LPAREN)dt$(RPAREN);
   * ]|
   * Params:
   *   isoDate = an ISO 8601 encoded date string
   *   time = a #GTimeVal
   * Returns: %TRUE if the conversion was successful.

   * Deprecated: #GTimeVal is not year-2038-safe. Use
   *   [GLib.DateTime.newFromIso8601] instead.
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

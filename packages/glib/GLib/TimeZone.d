module GLib.TimeZone;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GTimeZone` represents a time zone, at no particular point in time.
 * The `GTimeZone` struct is refcounted and immutable.
 * Each time zone has an identifier $(LPAREN)for example, ‘Europe/London’$(RPAREN) which is
 * platform dependent. See [GLib.TimeZone.new_] for information on the
 * identifier formats. The identifier of a time zone can be retrieved using
 * [GLib.TimeZone.getIdentifier].
 * A time zone contains a number of intervals. Each interval has an abbreviation
 * to describe it $(LPAREN)for example, ‘PDT’$(RPAREN), an offset to UTC and a flag indicating
 * if the daylight savings time is in effect during that interval. A time zone
 * always has at least one interval — interval 0. Note that interval abbreviations
 * are not the same as time zone identifiers $(LPAREN)apart from ‘UTC’$(RPAREN), and cannot be
 * passed to [GLib.TimeZone.new_].
 * Every UTC time is contained within exactly one interval, but a given
 * local time may be contained within zero, one or two intervals $(LPAREN)due to
 * incontinuities associated with daylight savings time$(RPAREN).
 * An interval may refer to a specific period of time $(LPAREN)eg: the duration
 * of daylight savings time during 2010$(RPAREN) or it may refer to many periods
 * of time that share the same properties $(LPAREN)eg: all periods of daylight
 * savings time$(RPAREN).  It is also possible $(LPAREN)usually for political reasons$(RPAREN)
 * that some properties $(LPAREN)like the abbreviation$(RPAREN) change between intervals
 * without other properties changing.
 */
class TimeZone : Boxed
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
    return g_time_zone_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * A version of [GLib.TimeZone.newIdentifier] which returns the UTC time zone
   * if identifier could not be parsed or loaded.
   * If you need to check whether identifier was loaded successfully, use
   * [GLib.TimeZone.newIdentifier].
   * Params:
   *   identifier = a timezone identifier
   * Returns: the requested timezone

   * Deprecated: Use [GLib.TimeZone.newIdentifier] instead, as it provides
   *   error reporting. Change your code to handle a potentially %NULL return
   *   value.
   */
  this(string identifier)
  {
    GTimeZone* _cretval;
    const(char)* _identifier = identifier.toCString(false);
    _cretval = g_time_zone_new(_identifier);
    this(_cretval, true);
  }

  /**
   * Creates a #GTimeZone corresponding to identifier. If identifier cannot be
   * parsed or loaded, %NULL is returned.
   * identifier can either be an RFC3339/ISO 8601 time offset or
   * something that would pass as a valid value for the `TZ` environment
   * variable $(LPAREN)including %NULL$(RPAREN).
   * In Windows, identifier can also be the unlocalized name of a time
   * zone for standard time, for example "Pacific Standard Time".
   * Valid RFC3339 time offsets are `"Z"` $(LPAREN)for UTC$(RPAREN) or
   * `"±hh:mm"`.  ISO 8601 additionally specifies
   * `"±hhmm"` and `"±hh"`.  Offsets are
   * time values to be added to Coordinated Universal Time $(LPAREN)UTC$(RPAREN) to get
   * the local time.
   * In UNIX, the `TZ` environment variable typically corresponds
   * to the name of a file in the zoneinfo database, an absolute path to a file
   * somewhere else, or a string in
   * "std offset [dst [offset],start[/time],end[/time]]" (POSIX) format.
   * There  are  no spaces in the specification. The name of standard
   * and daylight savings time zone must be three or more alphabetic
   * characters. Offsets are time values to be added to local time to
   * get Coordinated Universal Time $(LPAREN)UTC$(RPAREN) and should be
   * `"[±]hh[[:]mm[:ss]]"`.  Dates are either
   * `"Jn"` $(LPAREN)Julian day with n between 1 and 365, leap
   * years not counted$(RPAREN), `"n"` $(LPAREN)zero-based Julian day
   * with n between 0 and 365$(RPAREN) or `"Mm.w.d"` $(LPAREN)day d
   * $(LPAREN)0 <\= d <\= 6$(RPAREN) of week w $(LPAREN)1 <\= w <\= 5$(RPAREN) of month m $(LPAREN)1 <\= m <\= 12$(RPAREN), day
   * 0 is a Sunday$(RPAREN).  Times are in local wall clock time, the default is
   * 02:00:00.
   * In Windows, the "tzn[+|–]hh[:mm[:ss]][dzn]" format is used, but also
   * accepts POSIX format.  The Windows format uses US rules for all time
   * zones; daylight savings time is 60 minutes behind the standard time
   * with date and time of change taken from Pacific Standard Time.
   * Offsets are time values to be added to the local time to get
   * Coordinated Universal Time $(LPAREN)UTC$(RPAREN).
   * [GLib.TimeZone.newLocal] calls this function with the value of the
   * `TZ` environment variable. This function itself is independent of
   * the value of `TZ`, but if identifier is %NULL then `/etc/localtime`
   * will be consulted to discover the correct time zone on UNIX and the
   * registry will be consulted or GetTimeZoneInformation$(LPAREN)$(RPAREN) will be used
   * to get the local time zone on Windows.
   * If intervals are not available, only time zone rules from `TZ`
   * environment variable or other means, then they will be computed
   * from year 1900 to 2037.  If the maximum year for the rules is
   * available and it is greater than 2037, then it will followed
   * instead.
   * See
   * [RFC3339 §5.6](http://tools.ietf.org/html/rfc3339#section-5.6)
   * for a precise definition of valid RFC3339 time offsets
   * $(LPAREN)the `time-offset` expansion$(RPAREN) and ISO 8601 for the
   * full list of valid time offsets.  See
   * [The GNU C Library manual](http://www.gnu.org/s/libc/manual/html_node/TZ-Variable.html)
   * for an explanation of the possible
   * values of the `TZ` environment variable. See
   * [Microsoft Time Zone Index Values](http://msdn.microsoft.com/en-us/library/ms912391%28v\=winembedded.11%29.aspx)
   * for the list of time zones on Windows.
   * You should release the return value by calling [GLib.TimeZone.unref]
   * when you are done with it.
   * Params:
   *   identifier = a timezone identifier
   * Returns: the requested timezone, or %NULL on
   *   failure
   */
  static TimeZone newIdentifier(string identifier)
  {
    GTimeZone* _cretval;
    const(char)* _identifier = identifier.toCString(false);
    _cretval = g_time_zone_new_identifier(_identifier);
    auto _retval = _cretval ? new TimeZone(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTimeZone corresponding to local time.  The local time
   * zone may change between invocations to this function; for example,
   * if the system administrator changes it.
   * This is equivalent to calling [GLib.TimeZone.new_] with the value of
   * the `TZ` environment variable $(LPAREN)including the possibility of %NULL$(RPAREN).
   * You should release the return value by calling [GLib.TimeZone.unref]
   * when you are done with it.
   * Returns: the local timezone
   */
  static TimeZone newLocal()
  {
    GTimeZone* _cretval;
    _cretval = g_time_zone_new_local();
    auto _retval = _cretval ? new TimeZone(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTimeZone corresponding to the given constant offset from UTC,
   * in seconds.
   * This is equivalent to calling [GLib.TimeZone.new_] with a string in the form
   * `[+|-]hh[:mm[:ss]]`.
   * It is possible for this function to fail if seconds is too big $(LPAREN)greater than
   * 24 hours$(RPAREN), in which case this function will return the UTC timezone for
   * backwards compatibility. To detect failures like this, use
   * [GLib.TimeZone.newIdentifier] directly.
   * Params:
   *   seconds = offset to UTC, in seconds
   * Returns: a timezone at the given offset from UTC, or UTC on
   *   failure
   */
  static TimeZone newOffset(int seconds)
  {
    GTimeZone* _cretval;
    _cretval = g_time_zone_new_offset(seconds);
    auto _retval = _cretval ? new TimeZone(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GTimeZone corresponding to UTC.
   * This is equivalent to calling [GLib.TimeZone.new_] with a value like
   * "Z", "UTC", "+00", etc.
   * You should release the return value by calling [GLib.TimeZone.unref]
   * when you are done with it.
   * Returns: the universal timezone
   */
  static TimeZone newUtc()
  {
    GTimeZone* _cretval;
    _cretval = g_time_zone_new_utc();
    auto _retval = _cretval ? new TimeZone(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Finds an interval within tz that corresponds to the given time_,
   * possibly adjusting time_ if required to fit into an interval.
   * The meaning of time_ depends on type.
   * This function is similar to [GLib.TimeZone.findInterval], with the
   * difference that it always succeeds $(LPAREN)by making the adjustments
   * described below$(RPAREN).
   * In any of the cases where [GLib.TimeZone.findInterval] succeeds then
   * this function returns the same value, without modifying time_.
   * This function may, however, modify time_ in order to deal with
   * non-existent times.  If the non-existent local time_ of 02:30 were
   * requested on March 14th 2010 in Toronto then this function would
   * adjust time_ to be 03:00 and return the interval containing the
   * adjusted time.
   * Params:
   *   type = the #GTimeType of time_
   *   time = a pointer to a number of seconds since January 1, 1970
   * Returns: the interval containing time_, never -1
   */
  int adjustTime(TimeType type, ref long time)
  {
    int _retval;
    _retval = g_time_zone_adjust_time(cast(GTimeZone*)cPtr, type, cast(long*)&time);
    return _retval;
  }

  /**
   * Finds an interval within tz that corresponds to the given time_.
   * The meaning of time_ depends on type.
   * If type is %G_TIME_TYPE_UNIVERSAL then this function will always
   * succeed $(LPAREN)since universal time is monotonic and continuous$(RPAREN).
   * Otherwise time_ is treated as local time.  The distinction between
   * %G_TIME_TYPE_STANDARD and %G_TIME_TYPE_DAYLIGHT is ignored except in
   * the case that the given time_ is ambiguous.  In Toronto, for example,
   * 01:30 on November 7th 2010 occurred twice $(LPAREN)once inside of daylight
   * savings time and the next, an hour later, outside of daylight savings
   * time$(RPAREN).  In this case, the different value of type would result in a
   * different interval being returned.
   * It is still possible for this function to fail.  In Toronto, for
   * example, 02:00 on March 14th 2010 does not exist $(LPAREN)due to the leap
   * forward to begin daylight savings time$(RPAREN).  -1 is returned in that
   * case.
   * Params:
   *   type = the #GTimeType of time_
   *   time = a number of seconds since January 1, 1970
   * Returns: the interval containing time_, or -1 in case of failure
   */
  int findInterval(TimeType type, long time)
  {
    int _retval;
    _retval = g_time_zone_find_interval(cast(GTimeZone*)cPtr, type, time);
    return _retval;
  }

  /**
   * Determines the time zone abbreviation to be used during a particular
   * interval of time in the time zone tz.
   * For example, in Toronto this is currently "EST" during the winter
   * months and "EDT" during the summer months when daylight savings time
   * is in effect.
   * Params:
   *   interval = an interval within the timezone
   * Returns: the time zone abbreviation, which belongs to tz
   */
  string getAbbreviation(int interval)
  {
    const(char)* _cretval;
    _cretval = g_time_zone_get_abbreviation(cast(GTimeZone*)cPtr, interval);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Get the identifier of this #GTimeZone, as passed to [GLib.TimeZone.new_].
   * If the identifier passed at construction time was not recognised, `UTC` will
   * be returned. If it was %NULL, the identifier of the local timezone at
   * construction time will be returned.
   * The identifier will be returned in the same format as provided at
   * construction time: if provided as a time offset, that will be returned by
   * this function.
   * Returns: identifier for this timezone
   */
  string getIdentifier()
  {
    const(char)* _cretval;
    _cretval = g_time_zone_get_identifier(cast(GTimeZone*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Determines the offset to UTC in effect during a particular interval
   * of time in the time zone tz.
   * The offset is the number of seconds that you add to UTC time to
   * arrive at local time for tz $(LPAREN)ie: negative numbers for time zones
   * west of GMT, positive numbers for east$(RPAREN).
   * Params:
   *   interval = an interval within the timezone
   * Returns: the number of seconds that should be added to UTC to get the
   *   local time in tz
   */
  int getOffset(int interval)
  {
    int _retval;
    _retval = g_time_zone_get_offset(cast(GTimeZone*)cPtr, interval);
    return _retval;
  }

  /**
   * Determines if daylight savings time is in effect during a particular
   * interval of time in the time zone tz.
   * Params:
   *   interval = an interval within the timezone
   * Returns: %TRUE if daylight savings time is in effect
   */
  bool isDst(int interval)
  {
    bool _retval;
    _retval = g_time_zone_is_dst(cast(GTimeZone*)cPtr, interval);
    return _retval;
  }
}

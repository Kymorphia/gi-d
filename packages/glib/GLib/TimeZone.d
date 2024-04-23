module GLib.TimeZone;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * #GTimeZone is an opaque structure whose members cannot be accessed
 * directly.
 */
class TimeZone : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GTimeZone))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_time_zone_get_type();
  }

  /**
   * the requested timezone
   */
  this(string identifier)
  {
    GTimeZone* _cretval;
    const(char)* _identifier = identifier.toCString(false);
    _cretval = g_time_zone_new(_identifier);
    this(_cretval, true);
  }

  /**
   * the requested timezone, or %NULL on
   * failure
   */
  static TimeZone newIdentifier(string identifier)
  {
    GTimeZone* _cretval;
    const(char)* _identifier = identifier.toCString(false);
    _cretval = g_time_zone_new_identifier(_identifier);
    TimeZone _retval = new TimeZone(cast(GTimeZone*)_cretval, true);
    return _retval;
  }

  /**
   * the local timezone
   */
  static TimeZone newLocal()
  {
    GTimeZone* _cretval;
    _cretval = g_time_zone_new_local();
    TimeZone _retval = new TimeZone(cast(GTimeZone*)_cretval, true);
    return _retval;
  }

  /**
   * a timezone at the given offset from UTC, or UTC on
   * failure
   */
  static TimeZone newOffset(int seconds)
  {
    GTimeZone* _cretval;
    _cretval = g_time_zone_new_offset(seconds);
    TimeZone _retval = new TimeZone(cast(GTimeZone*)_cretval, true);
    return _retval;
  }

  /**
   * the universal timezone
   */
  static TimeZone newUtc()
  {
    GTimeZone* _cretval;
    _cretval = g_time_zone_new_utc();
    TimeZone _retval = new TimeZone(cast(GTimeZone*)_cretval, true);
    return _retval;
  }

  /**
   * the interval containing @time_, never -1
   */
  int adjustTime(TimeType type, inout long time)
  {
    int _retval;
    _retval = g_time_zone_adjust_time(cPtr!GTimeZone, type, cast(long*)&time);
    return _retval;
  }

  /**
   * the interval containing @time_, or -1 in case of failure
   */
  int findInterval(TimeType type, long time)
  {
    int _retval;
    _retval = g_time_zone_find_interval(cPtr!GTimeZone, type, time);
    return _retval;
  }

  /**
   * the time zone abbreviation, which belongs to @tz
   */
  string getAbbreviation(int interval)
  {
    const(char)* _cretval;
    _cretval = g_time_zone_get_abbreviation(cPtr!GTimeZone, interval);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * identifier for this timezone
   */
  string getIdentifier()
  {
    const(char)* _cretval;
    _cretval = g_time_zone_get_identifier(cPtr!GTimeZone);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the number of seconds that should be added to UTC to get the
   * local time in @tz
   */
  int getOffset(int interval)
  {
    int _retval;
    _retval = g_time_zone_get_offset(cPtr!GTimeZone, interval);
    return _retval;
  }

  /**
   * %TRUE if daylight savings time is in effect
   */
  bool isDst(int interval)
  {
    bool _retval;
    _retval = g_time_zone_is_dst(cPtr!GTimeZone, interval);
    return _retval;
  }
}

module GLib.DateTime;

import GLib.Boxed;
import GLib.TimeVal;
import GLib.TimeZone;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque structure that represents a date and time, including a time zone.
 */
class DateTime : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDateTime))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_date_time_get_type();
  }

  /**
   * a new #GDateTime, or %NULL
   */
  this(TimeZone tz, int year, int month, int day, int hour, int minute, double seconds)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new(tz ? tz.cPtr!GTimeZone : null, year, month, day, hour, minute, seconds);
    this(_cretval, true);
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newFromIso8601(string text, TimeZone defaultTz)
  {
    GDateTime* _cretval;
    const(char)* _text = text.toCString(false);
    _cretval = g_date_time_new_from_iso8601(_text, defaultTz ? defaultTz.cPtr!GTimeZone : null);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newFromTimevalLocal(TimeVal tv)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_from_timeval_local(tv ? tv.cPtr!GTimeVal : null);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newFromTimevalUtc(TimeVal tv)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_from_timeval_utc(tv ? tv.cPtr!GTimeVal : null);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newFromUnixLocal(long t)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_from_unix_local(t);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newFromUnixUtc(long t)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_from_unix_utc(t);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDateTime, or %NULL
   */
  static DateTime newLocal(int year, int month, int day, int hour, int minute, double seconds)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_local(year, month, day, hour, minute, seconds);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newNow(TimeZone tz)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_now(tz ? tz.cPtr!GTimeZone : null);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newNowLocal()
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_now_local();
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDateTime, or %NULL
   */
  static DateTime newNowUtc()
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_now_utc();
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDateTime, or %NULL
   */
  static DateTime newUtc(int year, int month, int day, int hour, int minute, double seconds)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_new_utc(year, month, day, hour, minute, seconds);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime add(TimeSpan timespan)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add(cPtr!GDateTime, timespan);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addDays(int days)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_days(cPtr!GDateTime, days);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addFull(int years, int months, int days, int hours, int minutes, double seconds)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_full(cPtr!GDateTime, years, months, days, hours, minutes, seconds);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addHours(int hours)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_hours(cPtr!GDateTime, hours);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addMinutes(int minutes)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_minutes(cPtr!GDateTime, minutes);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addMonths(int months)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_months(cPtr!GDateTime, months);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addSeconds(double seconds)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_seconds(cPtr!GDateTime, seconds);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addWeeks(int weeks)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_weeks(cPtr!GDateTime, weeks);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime addYears(int years)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_add_years(cPtr!GDateTime, years);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * -1, 0 or 1 if @dt1 is less than, equal to or greater
   * than @dt2.
   */
  int compare(DateTime dt2)
  {
    int _retval;
    _retval = g_date_time_compare(cPtr!GDateTime, dt2 ? dt2.cPtr!GDateTime : null);
    return _retval;
  }

  /**
   * the difference between the two #GDateTime, as a time
   * span expressed in microseconds.
   */
  TimeSpan difference(DateTime begin)
  {
    TimeSpan _retval;
    _retval = g_date_time_difference(cPtr!GDateTime, begin ? begin.cPtr!GDateTime : null);
    return _retval;
  }

  /**
   * %TRUE if @dt1 and @dt2 are equal
   */
  bool equal(DateTime dt2)
  {
    bool _retval;
    _retval = g_date_time_equal(cPtr!GDateTime, dt2 ? dt2.cPtr!GDateTime : null);
    return _retval;
  }

  /**
   * a newly allocated string formatted to
   * the requested format or %NULL in the case that there was an error (such
   * as a format specifier not being supported in the current locale). The
   * string should be freed with g_free().
   */
  string format(string format)
  {
    char* _cretval;
    const(char)* _format = format.toCString(false);
    _cretval = g_date_time_format(cPtr!GDateTime, _format);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated string formatted in
   * ISO 8601 format or %NULL in the case that there was an error. The string
   * should be freed with g_free().
   */
  string formatIso8601()
  {
    char* _cretval;
    _cretval = g_date_time_format_iso8601(cPtr!GDateTime);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the day of the month
   */
  int getDayOfMonth()
  {
    int _retval;
    _retval = g_date_time_get_day_of_month(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the day of the week
   */
  int getDayOfWeek()
  {
    int _retval;
    _retval = g_date_time_get_day_of_week(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the day of the year
   */
  int getDayOfYear()
  {
    int _retval;
    _retval = g_date_time_get_day_of_year(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the hour of the day
   */
  int getHour()
  {
    int _retval;
    _retval = g_date_time_get_hour(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the microsecond of the second
   */
  int getMicrosecond()
  {
    int _retval;
    _retval = g_date_time_get_microsecond(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the minute of the hour
   */
  int getMinute()
  {
    int _retval;
    _retval = g_date_time_get_minute(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the month represented by @datetime
   */
  int getMonth()
  {
    int _retval;
    _retval = g_date_time_get_month(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the second represented by @datetime
   */
  int getSecond()
  {
    int _retval;
    _retval = g_date_time_get_second(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the number of seconds
   */
  double getSeconds()
  {
    double _retval;
    _retval = g_date_time_get_seconds(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the time zone
   */
  TimeZone getTimezone()
  {
    GTimeZone* _cretval;
    _cretval = g_date_time_get_timezone(cPtr!GDateTime);
    TimeZone _retval = new TimeZone(cast(GTimeZone*)_cretval, false);
    return _retval;
  }

  /**
   * the time zone abbreviation. The returned
   * string is owned by the #GDateTime and it should not be
   * modified or freed
   */
  string getTimezoneAbbreviation()
  {
    const(char)* _cretval;
    _cretval = g_date_time_get_timezone_abbreviation(cPtr!GDateTime);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the number of microseconds that should be added to UTC to
   * get the local time
   */
  TimeSpan getUtcOffset()
  {
    TimeSpan _retval;
    _retval = g_date_time_get_utc_offset(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the ISO 8601 week-numbering year for @datetime
   */
  int getWeekNumberingYear()
  {
    int _retval;
    _retval = g_date_time_get_week_numbering_year(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the ISO 8601 week number for @datetime.
   */
  int getWeekOfYear()
  {
    int _retval;
    _retval = g_date_time_get_week_of_year(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the year represented by @datetime
   */
  int getYear()
  {
    int _retval;
    _retval = g_date_time_get_year(cPtr!GDateTime);
    return _retval;
  }

  /**
   * Retrieves the Gregorian day, month, and year of a given #GDateTime.
   */
  void getYmd(out int year, out int month, out int day)
  {
    g_date_time_get_ymd(cPtr!GDateTime, cast(int*)&year, cast(int*)&month, cast(int*)&day);
  }

  /**
   * a #guint containing the hash
   */
  uint hash()
  {
    uint _retval;
    _retval = g_date_time_hash(cPtr!GDateTime);
    return _retval;
  }

  /**
   * %TRUE if daylight savings time is in effect
   */
  bool isDaylightSavings()
  {
    bool _retval;
    _retval = g_date_time_is_daylight_savings(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime toLocal()
  {
    GDateTime* _cretval;
    _cretval = g_date_time_to_local(cPtr!GDateTime);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if successful, else %FALSE
   */
  bool toTimeval(TimeVal tv)
  {
    bool _retval;
    _retval = g_date_time_to_timeval(cPtr!GDateTime, tv ? tv.cPtr!GTimeVal : null);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime toTimezone(TimeZone tz)
  {
    GDateTime* _cretval;
    _cretval = g_date_time_to_timezone(cPtr!GDateTime, tz ? tz.cPtr!GTimeZone : null);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }

  /**
   * the Unix time corresponding to @datetime
   */
  long toUnix()
  {
    long _retval;
    _retval = g_date_time_to_unix(cPtr!GDateTime);
    return _retval;
  }

  /**
   * the newly created #GDateTime which
   * should be freed with g_date_time_unref(), or %NULL
   */
  DateTime toUtc()
  {
    GDateTime* _cretval;
    _cretval = g_date_time_to_utc(cPtr!GDateTime);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, true);
    return _retval;
  }
}

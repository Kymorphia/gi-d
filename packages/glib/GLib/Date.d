module GLib.Date;

import GLib.Boxed;
import GLib.TimeVal;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GDate` is a struct for calendrical calculations.
 * The `GDate` data structure represents a day between January 1, Year 1,
 * and sometime a few thousand years in the future $(LPAREN)right now it will go
 * to the year 65535 or so, but [GLib.Date.setParse] only parses up to the
 * year 8000 or so - just count on "a few thousand"$(RPAREN). `GDate` is meant to
 * represent everyday dates, not astronomical dates or historical dates
 * or ISO timestamps or the like. It extrapolates the current Gregorian
 * calendar forward and backward in time; there is no attempt to change
 * the calendar to match time periods or locations. `GDate` does not store
 * time information; it represents a day.
 * The `GDate` implementation has several nice features; it is only a
 * 64-bit struct, so storing large numbers of dates is very efficient. It
 * can keep both a Julian and day-month-year representation of the date,
 * since some calculations are much easier with one representation or the
 * other. A Julian representation is simply a count of days since some
 * fixed day in the past; for #GDate the fixed day is January 1, 1 AD.
 * $(LPAREN)"Julian" dates in the #GDate API aren't really Julian dates in the
 * technical sense; technically, Julian dates count from the start of the
 * Julian period, Jan 1, 4713 BC$(RPAREN).
 * `GDate` is simple to use. First you need a "blank" date; you can get a
 * dynamically allocated date from [GLib.Date.new_], or you can declare an
 * automatic variable or array and initialize it by calling [GLib.Date.clear].
 * A cleared date is safe; it's safe to call [GLib.Date.setDmy] and the other
 * mutator functions to initialize the value of a cleared date. However, a cleared date
 * is initially invalid, meaning that it doesn't represent a day that exists.
 * It is undefined to call any of the date calculation routines on an invalid date.
 * If you obtain a date from a user or other unpredictable source, you should check
 * its validity with the [GLib.Date.valid] predicate. [GLib.Date.valid]
 * is also used to check for errors with [GLib.Date.setParse] and other functions
 * that can fail. Dates can be invalidated by calling [GLib.Date.clear] again.
 * It is very important to use the API to access the `GDate` struct. Often only the
 * day-month-year or only the Julian representation is valid. Sometimes neither is valid.
 * Use the API.
 * GLib also features `GDateTime` which represents a precise time.
 */
class Date : Boxed
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
    return g_date_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property uint julianDays()
  {
    return (cast(GDate*)cPtr).julianDays;
  }

  @property void julianDays(uint propval)
  {
    (cast(GDate*)cPtr).julianDays = propval;
  }

  @property uint julian()
  {
    return (cast(GDate*)cPtr).julian;
  }

  @property void julian(uint propval)
  {
    (cast(GDate*)cPtr).julian = propval;
  }

  @property uint dmy()
  {
    return (cast(GDate*)cPtr).dmy;
  }

  @property void dmy(uint propval)
  {
    (cast(GDate*)cPtr).dmy = propval;
  }

  @property uint day()
  {
    return (cast(GDate*)cPtr).day;
  }

  @property void day(uint propval)
  {
    (cast(GDate*)cPtr).day = propval;
  }

  @property uint month()
  {
    return (cast(GDate*)cPtr).month;
  }

  @property void month(uint propval)
  {
    (cast(GDate*)cPtr).month = propval;
  }

  @property uint year()
  {
    return (cast(GDate*)cPtr).year;
  }

  @property void year(uint propval)
  {
    (cast(GDate*)cPtr).year = propval;
  }

  /**
   * Allocates a #GDate and initializes
   * it to a safe state. The new date will
   * be cleared $(LPAREN)as if you'd called [GLib.Date.clear]$(RPAREN) but invalid $(LPAREN)it won't
   * represent an existing day$(RPAREN). Free the return value with [GLib.Date.free].
   * Returns: a newly-allocated #GDate
   */
  this()
  {
    GDate* _cretval;
    _cretval = g_date_new();
    this(_cretval, true);
  }

  /**
   * Create a new #GDate representing the given day-month-year triplet.
   * The triplet you pass in must represent a valid date. Use [GLib.Date.validDmy]
   * if needed to validate it. The returned #GDate is guaranteed to be non-%NULL
   * and valid.
   * Params:
   *   day = day of the month
   *   month = month of the year
   *   year = year
   * Returns: a newly-allocated #GDate
   *   initialized with day, month, and year
   */
  static Date newDmy(DateDay day, DateMonth month, DateYear year)
  {
    GDate* _cretval;
    _cretval = g_date_new_dmy(day, month, year);
    auto _retval = _cretval ? new Date(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Create a new #GDate representing the given Julian date.
   * The julian_day you pass in must be valid. Use [GLib.Date.validJulian] if
   * needed to validate it. The returned #GDate is guaranteed to be non-%NULL and
   * valid.
   * Params:
   *   julianDay = days since January 1, Year 1
   * Returns: a newly-allocated #GDate initialized
   *   with julian_day
   */
  static Date newJulian(uint julianDay)
  {
    GDate* _cretval;
    _cretval = g_date_new_julian(julianDay);
    auto _retval = _cretval ? new Date(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Increments a date some number of days.
   * To move forward by weeks, add weeks*7 days.
   * The date must be valid.
   * Params:
   *   nDays = number of days to move the date forward
   */
  void addDays(uint nDays)
  {
    g_date_add_days(cast(GDate*)cPtr, nDays);
  }

  /**
   * Increments a date by some number of months.
   * If the day of the month is greater than 28,
   * this routine may change the day of the month
   * $(LPAREN)because the destination month may not have
   * the current day in it$(RPAREN). The date must be valid.
   * Params:
   *   nMonths = number of months to move forward
   */
  void addMonths(uint nMonths)
  {
    g_date_add_months(cast(GDate*)cPtr, nMonths);
  }

  /**
   * Increments a date by some number of years.
   * If the date is February 29, and the destination
   * year is not a leap year, the date will be changed
   * to February 28. The date must be valid.
   * Params:
   *   nYears = number of years to move forward
   */
  void addYears(uint nYears)
  {
    g_date_add_years(cast(GDate*)cPtr, nYears);
  }

  /**
   * If date is prior to min_date, sets date equal to min_date.
   * If date falls after max_date, sets date equal to max_date.
   * Otherwise, date is unchanged.
   * Either of min_date and max_date may be %NULL.
   * All non-%NULL dates must be valid.
   * Params:
   *   minDate = minimum accepted value for date
   *   maxDate = maximum accepted value for date
   */
  void clamp(Date minDate, Date maxDate)
  {
    g_date_clamp(cast(GDate*)cPtr, minDate ? cast(GDate*)minDate.cPtr(false) : null, maxDate ? cast(GDate*)maxDate.cPtr(false) : null);
  }

  /**
   * Initializes one or more #GDate structs to a safe but invalid
   * state. The cleared dates will not represent an existing date, but will
   * not contain garbage. Useful to init a date declared on the stack.
   * Validity can be tested with [GLib.Date.valid].
   * Params:
   *   nDates = number of dates to clear
   */
  void clear(uint nDates)
  {
    g_date_clear(cast(GDate*)cPtr, nDates);
  }

  /**
   * qsort$(LPAREN)$(RPAREN)-style comparison function for dates.
   * Both dates must be valid.
   * Params:
   *   rhs = second date to compare
   * Returns: 0 for equal, less than zero if lhs is less than rhs,
   *   greater than zero if lhs is greater than rhs
   */
  int compare(Date rhs)
  {
    int _retval;
    _retval = g_date_compare(cast(GDate*)cPtr, rhs ? cast(GDate*)rhs.cPtr(false) : null);
    return _retval;
  }

  /**
   * Copies a GDate to a newly-allocated GDate. If the input was invalid
   * $(LPAREN)as determined by [GLib.Date.valid]$(RPAREN), the invalid state will be copied
   * as is into the new object.
   * Returns: a newly-allocated #GDate initialized from date
   */
  Date copy()
  {
    GDate* _cretval;
    _cretval = g_date_copy(cast(GDate*)cPtr);
    auto _retval = _cretval ? new Date(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Computes the number of days between two dates.
   * If date2 is prior to date1, the returned value is negative.
   * Both dates must be valid.
   * Params:
   *   date2 = the second date
   * Returns: the number of days between date1 and date2
   */
  int daysBetween(Date date2)
  {
    int _retval;
    _retval = g_date_days_between(cast(GDate*)cPtr, date2 ? cast(GDate*)date2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the day of the month. The date must be valid.
   * Returns: day of the month
   */
  DateDay getDay()
  {
    DateDay _retval;
    _retval = g_date_get_day(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns the day of the year, where Jan 1 is the first day of the
   * year. The date must be valid.
   * Returns: day of the year
   */
  uint getDayOfYear()
  {
    uint _retval;
    _retval = g_date_get_day_of_year(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns the week of the year, where weeks are interpreted according
   * to ISO 8601.
   * Returns: ISO 8601 week number of the year.
   */
  uint getIso8601WeekOfYear()
  {
    uint _retval;
    _retval = g_date_get_iso8601_week_of_year(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns the Julian day or "serial number" of the #GDate. The
   * Julian day is simply the number of days since January 1, Year 1; i.e.,
   * January 1, Year 1 is Julian day 1; January 2, Year 1 is Julian day 2,
   * etc. The date must be valid.
   * Returns: Julian day
   */
  uint getJulian()
  {
    uint _retval;
    _retval = g_date_get_julian(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns the week of the year, where weeks are understood to start on
   * Monday. If the date is before the first Monday of the year, return 0.
   * The date must be valid.
   * Returns: week of the year
   */
  uint getMondayWeekOfYear()
  {
    uint _retval;
    _retval = g_date_get_monday_week_of_year(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns the month of the year. The date must be valid.
   * Returns: month of the year as a #GDateMonth
   */
  DateMonth getMonth()
  {
    GDateMonth _cretval;
    _cretval = g_date_get_month(cast(GDate*)cPtr);
    DateMonth _retval = cast(DateMonth)_cretval;
    return _retval;
  }

  /**
   * Returns the week of the year during which this date falls, if
   * weeks are understood to begin on Sunday. The date must be valid.
   * Can return 0 if the day is before the first Sunday of the year.
   * Returns: week number
   */
  uint getSundayWeekOfYear()
  {
    uint _retval;
    _retval = g_date_get_sunday_week_of_year(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns the day of the week for a #GDate. The date must be valid.
   * Returns: day of the week as a #GDateWeekday.
   */
  DateWeekday getWeekday()
  {
    GDateWeekday _cretval;
    _cretval = g_date_get_weekday(cast(GDate*)cPtr);
    DateWeekday _retval = cast(DateWeekday)_cretval;
    return _retval;
  }

  /**
   * Returns the year of a #GDate. The date must be valid.
   * Returns: year in which the date falls
   */
  DateYear getYear()
  {
    DateYear _retval;
    _retval = g_date_get_year(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the date is on the first of a month.
   * The date must be valid.
   * Returns: %TRUE if the date is the first of the month
   */
  bool isFirstOfMonth()
  {
    bool _retval;
    _retval = g_date_is_first_of_month(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the date is the last day of the month.
   * The date must be valid.
   * Returns: %TRUE if the date is the last day of the month
   */
  bool isLastOfMonth()
  {
    bool _retval;
    _retval = g_date_is_last_of_month(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Checks if date1 is less than or equal to date2,
   * and swap the values if this is not the case.
   * Params:
   *   date2 = the second date
   */
  void order(Date date2)
  {
    g_date_order(cast(GDate*)cPtr, date2 ? cast(GDate*)date2.cPtr(false) : null);
  }

  /**
   * Sets the day of the month for a #GDate. If the resulting
   * day-month-year triplet is invalid, the date will be invalid.
   * Params:
   *   day = day to set
   */
  void setDay(DateDay day)
  {
    g_date_set_day(cast(GDate*)cPtr, day);
  }

  /**
   * Sets the value of a #GDate from a day, month, and year.
   * The day-month-year triplet must be valid; if you aren't
   * sure it is, call [GLib.Date.validDmy] to check before you
   * set it.
   * Params:
   *   day = day
   *   month = month
   *   y = year
   */
  void setDmy(DateDay day, DateMonth month, DateYear y)
  {
    g_date_set_dmy(cast(GDate*)cPtr, day, month, y);
  }

  /**
   * Sets the value of a #GDate from a Julian day number.
   * Params:
   *   julianDate = Julian day number $(LPAREN)days since January 1, Year 1$(RPAREN)
   */
  void setJulian(uint julianDate)
  {
    g_date_set_julian(cast(GDate*)cPtr, julianDate);
  }

  /**
   * Sets the month of the year for a #GDate.  If the resulting
   * day-month-year triplet is invalid, the date will be invalid.
   * Params:
   *   month = month to set
   */
  void setMonth(DateMonth month)
  {
    g_date_set_month(cast(GDate*)cPtr, month);
  }

  /**
   * Parses a user-inputted string str, and try to figure out what date it
   * represents, taking the [current locale][setlocale] into account. If the
   * string is successfully parsed, the date will be valid after the call.
   * Otherwise, it will be invalid. You should check using [GLib.Date.valid]
   * to see whether the parsing succeeded.
   * This function is not appropriate for file formats and the like; it
   * isn't very precise, and its exact behavior varies with the locale.
   * It's intended to be a heuristic routine that guesses what the user
   * means by a given string $(LPAREN)and it does work pretty well in that
   * capacity$(RPAREN).
   * Params:
   *   str = string to parse
   */
  void setParse(string str)
  {
    const(char)* _str = str.toCString(false);
    g_date_set_parse(cast(GDate*)cPtr, _str);
  }

  /**
   * Sets the value of a date from a #GTime value.
   * The time to date conversion is done using the user's current timezone.
   * Params:
   *   time = #GTime value to set.

   * Deprecated: Use [GLib.Date.setTimeT] instead.
   */
  void setTime(Time time)
  {
    g_date_set_time(cast(GDate*)cPtr, time);
  }

  /**
   * Sets the value of a date to the date corresponding to a time
   * specified as a time_t. The time to date conversion is done using
   * the user's current timezone.
   * To set the value of a date to the current day, you could write:
   * |[<!-- language\="C" -->
   * time_t now \= time $(LPAREN)NULL$(RPAREN);
   * if $(LPAREN)now \=\= $(LPAREN)time_t$(RPAREN) -1$(RPAREN)
   * // handle the error
   * g_date_set_time_t $(LPAREN)date, now$(RPAREN);
   * ]|
   * Params:
   *   timet = time_t value to set
   */
  void setTimeT(long timet)
  {
    g_date_set_time_t(cast(GDate*)cPtr, timet);
  }

  /**
   * Sets the value of a date from a #GTimeVal value.  Note that the
   * tv_usec member is ignored, because #GDate can't make use of the
   * additional precision.
   * The time to date conversion is done using the user's current timezone.
   * Params:
   *   timeval = #GTimeVal value to set

   * Deprecated: #GTimeVal is not year-2038-safe. Use [GLib.Date.setTimeT]
   *   instead.
   */
  void setTimeVal(TimeVal timeval)
  {
    g_date_set_time_val(cast(GDate*)cPtr, timeval ? cast(GTimeVal*)timeval.cPtr : null);
  }

  /**
   * Sets the year for a #GDate. If the resulting day-month-year
   * triplet is invalid, the date will be invalid.
   * Params:
   *   year = year to set
   */
  void setYear(DateYear year)
  {
    g_date_set_year(cast(GDate*)cPtr, year);
  }

  /**
   * Moves a date some number of days into the past.
   * To move by weeks, just move by weeks*7 days.
   * The date must be valid.
   * Params:
   *   nDays = number of days to move
   */
  void subtractDays(uint nDays)
  {
    g_date_subtract_days(cast(GDate*)cPtr, nDays);
  }

  /**
   * Moves a date some number of months into the past.
   * If the current day of the month doesn't exist in
   * the destination month, the day of the month
   * may change. The date must be valid.
   * Params:
   *   nMonths = number of months to move
   */
  void subtractMonths(uint nMonths)
  {
    g_date_subtract_months(cast(GDate*)cPtr, nMonths);
  }

  /**
   * Moves a date some number of years into the past.
   * If the current day doesn't exist in the destination
   * year $(LPAREN)i.e. it's February 29 and you move to a non-leap-year$(RPAREN)
   * then the day is changed to February 29. The date
   * must be valid.
   * Params:
   *   nYears = number of years to move
   */
  void subtractYears(uint nYears)
  {
    g_date_subtract_years(cast(GDate*)cPtr, nYears);
  }

  /**
   * Fills in the date-related bits of a struct tm using the date value.
   * Initializes the non-date parts with something safe but meaningless.
   * Params:
   *   tm = struct tm to fill
   */
  void toStructTm(void* tm)
  {
    g_date_to_struct_tm(cast(GDate*)cPtr, tm);
  }

  /**
   * Returns %TRUE if the #GDate represents an existing day. The date must not
   * contain garbage; it should have been initialized with [GLib.Date.clear]
   * if it wasn't allocated by one of the [GLib.Date.new_] variants.
   * Returns: Whether the date is valid
   */
  bool valid()
  {
    bool _retval;
    _retval = g_date_valid(cast(GDate*)cPtr);
    return _retval;
  }

  /**
   * Returns the number of days in a month, taking leap
   * years into account.
   * Params:
   *   month = month
   *   year = year
   * Returns: number of days in month during the year
   */
  static ubyte getDaysInMonth(DateMonth month, DateYear year)
  {
    ubyte _retval;
    _retval = g_date_get_days_in_month(month, year);
    return _retval;
  }

  /**
   * Returns the number of weeks in the year, where weeks
   * are taken to start on Monday. Will be 52 or 53. The
   * date must be valid. $(LPAREN)Years always have 52 7-day periods,
   * plus 1 or 2 extra days depending on whether it's a leap
   * year. This function is basically telling you how many
   * Mondays are in the year, i.e. there are 53 Mondays if
   * one of the extra days happens to be a Monday.$(RPAREN)
   * Params:
   *   year = a year
   * Returns: number of Mondays in the year
   */
  static ubyte getMondayWeeksInYear(DateYear year)
  {
    ubyte _retval;
    _retval = g_date_get_monday_weeks_in_year(year);
    return _retval;
  }

  /**
   * Returns the number of weeks in the year, where weeks
   * are taken to start on Sunday. Will be 52 or 53. The
   * date must be valid. $(LPAREN)Years always have 52 7-day periods,
   * plus 1 or 2 extra days depending on whether it's a leap
   * year. This function is basically telling you how many
   * Sundays are in the year, i.e. there are 53 Sundays if
   * one of the extra days happens to be a Sunday.$(RPAREN)
   * Params:
   *   year = year to count weeks in
   * Returns: the number of weeks in year
   */
  static ubyte getSundayWeeksInYear(DateYear year)
  {
    ubyte _retval;
    _retval = g_date_get_sunday_weeks_in_year(year);
    return _retval;
  }

  /**
   * Returns %TRUE if the year is a leap year.
   * For the purposes of this function, leap year is every year
   * divisible by 4 unless that year is divisible by 100. If it
   * is divisible by 100 it would be a leap year only if that year
   * is also divisible by 400.
   * Params:
   *   year = year to check
   * Returns: %TRUE if the year is a leap year
   */
  static bool isLeapYear(DateYear year)
  {
    bool _retval;
    _retval = g_date_is_leap_year(year);
    return _retval;
  }

  /**
   * Generates a printed representation of the date, in a
   * [locale][setlocale]-specific way.
   * Works just like the platform's C library strftime$(LPAREN)$(RPAREN) function,
   * but only accepts date-related formats; time-related formats
   * give undefined results. Date must be valid. Unlike strftime$(LPAREN)$(RPAREN)
   * $(LPAREN)which uses the locale encoding$(RPAREN), works on a UTF-8 format
   * string and stores a UTF-8 result.
   * This function does not provide any conversion specifiers in
   * addition to those implemented by the platform's C library.
   * For example, don't expect that using [GLib.Date.strftime] would
   * make the \%F provided by the C99 strftime$(LPAREN)$(RPAREN) work on Windows
   * where the C library only complies to C89.
   * Params:
   *   s = destination buffer
   *   slen = buffer size
   *   format = format string
   *   date = valid #GDate
   * Returns: number of characters written to the buffer, or 0 the buffer was too small
   */
  static size_t strftime(string s, size_t slen, string format, Date date)
  {
    size_t _retval;
    char* _s = s.toCString(false);
    const(char)* _format = format.toCString(false);
    _retval = g_date_strftime(_s, slen, _format, date ? cast(GDate*)date.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns %TRUE if the day of the month is valid $(LPAREN)a day is valid if it's
   * between 1 and 31 inclusive$(RPAREN).
   * Params:
   *   day = day to check
   * Returns: %TRUE if the day is valid
   */
  static bool validDay(DateDay day)
  {
    bool _retval;
    _retval = g_date_valid_day(day);
    return _retval;
  }

  /**
   * Returns %TRUE if the day-month-year triplet forms a valid, existing day
   * in the range of days #GDate understands $(LPAREN)Year 1 or later, no more than
   * a few thousand years in the future$(RPAREN).
   * Params:
   *   day = day
   *   month = month
   *   year = year
   * Returns: %TRUE if the date is a valid one
   */
  static bool validDmy(DateDay day, DateMonth month, DateYear year)
  {
    bool _retval;
    _retval = g_date_valid_dmy(day, month, year);
    return _retval;
  }

  /**
   * Returns %TRUE if the Julian day is valid. Anything greater than zero
   * is basically a valid Julian, though there is a 32-bit limit.
   * Params:
   *   julianDate = Julian day to check
   * Returns: %TRUE if the Julian day is valid
   */
  static bool validJulian(uint julianDate)
  {
    bool _retval;
    _retval = g_date_valid_julian(julianDate);
    return _retval;
  }

  /**
   * Returns %TRUE if the month value is valid. The 12 #GDateMonth
   * enumeration values are the only valid months.
   * Params:
   *   month = month
   * Returns: %TRUE if the month is valid
   */
  static bool validMonth(DateMonth month)
  {
    bool _retval;
    _retval = g_date_valid_month(month);
    return _retval;
  }

  /**
   * Returns %TRUE if the weekday is valid. The seven #GDateWeekday enumeration
   * values are the only valid weekdays.
   * Params:
   *   weekday = weekday
   * Returns: %TRUE if the weekday is valid
   */
  static bool validWeekday(DateWeekday weekday)
  {
    bool _retval;
    _retval = g_date_valid_weekday(weekday);
    return _retval;
  }

  /**
   * Returns %TRUE if the year is valid. Any year greater than 0 is valid,
   * though there is a 16-bit limit to what #GDate will understand.
   * Params:
   *   year = year
   * Returns: %TRUE if the year is valid
   */
  static bool validYear(DateYear year)
  {
    bool _retval;
    _retval = g_date_valid_year(year);
    return _retval;
  }
}

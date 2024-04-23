module GLib.Date;

import GLib.Boxed;
import GLib.TimeVal;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * Represents a day between January 1, Year 1 and a few thousand years in
 * the future. None of its members should be accessed directly.
 *
 * If the `GDate` is obtained from g_date_new(), it will be safe
 * to mutate but invalid and thus not safe for calendrical computations.
 *
 * If it's declared on the stack, it will contain garbage so must be
 * initialized with g_date_clear(). g_date_clear() makes the date invalid
 * but safe. An invalid date doesn't represent a day, it's "empty." A date
 * becomes valid after you set it to a Julian day or you set a day, month,
 * and year.
 */
class Date : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDate))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_date_get_type();
  }

  @property uint julianDays()
  {
    return cPtr!GDate.julianDays;
  }

  @property void julianDays(uint propval)
  {
    cPtr!GDate.julianDays = propval;
  }

  @property uint julian()
  {
    return cPtr!GDate.julian;
  }

  @property void julian(uint propval)
  {
    cPtr!GDate.julian = propval;
  }

  @property uint dmy()
  {
    return cPtr!GDate.dmy;
  }

  @property void dmy(uint propval)
  {
    cPtr!GDate.dmy = propval;
  }

  @property uint day()
  {
    return cPtr!GDate.day;
  }

  @property void day(uint propval)
  {
    cPtr!GDate.day = propval;
  }

  @property uint month()
  {
    return cPtr!GDate.month;
  }

  @property void month(uint propval)
  {
    cPtr!GDate.month = propval;
  }

  @property uint year()
  {
    return cPtr!GDate.year;
  }

  @property void year(uint propval)
  {
    cPtr!GDate.year = propval;
  }

  /**
   * a newly-allocated #GDate
   */
  this()
  {
    GDate* _cretval;
    _cretval = g_date_new();
    this(_cretval, true);
  }

  /**
   * a newly-allocated #GDate
   * initialized with @day, @month, and @year
   */
  static Date newDmy(DateDay day, DateMonth month, DateYear year)
  {
    GDate* _cretval;
    _cretval = g_date_new_dmy(day, month, year);
    Date _retval = new Date(cast(GDate*)_cretval, true);
    return _retval;
  }

  /**
   * a newly-allocated #GDate initialized
   * with @julian_day
   */
  static Date newJulian(uint julianDay)
  {
    GDate* _cretval;
    _cretval = g_date_new_julian(julianDay);
    Date _retval = new Date(cast(GDate*)_cretval, true);
    return _retval;
  }

  /**
   * Increments a date some number of days.
   * To move forward by weeks, add weeks*7 days.
   * The date must be valid.
   */
  void addDays(uint nDays)
  {
    g_date_add_days(cPtr!GDate, nDays);
  }

  /**
   * Increments a date by some number of months.
   * If the day of the month is greater than 28,
   * this routine may change the day of the month
   * (because the destination month may not have
   * the current day in it). The date must be valid.
   */
  void addMonths(uint nMonths)
  {
    g_date_add_months(cPtr!GDate, nMonths);
  }

  /**
   * Increments a date by some number of years.
   * If the date is February 29, and the destination
   * year is not a leap year, the date will be changed
   * to February 28. The date must be valid.
   */
  void addYears(uint nYears)
  {
    g_date_add_years(cPtr!GDate, nYears);
  }

  /**
   * If @date is prior to @min_date, sets @date equal to @min_date.
   * If @date falls after @max_date, sets @date equal to @max_date.
   * Otherwise, @date is unchanged.
   * Either of @min_date and @max_date may be %NULL.
   * All non-%NULL dates must be valid.
   */
  void clamp(Date minDate, Date maxDate)
  {
    g_date_clamp(cPtr!GDate, minDate ? minDate.cPtr!GDate : null, maxDate ? maxDate.cPtr!GDate : null);
  }

  /**
   * Initializes one or more #GDate structs to a safe but invalid
   * state. The cleared dates will not represent an existing date, but will
   * not contain garbage. Useful to init a date declared on the stack.
   * Validity can be tested with g_date_valid().
   */
  void clear(uint nDates)
  {
    g_date_clear(cPtr!GDate, nDates);
  }

  /**
   * 0 for equal, less than zero if @lhs is less than @rhs,
   * greater than zero if @lhs is greater than @rhs
   */
  int compare(Date rhs)
  {
    int _retval;
    _retval = g_date_compare(cPtr!GDate, rhs ? rhs.cPtr!GDate : null);
    return _retval;
  }

  /**
   * a newly-allocated #GDate initialized from @date
   */
  Date copy()
  {
    GDate* _cretval;
    _cretval = g_date_copy(cPtr!GDate);
    Date _retval = new Date(cast(GDate*)_cretval, true);
    return _retval;
  }

  /**
   * the number of days between @date1 and @date2
   */
  int daysBetween(Date date2)
  {
    int _retval;
    _retval = g_date_days_between(cPtr!GDate, date2 ? date2.cPtr!GDate : null);
    return _retval;
  }

  /**
   * day of the month
   */
  DateDay getDay()
  {
    DateDay _retval;
    _retval = g_date_get_day(cPtr!GDate);
    return _retval;
  }

  /**
   * day of the year
   */
  uint getDayOfYear()
  {
    uint _retval;
    _retval = g_date_get_day_of_year(cPtr!GDate);
    return _retval;
  }

  /**
   * ISO 8601 week number of the year.
   */
  uint getIso8601WeekOfYear()
  {
    uint _retval;
    _retval = g_date_get_iso8601_week_of_year(cPtr!GDate);
    return _retval;
  }

  /**
   * Julian day
   */
  uint getJulian()
  {
    uint _retval;
    _retval = g_date_get_julian(cPtr!GDate);
    return _retval;
  }

  /**
   * week of the year
   */
  uint getMondayWeekOfYear()
  {
    uint _retval;
    _retval = g_date_get_monday_week_of_year(cPtr!GDate);
    return _retval;
  }

  /**
   * month of the year as a #GDateMonth
   */
  DateMonth getMonth()
  {
    GDateMonth _cretval;
    _cretval = g_date_get_month(cPtr!GDate);
    DateMonth _retval = cast(DateMonth)_cretval;
    return _retval;
  }

  /**
   * week number
   */
  uint getSundayWeekOfYear()
  {
    uint _retval;
    _retval = g_date_get_sunday_week_of_year(cPtr!GDate);
    return _retval;
  }

  /**
   * day of the week as a #GDateWeekday.
   */
  DateWeekday getWeekday()
  {
    GDateWeekday _cretval;
    _cretval = g_date_get_weekday(cPtr!GDate);
    DateWeekday _retval = cast(DateWeekday)_cretval;
    return _retval;
  }

  /**
   * year in which the date falls
   */
  DateYear getYear()
  {
    DateYear _retval;
    _retval = g_date_get_year(cPtr!GDate);
    return _retval;
  }

  /**
   * %TRUE if the date is the first of the month
   */
  bool isFirstOfMonth()
  {
    bool _retval;
    _retval = g_date_is_first_of_month(cPtr!GDate);
    return _retval;
  }

  /**
   * %TRUE if the date is the last day of the month
   */
  bool isLastOfMonth()
  {
    bool _retval;
    _retval = g_date_is_last_of_month(cPtr!GDate);
    return _retval;
  }

  /**
   * Checks if @date1 is less than or equal to @date2,
   * and swap the values if this is not the case.
   */
  void order(Date date2)
  {
    g_date_order(cPtr!GDate, date2 ? date2.cPtr!GDate : null);
  }

  /**
   * Sets the day of the month for a #GDate. If the resulting
   * day-month-year triplet is invalid, the date will be invalid.
   */
  void setDay(DateDay day)
  {
    g_date_set_day(cPtr!GDate, day);
  }

  /**
   * Sets the value of a #GDate from a day, month, and year.
   * The day-month-year triplet must be valid; if you aren't
   * sure it is, call g_date_valid_dmy() to check before you
   * set it.
   */
  void setDmy(DateDay day, DateMonth month, DateYear y)
  {
    g_date_set_dmy(cPtr!GDate, day, month, y);
  }

  /**
   * Sets the value of a #GDate from a Julian day number.
   */
  void setJulian(uint julianDate)
  {
    g_date_set_julian(cPtr!GDate, julianDate);
  }

  /**
   * Sets the month of the year for a #GDate.  If the resulting
   * day-month-year triplet is invalid, the date will be invalid.
   */
  void setMonth(DateMonth month)
  {
    g_date_set_month(cPtr!GDate, month);
  }

  /**
   * Parses a user-inputted string @str, and try to figure out what date it
   * represents, taking the [current locale][setlocale] into account. If the
   * string is successfully parsed, the date will be valid after the call.
   * Otherwise, it will be invalid. You should check using g_date_valid()
   * to see whether the parsing succeeded.
   *
   * This function is not appropriate for file formats and the like; it
   * isn't very precise, and its exact behavior varies with the locale.
   * It's intended to be a heuristic routine that guesses what the user
   * means by a given string (and it does work pretty well in that
   * capacity).
   */
  void setParse(string str)
  {
    const(char)* _str = str.toCString(false);
    g_date_set_parse(cPtr!GDate, _str);
  }

  /**
   * Sets the value of a date from a #GTime value.
   * The time to date conversion is done using the user's current timezone.
   */
  void setTime(Time time)
  {
    g_date_set_time(cPtr!GDate, time);
  }

  /**
   * Sets the value of a date to the date corresponding to a time
   * specified as a time_t. The time to date conversion is done using
   * the user's current timezone.
   *
   * To set the value of a date to the current day, you could write:
   * |[<!-- language="C" -->
   * time_t now = time (NULL);
   * if (now == (time_t) -1)
   * // handle the error
   * g_date_set_time_t (date, now);
   * ]|
   */
  void setTimeT(long timet)
  {
    g_date_set_time_t(cPtr!GDate, timet);
  }

  /**
   * Sets the value of a date from a #GTimeVal value.  Note that the
   * @tv_usec member is ignored, because #GDate can't make use of the
   * additional precision.
   *
   * The time to date conversion is done using the user's current timezone.
   */
  void setTimeVal(TimeVal timeval)
  {
    g_date_set_time_val(cPtr!GDate, timeval ? timeval.cPtr!GTimeVal : null);
  }

  /**
   * Sets the year for a #GDate. If the resulting day-month-year
   * triplet is invalid, the date will be invalid.
   */
  void setYear(DateYear year)
  {
    g_date_set_year(cPtr!GDate, year);
  }

  /**
   * Moves a date some number of days into the past.
   * To move by weeks, just move by weeks*7 days.
   * The date must be valid.
   */
  void subtractDays(uint nDays)
  {
    g_date_subtract_days(cPtr!GDate, nDays);
  }

  /**
   * Moves a date some number of months into the past.
   * If the current day of the month doesn't exist in
   * the destination month, the day of the month
   * may change. The date must be valid.
   */
  void subtractMonths(uint nMonths)
  {
    g_date_subtract_months(cPtr!GDate, nMonths);
  }

  /**
   * Moves a date some number of years into the past.
   * If the current day doesn't exist in the destination
   * year (i.e. it's February 29 and you move to a non-leap-year)
   * then the day is changed to February 29. The date
   * must be valid.
   */
  void subtractYears(uint nYears)
  {
    g_date_subtract_years(cPtr!GDate, nYears);
  }

  /**
   * Fills in the date-related bits of a struct tm using the @date value.
   * Initializes the non-date parts with something safe but meaningless.
   */
  void toStructTm(void* tm)
  {
    g_date_to_struct_tm(cPtr!GDate, tm);
  }

  /**
   * Whether the date is valid
   */
  bool valid()
  {
    bool _retval;
    _retval = g_date_valid(cPtr!GDate);
    return _retval;
  }

  /**
   * number of days in @month during the @year
   */
  static ubyte getDaysInMonth(DateMonth month, DateYear year)
  {
    ubyte _retval;
    _retval = g_date_get_days_in_month(month, year);
    return _retval;
  }

  /**
   * number of Mondays in the year
   */
  static ubyte getMondayWeeksInYear(DateYear year)
  {
    ubyte _retval;
    _retval = g_date_get_monday_weeks_in_year(year);
    return _retval;
  }

  /**
   * the number of weeks in @year
   */
  static ubyte getSundayWeeksInYear(DateYear year)
  {
    ubyte _retval;
    _retval = g_date_get_sunday_weeks_in_year(year);
    return _retval;
  }

  /**
   * %TRUE if the year is a leap year
   */
  static bool isLeapYear(DateYear year)
  {
    bool _retval;
    _retval = g_date_is_leap_year(year);
    return _retval;
  }

  /**
   * number of characters written to the buffer, or 0 the buffer was too small
   */
  static size_t strftime(string s, size_t slen, string format, Date date)
  {
    size_t _retval;
    char* _s = s.toCString(false);
    const(char)* _format = format.toCString(false);
    _retval = g_date_strftime(_s, slen, _format, date ? date.cPtr!GDate : null);
    return _retval;
  }

  /**
   * %TRUE if the day is valid
   */
  static bool validDay(DateDay day)
  {
    bool _retval;
    _retval = g_date_valid_day(day);
    return _retval;
  }

  /**
   * %TRUE if the date is a valid one
   */
  static bool validDmy(DateDay day, DateMonth month, DateYear year)
  {
    bool _retval;
    _retval = g_date_valid_dmy(day, month, year);
    return _retval;
  }

  /**
   * %TRUE if the Julian day is valid
   */
  static bool validJulian(uint julianDate)
  {
    bool _retval;
    _retval = g_date_valid_julian(julianDate);
    return _retval;
  }

  /**
   * %TRUE if the month is valid
   */
  static bool validMonth(DateMonth month)
  {
    bool _retval;
    _retval = g_date_valid_month(month);
    return _retval;
  }

  /**
   * %TRUE if the weekday is valid
   */
  static bool validWeekday(DateWeekday weekday)
  {
    bool _retval;
    _retval = g_date_valid_weekday(weekday);
    return _retval;
  }

  /**
   * %TRUE if the year is valid
   */
  static bool validYear(DateYear year)
  {
    bool _retval;
    _retval = g_date_valid_year(year);
    return _retval;
  }
}

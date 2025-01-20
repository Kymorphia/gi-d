module Gtk.Calendar;

import GLib.DateTime;
import GObject.DClosure;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkCalendar` is a widget that displays a Gregorian calendar, one month
 * at a time.
 * ![An example GtkCalendar](calendar.png)
 * A `GtkCalendar` can be created with [Gtk.Calendar.new_].
 * The date that is currently displayed can be altered with
 * [Gtk.Calendar.selectDay].
 * To place a visual marker on a particular day, use
 * [Gtk.Calendar.markDay] and to remove the marker,
 * [Gtk.Calendar.unmarkDay]. Alternative, all
 * marks can be cleared with [Gtk.Calendar.clearMarks].
 * The selected date can be retrieved from a `GtkCalendar` using
 * [Gtk.Calendar.getDate].
 * Users should be aware that, although the Gregorian calendar is the
 * legal calendar in most countries, it was adopted progressively
 * between 1582 and 1929. Display before these dates is likely to be
 * historically incorrect.
 * # CSS nodes
 * ```
 * calendar.view
 * ├── header
 * │   ├── button
 * │   ├── stack.month
 * │   ├── button
 * │   ├── button
 * │   ├── label.year
 * │   ╰── button
 * ╰── grid
 * ╰── label[.day-name][.week-number][.day-number][.other-month][.today]
 * ```
 * `GtkCalendar` has a main node with name calendar. It contains a subnode
 * called header containing the widgets for switching between years and months.
 * The grid subnode contains all day labels, including week numbers on the left
 * $(LPAREN)marked with the .week-number css class$(RPAREN) and day names on top $(LPAREN)marked with the
 * .day-name css class$(RPAREN).
 * Day labels that belong to the previous or next month get the .other-month
 * style class. The label of the current day get the .today style class.
 * Marked day labels get the :selected state assigned.
 */
class Calendar : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_calendar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new calendar, with the current date being selected.
   * Returns: a newly `GtkCalendar` widget
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_calendar_new();
    this(_cretval, false);
  }

  /**
   * Remove all visual markers.
   */
  void clearMarks()
  {
    gtk_calendar_clear_marks(cast(GtkCalendar*)cPtr);
  }

  /**
   * Returns a `GDateTime` representing the shown
   * year, month and the selected day.
   * The returned date is in the local time zone.
   * Returns: the `GDateTime` representing the shown date
   */
  DateTime getDate()
  {
    GDateTime* _cretval;
    _cretval = gtk_calendar_get_date(cast(GtkCalendar*)cPtr);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the day of the selected date.
   * Returns: the day of the selected date.
   */
  int getDay()
  {
    int _retval;
    _retval = gtk_calendar_get_day(cast(GtkCalendar*)cPtr);
    return _retval;
  }

  /**
   * Returns if the day of the calendar is already marked.
   * Params:
   *   day = the day number between 1 and 31.
   * Returns: whether the day is marked.
   */
  bool getDayIsMarked(uint day)
  {
    bool _retval;
    _retval = gtk_calendar_get_day_is_marked(cast(GtkCalendar*)cPtr, day);
    return _retval;
  }

  /**
   * Gets the month of the selected date.
   * Returns: The month of the selected date $(LPAREN)as a number between 0 and 11$(RPAREN).
   */
  int getMonth()
  {
    int _retval;
    _retval = gtk_calendar_get_month(cast(GtkCalendar*)cPtr);
    return _retval;
  }

  /**
   * Returns whether self is currently showing the names
   * of the week days.
   * This is the value of the propertyGtk.Calendar:show-day-names
   * property.
   * Returns: Whether the calendar shows day names.
   */
  bool getShowDayNames()
  {
    bool _retval;
    _retval = gtk_calendar_get_show_day_names(cast(GtkCalendar*)cPtr);
    return _retval;
  }

  /**
   * Returns whether self is currently showing the heading.
   * This is the value of the propertyGtk.Calendar:show-heading
   * property.
   * Returns: Whether the calendar is showing a heading.
   */
  bool getShowHeading()
  {
    bool _retval;
    _retval = gtk_calendar_get_show_heading(cast(GtkCalendar*)cPtr);
    return _retval;
  }

  /**
   * Returns whether self is showing week numbers right
   * now.
   * This is the value of the propertyGtk.Calendar:show-week-numbers
   * property.
   * Returns: Whether the calendar is showing week numbers.
   */
  bool getShowWeekNumbers()
  {
    bool _retval;
    _retval = gtk_calendar_get_show_week_numbers(cast(GtkCalendar*)cPtr);
    return _retval;
  }

  /**
   * Gets the year of the selected date.
   * Returns: the year of the selected date.
   */
  int getYear()
  {
    int _retval;
    _retval = gtk_calendar_get_year(cast(GtkCalendar*)cPtr);
    return _retval;
  }

  /**
   * Places a visual marker on a particular day of the current month.
   * Params:
   *   day = the day number to mark between 1 and 31.
   */
  void markDay(uint day)
  {
    gtk_calendar_mark_day(cast(GtkCalendar*)cPtr, day);
  }

  /**
   * Switches to date's year and month and select its day.
   * Params:
   *   date = a `GDateTime` representing the day to select
   */
  void selectDay(DateTime date)
  {
    gtk_calendar_select_day(cast(GtkCalendar*)cPtr, date ? cast(GDateTime*)date.cPtr(false) : null);
  }

  /**
   * Sets the day for the selected date.
   * The new date must be valid. For example, setting 31 for the day when the
   * month is February, fails.
   * Params:
   *   day = The desired day for the selected date $(LPAREN)as a number between 1 and 31$(RPAREN).
   */
  void setDay(int day)
  {
    gtk_calendar_set_day(cast(GtkCalendar*)cPtr, day);
  }

  /**
   * Sets the month for the selected date.
   * The new date must be valid. For example, setting 1 $(LPAREN)February$(RPAREN) for the month
   * when the day is 31, fails.
   * Params:
   *   month = The desired month for the selected date $(LPAREN)as a number between 0 and 11$(RPAREN).
   */
  void setMonth(int month)
  {
    gtk_calendar_set_month(cast(GtkCalendar*)cPtr, month);
  }

  /**
   * Sets whether the calendar shows day names.
   * Params:
   *   value = Whether to show day names above the day numbers
   */
  void setShowDayNames(bool value)
  {
    gtk_calendar_set_show_day_names(cast(GtkCalendar*)cPtr, value);
  }

  /**
   * Sets whether the calendar should show a heading.
   * The heading contains the current year and month as well as
   * buttons for changing both.
   * Params:
   *   value = Whether to show the heading in the calendar
   */
  void setShowHeading(bool value)
  {
    gtk_calendar_set_show_heading(cast(GtkCalendar*)cPtr, value);
  }

  /**
   * Sets whether week numbers are shown in the calendar.
   * Params:
   *   value = whether to show week numbers on the left of the days
   */
  void setShowWeekNumbers(bool value)
  {
    gtk_calendar_set_show_week_numbers(cast(GtkCalendar*)cPtr, value);
  }

  /**
   * Sets the year for the selected date.
   * The new date must be valid. For example, setting 2023 for the year when then
   * the date is 2024-02-29, fails.
   * Params:
   *   year = The desired year for the selected date $(LPAREN)within [GLib.DateTime]
   *     limits, i.e. from 0001 to 9999$(RPAREN).
   */
  void setYear(int year)
  {
    gtk_calendar_set_year(cast(GtkCalendar*)cPtr, year);
  }

  /**
   * Removes the visual marker from a particular day.
   * Params:
   *   day = the day number to unmark between 1 and 31.
   */
  void unmarkDay(uint day)
  {
    gtk_calendar_unmark_day(cast(GtkCalendar*)cPtr, day);
  }

  /**
   * Emitted when the user selects a day.
   *   calendar = the instance the signal is connected to
   */
  alias DaySelectedCallback = void delegate(Calendar calendar);

  /**
   * Connect to DaySelected signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDaySelected(DaySelectedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto calendar = getVal!Calendar(_paramVals);
      _dgClosure.dlg(calendar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("day-selected", closure, after);
  }

  /**
   * Emitted when the user switched to the next month.
   *   calendar = the instance the signal is connected to
   */
  alias NextMonthCallback = void delegate(Calendar calendar);

  /**
   * Connect to NextMonth signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectNextMonth(NextMonthCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto calendar = getVal!Calendar(_paramVals);
      _dgClosure.dlg(calendar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("next-month", closure, after);
  }

  /**
   * Emitted when user switched to the next year.
   *   calendar = the instance the signal is connected to
   */
  alias NextYearCallback = void delegate(Calendar calendar);

  /**
   * Connect to NextYear signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectNextYear(NextYearCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto calendar = getVal!Calendar(_paramVals);
      _dgClosure.dlg(calendar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("next-year", closure, after);
  }

  /**
   * Emitted when the user switched to the previous month.
   *   calendar = the instance the signal is connected to
   */
  alias PrevMonthCallback = void delegate(Calendar calendar);

  /**
   * Connect to PrevMonth signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPrevMonth(PrevMonthCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto calendar = getVal!Calendar(_paramVals);
      _dgClosure.dlg(calendar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("prev-month", closure, after);
  }

  /**
   * Emitted when user switched to the previous year.
   *   calendar = the instance the signal is connected to
   */
  alias PrevYearCallback = void delegate(Calendar calendar);

  /**
   * Connect to PrevYear signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPrevYear(PrevYearCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto calendar = getVal!Calendar(_paramVals);
      _dgClosure.dlg(calendar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("prev-year", closure, after);
  }
}

module Gtk.EventControllerScroll;

import GObject.DClosure;
import Gdk.Types;
import Gid.gid;
import Gtk.EventController;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkEventControllerScroll` is an event controller that handles scroll
 * events.
 * It is capable of handling both discrete and continuous scroll
 * events from mice or touchpads, abstracting them both with the
 * [Gtk.EventControllerScroll.scroll] signal. Deltas in
 * the discrete case are multiples of 1.
 * In the case of continuous scroll events, `GtkEventControllerScroll`
 * encloses all [Gtk.EventControllerScroll.scroll] emissions
 * between two [Gtk.EventControllerScroll.scroll] and
 * [Gtk.EventControllerScroll.scroll] signals.
 * The behavior of the event controller can be modified by the flags
 * given at creation time, or modified at a later point through
 * [Gtk.EventControllerScroll.setFlags] $(LPAREN)e.g. because the scrolling
 * conditions of the widget changed$(RPAREN).
 * The controller can be set up to emit motion for either/both vertical
 * and horizontal scroll events through %GTK_EVENT_CONTROLLER_SCROLL_VERTICAL,
 * %GTK_EVENT_CONTROLLER_SCROLL_HORIZONTAL and %GTK_EVENT_CONTROLLER_SCROLL_BOTH_AXES.
 * If any axis is disabled, the respective [Gtk.EventControllerScroll.scroll]
 * delta will be 0. Vertical scroll events will be translated to horizontal
 * motion for the devices incapable of horizontal scrolling.
 * The event controller can also be forced to emit discrete events on all
 * devices through %GTK_EVENT_CONTROLLER_SCROLL_DISCRETE. This can be used
 * to implement discrete actions triggered through scroll events $(LPAREN)e.g.
 * switching across combobox options$(RPAREN).
 * The %GTK_EVENT_CONTROLLER_SCROLL_KINETIC flag toggles the emission of the
 * [Gtk.EventControllerScroll.decelerate] signal, emitted at the end
 * of scrolling with two X/Y velocity arguments that are consistent with the
 * motion that was received.
 */
class EventControllerScroll : EventController
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_event_controller_scroll_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new event controller that will handle scroll events.
   * Params:
   *   flags = flags affecting the controller behavior
   * Returns: a new `GtkEventControllerScroll`
   */
  this(EventControllerScrollFlags flags)
  {
    GtkEventController* _cretval;
    _cretval = gtk_event_controller_scroll_new(flags);
    this(_cretval, true);
  }

  /**
   * Gets the flags conditioning the scroll controller behavior.
   * Returns: the controller flags.
   */
  EventControllerScrollFlags getFlags()
  {
    GtkEventControllerScrollFlags _cretval;
    _cretval = gtk_event_controller_scroll_get_flags(cast(GtkEventControllerScroll*)cPtr);
    EventControllerScrollFlags _retval = cast(EventControllerScrollFlags)_cretval;
    return _retval;
  }

  /**
   * Gets the scroll unit of the last
   * [Gtk.EventControllerScroll.scroll] signal received.
   * Always returns %GDK_SCROLL_UNIT_WHEEL if the
   * %GTK_EVENT_CONTROLLER_SCROLL_DISCRETE flag is set.
   * Returns: the scroll unit.
   */
  ScrollUnit getUnit()
  {
    GdkScrollUnit _cretval;
    _cretval = gtk_event_controller_scroll_get_unit(cast(GtkEventControllerScroll*)cPtr);
    ScrollUnit _retval = cast(ScrollUnit)_cretval;
    return _retval;
  }

  /**
   * Sets the flags conditioning scroll controller behavior.
   * Params:
   *   flags = flags affecting the controller behavior
   */
  void setFlags(EventControllerScrollFlags flags)
  {
    gtk_event_controller_scroll_set_flags(cast(GtkEventControllerScroll*)cPtr, flags);
  }

  /**
   * Emitted after scroll is finished if the
   * %GTK_EVENT_CONTROLLER_SCROLL_KINETIC flag is set.
   * vel_x and vel_y express the initial velocity that was
   * imprinted by the scroll events. vel_x and vel_y are expressed in
   * pixels/ms.
   * Params
   *   velX = X velocity
   *   velY = Y velocity
   *   eventControllerScroll = the instance the signal is connected to
   */
  alias DecelerateCallback = void delegate(double velX, double velY, EventControllerScroll eventControllerScroll);

  /**
   * Connect to Decelerate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDecelerate(DecelerateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto eventControllerScroll = getVal!EventControllerScroll(_paramVals);
      auto velX = getVal!double(&_paramVals[1]);
      auto velY = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(velX, velY, eventControllerScroll);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("decelerate", closure, after);
  }

  /**
   * Signals that the widget should scroll by the
   * amount specified by dx and dy.
   * For the representation unit of the deltas, see
   * [Gtk.EventControllerScroll.getUnit].
   * Params
   *   dx = X delta
   *   dy = Y delta
   *   eventControllerScroll = the instance the signal is connected to
   * Returns: %TRUE if the scroll event was handled,
   *   %FALSE otherwise.
   */
  alias ScrollCallback = bool delegate(double dx, double dy, EventControllerScroll eventControllerScroll);

  /**
   * Connect to Scroll signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectScroll(ScrollCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto eventControllerScroll = getVal!EventControllerScroll(_paramVals);
      auto dx = getVal!double(&_paramVals[1]);
      auto dy = getVal!double(&_paramVals[2]);
      _retval = _dgClosure.dlg(dx, dy, eventControllerScroll);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("scroll", closure, after);
  }

  /**
   * Signals that a new scrolling operation has begun.
   * It will only be emitted on devices capable of it.
   *   eventControllerScroll = the instance the signal is connected to
   */
  alias ScrollBeginCallback = void delegate(EventControllerScroll eventControllerScroll);

  /**
   * Connect to ScrollBegin signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectScrollBegin(ScrollBeginCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto eventControllerScroll = getVal!EventControllerScroll(_paramVals);
      _dgClosure.dlg(eventControllerScroll);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("scroll-begin", closure, after);
  }

  /**
   * Signals that a scrolling operation has finished.
   * It will only be emitted on devices capable of it.
   *   eventControllerScroll = the instance the signal is connected to
   */
  alias ScrollEndCallback = void delegate(EventControllerScroll eventControllerScroll);

  /**
   * Connect to ScrollEnd signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectScrollEnd(ScrollEndCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto eventControllerScroll = getVal!EventControllerScroll(_paramVals);
      _dgClosure.dlg(eventControllerScroll);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("scroll-end", closure, after);
  }
}

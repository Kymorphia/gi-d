module Gtk.EventControllerMotion;

import GObject.DClosure;
import Gid.gid;
import Gtk.EventController;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkEventControllerMotion` is an event controller tracking the pointer
 * position.
 * The event controller offers [Gtk.EventControllerMotion.enter]
 * and [Gtk.EventControllerMotion.leave] signals, as well as
 * property@Gtk.EventControllerMotion:is-pointer and
 * property@Gtk.EventControllerMotion:contains-pointer properties
 * which are updated to reflect changes in the pointer position as it
 * moves over the widget.
 */
class EventControllerMotion : EventController
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_event_controller_motion_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new event controller that will handle motion events.
   * Returns: a new `GtkEventControllerMotion`
   */
  this()
  {
    GtkEventController* _cretval;
    _cretval = gtk_event_controller_motion_new();
    this(_cretval, true);
  }

  /**
   * Returns if a pointer is within self or one of its children.
   * Returns: %TRUE if a pointer is within self or one of its children
   */
  bool containsPointer()
  {
    bool _retval;
    _retval = gtk_event_controller_motion_contains_pointer(cast(GtkEventControllerMotion*)cPtr);
    return _retval;
  }

  /**
   * Returns if a pointer is within self, but not one of its children.
   * Returns: %TRUE if a pointer is within self but not one of its children
   */
  bool isPointer()
  {
    bool _retval;
    _retval = gtk_event_controller_motion_is_pointer(cast(GtkEventControllerMotion*)cPtr);
    return _retval;
  }

  /**
   * Signals that the pointer has entered the widget.
   * Params
   *   x = coordinates of pointer location
   *   y = coordinates of pointer location
   *   eventControllerMotion = the instance the signal is connected to
   */
  alias EnterCallback = void delegate(double x, double y, EventControllerMotion eventControllerMotion);

  /**
   * Connect to Enter signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEnter(EnterCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto eventControllerMotion = getVal!EventControllerMotion(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(x, y, eventControllerMotion);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("enter", closure, after);
  }

  /**
   * Signals that the pointer has left the widget.
   *   eventControllerMotion = the instance the signal is connected to
   */
  alias LeaveCallback = void delegate(EventControllerMotion eventControllerMotion);

  /**
   * Connect to Leave signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLeave(LeaveCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto eventControllerMotion = getVal!EventControllerMotion(_paramVals);
      _dgClosure.dlg(eventControllerMotion);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("leave", closure, after);
  }

  /**
   * Emitted when the pointer moves inside the widget.
   * Params
   *   x = the x coordinate
   *   y = the y coordinate
   *   eventControllerMotion = the instance the signal is connected to
   */
  alias MotionCallback = void delegate(double x, double y, EventControllerMotion eventControllerMotion);

  /**
   * Connect to Motion signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMotion(MotionCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto eventControllerMotion = getVal!EventControllerMotion(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(x, y, eventControllerMotion);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("motion", closure, after);
  }
}

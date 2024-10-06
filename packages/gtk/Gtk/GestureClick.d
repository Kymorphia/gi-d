module Gtk.GestureClick;

import GObject.DClosure;
import GObject.Types;
import Gdk.EventSequence;
import Gid.gid;
import Gtk.GestureSingle;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGestureClick` is a `GtkGesture` implementation for clicks.
 * It is able to recognize multiple clicks on a nearby zone, which
 * can be listened for through the [Gtk.GestureClick.pressed]
 * signal. Whenever time or distance between clicks exceed the GTK
 * defaults, [Gtk.GestureClick.stopped] is emitted, and the
 * click counter is reset.
 */
class GestureClick : GestureSingle
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_gesture_click_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a newly created `GtkGesture` that recognizes
   * single and multiple presses.
   * Returns: a newly created `GtkGestureClick`
   */
  this()
  {
    GtkGesture* _cretval;
    _cretval = gtk_gesture_click_new();
    this(_cretval, true);
  }

  /**
   * Emitted whenever a button or touch press happens.
   * Params
   *   nPress = how many touch/button presses happened with this one
   *   x = The X coordinate, in widget allocation coordinates
   *   y = The Y coordinate, in widget allocation coordinates
   *   gestureClick = the instance the signal is connected to
   */
  alias PressedCallback = void delegate(int nPress, double x, double y, GestureClick gestureClick);

  /**
   * Connect to Pressed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPressed(PressedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureClick = getVal!GestureClick(_paramVals);
      auto nPress = getVal!int(&_paramVals[1]);
      auto x = getVal!double(&_paramVals[2]);
      auto y = getVal!double(&_paramVals[3]);
      _dgClosure.dlg(nPress, x, y, gestureClick);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("pressed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a button or touch is released.
   * n_press will report the number of press that is paired to
   * this event, note that [Gtk.GestureClick.stopped] may
   * have been emitted between the press and its release, n_press
   * will only start over at the next press.
   * Params
   *   nPress = number of press that is paired with this release
   *   x = The X coordinate, in widget allocation coordinates
   *   y = The Y coordinate, in widget allocation coordinates
   *   gestureClick = the instance the signal is connected to
   */
  alias ReleasedCallback = void delegate(int nPress, double x, double y, GestureClick gestureClick);

  /**
   * Connect to Released signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectReleased(ReleasedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureClick = getVal!GestureClick(_paramVals);
      auto nPress = getVal!int(&_paramVals[1]);
      auto x = getVal!double(&_paramVals[2]);
      auto y = getVal!double(&_paramVals[3]);
      _dgClosure.dlg(nPress, x, y, gestureClick);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("released", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted whenever any time/distance threshold has been exceeded.
   *   gestureClick = the instance the signal is connected to
   */
  alias StoppedCallback = void delegate(GestureClick gestureClick);

  /**
   * Connect to Stopped signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectStopped(StoppedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureClick = getVal!GestureClick(_paramVals);
      _dgClosure.dlg(gestureClick);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("stopped", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted whenever the gesture receives a release
   * event that had no previous corresponding press.
   * Due to implicit grabs, this can only happen on situations
   * where input is grabbed elsewhere mid-press or the pressed
   * widget voluntarily relinquishes its implicit grab.
   * Params
   *   x = X coordinate of the event
   *   y = Y coordinate of the event
   *   button = Button being released
   *   sequence = Sequence being released
   *   gestureClick = the instance the signal is connected to
   */
  alias UnpairedReleaseCallback = void delegate(double x, double y, uint button, EventSequence sequence, GestureClick gestureClick);

  /**
   * Connect to UnpairedRelease signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectUnpairedRelease(UnpairedReleaseCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureClick = getVal!GestureClick(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      auto button = getVal!uint(&_paramVals[3]);
      auto sequence = getVal!EventSequence(&_paramVals[4]);
      _dgClosure.dlg(x, y, button, sequence, gestureClick);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unpaired-release", closure, (flags & ConnectFlags.After) != 0);
  }
}

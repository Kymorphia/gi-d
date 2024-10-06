module Gtk.GestureRotate;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.Gesture;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGestureRotate` is a `GtkGesture` for 2-finger rotations.
 * Whenever the angle between both handled sequences changes, the
 * signal@Gtk.GestureRotate::angle-changed signal is emitted.
 */
class GestureRotate : Gesture
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_gesture_rotate_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a newly created `GtkGesture` that recognizes 2-touch
   * rotation gestures.
   * Returns: a newly created `GtkGestureRotate`
   */
  this()
  {
    GtkGesture* _cretval;
    _cretval = gtk_gesture_rotate_new();
    this(_cretval, true);
  }

  /**
   * Gets the angle delta in radians.
   * If gesture is active, this function returns the angle difference
   * in radians since the gesture was first recognized. If gesture is
   * not active, 0 is returned.
   * Returns: the angle delta in radians
   */
  double getAngleDelta()
  {
    double _retval;
    _retval = gtk_gesture_rotate_get_angle_delta(cast(GtkGestureRotate*)cPtr);
    return _retval;
  }

  /**
   * Emitted when the angle between both tracked points changes.
   * Params
   *   angle = Current angle in radians
   *   angleDelta = Difference with the starting angle, in radians
   *   gestureRotate = the instance the signal is connected to
   */
  alias AngleChangedCallback = void delegate(double angle, double angleDelta, GestureRotate gestureRotate);

  /**
   * Connect to AngleChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAngleChanged(AngleChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureRotate = getVal!GestureRotate(_paramVals);
      auto angle = getVal!double(&_paramVals[1]);
      auto angleDelta = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(angle, angleDelta, gestureRotate);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("angle-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

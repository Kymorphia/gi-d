module Gtk.GestureLongPress;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.GestureSingle;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGestureLongPress` is a `GtkGesture` for long presses.
 * This gesture is also known as “Press and Hold”.
 * When the timeout is exceeded, the gesture is triggering the
 * [Gtk.GestureLongPress.pressed] signal.
 * If the touchpoint is lifted before the timeout passes, or if
 * it drifts too far of the initial press point, the
 * [Gtk.GestureLongPress.cancelled] signal will be emitted.
 * How long the timeout is before the ::pressed signal gets emitted is
 * determined by the property@Gtk.Settings:gtk-long-press-time setting.
 * It can be modified by the property@Gtk.GestureLongPress:delay-factor
 * property.
 */
class GestureLongPress : GestureSingle
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_gesture_long_press_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a newly created `GtkGesture` that recognizes long presses.
   * Returns: a newly created `GtkGestureLongPress`.
   */
  this()
  {
    GtkGesture* _cretval;
    _cretval = gtk_gesture_long_press_new();
    this(_cretval, true);
  }

  /**
   * Returns the delay factor.
   * Returns: the delay factor
   */
  double getDelayFactor()
  {
    double _retval;
    _retval = gtk_gesture_long_press_get_delay_factor(cast(GtkGestureLongPress*)cPtr);
    return _retval;
  }

  /**
   * Applies the given delay factor.
   * The default long press time will be multiplied by this value.
   * Valid values are in the range [0.5..2.0].
   * Params:
   *   delayFactor = The delay factor to apply
   */
  void setDelayFactor(double delayFactor)
  {
    gtk_gesture_long_press_set_delay_factor(cast(GtkGestureLongPress*)cPtr, delayFactor);
  }

  /**
   * Emitted whenever a press moved too far, or was released
   * before [Gtk.GestureLongPress.pressed] happened.
   *   gestureLongPress = the instance the signal is connected to
   */
  alias CancelledCallback = void delegate(GestureLongPress gestureLongPress);

  /**
   * Connect to Cancelled signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectCancelled(CancelledCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureLongPress = getVal!GestureLongPress(_paramVals);
      _dgClosure.dlg(gestureLongPress);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cancelled", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted whenever a press goes unmoved/unreleased longer than
   * what the GTK defaults tell.
   * Params
   *   x = the X coordinate where the press happened, relative to the widget allocation
   *   y = the Y coordinate where the press happened, relative to the widget allocation
   *   gestureLongPress = the instance the signal is connected to
   */
  alias PressedCallback = void delegate(double x, double y, GestureLongPress gestureLongPress);

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
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureLongPress = getVal!GestureLongPress(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(x, y, gestureLongPress);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("pressed", closure, (flags & ConnectFlags.After) != 0);
  }
}

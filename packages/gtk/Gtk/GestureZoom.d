module Gtk.GestureZoom;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.Gesture;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGestureZoom` is a `GtkGesture` for 2-finger pinch/zoom gestures.
 * Whenever the distance between both tracked sequences changes, the
 * signal@Gtk.GestureZoom::scale-changed signal is emitted to report
 * the scale factor.
 */
class GestureZoom : Gesture
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_gesture_zoom_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a newly created `GtkGesture` that recognizes
   * pinch/zoom gestures.
   * Returns: a newly created `GtkGestureZoom`
   */
  this()
  {
    GtkGesture* _cretval;
    _cretval = gtk_gesture_zoom_new();
    this(_cretval, true);
  }

  /**
   * Gets the scale delta.
   * If gesture is active, this function returns the zooming
   * difference since the gesture was recognized $(LPAREN)hence the
   * starting point is considered 1:1$(RPAREN). If gesture is not
   * active, 1 is returned.
   * Returns: the scale delta
   */
  double getScaleDelta()
  {
    double _retval;
    _retval = gtk_gesture_zoom_get_scale_delta(cast(GtkGestureZoom*)cPtr);
    return _retval;
  }

  /**
   * Emitted whenever the distance between both tracked sequences changes.
   * Params
   *   scale = Scale delta, taking the initial state as 1:1
   *   gestureZoom = the instance the signal is connected to
   */
  alias ScaleChangedCallback = void delegate(double scale, GestureZoom gestureZoom);

  /**
   * Connect to ScaleChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectScaleChanged(ScaleChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureZoom = getVal!GestureZoom(_paramVals);
      auto scale = getVal!double(&_paramVals[1]);
      _dgClosure.dlg(scale, gestureZoom);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("scale-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}

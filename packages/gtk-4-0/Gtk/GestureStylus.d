module Gtk.GestureStylus;

import GObject.DClosure;
import GObject.ObjectG;
import Gdk.DeviceTool;
import Gdk.Types;
import Gid.gid;
import Gtk.GestureSingle;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGestureStylus` is a `GtkGesture` specific to stylus input.
 * The provided signals just relay the basic information of the
 * stylus events.
 */
class GestureStylus : GestureSingle
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_gesture_stylus_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkGestureStylus`.
   * Returns: a newly created stylus gesture
   */
  this()
  {
    GtkGesture* _cretval;
    _cretval = gtk_gesture_stylus_new();
    this(_cretval, true);
  }

  /**
   * Returns the current value for the requested axis.
   * This function must be called from the handler of one of the
   * [Gtk.GestureStylus.down], [Gtk.GestureStylus.motion],
   * [Gtk.GestureStylus.up] or [Gtk.GestureStylus.proximity]
   * signals.
   * Params:
   *   axis = requested device axis
   *   value = return location for the axis value
   * Returns: %TRUE if there is a current value for the axis
   */
  bool getAxis(AxisUse axis, out double value)
  {
    bool _retval;
    _retval = gtk_gesture_stylus_get_axis(cast(GtkGestureStylus*)cPtr, axis, cast(double*)&value);
    return _retval;
  }

  /**
   * Returns the accumulated backlog of tracking information.
   * By default, GTK will limit rate of input events. On stylus input
   * where accuracy of strokes is paramount, this function returns the
   * accumulated coordinate/timing state before the emission of the
   * current [Gtk.GestureStylus::motion] signal.
   * This function may only be called within a [Gtk.GestureStylus.motion]
   * signal handler, the state given in this signal and obtainable through
   * [Gtk.GestureStylus.getAxis] express the latest (most up-to-date)
   * state in motion history.
   * The backlog is provided in chronological order.
   * Params:
   *   backlog = coordinates and times for the backlog events
   * Returns: %TRUE if there is a backlog to unfold in the current state.
   */
  bool getBacklog(out TimeCoord[] backlog)
  {
    bool _retval;
    uint _nElems;
    GdkTimeCoord* _backlog;
    _retval = gtk_gesture_stylus_get_backlog(cast(GtkGestureStylus*)cPtr, &_backlog, &_nElems);
    backlog.length = _nElems;
    backlog[0 .. $] = _backlog[0 .. _nElems];
    safeFree(cast(void*)_backlog);
    return _retval;
  }

  /**
   * Returns the `GdkDeviceTool` currently driving input through this gesture.
   * This function must be called from the handler of one of the
   * [Gtk.GestureStylus.down], [Gtk.GestureStylus.motion],
   * [Gtk.GestureStylus.up] or [Gtk.GestureStylus.proximity]
   * signals.
   * Returns: The current stylus tool
   */
  DeviceTool getDeviceTool()
  {
    GdkDeviceTool* _cretval;
    _cretval = gtk_gesture_stylus_get_device_tool(cast(GtkGestureStylus*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DeviceTool(cast(GdkDeviceTool*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether the gesture is for styluses only.
   * Stylus-only gestures will signal events exclusively from stylus
   * input devices.
   * Returns: %TRUE if the gesture is only for stylus events
   */
  bool getStylusOnly()
  {
    bool _retval;
    _retval = gtk_gesture_stylus_get_stylus_only(cast(GtkGestureStylus*)cPtr);
    return _retval;
  }

  /**
   * Sets the state of stylus-only
   * If true, the gesture will exclusively handle events from stylus input devices,
   * otherwise it'll handle events from any pointing device.
   * Params:
   *   stylusOnly = whether the gesture is used exclusively for stylus events
   */
  void setStylusOnly(bool stylusOnly)
  {
    gtk_gesture_stylus_set_stylus_only(cast(GtkGestureStylus*)cPtr, stylusOnly);
  }

  /**
   * Emitted when the stylus touches the device.
   * Params
   *   x = the X coordinate of the stylus event
   *   y = the Y coordinate of the stylus event
   *   gestureStylus = the instance the signal is connected to
   */
  alias DownCallback = void delegate(double x, double y, GestureStylus gestureStylus);

  /**
   * Connect to Down signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDown(DownCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureStylus = getVal!GestureStylus(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(x, y, gestureStylus);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("down", closure, after);
  }

  /**
   * Emitted when the stylus moves while touching the device.
   * Params
   *   x = the X coordinate of the stylus event
   *   y = the Y coordinate of the stylus event
   *   gestureStylus = the instance the signal is connected to
   */
  alias MotionCallback = void delegate(double x, double y, GestureStylus gestureStylus);

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
      auto gestureStylus = getVal!GestureStylus(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(x, y, gestureStylus);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("motion", closure, after);
  }

  /**
   * Emitted when the stylus is in proximity of the device.
   * Params
   *   x = the X coordinate of the stylus event
   *   y = the Y coordinate of the stylus event
   *   gestureStylus = the instance the signal is connected to
   */
  alias ProximityCallback = void delegate(double x, double y, GestureStylus gestureStylus);

  /**
   * Connect to Proximity signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectProximity(ProximityCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureStylus = getVal!GestureStylus(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(x, y, gestureStylus);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("proximity", closure, after);
  }

  /**
   * Emitted when the stylus no longer touches the device.
   * Params
   *   x = the X coordinate of the stylus event
   *   y = the Y coordinate of the stylus event
   *   gestureStylus = the instance the signal is connected to
   */
  alias UpCallback = void delegate(double x, double y, GestureStylus gestureStylus);

  /**
   * Connect to Up signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUp(UpCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gestureStylus = getVal!GestureStylus(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      _dgClosure.dlg(x, y, gestureStylus);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("up", closure, after);
  }
}

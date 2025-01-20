module Gdk.Seat;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gdk.Device;
import Gdk.DeviceTool;
import Gdk.Display;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The `GdkSeat` object represents a collection of input devices
 * that belong to a user.
 */
class Seat : ObjectG
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
    return gdk_seat_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the capabilities this `GdkSeat` currently has.
   * Returns: the seat capabilities
   */
  SeatCapabilities getCapabilities()
  {
    GdkSeatCapabilities _cretval;
    _cretval = gdk_seat_get_capabilities(cast(GdkSeat*)cPtr);
    SeatCapabilities _retval = cast(SeatCapabilities)_cretval;
    return _retval;
  }

  /**
   * Returns the devices that match the given capabilities.
   * Params:
   *   capabilities = capabilities to get devices for
   * Returns: A list
   *   of `GdkDevices`. The list must be freed with [GLib.List.free],
   *   the elements are owned by GTK and must not be freed.
   */
  List!(Device, GdkDevice) getDevices(SeatCapabilities capabilities)
  {
    GList* _cretval;
    _cretval = gdk_seat_get_devices(cast(GdkSeat*)cPtr, capabilities);
    List!(Device, GdkDevice) _retval = new List!(Device, GdkDevice)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Returns the `GdkDisplay` this seat belongs to.
   * Returns: a `GdkDisplay`. This object
   *   is owned by GTK and must not be freed.
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_seat_get_display(cast(GdkSeat*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the device that routes keyboard events.
   * Returns: a `GdkDevice` with keyboard
   *   capabilities. This object is owned by GTK and must not be freed.
   */
  Device getKeyboard()
  {
    GdkDevice* _cretval;
    _cretval = gdk_seat_get_keyboard(cast(GdkSeat*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Device(cast(GdkDevice*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the device that routes pointer events.
   * Returns: a `GdkDevice` with pointer
   *   capabilities. This object is owned by GTK and must not be freed.
   */
  Device getPointer()
  {
    GdkDevice* _cretval;
    _cretval = gdk_seat_get_pointer(cast(GdkSeat*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Device(cast(GdkDevice*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns all `GdkDeviceTools` that are known to the application.
   * Returns: A list of tools. Free with [GLib.List.free].
   */
  List!(DeviceTool, GdkDeviceTool) getTools()
  {
    GList* _cretval;
    _cretval = gdk_seat_get_tools(cast(GdkSeat*)cPtr);
    List!(DeviceTool, GdkDeviceTool) _retval = new List!(DeviceTool, GdkDeviceTool)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Emitted when a new input device is related to this seat.
   * Params
   *   device = the newly added `GdkDevice`.
   *   seat = the instance the signal is connected to
   */
  alias DeviceAddedCallback = void delegate(Device device, Seat seat);

  /**
   * Connect to DeviceAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDeviceAdded(DeviceAddedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto seat = getVal!Seat(_paramVals);
      auto device = getVal!Device(&_paramVals[1]);
      _dgClosure.dlg(device, seat);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("device-added", closure, after);
  }

  /**
   * Emitted when an input device is removed $(LPAREN)e.g. unplugged$(RPAREN).
   * Params
   *   device = the just removed `GdkDevice`.
   *   seat = the instance the signal is connected to
   */
  alias DeviceRemovedCallback = void delegate(Device device, Seat seat);

  /**
   * Connect to DeviceRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDeviceRemoved(DeviceRemovedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto seat = getVal!Seat(_paramVals);
      auto device = getVal!Device(&_paramVals[1]);
      _dgClosure.dlg(device, seat);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("device-removed", closure, after);
  }

  /**
   * Emitted whenever a new tool is made known to the seat.
   * The tool may later be assigned to a device $(LPAREN)i.e. on
   * proximity with a tablet$(RPAREN). The device will emit the
   * signalGdk.Device::tool-changed signal accordingly.
   * A same tool may be used by several devices.
   * Params
   *   tool = the new `GdkDeviceTool` known to the seat
   *   seat = the instance the signal is connected to
   */
  alias ToolAddedCallback = void delegate(DeviceTool tool, Seat seat);

  /**
   * Connect to ToolAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToolAdded(ToolAddedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto seat = getVal!Seat(_paramVals);
      auto tool = getVal!DeviceTool(&_paramVals[1]);
      _dgClosure.dlg(tool, seat);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("tool-added", closure, after);
  }

  /**
   * Emitted whenever a tool is no longer known to this seat.
   * Params
   *   tool = the just removed `GdkDeviceTool`
   *   seat = the instance the signal is connected to
   */
  alias ToolRemovedCallback = void delegate(DeviceTool tool, Seat seat);

  /**
   * Connect to ToolRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToolRemoved(ToolRemovedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto seat = getVal!Seat(_paramVals);
      auto tool = getVal!DeviceTool(&_paramVals[1]);
      _dgClosure.dlg(tool, seat);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("tool-removed", closure, after);
  }
}

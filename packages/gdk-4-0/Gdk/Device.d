module Gdk.Device;

import GObject.DClosure;
import GObject.ObjectG;
import Gdk.DeviceTool;
import Gdk.Display;
import Gdk.Seat;
import Gdk.Surface;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Pango.Types;

/**
 * The `GdkDevice` object represents an input device, such
 * as a keyboard, a mouse, or a touchpad.
 * See the [Gdk.Seat] documentation for more information
 * about the various kinds of devices, and their relationships.
 */
class Device : ObjectG
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
    return gdk_device_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves whether the Caps Lock modifier of the keyboard is locked.
   * This is only relevant for keyboard devices.
   * Returns: %TRUE if Caps Lock is on for device
   */
  bool getCapsLockState()
  {
    bool _retval;
    _retval = gdk_device_get_caps_lock_state(cast(GdkDevice*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the current tool for device.
   * Returns: the `GdkDeviceTool`
   */
  DeviceTool getDeviceTool()
  {
    GdkDeviceTool* _cretval;
    _cretval = gdk_device_get_device_tool(cast(GdkDevice*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DeviceTool(cast(GdkDeviceTool*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the direction of effective layout of the keyboard.
   * This is only relevant for keyboard devices.
   * The direction of a layout is the direction of the majority
   * of its symbols. See funcPango.unichar_direction.
   * Returns: %PANGO_DIRECTION_LTR or %PANGO_DIRECTION_RTL
   *   if it can determine the direction. %PANGO_DIRECTION_NEUTRAL
   *   otherwise
   */
  Direction getDirection()
  {
    PangoDirection _cretval;
    _cretval = gdk_device_get_direction(cast(GdkDevice*)cPtr);
    Direction _retval = cast(Direction)_cretval;
    return _retval;
  }

  /**
   * Returns the `GdkDisplay` to which device pertains.
   * Returns: a `GdkDisplay`
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_device_get_display(cast(GdkDevice*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Determines whether the pointer follows device motion.
   * This is not meaningful for keyboard devices, which
   * don't have a pointer.
   * Returns: %TRUE if the pointer follows device motion
   */
  bool getHasCursor()
  {
    bool _retval;
    _retval = gdk_device_get_has_cursor(cast(GdkDevice*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the current modifier state of the keyboard.
   * This is only relevant for keyboard devices.
   * Returns: the current modifier state
   */
  ModifierType getModifierState()
  {
    GdkModifierType _cretval;
    _cretval = gdk_device_get_modifier_state(cast(GdkDevice*)cPtr);
    ModifierType _retval = cast(ModifierType)_cretval;
    return _retval;
  }

  /**
   * The name of the device, suitable for showing in a user interface.
   * Returns: a name
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gdk_device_get_name(cast(GdkDevice*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves whether the Num Lock modifier of the keyboard is locked.
   * This is only relevant for keyboard devices.
   * Returns: %TRUE if Num Lock is on for device
   */
  bool getNumLockState()
  {
    bool _retval;
    _retval = gdk_device_get_num_lock_state(cast(GdkDevice*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the number of touch points associated to device.
   * Returns: the number of touch points
   */
  uint getNumTouches()
  {
    uint _retval;
    _retval = gdk_device_get_num_touches(cast(GdkDevice*)cPtr);
    return _retval;
  }

  /**
   * Returns the product ID of this device.
   * This ID is retrieved from the device, and does not change.
   * See [Gdk.Device.getVendorId] for more information.
   * Returns: the product ID
   */
  string getProductId()
  {
    const(char)* _cretval;
    _cretval = gdk_device_get_product_id(cast(GdkDevice*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves whether the Scroll Lock modifier of the keyboard is locked.
   * This is only relevant for keyboard devices.
   * Returns: %TRUE if Scroll Lock is on for device
   */
  bool getScrollLockState()
  {
    bool _retval;
    _retval = gdk_device_get_scroll_lock_state(cast(GdkDevice*)cPtr);
    return _retval;
  }

  /**
   * Returns the `GdkSeat` the device belongs to.
   * Returns: a `GdkSeat`
   */
  Seat getSeat()
  {
    GdkSeat* _cretval;
    _cretval = gdk_device_get_seat(cast(GdkDevice*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Seat(cast(GdkSeat*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Determines the type of the device.
   * Returns: a `GdkInputSource`
   */
  InputSource getSource()
  {
    GdkInputSource _cretval;
    _cretval = gdk_device_get_source(cast(GdkDevice*)cPtr);
    InputSource _retval = cast(InputSource)_cretval;
    return _retval;
  }

  /**
   * Obtains the surface underneath device, returning the location of the
   * device in win_x and win_y.
   * Returns %NULL if the surface tree under device is not known to GDK
   * $(LPAREN)for example, belongs to another application$(RPAREN).
   * Params:
   *   winX = return location for the X coordinate
   *     of the device location relative to the surface origin
   *   winY = return location for the Y coordinate
   *     of the device location relative to the surface origin
   * Returns: the `GdkSurface` under the
   *   device position
   */
  Surface getSurfaceAtPosition(out double winX, out double winY)
  {
    GdkSurface* _cretval;
    _cretval = gdk_device_get_surface_at_position(cast(GdkDevice*)cPtr, cast(double*)&winX, cast(double*)&winY);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the timestamp of the last activity for this device.
   * In practice, this means the timestamp of the last event that was
   * received from the OS for this device. $(LPAREN)GTK may occasionally produce
   * events for a device that are not received from the OS, and will not
   * update the timestamp$(RPAREN).
   * Returns: the timestamp of the last activity for this device
   */
  uint getTimestamp()
  {
    uint _retval;
    _retval = gdk_device_get_timestamp(cast(GdkDevice*)cPtr);
    return _retval;
  }

  /**
   * Returns the vendor ID of this device.
   * This ID is retrieved from the device, and does not change.
   * This function, together with [Gdk.Device.getProductId],
   * can be used to eg. compose `GSettings` paths to store settings
   * for this device.
   * ```c
   * static GSettings *
   * get_device_settings $(LPAREN)GdkDevice *device$(RPAREN)
   * {
   * const char *vendor, *product;
   * GSettings *settings;
   * GdkDevice *device;
   * char *path;
   * vendor \= gdk_device_get_vendor_id $(LPAREN)device$(RPAREN);
   * product \= gdk_device_get_product_id $(LPAREN)device$(RPAREN);
   * path \= g_strdup_printf $(LPAREN)"/org/example/app/devices/%s:%s/", vendor, product$(RPAREN);
   * settings \= g_settings_new_with_path $(LPAREN)DEVICE_SCHEMA, path$(RPAREN);
   * g_free $(LPAREN)path$(RPAREN);
   * return settings;
   * }
   * ```
   * Returns: the vendor ID
   */
  string getVendorId()
  {
    const(char)* _cretval;
    _cretval = gdk_device_get_vendor_id(cast(GdkDevice*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Determines if layouts for both right-to-left and
   * left-to-right languages are in use on the keyboard.
   * This is only relevant for keyboard devices.
   * Returns: %TRUE if there are layouts with both directions, %FALSE otherwise
   */
  bool hasBidiLayouts()
  {
    bool _retval;
    _retval = gdk_device_has_bidi_layouts(cast(GdkDevice*)cPtr);
    return _retval;
  }

  /**
   * Emitted either when the number of either axes or keys changes.
   * On X11 this will normally happen when the physical device
   * routing events through the logical device changes $(LPAREN)for
   * example, user switches from the USB mouse to a tablet$(RPAREN); in
   * that case the logical device will change to reflect the axes
   * and keys on the new physical device.
   *   device = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Device device);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto device = getVal!Device(_paramVals);
      _dgClosure.dlg(device);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }

  /**
   * Emitted on pen/eraser devices whenever tools enter or leave proximity.
   * Params
   *   tool = The new current tool
   *   device = the instance the signal is connected to
   */
  alias ToolChangedCallback = void delegate(DeviceTool tool, Device device);

  /**
   * Connect to ToolChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToolChanged(ToolChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto device = getVal!Device(_paramVals);
      auto tool = getVal!DeviceTool(&_paramVals[1]);
      _dgClosure.dlg(tool, device);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("tool-changed", closure, after);
  }
}

module Gdk.DeviceTool;

import GObject.ObjectG;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * A physical tool associated to a `GdkDevice`.
 */
class DeviceTool : ObjectG
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
    return gdk_device_tool_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the axes of the tool.
   * Returns: the axes of tool
   */
  AxisFlags getAxes()
  {
    GdkAxisFlags _cretval;
    _cretval = gdk_device_tool_get_axes(cast(GdkDeviceTool*)cPtr);
    AxisFlags _retval = cast(AxisFlags)_cretval;
    return _retval;
  }

  /**
   * Gets the hardware ID of this tool, or 0 if it's not known.
   * When non-zero, the identifier is unique for the given tool model,
   * meaning that two identical tools will share the same hardware_id,
   * but will have different serial numbers $(LPAREN)see
   * [Gdk.DeviceTool.getSerial]$(RPAREN).
   * This is a more concrete $(LPAREN)and device specific$(RPAREN) method to identify
   * a `GdkDeviceTool` than [Gdk.DeviceTool.getToolType],
   * as a tablet may support multiple devices with the same
   * `GdkDeviceToolType`, but different hardware identifiers.
   * Returns: The hardware identifier of this tool.
   */
  ulong getHardwareId()
  {
    ulong _retval;
    _retval = gdk_device_tool_get_hardware_id(cast(GdkDeviceTool*)cPtr);
    return _retval;
  }

  /**
   * Gets the serial number of this tool.
   * This value can be used to identify a physical tool
   * $(LPAREN)eg. a tablet pen$(RPAREN) across program executions.
   * Returns: The serial ID for this tool
   */
  ulong getSerial()
  {
    ulong _retval;
    _retval = gdk_device_tool_get_serial(cast(GdkDeviceTool*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GdkDeviceToolType` of the tool.
   * Returns: The physical type for this tool. This can be used to
   *   figure out what sort of pen is being used, such as an airbrush
   *   or a pencil.
   */
  DeviceToolType getToolType()
  {
    GdkDeviceToolType _cretval;
    _cretval = gdk_device_tool_get_tool_type(cast(GdkDeviceTool*)cPtr);
    DeviceToolType _retval = cast(DeviceToolType)_cretval;
    return _retval;
  }
}

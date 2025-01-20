module Gio.PowerProfileMonitorT;

public import Gio.PowerProfileMonitorIfaceProxy;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GPowerProfileMonitor` makes it possible for applications as well as OS
 * components to monitor system power profiles and act upon them. It currently
 * only exports whether the system is in “Power Saver” mode $(LPAREN)known as
 * “Low Power” mode on some systems$(RPAREN).
 * When in “Low Power” mode, it is recommended that applications:
 * - disable automatic downloads;
 * - reduce the rate of refresh from online sources such as calendar or
 * email synchronisation;
 * - reduce the use of expensive visual effects.
 * It is also likely that OS components providing services to applications will
 * lower their own background activity, for the sake of the system.
 * There are a variety of tools that exist for power consumption analysis, but those
 * usually depend on the OS and hardware used. On Linux, one could use `upower` to
 * monitor the battery discharge rate, `powertop` to check on the background activity
 * or activity at all$(RPAREN), `sysprof` to inspect CPU usage, and `intel_gpu_time` to
 * profile GPU usage.
 * Don’t forget to disconnect the [GObject.ObjectG.notify] signal for
 * property@Gio.PowerProfileMonitor:power-saver-enabled, and unref the
 * `GPowerProfileMonitor` itself when exiting.
 */
template PowerProfileMonitorT()
{


  /**
   * Gets whether the system is in “Power Saver” mode.
   * You are expected to listen to the
   * #GPowerProfileMonitor::notify::power-saver-enabled signal to know when the profile has
   * changed.
   * Returns: Whether the system is in “Power Saver” mode.
   */
  override bool getPowerSaverEnabled()
  {
    bool _retval;
    _retval = g_power_profile_monitor_get_power_saver_enabled(cast(GPowerProfileMonitor*)cPtr);
    return _retval;
  }
}

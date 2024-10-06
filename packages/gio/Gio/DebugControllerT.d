module Gio.DebugControllerT;

public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GDebugController` is an interface to expose control of debugging features and
 * debug output.
 * It is implemented on Linux using [Gio.DebugControllerDBus], which
 * exposes a D-Bus interface to allow authenticated peers to control debug
 * features in this process.
 * Whether debug output is enabled is exposed as
 * property@Gio.DebugController:debug-enabled. This controls
 * func@GLib.log_set_debug_enabled by default. Application code may
 * connect to the [GObject.ObjectG.notify] signal for it
 * to control other parts of its debug infrastructure as necessary.
 * If your application or service is using the default GLib log writer function,
 * creating one of the built-in implementations of `GDebugController` should be
 * all that’s needed to dynamically enable or disable debug output.
 */
template DebugControllerT(TStruct)
{

  /**
   * Get the value of #GDebugController:debug-enabled.
   * Returns: %TRUE if debug output should be exposed, %FALSE otherwise
   */
  override bool getDebugEnabled()
  {
    bool _retval;
    _retval = g_debug_controller_get_debug_enabled(cast(GDebugController*)cPtr);
    return _retval;
  }

  /**
   * Set the value of #GDebugController:debug-enabled.
   * Params:
   *   debugEnabled = %TRUE if debug output should be exposed, %FALSE otherwise
   */
  override void setDebugEnabled(bool debugEnabled)
  {
    g_debug_controller_set_debug_enabled(cast(GDebugController*)cPtr, debugEnabled);
  }
}

module Gio.DebugController;

public import Gio.DebugControllerIfaceProxy;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
interface DebugController
{

  static GType getType()
  {
    return g_debug_controller_get_type();
  }

  /**
   * Get the value of #GDebugController:debug-enabled.
   * Returns: %TRUE if debug output should be exposed, %FALSE otherwise
   */
  bool getDebugEnabled();

  /**
   * Set the value of #GDebugController:debug-enabled.
   * Params:
   *   debugEnabled = %TRUE if debug output should be exposed, %FALSE otherwise
   */
  void setDebugEnabled(bool debugEnabled);
}

module Gdk.Toplevel;

public import Gdk.ToplevelIfaceProxy;
import Gdk.Device;
import Gdk.Event;
import Gdk.Surface;
import Gdk.Texture;
import Gdk.ToplevelLayout;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * A `GdkToplevel` is a freestanding toplevel surface.
 * The `GdkToplevel` interface provides useful APIs for interacting with
 * the windowing system, such as controlling maximization and size of the
 * surface, setting icons and transient parents for dialogs.
 */
interface Toplevel
{

  static GType getType()
  {
    return gdk_toplevel_get_type();
  }

  /**
   * Begins an interactive move operation.
   * You might use this function to implement draggable titlebars.
   * Params:
   *   device = the device used for the operation
   *   button = the button being used to drag, or 0 for a keyboard-initiated drag
   *   x = surface X coordinate of mouse click that began the drag
   *   y = surface Y coordinate of mouse click that began the drag
   *   timestamp = timestamp of mouse click that began the drag $(LPAREN)use
   *     [Gdk.Event.getTime]$(RPAREN)
   */
  void beginMove(Device device, int button, double x, double y, uint timestamp);

  /**
   * Begins an interactive resize operation.
   * You might use this function to implement a “window resize grip.”
   * Params:
   *   edge = the edge or corner from which the drag is started
   *   device = the device used for the operation
   *   button = the button being used to drag, or 0 for a keyboard-initiated drag
   *   x = surface X coordinate of mouse click that began the drag
   *   y = surface Y coordinate of mouse click that began the drag
   *   timestamp = timestamp of mouse click that began the drag $(LPAREN)use
   *     [Gdk.Event.getTime]$(RPAREN)
   */
  void beginResize(SurfaceEdge edge, Device device, int button, double x, double y, uint timestamp);

  /**
   * Sets keyboard focus to surface.
   * In most cases, [[Gtk.Window.presentWithTime]](../gtk4/method.Window.present_with_time.html)
   * should be used on a [GtkWindow](../gtk4/class.Window.html), rather than
   * calling this function.
   * Params:
   *   timestamp = timestamp of the event triggering the surface focus
   */
  void focus(uint timestamp);

  /**
   * Gets the bitwise or of the currently active surface state flags,
   * from the `GdkToplevelState` enumeration.
   * Returns: surface state bitfield
   */
  ToplevelState getState();

  /**
   * Requests that the toplevel inhibit the system shortcuts.
   * This is asking the desktop environment/windowing system to let all
   * keyboard events reach the surface, as long as it is focused, instead
   * of triggering system actions.
   * If granted, the rerouting remains active until the default shortcuts
   * processing is restored with [Gdk.Toplevel.restoreSystemShortcuts],
   * or the request is revoked by the desktop environment, windowing system
   * or the user.
   * A typical use case for this API is remote desktop or virtual machine
   * viewers which need to inhibit the default system keyboard shortcuts
   * so that the remote session or virtual host gets those instead of the
   * local environment.
   * The windowing system or desktop environment may ask the user to grant
   * or deny the request or even choose to ignore the request entirely.
   * The caller can be notified whenever the request is granted or revoked
   * by listening to the propertyGdk.Toplevel:shortcuts-inhibited property.
   * Params:
   *   event = the `GdkEvent` that is triggering the inhibit
   *     request, or %NULL if none is available
   */
  void inhibitSystemShortcuts(Event event);

  /**
   * Asks to lower the toplevel below other windows.
   * The windowing system may choose to ignore the request.
   * Returns: %TRUE if the surface was lowered
   */
  bool lower();

  /**
   * Asks to minimize the toplevel.
   * The windowing system may choose to ignore the request.
   * Returns: %TRUE if the surface was minimized
   */
  bool minimize();

  /**
   * Present toplevel after having processed the `GdkToplevelLayout` rules.
   * If the toplevel was previously not showing, it will be showed,
   * otherwise it will change layout according to layout.
   * GDK may emit the signalGdk.Toplevel::compute-size signal to let
   * the user of this toplevel compute the preferred size of the toplevel
   * surface.
   * Presenting is asynchronous and the specified layout parameters are not
   * guaranteed to be respected.
   * Params:
   *   layout = the `GdkToplevelLayout` object used to layout
   */
  void present(ToplevelLayout layout);

  /**
   * Restore default system keyboard shortcuts which were previously
   * inhibited.
   * This undoes the effect of [Gdk.Toplevel.inhibitSystemShortcuts].
   */
  void restoreSystemShortcuts();

  /**
   * Sets the toplevel to be decorated.
   * Setting decorated to %FALSE hints the desktop environment
   * that the surface has its own, client-side decorations and
   * does not need to have window decorations added.
   * Params:
   *   decorated = %TRUE to request decorations
   */
  void setDecorated(bool decorated);

  /**
   * Sets the toplevel to be deletable.
   * Setting deletable to %TRUE hints the desktop environment
   * that it should offer the user a way to close the surface.
   * Params:
   *   deletable = %TRUE to request a delete button
   */
  void setDeletable(bool deletable);

  /**
   * Sets a list of icons for the surface.
   * One of these will be used to represent the surface in iconic form.
   * The icon may be shown in window lists or task bars. Which icon
   * size is shown depends on the window manager. The window manager
   * can scale the icon but setting several size icons can give better
   * image quality.
   * Note that some platforms don't support surface icons.
   * Params:
   *   surfaces = A list of textures to use as icon, of different sizes
   */
  void setIconList(Texture[] surfaces);

  /**
   * Sets the toplevel to be modal.
   * The application can use this hint to tell the
   * window manager that a certain surface has modal
   * behaviour. The window manager can use this information
   * to handle modal surfaces in a special way.
   * You should only use this on surfaces for which you have
   * previously called [Gdk.Toplevel.setTransientFor].
   * Params:
   *   modal = %TRUE if the surface is modal, %FALSE otherwise.
   */
  void setModal(bool modal);

  /**
   * Sets the startup notification ID.
   * When using GTK, typically you should use
   * [[Gtk.Window.setStartupId]](../gtk4/method.Window.set_startup_id.html)
   * instead of this low-level function.
   * Params:
   *   startupId = a string with startup-notification identifier
   */
  void setStartupId(string startupId);

  /**
   * Sets the title of a toplevel surface.
   * The title maybe be displayed in the titlebar,
   * in lists of windows, etc.
   * Params:
   *   title = title of surface
   */
  void setTitle(string title);

  /**
   * Sets a transient-for parent.
   * Indicates to the window manager that surface is a transient
   * dialog associated with the application surface parent. This
   * allows the window manager to do things like center surface
   * on parent and keep surface above parent.
   * See [[Gtk.Window.setTransientFor]](../gtk4/method.Window.set_transient_for.html)
   * if you’re using [GtkWindow](../gtk4/class.Window.html).
   * Params:
   *   parent = another toplevel `GdkSurface`
   */
  void setTransientFor(Surface parent);

  /**
   * Asks the windowing system to show the window menu.
   * The window menu is the menu shown when right-clicking the titlebar
   * on traditional windows managed by the window manager. This is useful
   * for windows using client-side decorations, activating it with a
   * right-click on the window decorations.
   * Params:
   *   event = a `GdkEvent` to show the menu for
   * Returns: %TRUE if the window menu was shown and %FALSE otherwise.
   */
  bool showWindowMenu(Event event);

  /**
   * Returns whether the desktop environment supports
   * tiled window states.
   * Returns: %TRUE if the desktop environment supports tiled window states
   */
  bool supportsEdgeConstraints();

  bool titlebarGesture(TitlebarGesture gesture);
}

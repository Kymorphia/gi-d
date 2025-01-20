module Gdk.ToplevelLayout;

import GLib.Boxed;
import GObject.ObjectG;
import Gdk.MonitorG;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The `GdkToplevelLayout` struct contains information that
 * is necessary to present a sovereign window on screen.
 * The `GdkToplevelLayout` struct is necessary for using
 * [Gdk.Toplevel.present].
 * Toplevel surfaces are sovereign windows that can be presented
 * to the user in various states $(LPAREN)maximized, on all workspaces,
 * etc$(RPAREN).
 */
class ToplevelLayout : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gdk_toplevel_layout_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a toplevel layout description.
   * Used together with [Gdk.Toplevel.present] to describe
   * how a toplevel surface should be placed and behave on-screen.
   * The size is in ”application pixels”, not
   * ”device pixels” $(LPAREN)see [Gdk.Surface.getScaleFactor]$(RPAREN).
   * Returns: newly created instance of `GdkToplevelLayout`
   */
  this()
  {
    GdkToplevelLayout* _cretval;
    _cretval = gdk_toplevel_layout_new();
    this(_cretval, true);
  }

  /**
   * Create a new `GdkToplevelLayout` and copy the contents of layout into it.
   * Returns: a copy of layout.
   */
  ToplevelLayout copy()
  {
    GdkToplevelLayout* _cretval;
    _cretval = gdk_toplevel_layout_copy(cast(GdkToplevelLayout*)cPtr);
    auto _retval = _cretval ? new ToplevelLayout(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Check whether layout and other has identical layout properties.
   * Params:
   *   other = another `GdkToplevelLayout`
   * Returns: %TRUE if layout and other have identical layout properties,
   *   otherwise %FALSE.
   */
  bool equal(ToplevelLayout other)
  {
    bool _retval;
    _retval = gdk_toplevel_layout_equal(cast(GdkToplevelLayout*)cPtr, other ? cast(GdkToplevelLayout*)other.cPtr(false) : null);
    return _retval;
  }

  /**
   * If the layout specifies whether to the toplevel should go fullscreen,
   * the value pointed to by fullscreen is set to %TRUE if it should go
   * fullscreen, or %FALSE, if it should go unfullscreen.
   * Params:
   *   fullscreen = location to store whether the toplevel should be fullscreen
   * Returns: whether the layout specifies the fullscreen state for the toplevel
   */
  bool getFullscreen(out bool fullscreen)
  {
    bool _retval;
    _retval = gdk_toplevel_layout_get_fullscreen(cast(GdkToplevelLayout*)cPtr, cast(bool*)&fullscreen);
    return _retval;
  }

  /**
   * Returns the monitor that the layout is fullscreening
   * the surface on.
   * Returns: the monitor on which layout fullscreens
   */
  MonitorG getFullscreenMonitor()
  {
    GdkMonitor* _cretval;
    _cretval = gdk_toplevel_layout_get_fullscreen_monitor(cast(GdkToplevelLayout*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MonitorG(cast(GdkMonitor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * If the layout specifies whether to the toplevel should go maximized,
   * the value pointed to by maximized is set to %TRUE if it should go
   * fullscreen, or %FALSE, if it should go unmaximized.
   * Params:
   *   maximized = set to %TRUE if the toplevel should be maximized
   * Returns: whether the layout specifies the maximized state for the toplevel
   */
  bool getMaximized(out bool maximized)
  {
    bool _retval;
    _retval = gdk_toplevel_layout_get_maximized(cast(GdkToplevelLayout*)cPtr, cast(bool*)&maximized);
    return _retval;
  }

  /**
   * Returns whether the layout should allow the user
   * to resize the surface.
   * Returns: %TRUE if the layout is resizable
   */
  bool getResizable()
  {
    bool _retval;
    _retval = gdk_toplevel_layout_get_resizable(cast(GdkToplevelLayout*)cPtr);
    return _retval;
  }

  /**
   * Sets whether the layout should cause the surface
   * to be fullscreen when presented.
   * Params:
   *   fullscreen = %TRUE to fullscreen the surface
   *   monitor = the monitor to fullscreen on
   */
  void setFullscreen(bool fullscreen, MonitorG monitor)
  {
    gdk_toplevel_layout_set_fullscreen(cast(GdkToplevelLayout*)cPtr, fullscreen, monitor ? cast(GdkMonitor*)monitor.cPtr(false) : null);
  }

  /**
   * Sets whether the layout should cause the surface
   * to be maximized when presented.
   * Params:
   *   maximized = %TRUE to maximize
   */
  void setMaximized(bool maximized)
  {
    gdk_toplevel_layout_set_maximized(cast(GdkToplevelLayout*)cPtr, maximized);
  }

  /**
   * Sets whether the layout should allow the user
   * to resize the surface after it has been presented.
   * Params:
   *   resizable = %TRUE to allow resizing
   */
  void setResizable(bool resizable)
  {
    gdk_toplevel_layout_set_resizable(cast(GdkToplevelLayout*)cPtr, resizable);
  }
}

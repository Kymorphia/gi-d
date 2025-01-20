module Gdk.Surface;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import Gdk.CairoContext;
import Gdk.Cursor;
import Gdk.Device;
import Gdk.Display;
import Gdk.Event;
import Gdk.FrameClock;
import Gdk.GLContext;
import Gdk.MonitorG;
import Gdk.Types;
import Gdk.VulkanContext;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import cairo.Region;
import cairo.Surface : DcairoSurface = Surface;
import cairo.Types;

/**
 * A `GdkSurface` is a rectangular region on the screen.
 * It’s a low-level object, used to implement high-level objects
 * such as [GtkWindow](../gtk4/class.Window.html).
 * The surfaces you see in practice are either [Gdk.Toplevel] or
 * [Gdk.Popup], and those interfaces provide much of the required
 * API to interact with these surfaces. Other, more specialized surface
 * types exist, but you will rarely interact with them directly.
 */
class Surface : ObjectG
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
    return gdk_surface_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new popup surface.
   * The surface will be attached to parent and can be positioned
   * relative to it using [Gdk.Popup.present].
   * Params:
   *   parent = the parent surface to attach the surface to
   *   autohide = whether to hide the surface on outside clicks
   * Returns: a new `GdkSurface`
   */
  static Surface newPopup(Surface parent, bool autohide)
  {
    GdkSurface* _cretval;
    _cretval = gdk_surface_new_popup(parent ? cast(GdkSurface*)parent.cPtr(false) : null, autohide);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new toplevel surface.
   * Params:
   *   display = the display to create the surface on
   * Returns: the new `GdkSurface`
   */
  static Surface newToplevel(Display display)
  {
    GdkSurface* _cretval;
    _cretval = gdk_surface_new_toplevel(display ? cast(GdkDisplay*)display.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Emits a short beep associated to surface.
   * If the display of surface does not support per-surface beeps,
   * emits a short beep on the display just as [Gdk.Display.beep].
   */
  void beep()
  {
    gdk_surface_beep(cast(GdkSurface*)cPtr);
  }

  /**
   * Creates a new `GdkCairoContext` for rendering on surface.
   * Returns: the newly created `GdkCairoContext`
   */
  CairoContext createCairoContext()
  {
    GdkCairoContext* _cretval;
    _cretval = gdk_surface_create_cairo_context(cast(GdkSurface*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!CairoContext(cast(GdkCairoContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new `GdkGLContext` for the `GdkSurface`.
   * The context is disconnected from any particular surface or surface.
   * If the creation of the `GdkGLContext` failed, error will be set.
   * Before using the returned `GdkGLContext`, you will need to
   * call [Gdk.GLContext.makeCurrent] or [Gdk.GLContext.realize].
   * Returns: the newly created `GdkGLContext`
   */
  GLContext createGlContext()
  {
    GdkGLContext* _cretval;
    GError *_err;
    _cretval = gdk_surface_create_gl_context(cast(GdkSurface*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!GLContext(cast(GdkGLContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Create a new Cairo surface that is as compatible as possible with the
   * given surface.
   * For example the new surface will have the same fallback resolution
   * and font options as surface. Generally, the new surface will also
   * use the same backend as surface, unless that is not possible for
   * some reason. The type of the returned surface may be examined with
   * [cairo.DcairoSurface.getSurfaceType].
   * Initially the surface contents are all 0 $(LPAREN)transparent if contents
   * have transparency, black otherwise.$(RPAREN)
   * This function always returns a valid pointer, but it will return a
   * pointer to a “nil” surface if other is already in an error state
   * or any other error occurs.
   * Params:
   *   content = the content for the new surface
   *   width = width of the new surface
   *   height = height of the new surface
   * Returns: a pointer to the newly allocated surface. The caller
   *   owns the surface and should call [cairo.DcairoSurface.destroy] when done
   *   with it.

   * Deprecated: Create a suitable cairo image surface yourself
   */
  DcairoSurface createSimilarSurface(Content content, int width, int height)
  {
    cairo_surface_t* _cretval;
    _cretval = gdk_surface_create_similar_surface(cast(GdkSurface*)cPtr, content, width, height);
    auto _retval = _cretval ? new DcairoSurface(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets an error and returns %NULL.
   * Returns: %NULL

   * Deprecated: GTK does not expose any Vulkan internals. This
   *   function is a leftover that was accidentally exposed.
   */
  VulkanContext createVulkanContext()
  {
    GdkVulkanContext* _cretval;
    GError *_err;
    _cretval = gdk_surface_create_vulkan_context(cast(GdkSurface*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!VulkanContext(cast(GdkVulkanContext*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Destroys the window system resources associated with surface and
   * decrements surface's reference count.
   * The window system resources for all children of surface are also
   * destroyed, but the children’s reference counts are not decremented.
   * Note that a surface will not be destroyed automatically when its
   * reference count reaches zero. You must call this function yourself
   * before that happens.
   */
  void destroy()
  {
    gdk_surface_destroy(cast(GdkSurface*)cPtr);
  }

  /**
   * Retrieves a `GdkCursor` pointer for the cursor currently set on the
   * `GdkSurface`.
   * If the return value is %NULL then there is no custom cursor set on
   * the surface, and it is using the cursor for its parent surface.
   * Use [Gdk.Surface.setCursor] to unset the cursor of the surface.
   * Returns: a `GdkCursor`
   */
  Cursor getCursor()
  {
    GdkCursor* _cretval;
    _cretval = gdk_surface_get_cursor(cast(GdkSurface*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Cursor(cast(GdkCursor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves a `GdkCursor` pointer for the device currently set on the
   * specified `GdkSurface`.
   * If the return value is %NULL then there is no custom cursor set on the
   * specified surface, and it is using the cursor for its parent surface.
   * Use [Gdk.Surface.setCursor] to unset the cursor of the surface.
   * Params:
   *   device = a pointer `GdkDevice`
   * Returns: a `GdkCursor`
   */
  Cursor getDeviceCursor(Device device)
  {
    GdkCursor* _cretval;
    _cretval = gdk_surface_get_device_cursor(cast(GdkSurface*)cPtr, device ? cast(GdkDevice*)device.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Cursor(cast(GdkCursor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the current device position and modifier state.
   * The position is given in coordinates relative to the upper
   * left corner of surface.
   * Params:
   *   device = pointer `GdkDevice` to query to
   *   x = return location for the X coordinate of device
   *   y = return location for the Y coordinate of device
   *   mask = return location for the modifier mask
   * Returns: %TRUE if the device is over the surface
   */
  bool getDevicePosition(Device device, out double x, out double y, out ModifierType mask)
  {
    bool _retval;
    _retval = gdk_surface_get_device_position(cast(GdkSurface*)cPtr, device ? cast(GdkDevice*)device.cPtr(false) : null, cast(double*)&x, cast(double*)&y, &mask);
    return _retval;
  }

  /**
   * Gets the `GdkDisplay` associated with a `GdkSurface`.
   * Returns: the `GdkDisplay` associated with surface
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_surface_get_display(cast(GdkSurface*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the frame clock for the surface.
   * The frame clock for a surface never changes unless the surface is
   * reparented to a new toplevel surface.
   * Returns: the frame clock
   */
  FrameClock getFrameClock()
  {
    GdkFrameClock* _cretval;
    _cretval = gdk_surface_get_frame_clock(cast(GdkSurface*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FrameClock(cast(GdkFrameClock*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the height of the given surface.
   * Surface size is reported in ”application pixels”, not
   * ”device pixels” $(LPAREN)see [Gdk.Surface.getScaleFactor]$(RPAREN).
   * Returns: The height of surface
   */
  int getHeight()
  {
    int _retval;
    _retval = gdk_surface_get_height(cast(GdkSurface*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the surface has been mapped.
   * A surface is mapped with [Gdk.Toplevel.present]
   * or [Gdk.Popup.present].
   * Returns: %TRUE if the surface is mapped
   */
  bool getMapped()
  {
    bool _retval;
    _retval = gdk_surface_get_mapped(cast(GdkSurface*)cPtr);
    return _retval;
  }

  /**
   * Returns the internal scale that maps from surface coordinates
   * to the actual device pixels.
   * When the scale is bigger than 1, the windowing system prefers to get
   * buffers with a resolution that is bigger than the surface size $(LPAREN)e.g.
   * to show the surface on a high-resolution display, or in a magnifier$(RPAREN).
   * Compare with [Gdk.Surface.getScaleFactor], which returns the
   * next larger integer.
   * The scale may change during the lifetime of the surface.
   * Returns: the scale
   */
  double getScale()
  {
    double _retval;
    _retval = gdk_surface_get_scale(cast(GdkSurface*)cPtr);
    return _retval;
  }

  /**
   * Returns the internal scale factor that maps from surface coordinates
   * to the actual device pixels.
   * On traditional systems this is 1, but on very high density outputs
   * this can be a higher value $(LPAREN)often 2$(RPAREN). A higher value means that drawing
   * is automatically scaled up to a higher resolution, so any code doing
   * drawing will automatically look nicer. However, if you are supplying
   * pixel-based data the scale value can be used to determine whether to
   * use a pixel resource with higher resolution data.
   * The scale factor may change during the lifetime of the surface.
   * Returns: the scale factor
   */
  int getScaleFactor()
  {
    int _retval;
    _retval = gdk_surface_get_scale_factor(cast(GdkSurface*)cPtr);
    return _retval;
  }

  /**
   * Returns the width of the given surface.
   * Surface size is reported in ”application pixels”, not
   * ”device pixels” $(LPAREN)see [Gdk.Surface.getScaleFactor]$(RPAREN).
   * Returns: The width of surface
   */
  int getWidth()
  {
    int _retval;
    _retval = gdk_surface_get_width(cast(GdkSurface*)cPtr);
    return _retval;
  }

  /**
   * Hide the surface.
   * For toplevel surfaces, withdraws them, so they will no longer be
   * known to the window manager; for all surfaces, unmaps them, so
   * they won’t be displayed. Normally done automatically as
   * part of [[Gtk.Widget.hide]](../gtk4/method.Widget.hide.html).
   */
  void hide()
  {
    gdk_surface_hide(cast(GdkSurface*)cPtr);
  }

  /**
   * Check to see if a surface is destroyed.
   * Returns: %TRUE if the surface is destroyed
   */
  bool isDestroyed()
  {
    bool _retval;
    _retval = gdk_surface_is_destroyed(cast(GdkSurface*)cPtr);
    return _retval;
  }

  /**
   * Forces a [Gdk.Surface.render] signal emission for surface
   * to be scheduled.
   * This function is useful for implementations that track invalid
   * regions on their own.
   */
  void queueRender()
  {
    gdk_surface_queue_render(cast(GdkSurface*)cPtr);
  }

  /**
   * Request a layout phase from the surface's frame clock.
   * See [Gdk.FrameClock.requestPhase].
   */
  void requestLayout()
  {
    gdk_surface_request_layout(cast(GdkSurface*)cPtr);
  }

  /**
   * Sets the default mouse pointer for a `GdkSurface`.
   * Passing %NULL for the cursor argument means that surface will use
   * the cursor of its parent surface. Most surfaces should use this default.
   * Note that cursor must be for the same display as surface.
   * Use [Gdk.Cursor.newFromName] or [Gdk.Cursor.newFromTexture]
   * to create the cursor. To make the cursor invisible, use %GDK_BLANK_CURSOR.
   * Params:
   *   cursor = a `GdkCursor`
   */
  void setCursor(Cursor cursor)
  {
    gdk_surface_set_cursor(cast(GdkSurface*)cPtr, cursor ? cast(GdkCursor*)cursor.cPtr(false) : null);
  }

  /**
   * Sets a specific `GdkCursor` for a given device when it gets inside surface.
   * Passing %NULL for the cursor argument means that surface will use the
   * cursor of its parent surface. Most surfaces should use this default.
   * Use [Gdk.Cursor.newFromName] or [Gdk.Cursor.newFromTexture]
   * to create the cursor. To make the cursor invisible, use %GDK_BLANK_CURSOR.
   * Params:
   *   device = a pointer `GdkDevice`
   *   cursor = a `GdkCursor`
   */
  void setDeviceCursor(Device device, Cursor cursor)
  {
    gdk_surface_set_device_cursor(cast(GdkSurface*)cPtr, device ? cast(GdkDevice*)device.cPtr(false) : null, cursor ? cast(GdkCursor*)cursor.cPtr(false) : null);
  }

  /**
   * Apply the region to the surface for the purpose of event
   * handling.
   * Mouse events which happen while the pointer position corresponds
   * to an unset bit in the mask will be passed on the surface below
   * surface.
   * An input region is typically used with RGBA surfaces. The alpha
   * channel of the surface defines which pixels are invisible and
   * allows for nicely antialiased borders, and the input region
   * controls where the surface is “clickable”.
   * Use [Gdk.Display.supportsInputShapes] to find out if
   * a particular backend supports input regions.
   * Params:
   *   region = region of surface to be reactive
   */
  void setInputRegion(Region region)
  {
    gdk_surface_set_input_region(cast(GdkSurface*)cPtr, region ? cast(cairo_region_t*)region.cPtr(false) : null);
  }

  /**
   * Marks a region of the `GdkSurface` as opaque.
   * For optimisation purposes, compositing window managers may
   * like to not draw obscured regions of surfaces, or turn off blending
   * during for these regions. With RGB windows with no transparency,
   * this is just the shape of the window, but with ARGB32 windows, the
   * compositor does not know what regions of the window are transparent
   * or not.
   * This function only works for toplevel surfaces.
   * GTK will update this property automatically if the surface background
   * is opaque, as we know where the opaque regions are. If your surface
   * background is not opaque, please update this property in your
   * [GtkWidgetClass.css_changed](../gtk4/vfunc.Widget.css_changed.html) handler.
   * Params:
   *   region = a region, or %NULL to make the entire
   *     surface opaque
   */
  void setOpaqueRegion(Region region)
  {
    gdk_surface_set_opaque_region(cast(GdkSurface*)cPtr, region ? cast(cairo_region_t*)region.cPtr(false) : null);
  }

  /**
   * Translates coordinates between two surfaces.
   * Note that this only works if to and from are popups or
   * transient-for to the same toplevel $(LPAREN)directly or indirectly$(RPAREN).
   * Params:
   *   to = the target surface
   *   x = coordinates to translate
   *   y = coordinates to translate
   * Returns: %TRUE if the coordinates were successfully translated
   */
  bool translateCoordinates(Surface to, ref double x, ref double y)
  {
    bool _retval;
    _retval = gdk_surface_translate_coordinates(cast(GdkSurface*)cPtr, to ? cast(GdkSurface*)to.cPtr(false) : null, cast(double*)&x, cast(double*)&y);
    return _retval;
  }

  /**
   * Emitted when surface starts being present on the monitor.
   * Params
   *   monitor = the monitor
   *   surface = the instance the signal is connected to
   */
  alias EnterMonitorCallback = void delegate(MonitorG monitor, Surface surface);

  /**
   * Connect to EnterMonitor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEnterMonitor(EnterMonitorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto surface = getVal!Surface(_paramVals);
      auto monitor = getVal!MonitorG(&_paramVals[1]);
      _dgClosure.dlg(monitor, surface);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("enter-monitor", closure, after);
  }

  /**
   * Emitted when GDK receives an input event for surface.
   * Params
   *   event = an input event
   *   surface = the instance the signal is connected to
   * Returns: %TRUE to indicate that the event has been handled
   */
  alias EventCallback = bool delegate(Event event, Surface surface);

  /**
   * Connect to Event signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEvent(EventCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto surface = getVal!Surface(_paramVals);
      auto event = getVal!Event(&_paramVals[1]);
      _retval = _dgClosure.dlg(event, surface);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("event", closure, after);
  }

  /**
   * Emitted when the size of surface is changed, or when relayout should
   * be performed.
   * Surface size is reported in ”application pixels”, not
   * ”device pixels” $(LPAREN)see [Gdk.Surface.getScaleFactor]$(RPAREN).
   * Params
   *   width = the current width
   *   height = the current height
   *   surface = the instance the signal is connected to
   */
  alias LayoutCallback = void delegate(int width, int height, Surface surface);

  /**
   * Connect to Layout signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLayout(LayoutCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto surface = getVal!Surface(_paramVals);
      auto width = getVal!int(&_paramVals[1]);
      auto height = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(width, height, surface);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("layout", closure, after);
  }

  /**
   * Emitted when surface stops being present on the monitor.
   * Params
   *   monitor = the monitor
   *   surface = the instance the signal is connected to
   */
  alias LeaveMonitorCallback = void delegate(MonitorG monitor, Surface surface);

  /**
   * Connect to LeaveMonitor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectLeaveMonitor(LeaveMonitorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto surface = getVal!Surface(_paramVals);
      auto monitor = getVal!MonitorG(&_paramVals[1]);
      _dgClosure.dlg(monitor, surface);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("leave-monitor", closure, after);
  }

  /**
   * Emitted when part of the surface needs to be redrawn.
   * Params
   *   region = the region that needs to be redrawn
   *   surface = the instance the signal is connected to
   * Returns: %TRUE to indicate that the signal has been handled
   */
  alias RenderCallback = bool delegate(Region region, Surface surface);

  /**
   * Connect to Render signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRender(RenderCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto surface = getVal!Surface(_paramVals);
      auto region = getVal!Region(&_paramVals[1]);
      _retval = _dgClosure.dlg(region, surface);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("render", closure, after);
  }
}

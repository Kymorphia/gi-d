module Gdk.DrawContext;

import GObject.ObjectG;
import Gdk.Display;
import Gdk.Surface;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import cairo.Region;

/**
 * Base class for objects implementing different rendering methods.
 * `GdkDrawContext` is the base object used by contexts implementing different
 * rendering methods, such as [Gdk.CairoContext] or [Gdk.GLContext].
 * It provides shared functionality between those contexts.
 * You will always interact with one of those subclasses.
 * A `GdkDrawContext` is always associated with a single toplevel surface.
 */
class DrawContext : ObjectG
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
    return gdk_draw_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Indicates that you are beginning the process of redrawing region
   * on the context's surface.
   * Calling this function begins a drawing operation using context on the
   * surface that context was created from. The actual requirements and
   * guarantees for the drawing operation vary for different implementations
   * of drawing, so a [Gdk.CairoContext] and a [Gdk.GLContext]
   * need to be treated differently.
   * A call to this function is a requirement for drawing and must be
   * followed by a call to [Gdk.DrawContext.endFrame], which will
   * complete the drawing operation and ensure the contents become visible
   * on screen.
   * Note that the region passed to this function is the minimum region that
   * needs to be drawn and depending on implementation, windowing system and
   * hardware in use, it might be necessary to draw a larger region. Drawing
   * implementation must use [Gdk.DrawContext.getFrameRegion] to
   * query the region that must be drawn.
   * When using GTK, the widget system automatically places calls to
   * [Gdk.DrawContext.beginFrame] and [Gdk.DrawContext.endFrame] via the
   * use of [GskRenderer](../gsk4/class.Renderer.html)s, so application code
   * does not need to call these functions explicitly.
   * Params:
   *   region = minimum region that should be drawn
   */
  void beginFrame(Region region)
  {
    gdk_draw_context_begin_frame(cast(GdkDrawContext*)cPtr, region ? cast(cairo_region_t*)region.cPtr(false) : null);
  }

  /**
   * Ends a drawing operation started with [Gdk.DrawContext.beginFrame].
   * This makes the drawing available on screen.
   * See [Gdk.DrawContext.beginFrame] for more details about drawing.
   * When using a [Gdk.GLContext], this function may call `glFlush()`
   * implicitly before returning; it is not recommended to call `glFlush$(LPAREN)$(RPAREN)`
   * explicitly before calling this function.
   */
  void endFrame()
  {
    gdk_draw_context_end_frame(cast(GdkDrawContext*)cPtr);
  }

  /**
   * Retrieves the `GdkDisplay` the context is created for
   * Returns: the `GdkDisplay`
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_draw_context_get_display(cast(GdkDrawContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the region that is currently being repainted.
   * After a call to [Gdk.DrawContext.beginFrame] this function will
   * return a union of the region passed to that function and the area of the
   * surface that the context determined needs to be repainted.
   * If context is not in between calls to [Gdk.DrawContext.beginFrame]
   * and [Gdk.DrawContext.endFrame], %NULL will be returned.
   * Returns: a Cairo region
   */
  Region getFrameRegion()
  {
    const(cairo_region_t)* _cretval;
    _cretval = gdk_draw_context_get_frame_region(cast(GdkDrawContext*)cPtr);
    auto _retval = _cretval ? new Region(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the surface that context is bound to.
   * Returns: a `GdkSurface`
   */
  Surface getSurface()
  {
    GdkSurface* _cretval;
    _cretval = gdk_draw_context_get_surface(cast(GdkDrawContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if context is in the process of drawing to its surface.
   * This is the case between calls to [Gdk.DrawContext.beginFrame]
   * and [Gdk.DrawContext.endFrame]. In this situation, drawing commands
   * may be effecting the contents of the context's surface.
   * Returns: %TRUE if the context is between [Gdk.DrawContext.beginFrame]
   *   and [Gdk.DrawContext.endFrame] calls.
   */
  bool isInFrame()
  {
    bool _retval;
    _retval = gdk_draw_context_is_in_frame(cast(GdkDrawContext*)cPtr);
    return _retval;
  }
}

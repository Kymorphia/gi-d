module Gsk.CairoNode;

import Gid.gid;
import Graphene.Rect;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;
import cairo.Context;
import cairo.Surface;

/**
 * A render node for a Cairo surface.
 */
class CairoNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.CairoNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will render a cairo surface
   * into the area given by bounds.
   * You can draw to the cairo surface using [Gsk.CairoNode.getDrawContext].
   * Params:
   *   bounds = the rectangle to render to
   * Returns: A new `GskRenderNode`
   */
  this(Rect bounds)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_cairo_node_new(bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Creates a Cairo context for drawing using the surface associated
   * to the render node.
   * If no surface exists yet, a surface will be created optimized for
   * rendering to renderer.
   * Returns: a Cairo context used for drawing; use
   *   [cairo.Global.destroy] when done drawing
   */
  Context getDrawContext()
  {
    cairo_t* _cretval;
    _cretval = gsk_cairo_node_get_draw_context(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Context(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Retrieves the Cairo surface used by the render node.
   * Returns: a Cairo surface
   */
  Surface getSurface()
  {
    cairo_surface_t* _cretval;
    _cretval = gsk_cairo_node_get_surface(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Surface(cast(void*)_cretval, false) : null;
    return _retval;
  }
}

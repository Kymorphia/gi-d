module Gsk.RepeatingRadialGradientNode;

import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Gsk.ColorStop;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node for a repeating radial gradient.
 */
class RepeatingRadialGradientNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.RepeatingRadialGradientNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that draws a repeating radial gradient.
   * The radial gradient starts around center. The size of the gradient
   * is dictated by hradius in horizontal orientation and by vradius
   * in vertical orientation.
   * Params:
   *   bounds = the bounds of the node
   *   center = the center of the gradient
   *   hradius = the horizontal radius
   *   vradius = the vertical radius
   *   start = a percentage >\= 0 that defines the start of the gradient around center
   *   end = a percentage >\= 0 that defines the end of the gradient around center
   *   colorStops = a pointer to an array of
   *     `GskColorStop` defining the gradient. The offsets of all color stops
   *     must be increasing. The first stop's offset must be >\= 0 and the last
   *     stop's offset must be <\= 1.
   * Returns: A new `GskRenderNode`
   */
  this(Rect bounds, Point center, float hradius, float vradius, float start, float end, ColorStop[] colorStops)
  {
    GskRenderNode* _cretval;
    size_t _nColorStops;
    if (colorStops)
      _nColorStops = cast(size_t)colorStops.length;

    GskColorStop[] _tmpcolorStops;
    foreach (obj; colorStops)
      _tmpcolorStops ~= obj.cInstance;
    const(GskColorStop)* _colorStops = _tmpcolorStops.ptr;
    _cretval = gsk_repeating_radial_gradient_node_new(bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, center ? cast(graphene_point_t*)center.cPtr(false) : null, hradius, vradius, start, end, _colorStops, _nColorStops);
    this(_cretval, true);
  }
}

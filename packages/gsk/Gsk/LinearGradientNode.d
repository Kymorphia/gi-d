module Gsk.LinearGradientNode;

import Gid.gid;
import Graphene.Point;
import Graphene.Rect;
import Gsk.ColorStop;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node for a linear gradient.
 */
class LinearGradientNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.LinearGradientNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will create a linear gradient from the given
   * points and color stops, and render that into the area given by bounds.
   * Params:
   *   bounds = the rectangle to render the linear gradient into
   *   start = the point at which the linear gradient will begin
   *   end = the point at which the linear gradient will finish
   *   colorStops = a pointer to an array of
   *     `GskColorStop` defining the gradient. The offsets of all color stops
   *     must be increasing. The first stop's offset must be >\= 0 and the last
   *     stop's offset must be <\= 1.
   * Returns: A new `GskRenderNode`
   */
  this(Rect bounds, Point start, Point end, ColorStop[] colorStops)
  {
    GskRenderNode* _cretval;
    size_t _nColorStops;
    if (colorStops)
      _nColorStops = cast(size_t)colorStops.length;

    GskColorStop[] _tmpcolorStops;
    foreach (obj; colorStops)
      _tmpcolorStops ~= obj.cInstance;
    const(GskColorStop)* _colorStops = _tmpcolorStops.ptr;
    _cretval = gsk_linear_gradient_node_new(bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, start ? cast(graphene_point_t*)start.cPtr(false) : null, end ? cast(graphene_point_t*)end.cPtr(false) : null, _colorStops, _nColorStops);
    this(_cretval, true);
  }

  /**
   * Retrieves the color stops in the gradient.
   * Returns: the color stops in the gradient
   */
  ColorStop[] getColorStops()
  {
    const(GskColorStop)* _cretval;
    size_t _cretlength;
    _cretval = gsk_linear_gradient_node_get_color_stops(cast(GskRenderNode*)cPtr, &_cretlength);
    ColorStop[] _retval;

    if (_cretval)
    {
      _retval = new ColorStop[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new ColorStop(cast(void*)&_cretval[i], false);
    }
    return _retval;
  }

  /**
   * Retrieves the final point of the linear gradient.
   * Returns: the final point
   */
  Point getEnd()
  {
    const(graphene_point_t)* _cretval;
    _cretval = gsk_linear_gradient_node_get_end(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the number of color stops in the gradient.
   * Returns: the number of color stops
   */
  size_t getNColorStops()
  {
    size_t _retval;
    _retval = gsk_linear_gradient_node_get_n_color_stops(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the initial point of the linear gradient.
   * Returns: the initial point
   */
  Point getStart()
  {
    const(graphene_point_t)* _cretval;
    _cretval = gsk_linear_gradient_node_get_start(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
